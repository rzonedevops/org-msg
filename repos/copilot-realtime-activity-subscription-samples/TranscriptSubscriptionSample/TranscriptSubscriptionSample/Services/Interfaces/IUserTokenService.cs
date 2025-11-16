namespace TranscriptSubscriptionSample.Services
{
    public interface IUserTokenService
    {
        Task<string> GetAccessTokenForUserAsync();
    }
}
