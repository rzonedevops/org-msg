using System.ComponentModel.DataAnnotations;

namespace TranscriptSubscriptionSample.Models
{
    public class EventSubscriptionViewModel
    {
        public string Id { get; set; }
        public string OrganizerId { get; set; }
        public DateTime ExpirationDate { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }

    public class CreateEventSubscriptionViewModel
    {
        [Required(ErrorMessage = "Organizer ID is required")]
        [Display(Name = "Organizer ID")]
        public string OrganizerId { get; set; }

        [Required(ErrorMessage = "Expiration date is required")]
        [Display(Name = "Expiration Date")]
        [DataType(DataType.DateTime)]
        public DateTime ExpirationDate { get; set; } = DateTime.UtcNow.AddDays(1);
    }
}