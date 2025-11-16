using Microsoft.Extensions.Options;
using Microsoft.Identity.Web;
using TranscriptSubscriptionSample.Configurations;

namespace TranscriptSubscriptionSample.Services
{
    public class UserTokenService : IUserTokenService
    {
        private readonly ITokenAcquisition tokenAcquisition;
        private readonly ILogger<UserTokenService> logger;
        private readonly List<string> userScopes;

        public UserTokenService(
            ITokenAcquisition tokenAcquisition, 
            ILogger<UserTokenService> logger,
            IOptions<GraphConfigurations> graphConfigurations)
        {
            this.tokenAcquisition = tokenAcquisition;
            this.logger = logger;
            this.userScopes = graphConfigurations.Value.UserScopes;
        }

        public async Task<string> GetAccessTokenForUserAsync()
        {
            try
            {
                return await tokenAcquisition.GetAccessTokenForUserAsync(this.userScopes);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Failed to acquire token for user");
                throw;
            }
        }
    }
}