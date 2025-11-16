using System.ComponentModel.DataAnnotations;

namespace TranscriptSubscriptionSample.Models
{
    public class CreateSubscriptionViewModel
    {
        [Required(ErrorMessage = "Meeting URL is required")]
        [Display(Name = "Meeting URL")]
        [Url(ErrorMessage = "Please enter a valid URL")]
        public string MeetingUrl { get; set; }
    }

    public class SubscriptionViewModel
    {
        public string Id { get; set; }
        public string MeetingUrl { get; set; }
        public SubscriptionStatus Status { get; set; }
    }

    public class SubscriptionDetailsViewModel
    {
        public string Id { get; set; }
        public string MeetingUrl { get; set; }
        public SubscriptionStatus Status { get; set; }
        public List<TranscriptData> RecentTranscripts { get; set; }
    }
}