namespace TranscriptSubscriptionSample.Logging
{
    public class InMemoryLoggerProvider : ILoggerProvider
    {
        private readonly ILogStore _logStore;

        public InMemoryLoggerProvider(ILogStore logStore)
        {
            _logStore = logStore;
        }

        public ILogger CreateLogger(string categoryName)
        {
            return new InMemoryLogger(categoryName, _logStore);
        }

        public void Dispose() { }
    }
}
