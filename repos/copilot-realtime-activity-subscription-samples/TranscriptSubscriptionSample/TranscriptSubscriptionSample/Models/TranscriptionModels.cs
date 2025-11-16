using System.Text.Json.Serialization;

namespace TranscriptSubscriptionSample.Models
{
    public class TranscriptMessage
    {
        [JsonPropertyName("kind")]
        public string Kind { get; set; }

        [JsonPropertyName("liveCaptionDataV2")]
        public LiveCaptionDataV2 LiveCaptionDataV2 { get; set; }
    }

    public class LiveCaptionDataV2
    {
        [JsonPropertyName("activityType")]
        public string ActivityType { get; set; }

        [JsonPropertyName("transcriptData")]
        public TranscriptData TranscriptData { get; set; }
    }

    public class TranscriptData
    {
        [JsonPropertyName("audioCaptureTime")]
        public DateTime AudioCaptureTime { get; set; }

        [JsonPropertyName("speaker")]
        public TranscriptSpeaker Speaker { get; set; }

        [JsonPropertyName("text")]
        public string Text { get; set; }

        [JsonPropertyName("spokenLanguage")]
        public string SpokenLanguage { get; set; }
    }

    public class TranscriptSpeaker
    {
        [JsonPropertyName("user")]
        public SpeakerInfo User { get; set; }

        [JsonPropertyName("room")]
        public SpeakerInfo Room { get; set; }
    }

    public class SpeakerInfo
    {
        [JsonPropertyName("rawId")]
        public string RawId { get; set; }

        [JsonPropertyName("displayName")]
        public string DisplayName { get; set; }
    }
}