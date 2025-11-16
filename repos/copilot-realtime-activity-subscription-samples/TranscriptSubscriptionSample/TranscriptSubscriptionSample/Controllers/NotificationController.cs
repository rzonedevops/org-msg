using Microsoft.AspNetCore.Mvc;
using TranscriptSubscriptionSample.Models;
using TranscriptSubscriptionSample.Services;
using TranscriptSubscriptionSample.Utilities;
using System.Text.Json;

namespace TranscriptSubscriptionSample.Controllers
{
    /// <summary>
    /// This controller handles incoming notifications from Microsoft Graph webhooks.
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class NotificationController : ControllerBase
    {
        private readonly ILogger<NotificationController> logger;
        private readonly INotificationProcessor notificationProcessor;

        public NotificationController(ILogger<NotificationController> logger, INotificationProcessor notificationProcessor)
        {
            this.logger = logger;
            this.notificationProcessor = notificationProcessor;
        }

        [HttpPost("meetingEvents")]
        public async Task<IActionResult> MeetingEventNotification(
            [FromQuery] string validationToken = null)
        {
            // Case 1: Webhook validation request
            if (!string.IsNullOrEmpty(validationToken))
            {
                logger.LogInformation("Webhook validation request received with token: {ValidationToken}", validationToken);
                
                // Return the validation token as plain text
                return Content(validationToken, "text/plain", System.Text.Encoding.UTF8);
            }

            // Case 2: Actual event notification
            try
            {
                // Read the raw request body
                using var reader = new StreamReader(Request.Body);
                var requestBody = await reader.ReadToEndAsync();
                
                if (string.IsNullOrWhiteSpace(requestBody))
                {
                    logger.LogWarning("Empty request body received");
                    return BadRequest("Request body is empty");
                }

                // Asynchronously process the notification without awaiting
                _ = Task.Run(() => notificationProcessor.ProcessNotificationAsync(requestBody));

                return Accepted();
            }
            catch (JsonException ex)
            {
                logger.LogError(ex, "Error deserializing meeting event");
                return BadRequest("Invalid JSON format");
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error processing meeting event notification");
                return StatusCode(500, "Internal server error");
            }
        }
    }
}
