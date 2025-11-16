using TranscriptSubscriptionSample.Models;

namespace TranscriptSubscriptionSample.Services
{
    /// <summary>
    /// This service is responsible for managing transcipt subscriptions and event subscriptions.
    /// </summary>
    public interface ISubscriptionsService
    {
        /// <summary>
        /// Create subscription for the given meeting URL
        /// </summary>
        /// <param name="meetingUrl">The meeting url</param>
        /// <returns></returns>
        public Task<SubscriptionInfo> AddSubscription(string meetingUrl);

        /// <summary>
        /// Stop subscription but keep its info
        /// </summary>
        /// <param name="subscriptionId">The subscription id</param>
        /// <returns></returns>
        public Task Unsubscribe(string subscriptionId);

        /// <summary>
        /// Remove subscription and stop its handler 
        /// </summary>
        /// <param name="subscriptionId">The subscription id</param>
        public void RemoveSubscription(string subscriptionId);

        /// <summary>
        /// Get list of all subscriptions
        /// </summary>
        /// <returns></returns>
        public List<SubscriptionInfo> GetAllSubscriptions();

        /// <summary>
        /// Get subscription by id
        /// </summary>
        /// <param name="subscriptionId">The subscription id</param>
        public SubscriptionDetails GetSubscription(string subscriptionId);

        /// <summary>
        /// Create event subscription for the given organizer id
        /// </summary>
        /// <param name="eventSubscription"></param>
        /// <returns></returns>
        public Task AddEventSubscription(EventSubscription eventSubscription);

        /// <summary>
        /// Get event subscription by id.
        /// </summary>
        /// <param name="eventSubscriptionId"></param>
        /// <returns></returns>
        public EventSubscription GetEventSubscriptionById(string eventSubscriptionId);

        /// <summary>
        /// Get list of all event subscriptions.
        /// </summary>
        /// <returns></returns>
        public List<EventSubscription> GetAllEventSubscriptions();

        /// <summary>
        /// Remove event subscription by id.
        /// </summary>
        /// <param name="eventSubscriptionId"></param>
        /// <returns></returns>
        public Task RemoveEventSubscription(string eventSubscriptionId);
    }
}
