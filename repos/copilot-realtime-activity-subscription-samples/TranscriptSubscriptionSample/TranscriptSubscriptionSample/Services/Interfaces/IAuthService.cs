namespace TranscriptSubscriptionSample.Services
{
    /// <summary>
    /// The authentication service interface for obtaining access tokens.
    /// </summary>
    public interface IAuthService
    {
        Task<string> GetAccessTokenAsync();
    }
}