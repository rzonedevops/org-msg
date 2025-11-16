using Microsoft.AspNetCore.Mvc;
using TranscriptSubscriptionSample.Services;
using TranscriptSubscriptionSample.Models;

namespace TranscriptSubscriptionSample.Controllers
{
    /// <summary>
    /// This controller manages event subscriptions page of the web application.
    /// </summary>
    public class EventSubscriptionsController : Controller
    {
        private readonly ISubscriptionsService subscriptionsService;
        private readonly ILogger<EventSubscriptionsController> logger;

        public EventSubscriptionsController(
            ISubscriptionsService subscriptionsService,
            ILogger<EventSubscriptionsController> logger)
        {
            this.subscriptionsService = subscriptionsService;
            this.logger = logger;
        }

        // GET: /EventSubscriptions
        public IActionResult Index()
        {
            try
            {
                var subscriptions = subscriptionsService.GetAllEventSubscriptions();
                var viewModels = subscriptions.Select(s => new EventSubscriptionViewModel
                {
                    Id = s.Id,
                    OrganizerId = s.OrganizerId,
                    ExpirationDate = s.ExpirationDateTime,
                    CreatedAt = s.CreatedAt,
                }).ToList();

                return View(viewModels);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error retrieving event subscriptions");
                TempData["Error"] = "Failed to load event subscriptions.";
                return View(new List<EventSubscriptionViewModel>());
            }
        }

        // GET: /EventSubscriptions/Create
        public IActionResult Create()
        {
            return View(new CreateEventSubscriptionViewModel());
        }

        // POST: /EventSubscriptions/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CreateEventSubscriptionViewModel model)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Get the base URL for notification callback
                    var baseUrl = $"{Request.Scheme}://{Request.Host}";

                    var eventSubscription = new EventSubscription()
                    {
                        Id = string.Empty,
                        OrganizerId = model.OrganizerId,
                        ExpirationDateTime = model.ExpirationDate,
                        CreatedAt = DateTime.UtcNow
                    };

                    // Store subscription info locally
                    await subscriptionsService.AddEventSubscription(eventSubscription);

                    TempData["Success"] = "Event subscription created successfully!";
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    logger.LogError(ex, "Error creating event subscription");
                    ModelState.AddModelError(string.Empty, 
                        $"Failed to create event subscription: {ex.Message}");
                }
            }

            return View(model);
        }

        // GET: /EventSubscriptions/Delete/5
        public IActionResult Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var subscription = subscriptionsService.GetEventSubscriptionById(id);
                if (subscription == null)
                {
                    return NotFound();
                }

                var viewModel = new EventSubscriptionViewModel
                {
                    Id = subscription.Id,
                    OrganizerId = subscription.OrganizerId,
                    ExpirationDate = subscription.ExpirationDateTime,
                    CreatedAt = subscription.CreatedAt
                };

                return View(viewModel);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error retrieving event subscription {id} for deletion");
                return RedirectToAction(nameof(Index));
            }
        }

        // POST: /EventSubscriptions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            try
            {
                await subscriptionsService.RemoveEventSubscription(id);
                TempData["Success"] = "Event subscription removed successfully!";
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error deleting event subscription {id}");
                TempData["Error"] = "Failed to remove event subscription.";
            }

            return RedirectToAction(nameof(Index));
        }

        // GET: /EventSubscriptions/Events/5
        public IActionResult Events(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            try
            {
                var subscription = subscriptionsService.GetEventSubscriptionById(id);
                if (subscription == null)
                {
                    return NotFound();
                }

                var viewModel = new EventSubscriptionViewModel
                {
                    Id = subscription.Id,
                    OrganizerId = subscription.OrganizerId,
                    ExpirationDate = subscription.ExpirationDateTime,
                    CreatedAt = subscription.CreatedAt
                };

                return View(viewModel);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error retrieving events for subscription {id}");
                return RedirectToAction(nameof(Index));
            }
        }
    }
}