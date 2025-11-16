---
title: "outlookUser: supportedLanguages"
description: "Get the list of locales and languages that are supported for the user, as configured on the user's mailbox server."
ms.localizationpriority: medium
author: "abheek-das"
ms.prod: "outlook"
doc_type: apiPageType
---

# outlookUser: supportedLanguages

Namespace: microsoft.graph

Get the list of locales and languages that are supported for the user, as configured on the user's mailbox server.

When setting up an Outlook client, the user selects the preferred language from this supported list. You can subsequently get the preferred language by 
[getting the user's mailbox settings](user-get-mailboxsettings.md).


## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | User.Read, User.ReadBasic.All    |
|Delegated (personal Microsoft account) | User.Read    |
|Application | User.Read.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /me/outlook/supportedLanguages
GET /users/{id|userPrincipalName}/outlook/supportedLanguages
```
## Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| Authorization  | string  | Bearer {token}. Required. |


## Request body
Do not supply a request body for this method.

## Response
If successful, this method returns `200 OK` response code and a collection of [localeInfo](../resources/localeinfo.md) objects in the response body.

## Example
Here is an example of how to call this API.
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "user_supportedlanguages"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/outlook/supportedLanguages
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var supportedLanguages = await graphClient.Me.Outlook
	.SupportedLanguages()
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

