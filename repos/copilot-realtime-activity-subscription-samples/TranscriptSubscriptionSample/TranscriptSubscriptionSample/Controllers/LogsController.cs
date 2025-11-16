using Microsoft.AspNetCore.Mvc;
using TranscriptSubscriptionSample.Logging;
using TranscriptSubscriptionSample.Models;
using System.Text;

namespace TranscriptSubscriptionSample.Controllers
{
    /// <summary>
    /// This controller manages logs page of the web application.
    /// </summary>
    public class LogsController : Controller
    {
        private readonly ILogStore _logStore;
        private readonly ILogger<LogsController> _logger;

        public LogsController(ILogStore logStore, ILogger<LogsController> logger)
        {
            _logStore = logStore;
            _logger = logger;
        }

        // GET: /Logs
        public IActionResult Index(LogLevel? minLevel = null, string category = null, int count = 100)
        {
            try
            {
                var logs = _logStore.GetLogs(count, minLevel, category);
                
                var viewModel = new LogsViewModel
                {
                    Logs = logs.Select(log => new LogEntryViewModel
                    {
                        Timestamp = log.Timestamp,
                        LogLevel = log.LogLevel,
                        Category = log.Category,
                        Message = log.Message,
                        Exception = log.Exception,
                        EventId = log.EventId,
                        EventName = log.EventName
                    }).ToList(),
                    Filter = new LogFilterViewModel
                    {
                        MinLevel = minLevel,
                        Category = category,
                        Count = count
                    },
                    TotalCount = logs.Count()
                };

                return View(viewModel);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving logs");
                TempData["Error"] = "Failed to load logs.";
                return View(new LogsViewModel());
            }
        }

        // POST: /Logs/Clear
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Clear()
        {
            try
            {
                _logStore.Clear();
                TempData["Success"] = "All logs have been cleared successfully!";
                _logger.LogInformation("Logs cleared by user");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error clearing logs");
                TempData["Error"] = "Failed to clear logs.";
            }

            return RedirectToAction(nameof(Index));
        }

        // GET: /Logs/Export
        public IActionResult Export(LogLevel? minLevel = null, string category = null)
        {
            try
            {
                var logs = _logStore.GetLogs(minLevel: minLevel, category: category);
                var csv = new StringBuilder();
                
                // CSV Header
                csv.AppendLine("Timestamp,LogLevel,Category,EventId,EventName,Message,Exception");

                // CSV Data
                foreach (var log in logs)
                {
                    csv.AppendLine($"{log.Timestamp:yyyy-MM-dd HH:mm:ss.fff}," +
                                 $"{log.LogLevel}," +
                                 $"\"{EscapeCsvField(log.Category)}\"," +
                                 $"{log.EventId}," +
                                 $"\"{EscapeCsvField(log.EventName ?? "")}\"," +
                                 $"\"{EscapeCsvField(log.Message)}\"," +
                                 $"\"{EscapeCsvField(log.Exception ?? "")}\"");
                }

                var bytes = Encoding.UTF8.GetBytes(csv.ToString());
                return File(bytes, "text/csv", $"logs_{DateTime.UtcNow:yyyyMMddHHmmss}.csv");
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error exporting logs");
                TempData["Error"] = "Failed to export logs.";
                return RedirectToAction(nameof(Index));
            }
        }

        private string EscapeCsvField(string field)
        {
            if (string.IsNullOrEmpty(field))
                return field;

            // Escape double quotes by doubling them
            return field.Replace("\"", "\"\"");
        }
    }
}