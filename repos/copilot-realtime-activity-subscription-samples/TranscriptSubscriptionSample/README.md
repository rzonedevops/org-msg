# Transcript Subscription Sample
This sample demonstrates how to create a transcript subscription using the Graph Beta API. A transcript subscription allows you to receive real-time transcription of audio streams.

## Prerequisites
- An Azure account with an active subscription.
- Microsoft Graph Beta API access.
- Copilot license for your tenant or user.
- An application registered in Azure AD with the necessary permissions to access the Graph API.
- .NET SDK installed on your development machine.
- Visual Studio or any other C# development environment.

## Setup

### Register your application in Azure AD

1. Go to the [Azure Portal](https://portal.azure.com/) and navigate to "Azure Active Directory".
2. Click on "App registrations" and then "New registration".
3. Fill in the required details and click "Register".
4. Once registered, note down the Application (client) ID and Directory (tenant) ID.
5. Under "Certificates & secrets", upload a certificate. You can create and upload a self-signed certificate for testing purposes.
6. Under "API permissions", add the following permissions:
   - `RealtimeActivityFeed.Read.All` (Application or Delegated)
   - `OnlineMeetings.Read.All` (Application)
   - `OnlineMeetings.ReadWrite.All` (Application)

### Register Bot in Teams Store
1. Go to the [Azure Portal](https://portal.azure.com/) and navigate to "Create a resource".
2. Search for "Bot Services", click "Create" and then select "Azure Bot".
3. Fill in all the details. Select "Use existing app registration" and select the app you registered in the previous step.
4. Click "Create" to provision the bot.
5. Once the resource is provisioned, go to the resource and navigate to "Channels" by expanding "Settings".
6. Select "Microsoft Teams". Go to "Calling" tab and enable "Allow calling". Add the callback URL and press "Apply".

### Configure your development environment

1. Clone this repository to your local machine.
2. Open the solution in Visual Studio or your preferred C# development environment.
3. Update the `appsettings.json` file with your Azure AD application details and other details:
   ```json
   {
     "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "Domain": "contoso.onmicrosoft.com",
        "CallbackPath": "/signin-oidc",
        "SignedOutCallbackPath": "/signout-callback-oidc"
     },
     "GraphConfigurations": {
        "ClientId": "[AAD_APP_ID]", // Application (client) ID
        "TenantId": "[TENANT_ID_HERE]", // Directory (tenant) ID
        "GraphEndpoint": "https://graph.microsoft.com/beta/", // Use the Beta endpoint
        "AppScopes": [ "https://graph.microsoft.com/.default" ], // Application permissions
        "UserScopes": [ "realtimeactivityfeed.read.all" ], // Delegated permissions
        "CertificateThumbprint": "[CERTIFICATE_THUMBPRINT]", // Thumbprint of the uploaded certificate
        "CertificateFileName": "[PFX_CERTIFICATE_FILE_NAME]", // File name of the .pfx certificate file.
        "CertificatePassword": "[CERTIFICATE_PASSWORD]", // Password for the .pfx certificate file.
        "NotificationUrl": "[NOTIFICATION_URL]" // Your notification URL for receiving event notifications. This will be the base url of your application.
      }
   }
   ``` 
4. Add the self-signed certificate to your development machine's certificate store as well as in 'Certificates' folder of the project.
5. Build the solution to restore the NuGet packages.
6. Run the application.

