using Microsoft.Extensions.Options;
using TranscriptSubscriptionSample.Configurations;
using TranscriptSubscriptionSample.Models;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text.Json;

namespace TranscriptSubscriptionSample.Utilities
{
    /// <summary>
    /// This class provides methods to decrypt encrypted notifications received from Microsoft Graph webhooks.
    /// </summary>
    public class NotificationDecryption
    {
        public static string DecryptNotification(EncryptedContent encryptedContent, X509Certificate2 certificate)
        {
            return DecryptStringWithRSA(encryptedContent, certificate);
        }

        private static string DecryptStringWithRSA(EncryptedContent encryptedContent, X509Certificate2 certificate)
        {
            byte[] decryptedSymmetricKey = DecryptSymmetricKey(encryptedContent.DataKey, certificate);
            byte[] encryptedPayload = Convert.FromBase64String(encryptedContent.Data);
            byte[] expectedSignature = Convert.FromBase64String(encryptedContent.DataSignature);
            byte[] actualSignature;

            using (HMACSHA256 hmac = new HMACSHA256(decryptedSymmetricKey))
            {
                actualSignature = hmac.ComputeHash(encryptedPayload);
            }

            if (actualSignature.SequenceEqual(expectedSignature))
            {
                return DecryptStringWithAES(encryptedPayload, decryptedSymmetricKey);
            }
            else
            {
                throw new Exception("Encryption signature validation failed");
            }
        }

        private static byte[] DecryptSymmetricKey(string dataKey, X509Certificate2 certificate)
        {
            using (RSA rsa = certificate.GetRSAPrivateKey())
            {
                if (rsa == null)
                {
                    throw new InvalidOperationException("Unable to access private key");
                }

                // Test key access by exporting parameters (if allowed)
                try
                {
                    var parameters = rsa.ExportParameters(false); // public only
                    Console.WriteLine("Private key is accessible");

                    byte[] encryptedSymmetricKey = Convert.FromBase64String(dataKey);
                    return rsa.Decrypt(encryptedSymmetricKey, RSAEncryptionPadding.OaepSHA1);

                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Private key access issue: {ex.Message}");
                    throw;
                }
            }
        }

        private static string DecryptStringWithAES(byte[] encryptedPayload, byte[] decryptedSymmetricKey)
        {
            Aes aesProvider = Aes.Create();
            aesProvider.Key = decryptedSymmetricKey;
            aesProvider.Padding = PaddingMode.PKCS7;
            aesProvider.Mode = CipherMode.CBC;

            // Obtain the initialization vector from the symmetric key itself.
            int vectorSize = 16;
            byte[] iv = new byte[vectorSize];
            Array.Copy(decryptedSymmetricKey, iv, vectorSize);
            aesProvider.IV = iv;

            string decryptedResourceData;
            // Decrypt the resource data content.
            using (var decryptor = aesProvider.CreateDecryptor())
            {
                using (MemoryStream msDecrypt = new MemoryStream(encryptedPayload))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {
                            decryptedResourceData = srDecrypt.ReadToEnd();
                            return decryptedResourceData;
                        }
                    }
                }
            }
        }
    }
}
