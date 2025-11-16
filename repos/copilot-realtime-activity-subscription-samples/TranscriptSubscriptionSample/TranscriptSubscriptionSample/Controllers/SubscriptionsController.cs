using Microsoft.AspNetCore.Mvc;
using TranscriptSubscriptionSample.Services;
using TranscriptSubscriptionSample.Models;

namespace TranscriptSubscriptionSample.Controllers
{
    /// <summary>
    /// This controller manages subscriptions page of the web application.
    /// </summary>
    public class SubscriptionsController : Controller
    {
        private readonly ISubscriptionsService _subscriptionsService;
        private readonly ILogger<SubscriptionsController> _logger;

        public SubscriptionsController(ISubscriptionsService subscriptionsService, ILogger<SubscriptionsController> logger)
        {
            _subscriptionsService = subscriptionsService;
            _logger = logger;
        }

        // GET: /Subscriptions
        public IActionResult Index()
        {
            try
            {
                var subscriptions = _subscriptionsService.GetAllSubscriptions();
                return View(subscriptions.Select(s => new SubscriptionViewModel()
                {
                    Id = s.Id,
                    MeetingUrl = s.MeetingUrl,
                    Status = s.Status
                }).ToList());
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error retrieving subscriptions");
                TempData["Error"] = "Failed to load subscriptions.";
                return View(new List<SubscriptionViewModel>());
            }
        }

        // GET: /Subscriptions/Details/5
        public IActionResult Details(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var subscription = _subscriptionsService.GetSubscription(id);
                if (subscription == null)
                {
                    return NotFound();
                }

                return View(new SubscriptionDetailsViewModel() { 
                    Id = subscription.SubscriptionInfo.Id,
                    MeetingUrl = subscription.SubscriptionInfo.MeetingUrl,
                    Status = subscription.SubscriptionInfo.Status,
                    RecentTranscripts = subscription.Transcripts
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error retrieving subscription {id}");
                return RedirectToAction(nameof(Index));
            }
        }

        // GET: /Subscriptions/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: /Subscriptions/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CreateSubscriptionViewModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var subscription = await _subscriptionsService.AddSubscription(model.MeetingUrl);
                    TempData["Success"] = "Subscription created successfully!";
                    return RedirectToAction(nameof(Details), new { id = subscription.Id });
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error creating subscription");
                    ModelState.AddModelError(string.Empty, "Failed to create subscription. Please try again.");
                }
            }

            return View(model);
        }

        // GET: /Subscriptions/Delete/5
        public IActionResult Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var subscription = _subscriptionsService.GetSubscription(id);
                if (subscription == null)
                {
                    return NotFound();
                }

                return View(new SubscriptionViewModel()
                {
                    Id = subscription.SubscriptionInfo.Id,
                    MeetingUrl = subscription.SubscriptionInfo.MeetingUrl,
                    Status = subscription.SubscriptionInfo.Status
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error retrieving subscription {id} for deletion");
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: /Subscriptions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(string id)
        {
            try
            {
                _subscriptionsService.RemoveSubscription(id);
                TempData["Success"] = "Subscription removed successfully!";
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error deleting subscription {id}");
                TempData["Error"] = "Failed to remove subscription.";
            }

            return RedirectToAction(nameof(Index));
        }

        // GET: /Subscriptions/Transcripts/5
        public IActionResult Transcripts(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var subscription = _subscriptionsService.GetSubscription(id);
                if (subscription == null)
                {
                    return NotFound();
                }

                return View(new SubscriptionDetailsViewModel()
                {
                    Id = subscription.SubscriptionInfo.Id,
                    MeetingUrl = subscription.SubscriptionInfo.MeetingUrl,
                    Status = subscription.SubscriptionInfo.Status,
                    RecentTranscripts = subscription.Transcripts
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error retrieving transcripts for subscription {id}");
                return RedirectToAction(nameof(Index));
            }
        }
    }
}