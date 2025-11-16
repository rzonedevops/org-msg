using Microsoft.Extensions.Logging;
using System.Collections.Concurrent;

namespace TranscriptSubscriptionSample.Logging
{
    public class LogEntry
    {
        public DateTime Timestamp { get; set; }
        public LogLevel LogLevel { get; set; }
        public string Category { get; set; }
        public string Message { get; set; }
        public string Exception { get; set; }
        public int EventId { get; set; }
        public string EventName { get; set; }
    }

    public class InMemoryLogger : ILogger
    {
        private readonly string _categoryName;
        private readonly ILogStore _logStore;

        public InMemoryLogger(string categoryName, ILogStore logStore)
        {
            _categoryName = categoryName;
            _logStore = logStore;
        }

        public IDisposable BeginScope<TState>(TState state) => null;

        public bool IsEnabled(LogLevel logLevel) => true;

        public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception exception, Func<TState, Exception, string> formatter)
        {
            if (!IsEnabled(logLevel))
            {
                return;
            }

            var logEntry = new LogEntry
            {
                Timestamp = DateTime.UtcNow,
                LogLevel = logLevel,
                Category = _categoryName,
                Message = formatter(state, exception),
                Exception = exception?.ToString(),
                EventId = eventId.Id,
                EventName = eventId.Name
            };

            _logStore.AddLog(logEntry);
        }
    }
}