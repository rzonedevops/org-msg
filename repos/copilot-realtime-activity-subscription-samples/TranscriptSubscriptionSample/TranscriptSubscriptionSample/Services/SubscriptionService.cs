using TranscriptSubscriptionSample.Handlers;
using TranscriptSubscriptionSample.Models;
using TranscriptSubscriptionSample.Models.Common;
using System.Collections.Concurrent;

namespace TranscriptSubscriptionSample.Services
{
    /// <summary>
    /// This service is responsible for managing subscriptions to real-time activity feeds.
    /// </summary>
    public class SubscriptionService : ISubscriptionsService
    {
        private readonly IGraphService graphService;
        private readonly ISubscriptionHandlerFactory handlerFactory;

        /// <summary>
        /// Store active subscriptions and their handlers
        /// </summary>
        private readonly ConcurrentDictionary<string, SubscriptionHandler> subscriptions = new ConcurrentDictionary<string, SubscriptionHandler>();

        /// <summary>
        /// List of event subscriptions created in Graph
        /// </summary>
        private readonly List<EventSubscription> eventSubscriptions = new List<EventSubscription>();

        public SubscriptionService(IGraphService graphService, ISubscriptionHandlerFactory handlerFactory)
        {
            this.graphService = graphService ?? throw new ArgumentNullException(nameof(graphService));
            this.handlerFactory = handlerFactory ?? throw new ArgumentNullException(nameof(handlerFactory));
        }

        public async Task<SubscriptionInfo> AddSubscription(string meetingUrl)
        {
            var multiActivitySubscription = await graphService.SubscribeToActivity(meetingUrl);

            var subscription = new SubscriptionInfo()
            {
                Id = multiActivitySubscription.Id,
                MeetingUrl = meetingUrl,
                Status = SubscriptionStatus.InActive,
                StreamUrl = multiActivitySubscription.Activities.Transcript.Transport.Url
            };

            // Create handler for this subscription and start streaming it in the background
            var handler = handlerFactory.CreateHandler(subscription);
            await handler.StartStreamingAsync(subscription.StreamUrl);

            // Store the handler for future reference
            subscriptions.TryAdd(multiActivitySubscription.Id, handler);

            return subscription;
        }

        public List<SubscriptionInfo> GetAllSubscriptions()
        {
            return subscriptions.Values.Select(h => h.SubscriptionInfo).ToList();
        }

        public SubscriptionDetails GetSubscription(string subscriptionId)
        {
            if (subscriptions.TryGetValue(subscriptionId, out var handler))
            {
                return handler.SubscriptionDetails;
            }

            throw new CustomException(404, $"Subscription with id {subscriptionId} not found");
        }

        public void RemoveSubscription(string subscriptionId)
        {
            if (subscriptions.TryGetValue(subscriptionId, out var handler))
            {
                handler.Dispose();
                subscriptions.TryRemove(subscriptionId, out _);

                return;
            }

            throw new CustomException(404, $"Subscription with id {subscriptionId} not found");
        }

        public async Task Unsubscribe(string subscriptionId)
        {
            if (subscriptions.TryGetValue(subscriptionId, out var handler))
            {
                await graphService.UnsubscribeFromActivity(subscriptionId);
                return;
            }

            throw new CustomException(404, $"Subscription with id {subscriptionId} not found");
        }

        public async Task AddEventSubscription(EventSubscription eventSubscription)
        {
            if (eventSubscription == null)
            {
                throw new ArgumentNullException(nameof(eventSubscription));
            }

            var eventSubscriptionId = await graphService.SubscribeToEvent(eventSubscription.OrganizerId, eventSubscription.ExpirationDateTime);

            eventSubscription.Id = eventSubscriptionId;
            eventSubscriptions.Add(eventSubscription);
        }

        public EventSubscription GetEventSubscriptionById(string eventSubscriptionId)
        {
            var eventSubscription = eventSubscriptions.FirstOrDefault(es => es.Id == eventSubscriptionId);
            if (eventSubscription == null)
            {
                throw new CustomException(404, $"Event subscription with id {eventSubscriptionId} not found");
            }
            return eventSubscription;
        }

        public List<EventSubscription> GetAllEventSubscriptions()
        {
            return eventSubscriptions;
        }

        public async Task RemoveEventSubscription(string eventSubscriptionId)
        {
            var eventSubscription = eventSubscriptions.FirstOrDefault(es => es.Id == eventSubscriptionId);
            if (eventSubscription == null)
            {
                throw new CustomException(404, $"Event subscription with id {eventSubscriptionId} not found");
            }

            await graphService.RemoveEventSubscription(eventSubscriptionId);
            eventSubscriptions.Remove(eventSubscription);
        }
    }
}
