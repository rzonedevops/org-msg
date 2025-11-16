using System.Net.Http.Headers;
using TranscriptSubscriptionSample.Services;
using Microsoft.AspNetCore.Http;

namespace TranscriptSubscriptionSample.Handlers
{
    public class AuthenticationDelegatingHandler : DelegatingHandler
    {
        private readonly IAuthService authService;
        private readonly IHttpContextAccessor httpContextAccessor;
        private readonly IUserTokenService userTokenService;
        private readonly ILogger<AuthenticationDelegatingHandler> logger;

        public AuthenticationDelegatingHandler(
            IAuthService authService,
            IHttpContextAccessor httpContextAccessor,
            IUserTokenService userTokenService,
            ILogger<AuthenticationDelegatingHandler> logger)
        {
            this.authService = authService;
            this.httpContextAccessor = httpContextAccessor;
            this.userTokenService = userTokenService;
            this.logger = logger;
        }

        protected override async Task<HttpResponseMessage> SendAsync(
            HttpRequestMessage request,
            CancellationToken cancellationToken)
        {
            string accessToken = string.Empty;
            var isAppOnly = request.Headers.Contains("IsAppOnly");

            // Check if we have an authenticated user context
            var httpContext = httpContextAccessor.HttpContext;
            if (httpContext?.User?.Identity?.IsAuthenticated == true && !isAppOnly)
            {
                try
                {
                    // Try to get token for the current user
                    logger.LogDebug("Attempting to get user token for Graph API");
                   accessToken = await userTokenService.GetAccessTokenForUserAsync();
                    logger.LogDebug("Successfully obtained user token");
                }
                catch (Exception ex)
                {
                    logger.LogWarning(ex, "Failed to get user token, falling back to app token");
                }
            }

            // If no user token, fall back to application token
            if (string.IsNullOrEmpty(accessToken))
            {
                logger.LogDebug("Using application token for Graph API");
                accessToken = await authService.GetAccessTokenAsync();
            }

            // Add the bearer token to the Authorization header
            request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);

            // Continue with the request
            return await base.SendAsync(request, cancellationToken);
        }
    }
}