namespace TranscriptSubscriptionSample.Models.Common
{
    public class CustomException : Exception
    {
        public int Code { get; }

        public CustomException(int code, string message, Exception innerException = null) : base(message, innerException)
        {
            Code = code;
        }
    }
}
