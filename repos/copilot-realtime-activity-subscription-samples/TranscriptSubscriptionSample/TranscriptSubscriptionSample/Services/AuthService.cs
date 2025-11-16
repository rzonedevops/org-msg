using Microsoft.Extensions.Options;
using Microsoft.Identity.Client;
using TranscriptSubscriptionSample.Configurations;
using TranscriptSubscriptionSample.Models.Common;
using TranscriptSubscriptionSample.Utilities;
using System.Security.Cryptography.X509Certificates;

namespace TranscriptSubscriptionSample.Services
{
    /// <summary>
    /// This service is responsible for acquiring and managing authentication tokens
    /// </summary>
    public class AuthService : IAuthService
    {
        private readonly GraphConfigurations graphConfig;
        private readonly IWebHostEnvironment environment;
        private IConfidentialClientApplication confidentialClientApp;

        public AuthService(IOptions<GraphConfigurations> graphConfig, IWebHostEnvironment environment)
        {
            this.graphConfig = graphConfig.Value;
            this.environment = environment;
            InitializeConfidentialClientApp();
        }

        private void InitializeConfidentialClientApp()
        {
            var options = new ConfidentialClientApplicationOptions
            {
                ClientName = "Contoso",
                ClientId = graphConfig.ClientId,
                ClientVersion = this.GetType().Assembly.GetName().Version.ToString(),
                TenantId = graphConfig.TenantId,
                LogLevel = Microsoft.Identity.Client.LogLevel.Info,
                EnablePiiLogging = true,
                IsDefaultPlatformLoggingEnabled = false,
                AzureCloudInstance = AzureCloudInstance.AzurePublic,
            };

            ConfidentialClientApplicationBuilder builder = ConfidentialClientApplicationBuilder
                .CreateWithApplicationOptions(options);

            var certificate = CertificateLoader.LoadFromCertificateStore(graphConfig.CertificateThumbprint);

            confidentialClientApp = builder.WithCertificate(certificate).Build();
        }

        /// <summary>
        /// Retrieves an access token for Microsoft Graph API
        /// </summary>
        /// <returns>The task containing the access token</returns>
        /// <exception cref="CustomException"></exception>
        public async Task<string> GetAccessTokenAsync()
        {
            try
            {
                var result = await this.AcquireTokenWithRetryAsync(confidentialClientApp, attempts: 1).ConfigureAwait(false);
                return result.AccessToken;
            }
            catch (MsalException ex)
            {
                throw new CustomException(500, $"Failed to acquire token: {ex.Message}", ex);
            }
        }

        private async Task<AuthenticationResult> AcquireTokenWithRetryAsync(IConfidentialClientApplication app, int attempts)
        {
            while (true)
            {
                attempts--;

                try
                {
                    return await app
                        .AcquireTokenForClient(graphConfig.AppScopes)
                        .ExecuteAsync()
                        .ConfigureAwait(false);
                }
                catch (Exception)
                {
                    if (attempts < 1)
                    {
                        throw;
                    }
                }
            }
        }
    }
}