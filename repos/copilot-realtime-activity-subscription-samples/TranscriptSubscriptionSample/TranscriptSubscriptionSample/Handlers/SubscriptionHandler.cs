using System.Collections.Concurrent;
using System.Net.WebSockets;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Logging;
using TranscriptSubscriptionSample.Models;
using TranscriptSubscriptionSample.Services;

namespace TranscriptSubscriptionSample.Handlers
{
    /// <summary>
    /// This class manages a single subscription, including WebSocket connection,
    /// transcript buffering, and message processing.
    /// </summary>
    public class SubscriptionHandler : IDisposable
    {
        private readonly SubscriptionInfo subscriptionInfo;
        private readonly ILogger<SubscriptionHandler> logger;
        private readonly ConcurrentQueue<TranscriptData> transcriptBuffer;
        private ClientWebSocket webSocket;
        private CancellationTokenSource _cancellationTokenSource;
        private Task _streamingTask;
        private readonly int _maxTranscripts = 100;
        private IAuthService _authService;

        public string SubscriptionId => subscriptionInfo.Id;
        public SubscriptionStatus Status => subscriptionInfo.Status;
        public IReadOnlyList<TranscriptData> Transcripts => transcriptBuffer.ToList();
        public SubscriptionInfo SubscriptionInfo => subscriptionInfo;

        public SubscriptionDetails SubscriptionDetails => new SubscriptionDetails
        {
            SubscriptionInfo = subscriptionInfo,
            Transcripts = Transcripts.ToList()
        };

        public SubscriptionHandler(SubscriptionInfo subscription, ILogger<SubscriptionHandler> logger, IAuthService authService)
        {
            subscriptionInfo = subscription;
            _authService = authService;
            this.logger = logger;
            transcriptBuffer = new ConcurrentQueue<TranscriptData>();
            _cancellationTokenSource = new CancellationTokenSource();
        }

        public async Task StartStreamingAsync(string websocketUrl)
        {
            try
            {
                subscriptionInfo.Status = SubscriptionStatus.Active;
                webSocket = new ClientWebSocket();
                webSocket.Options.SetRequestHeader("Authorization", $"Bearer {await _authService.GetAccessTokenAsync().ConfigureAwait(false)}");

                await webSocket.ConnectAsync(new Uri(websocketUrl), _cancellationTokenSource.Token);
                logger.LogInformation($"Connected to WebSocket for subscription {SubscriptionId}");

                SubscriptionInfo.Status = SubscriptionStatus.Active;
                _streamingTask = Task.Run(async () => await StreamTranscriptsAsync(), _cancellationTokenSource.Token);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Failed to start streaming for subscription {SubscriptionId}");
                subscriptionInfo.Status = SubscriptionStatus.Error;
                throw;
            }
        }

        private async Task StreamTranscriptsAsync()
        {
            var buffer = new ArraySegment<byte>(new byte[4096]);

            try
            {
                while (webSocket.State == WebSocketState.Open && !_cancellationTokenSource.Token.IsCancellationRequested)
                {
                    var result = await webSocket.ReceiveAsync(buffer, _cancellationTokenSource.Token);

                    if (result.MessageType == WebSocketMessageType.Text)
                    {
                        var message = Encoding.UTF8.GetString(buffer.Array, 0, result.Count);
                        ProcessTranscriptMessage(message);
                    }
                    else if (result.MessageType == WebSocketMessageType.Close)
                    {
                        logger.LogInformation($"WebSocket closed for subscription {SubscriptionId}");
                        subscriptionInfo.Status = SubscriptionStatus.Expired;
                        break;
                    }
                }
            }
            catch (WebSocketException ex)
            {
                logger.LogError(ex, $"WebSocket error for subscription {SubscriptionId}");
                subscriptionInfo.Status = SubscriptionStatus.Error;
            }
            catch (OperationCanceledException)
            {
                logger.LogInformation($"Streaming cancelled for subscription {SubscriptionId}");
            }
        }

        private void ProcessTranscriptMessage(string message)
        {
            try
            {
                var transcript = JsonSerializer.Deserialize<TranscriptMessage>(message, new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                });

                if (transcript != null)
                {
                    transcriptBuffer.Enqueue(transcript.LiveCaptionDataV2.TranscriptData);

                    // Maintain maximum buffer size
                    while (transcriptBuffer.Count > _maxTranscripts)
                    {
                        transcriptBuffer.TryDequeue(out _);
                    }

                    logger.LogDebug($"Added transcript for subscription {SubscriptionId}. Buffer size: {transcriptBuffer.Count}");
                }
            }
            catch (JsonException ex)
            {
                logger.LogError(ex, $"Failed to deserialize transcript message for subscription {SubscriptionId}");
            }
        }

        public async Task StopStreamingAsync()
        {
            try
            {
                _cancellationTokenSource?.Cancel();

                if (webSocket?.State == WebSocketState.Open)
                {
                    await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure,
                        "Subscription cancelled", CancellationToken.None);
                }

                if (_streamingTask != null)
                {
                    await _streamingTask;
                }

                subscriptionInfo.Status = SubscriptionStatus.Expired;
                logger.LogInformation($"Stopped streaming for subscription {SubscriptionId}");
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error stopping streaming for subscription {SubscriptionId}");
            }
        }

        public void Dispose()
        {
            StopStreamingAsync().GetAwaiter().GetResult();
            webSocket?.Dispose();
            _cancellationTokenSource?.Dispose();
        }
    }
}