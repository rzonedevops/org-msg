using Microsoft.Extensions.Logging;
using TranscriptSubscriptionSample.Logging;
using System.ComponentModel.DataAnnotations;

namespace TranscriptSubscriptionSample.Models
{
    public class LogsViewModel
    {
        public List<LogEntryViewModel> Logs { get; set; } = new();
        public LogFilterViewModel Filter { get; set; } = new();
        public int TotalCount { get; set; }
    }

    public class LogFilterViewModel
    {
        [Display(Name = "Minimum Log Level")]
        public LogLevel? MinLevel { get; set; }

        [Display(Name = "Category Filter")]
        public string Category { get; set; }

        [Display(Name = "Display Count")]
        [Range(10, 1000)]
        public int Count { get; set; } = 100;
    }

    public class LogEntryViewModel
    {
        public DateTime Timestamp { get; set; }
        public LogLevel LogLevel { get; set; }
        public string Category { get; set; }
        public string Message { get; set; }
        public string Exception { get; set; }
        public int EventId { get; set; }
        public string EventName { get; set; }

        public string LogLevelClass => LogLevel switch
        {
            LogLevel.Error or LogLevel.Critical => "table-danger",
            LogLevel.Warning => "table-warning",
            LogLevel.Debug or LogLevel.Trace => "table-secondary",
            _ => ""
        };

        public string LogLevelBadgeClass => LogLevel switch
        {
            LogLevel.Critical => "bg-danger",
            LogLevel.Error => "bg-danger",
            LogLevel.Warning => "bg-warning text-dark",
            LogLevel.Information => "bg-info text-dark",
            LogLevel.Debug => "bg-secondary",
            LogLevel.Trace => "bg-secondary",
            _ => "bg-primary"
        };
    }
}