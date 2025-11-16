using System.Security.Cryptography.X509Certificates;

namespace TranscriptSubscriptionSample.Utilities
{
    public class CertificateLoader
    {
        public static X509Certificate2 LoadFromCertificateStore(string thumbprint)
        {
            using var store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
            store.Open(OpenFlags.ReadOnly);

            var certificates = store.Certificates.Find(X509FindType.FindByThumbprint, thumbprint, false);

            if (certificates.Count > 0)
            {
                return certificates[0];
            }

            throw new InvalidOperationException($"Certificate with thumbprint {thumbprint} not found");
        }

        public static X509Certificate2 LoadFromCertificateStoreWithFlag(string thumbprint, string password)
        {
            var originalCert = LoadFromCertificateStore(thumbprint);

            // Export the certificate with private key (if available)
            byte[] certData;
            try
            {
                // Try to export with private key
                certData = originalCert.Export(X509ContentType.Pfx);
            }
            catch (Exception ex)
            {
                // If private key export fails, just return the original certificate
                // This might happen if the private key is not exportable
                return originalCert;
            }

            // Reload the certificate with desired flags
            return new X509Certificate2(
                certData,
                (string)null, // No password needed for in-memory export
                X509KeyStorageFlags.Exportable | X509KeyStorageFlags.EphemeralKeySet
            );
        }

        public static X509Certificate2 LoadFromFile(string path, string password)
        {
            return new X509Certificate2(
                path,
                password,
                X509KeyStorageFlags.Exportable | X509KeyStorageFlags.EphemeralKeySet);
        }
    }
}
