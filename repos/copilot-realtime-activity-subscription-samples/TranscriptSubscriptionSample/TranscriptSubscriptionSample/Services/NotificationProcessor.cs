
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using TranscriptSubscriptionSample.Configurations;
using TranscriptSubscriptionSample.Models;
using TranscriptSubscriptionSample.Utilities;
using System.Security.Cryptography.X509Certificates;
using System.Text.Json;

namespace TranscriptSubscriptionSample.Services
{
    public class NotificationProcessor : INotificationProcessor
    {
        private readonly GraphConfigurations graphConfig;
        private readonly ISubscriptionsService subscriptionsService;
        private readonly ILogger<NotificationProcessor> logger;

        public NotificationProcessor(IOptions<GraphConfigurations> graphConfig, ISubscriptionsService subscriptionsService, ILogger<NotificationProcessor> logger)
        {
            this.graphConfig = graphConfig.Value;
            this.subscriptionsService = subscriptionsService;
            this.logger = logger;
        }

        public async Task ProcessNotificationAsync(string content)
        {
            var meetingCallEventNotifications = JsonSerializer.Deserialize<MeetingCallEventNotifications>(content);

            if (meetingCallEventNotifications?.Value == null || meetingCallEventNotifications.Value.Count() == 0)
                throw new ArgumentException("Invalid encrypted JSON payload");

            try
            {
                var certificatePath = Path.Combine(Directory.GetCurrentDirectory(), "Certificates", graphConfig.CertificateFileName);
                var certificate = CertificateLoader.LoadFromFile(certificatePath, graphConfig.CertificatePassword);
                var decryptedContent = NotificationDecryption.DecryptNotification(meetingCallEventNotifications.Value[0].EncryptedContent, certificate);
                var meetingCallEvent = JsonSerializer.Deserialize<MeetingCallEvent>(decryptedContent);

                logger.LogInformation("Meeting event notification received: {meetingCallEvent}", meetingCallEvent?.EventType);

                await HandleMeetingEvent(meetingCallEvent);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Exception while handling meeting event");
            }
        }

        private async Task HandleMeetingEvent(MeetingCallEvent meetingCallEvent)
        {
            if (meetingCallEvent?.EventType == CallEventType.TranscriptionStarted)
            {
                await subscriptionsService.AddSubscription(meetingCallEvent.JoinWebUrl);
            }
        }
    }
}
