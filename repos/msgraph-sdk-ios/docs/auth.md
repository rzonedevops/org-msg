# Authenticate your iOS app for Microsoft Graph

## Authentication Endpoint
Authentication can be done using one of two endpoints:
* [Azure Active Directory (AAD) endpoint](https://msdn.microsoft.com/en-us/library/azure/dn645545.aspx)
* [V2 Authentication endpoint](https://azure.microsoft.com/en-us/documentation/articles/active-directory-appmodel-v2-overview/) (preview)

AAD (V1) authentication will allow you to authenticate with a business or school account, whereas the V2 Authentication endpoint allows authentication with either business/school accounts or personal Microsoft accounts.

The AAD endpoint requries your app to be registered on the Azure management portal, either [directly](https://manage.windowsazure.com) or via the [Office 365 App Registration Tool](http://dev.office.com/app-registration).
The V2 Authentication endpoint requires your app to be registered on [apps.dev.microsoft.com](https://apps.dev.microsoft.com).

Links to both can be found [here](https://graph.microsoft.io/en-us/app-registration).

## MSAuthenticationProvider
The authentication component of the Microsoft Graph SDK for iOS is abstracted behind the MSAuthenticationProvider protocol. The protocol defines a single method:

```objc
/**
   Appends the proper authentication headers to the given request.
   @param request The request to append headers to.
   @param completionHandler The completion handler to be called when the auth headers have been appended.
          error should be non nil if there was no error, and should contain any error(s) that occurred.
 */
- (void) appendAuthenticationHeaders:(NSMutableURLRequest *)request completion:(MSAuthenticationCompletion)completionHandler;
```

Implementations of this protocol must obtain an OAuth 2.0 access token from one of the two endpoints above in a fashion suitable to the application, and implement the appendAuthenticationHeaders:completion: method such that the access token is appended to the supplied request object and the completion handler is invoked.

As a matter of convenience, a MSBlockAuthenticationProvider class exists which can be instantiated with just a block implementing the required protocol method:
```objc
MSAuthenticationProvider provider = [MSBlockAuthenticationProvider providerWithBlock:^void (NSMutableURLRequest *request, MSAuthenticationCompletion completion) {
	// Append auth header to request
	// Invoke completion
}]
```

## Quick Start
As different scenarios have varying authentication requirements, the Microsoft Graph SDK for iOS does not bundle an authentication implementation. However, a limited-scope sample implementation of MSAuthenticationProvider can be found [here](https://github.com/microsoftgraph/msgraph-sdk-ios-nxoauth2-adapter). This quick-start implementation uses a 3rd party OAuth 2.0 library to authenticate against the V2 Authentication endpoint. It can be included directly as a CocoaPod (`MSGraphSDK-NXOAuth2Adapter`) or simply used as a starting point for creating your own implementation.