using System.Text.Json.Serialization;

namespace TranscriptSubscriptionSample.Models
{
    public class SubscriptionInfo
    {
        [JsonPropertyName("id")]
        public string Id { get; set; }

        [JsonPropertyName("meetingUrl")]
        public string MeetingUrl { get; set; }

        [JsonPropertyName("status")]
        public SubscriptionStatus Status { get; set; }

        [JsonPropertyName("streamUrl")]
        public string StreamUrl { get; set; }
    }

    public class SubscriptionDetails
    {
        [JsonPropertyName("subscriptionInfo")]
        public SubscriptionInfo SubscriptionInfo { get; set; }

        [JsonPropertyName("transcripts")]
        public List<TranscriptData> Transcripts { get; set; }
    }

    public enum SubscriptionStatus
    {
        InActive,
        Active,
        Expired,
        Error
    }

    public class EventSubscription
    {
        [JsonPropertyName("id")]
        public string Id { get; set; }

        [JsonPropertyName("organizerId")]
        public string OrganizerId { get; set; }

        [JsonPropertyName("expirationDateTime")]
        public DateTime ExpirationDateTime { get; set; }

        [JsonPropertyName("createdAt")]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}