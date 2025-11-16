using System.Text.Json.Serialization;

namespace TranscriptSubscriptionSample.Models
{
    public class MeetingCallEventNotifications
    {
        [JsonPropertyName("value")]
        public List<MeetingCallEventNotification> Value { get; set; }

        [JsonPropertyName("validationTokens")]
        public List<string> ValidationTokens { get; set; }
    }

    public class MeetingCallEventNotification
    {
        [JsonPropertyName("subscriptionId")]
        public string SubscriptionId { get; set; }

        [JsonPropertyName("clientState")]
        public string ClientState { get; set; }

        [JsonPropertyName("changeType")]
        public string ChangeType { get; set; }

        [JsonPropertyName("tenantId")]
        public string TenantId { get; set; }

        [JsonPropertyName("resource")]
        public string Resource { get; set; }

        [JsonPropertyName("subscriptionExpirationDateTime")]
        public DateTime SubscriptionExpirationDateTime { get; set; }

        [JsonPropertyName("organizationId")]
        public string OrganizationId { get; set; }

        [JsonPropertyName("encryptedContent")]
        public EncryptedContent EncryptedContent { get; set; }
    }

    public class EncryptedContent
    {
        [JsonPropertyName("data")]
        public string Data { get; set; }

        [JsonPropertyName("dataSignature")]
        public string DataSignature { get; set; }

        [JsonPropertyName("dataKey")]
        public string DataKey { get; set; }

        [JsonPropertyName("encryptionCertificateId")]
        public string EncryptionCertificateId { get; set; }

        [JsonPropertyName("encryptionCertificateThumbprint")]
        public string EncryptionCertificateThumbprint { get; set; }
    }

    public class MeetingCallEvent
    {
        [JsonPropertyName("@odata.type")]
        public string ODataType { get; set; } = "#microsoft.graph.meetingCallEvent";

        [JsonPropertyName("@odata.id")]
        public string ODataId { get; set; }

        [JsonPropertyName("id")]
        public string Id { get; set; }

        [JsonPropertyName("eventType")]
        public CallEventType EventType { get; set; }

        [JsonPropertyName("eventDateTime")]
        public DateTime EventDateTime { get; set; }

        [JsonPropertyName("joinWebUrl")]
        public string JoinWebUrl { get; set; }
    }

    [JsonConverter(typeof(JsonStringEnumConverter))]
    public enum CallEventType
    {
        [JsonPropertyName("callStarted")]
        CallStarted,

        [JsonPropertyName("callEnded")]
        CallEnded,

        [JsonPropertyName("transcriptionStarted")]
        TranscriptionStarted,

        [JsonPropertyName("transcriptionEnded")]
        TranscriptionEnded,

        [JsonPropertyName("recordingStarted")]
        RecordingStarted,

        [JsonPropertyName("recordingEnded")]
        RecordingEnded
    }
}