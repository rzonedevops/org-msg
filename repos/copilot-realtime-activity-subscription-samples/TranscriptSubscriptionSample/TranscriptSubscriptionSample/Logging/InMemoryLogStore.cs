using System.Collections.Concurrent;

namespace TranscriptSubscriptionSample.Logging
{
    public interface ILogStore
    {
        void AddLog(LogEntry entry);
        IEnumerable<LogEntry> GetLogs(int? count = null, LogLevel? minLevel = null, string category = null);
        void Clear();
    }

    public class InMemoryLogStore : ILogStore
    {
        private readonly ConcurrentQueue<LogEntry> logs = new();
        private readonly int maxLogsCount;

        public InMemoryLogStore(int maxLogsCount = 10000)
        {
            this.maxLogsCount = maxLogsCount;
        }

        public void AddLog(LogEntry entry)
        {
            logs.Enqueue(entry);

            // Maintain max size
            while (logs.Count > maxLogsCount)
            {
                logs.TryDequeue(out _);
            }
        }

        public IEnumerable<LogEntry> GetLogs(int? count = null, LogLevel? minLevel = null, string category = null)
        {
            var query = logs.AsEnumerable();

            if (minLevel.HasValue)
            {
                query = query.Where(l => l.LogLevel >= minLevel.Value);
            }

            if (!string.IsNullOrEmpty(category))
            {
                query = query.Where(l => l.Category.Contains(category, StringComparison.OrdinalIgnoreCase));
            }

            query = query.OrderByDescending(l => l.Timestamp);

            if (count.HasValue)
            {
                query = query.Take(count.Value);
            }

            return query.ToList();
        }

        public void Clear()
        {
            logs.Clear();
        }
    }
}
