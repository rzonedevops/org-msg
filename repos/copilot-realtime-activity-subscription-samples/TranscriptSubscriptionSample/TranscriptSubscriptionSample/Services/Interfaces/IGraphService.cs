using Microsoft.Graph.Beta.Models;

namespace TranscriptSubscriptionSample.Services
{
    /// <summary>
    /// This interface defines methods for interacting with Microsoft Graph API.
    /// </summary>
    public interface IGraphService
    {
        /// <summary>
        /// Subscribe to real-time activity feed for a given meeting join URL.
        /// </summary>
        /// <param name="meetingJoinUrl">The Teams meeting join url.</param>
        /// <returns></returns>
        public Task<MultiActivitySubscription> SubscribeToActivity(string meetingJoinUrl);

        /// <summary>
        /// Unsubscribe from real-time activity feed using the subscription ID.
        /// </summary>
        /// <param name="subscriptionId">The subscription ID.</param>
        /// <returns></returns>
        public Task UnsubscribeFromActivity(string subscriptionId);

        /// <summary>
        /// Subscribe to meeting events for a given organizer with the specified expiry time.
        /// </summary>
        /// <param name="organizerId">The organizer ID.</param>
        /// <param name="expirationDateTime">The expiry time.</param>
        /// <returns></returns>
        public Task<string> SubscribeToEvent(string organizerId, DateTime expirationDateTime);

        /// <summary>
        /// Remove an event subscription using the subscription ID.
        /// </summary>
        /// <param name="eventSubscriptionId"></param>
        /// <returns></returns>
        public Task RemoveEventSubscription(string eventSubscriptionId);
    }
}
