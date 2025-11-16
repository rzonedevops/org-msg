using TranscriptSubscriptionSample.Models;
using TranscriptSubscriptionSample.Services;

namespace TranscriptSubscriptionSample.Handlers
{
    /// <summary>
    /// Provides a factory for creating instances of <see cref="SubscriptionHandler"/>.
    /// </summary>
    /// <remarks>This factory is responsible for constructing <see cref="SubscriptionHandler"/> objects with
    /// the necessary dependencies, including logging and authentication services.</remarks>
    public class SubscriptionHandlerFactory : ISubscriptionHandlerFactory
    {
        private readonly ILoggerFactory loggerFactory;
        private readonly IAuthService authService;

        public SubscriptionHandlerFactory(ILoggerFactory loggerFactory, IAuthService authService)
        {
            this.loggerFactory = loggerFactory ?? throw new ArgumentNullException(nameof(loggerFactory));
            this.authService = authService ?? throw new ArgumentNullException(nameof(authService));
        }

        public SubscriptionHandler CreateHandler(SubscriptionInfo subscription)
        {
            var logger = loggerFactory.CreateLogger<SubscriptionHandler>();
            return new SubscriptionHandler(subscription, logger, authService);
        }
    }
}