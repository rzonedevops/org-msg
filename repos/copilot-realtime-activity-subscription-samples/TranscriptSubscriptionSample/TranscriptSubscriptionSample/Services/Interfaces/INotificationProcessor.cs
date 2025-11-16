namespace TranscriptSubscriptionSample.Services
{
    /// <summary>
    /// This interface defines a contract for processing notifications received for meeting events.
    /// </summary>
    public interface INotificationProcessor
    {
        /// <summary>
        /// Process the notification asynchronously
        /// </summary>
        /// <param name="payload">The payload of the notification.</param>
        /// <returns></returns>
        Task ProcessNotificationAsync(string payload);
    }
}
