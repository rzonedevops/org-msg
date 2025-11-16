using TranscriptSubscriptionSample.Models;

namespace TranscriptSubscriptionSample.Handlers
{
    /// <summary>
    /// This interface defines a factory for creating subscription handlers.
    /// </summary>
    public interface ISubscriptionHandlerFactory
    {
        SubscriptionHandler CreateHandler(SubscriptionInfo subscription);
    }
}