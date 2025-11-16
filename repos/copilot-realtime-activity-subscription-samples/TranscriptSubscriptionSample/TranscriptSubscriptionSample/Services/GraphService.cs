using Microsoft.Extensions.Options;
using Microsoft.Graph.Beta.Models;
using Microsoft.Kiota.Abstractions.Serialization;
using Microsoft.Kiota.Serialization.Json;
using TranscriptSubscriptionSample.Configurations;
using TranscriptSubscriptionSample.Models.Common;
using TranscriptSubscriptionSample.Utilities;
using System.Buffers.Text;
using System.Net.Http;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Text.Json;

namespace TranscriptSubscriptionSample.Services
{
    /// <summary>
    /// This service is responsible for interacting with Microsoft Graph API to manage subscriptions to real-time activity feeds.
    /// </summary>
    public class GraphService : IGraphService
    {
        private readonly HttpClient httpClient;
        private readonly GraphConfigurations graphConfig;
        private readonly ISerializationWriterFactory serializationWriterFactory;
        private readonly IParseNodeFactory parseNodeFactory;
        private readonly ILogger<GraphService> logger;

        public GraphService(
            IHttpClientFactory httpClientFactory, 
            IOptions<GraphConfigurations> graphConfigurations, 
            ILogger<GraphService> logger)
        {
            httpClient = httpClientFactory.CreateClient("GraphClient");
            graphConfig = graphConfigurations.Value;
            this.logger = logger;

            // Initialize Kiota JSON serialization writer factory
            serializationWriterFactory = new JsonSerializationWriterFactory();

            // Initialize Kiota JSON parse node factory
            parseNodeFactory = new JsonParseNodeFactory();

            // Register the JSON parse node factory if not already registered
            if (!ParseNodeFactoryRegistry.DefaultInstance.ContentTypeAssociatedFactories.ContainsKey("application/json"))
            {
                ParseNodeFactoryRegistry.DefaultInstance.ContentTypeAssociatedFactories.TryAdd("application/json", parseNodeFactory);
            }
        }

        /// <summary>
        /// Subscribes to real-time activity feed for a given meeting join URL.
        /// </summary>
        /// <param name="meetingJoinUrl"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public async Task<MultiActivitySubscription> SubscribeToActivity(string meetingJoinUrl)
        {
            try
            {
                var (chatInfo, meetingInfo) = MeetingUrlParser.ParseJoinURL(meetingJoinUrl);

                var subscriptionRequest = new MultiActivitySubscription
                {
                    MeetingInfo = meetingInfo,
                    ChatInfo = chatInfo,
                    UserId = ((OrganizerMeetingInfo)meetingInfo).Organizer.User.Id,
                    Activities = new SubscriptionActivities
                    {
                        Transcript = new TranscriptActivity()
                    },
                    Id = string.Empty
                };

                // Use Kiota serialization
                using var writer = serializationWriterFactory.GetSerializationWriter("application/json");
                writer.WriteObjectValue(null, subscriptionRequest);
                var serializedContent = writer.GetSerializedContent();

                // Convert to HttpContent
                using var memoryStream = new MemoryStream();
                await serializedContent.CopyToAsync(memoryStream);
                var content = new ByteArrayContent(memoryStream.ToArray());
                content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("application/json");

                string contentString = await content.ReadAsStringAsync();

                // Send the request
                var response = await httpClient.PostAsync("copilot/communications/realtimeActivityFeed/multiActivitySubscriptions", content);

                if (!response.IsSuccessStatusCode)
                {
                    logger.LogError("Failed to subscribe to activity feed. Status Code: {0}, Reason: {1}", response.StatusCode, response.ReasonPhrase);
                    throw new CustomException((int)response.StatusCode, $"Failed to subscribe to activity feed: {response.ReasonPhrase}");
                }
                else
                {
                    // Deserialize using Kiota
                    var responseStream = await response.Content.ReadAsStreamAsync();
                    var parseNode = await ParseNodeFactoryRegistry.DefaultInstance.GetRootParseNodeAsync("application/json", responseStream);
                    return parseNode.GetObjectValue<MultiActivitySubscription>(MultiActivitySubscription.CreateFromDiscriminatorValue);
                }
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public async Task UnsubscribeFromActivity(string subscriptionId)
        {
            var response = await httpClient.DeleteAsync($"copilot/communications/realtimeActivityFeed/multiActivitySubscriptions/{subscriptionId}");

            if (!response.IsSuccessStatusCode)
            {
                logger.LogError("Failed to unsubscribe id: {0} from activity feed. Status Code: {1}, Reason: {2}",
                    subscriptionId, response.StatusCode, response.ReasonPhrase);

                throw new CustomException((int)response.StatusCode, $"Failed to unsubscribe from activity feed: {response.ReasonPhrase}");
            }
        }

        public async Task<string> SubscribeToEvent(string organizerId, DateTime expirationDateTime)
        {
            try
            {
                // Load the certificate for encryption
                var certificate = CertificateLoader.LoadFromCertificateStore(graphConfig.CertificateThumbprint);
                string base64PublicCert = Convert.ToBase64String(certificate.Export(X509ContentType.Cert));

                // Get the notification URL from configuration or construct it
                var notificationUrl = $"{graphConfig.NotificationUrl}/api/notification/meetingEvents"; ;

                // Create the subscription payload
                var subscriptionPayload = new
                {
                    changeType = "updated",
                    notificationUrl = notificationUrl,
                    resource = $"communications/onlineMeetings/getCallEvents(organizers=['{organizerId}'])",
                    includeResourceData = true,
                    encryptionCertificate = base64PublicCert,
                    encryptionCertificateId = "TestAADAppCert",
                    expirationDateTime = expirationDateTime.ToUniversalTime().ToString("yyyy-MM-dd'T'HH:mm:ss.fffffff'Z'"),
                    clientState = string.Empty
                };

                // Serialize the payload
                var json = JsonSerializer.Serialize(subscriptionPayload, new JsonSerializerOptions
                {
                    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,
                    WriteIndented = false
                });

                var content = new StringContent(json, Encoding.UTF8, "application/json");
                content.Headers.TryAddWithoutValidation("IsAppOnly", "true");

                // Send the request to the subscriptions endpoint
                var response = await httpClient.PostAsync("subscriptions", content);

                if (!response.IsSuccessStatusCode)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    throw new CustomException((int)response.StatusCode,
                        $"Failed to subscribe to events: {response.ReasonPhrase}. Details: {errorContent}");
                }

                // Log successful subscription
                var responseContent = await response.Content.ReadAsStringAsync();

                using (JsonDocument document = JsonDocument.Parse(responseContent))
                {
                    if (document.RootElement.TryGetProperty("id", out JsonElement idElement))
                    {
                        var subscriptionId = idElement.GetString();
                        logger.LogInformation("Successfully subscribed to events for organizer {OrganizerId}. Subscription ID: {SubscriptionId}",
                            organizerId, subscriptionId);

                        return subscriptionId;
                    }
                    else
                    {
                        logger.LogError("Subscription response did not contain an ID. Response: {Response}", responseContent);
                        throw new CustomException(500, "Subscription was created but no ID was returned");
                    }
                }
            }
            catch (CustomException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new CustomException(500, $"An error occurred while subscribing to events: {ex.Message}", ex);
            }
        }

        public async Task RemoveEventSubscription(string subscriptionId)
        {
            using var request = new HttpRequestMessage(HttpMethod.Delete, $"subscriptions/{subscriptionId}");
            request.Headers.Add("IsAppOnly", "true");

            var response = await httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
            {
                logger.LogError("Failed to unsubscribe id: {0} from Graph subscriptions. Status Code: {1}, Reason: {2}",
                    subscriptionId, response.StatusCode, response.ReasonPhrase);

                throw new CustomException((int)response.StatusCode, $"Failed to unsubscribe from Graph subscriptions: {response.ReasonPhrase}");
            }
        }
    }
}
