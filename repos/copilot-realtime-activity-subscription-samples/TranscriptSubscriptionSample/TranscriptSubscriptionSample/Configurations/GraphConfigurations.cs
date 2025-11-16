namespace TranscriptSubscriptionSample.Configurations
{
    /// <summary>
    /// This class holds configuration settings for Microsoft Graph API integration
    /// </summary>
    public class GraphConfigurations
    {
        /// <summary>
        /// The Application (client) ID of the Azure AD app
        /// </summary>
        public string ClientId { get; set; }

        /// <summary>
        /// The tenant ID of the Azure AD
        /// </summary>
        public string TenantId { get; set; }

        /// <summary>
        /// The endpoint for Microsoft Graph API
        /// </summary>
        public string GraphEndpoint { get; set; }

        /// <summary>
        /// The scope for Microsoft Graph API
        /// </summary>
        public List<string> AppScopes { get; set; }

        /// <summary>
        /// The scope for Microsoft Graph API
        /// </summary>
        public List<string> UserScopes { get; set; }

        /// <summary>
        /// The certificate thumbprint used for app authentication
        /// </summary>
        public string CertificateThumbprint { get; set; }

        /// <summary>
        /// The file name of the certificate used for app authentication
        /// </summary>
        public string CertificateFileName { get; set; }

        /// <summary>
        /// The certificate password used for app authentication
        /// </summary>
        public string CertificatePassword { get; set; }

        /// <summary>
        /// The URL for receiving Microsoft Graph change notifications. This url would be 
        /// https://contoso.com/api/notifications where contoso.com is your domain name.
        /// </summary>
        public string NotificationUrl { get; set; }
    }
}
