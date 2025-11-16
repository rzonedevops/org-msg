---
title: "List contacts"
description: "Get a contact collection from the default Contacts folder of the signed-in user (`.../me/contacts`), or from the specified contact folder."
ms.localizationpriority: medium
author: "kevinbellinger"
ms.prod: "outlook"
doc_type: apiPageType
---

# List contacts

Namespace: microsoft.graph

Get a contact collection from the default Contacts folder of the signed-in user (`.../me/contacts`), or from the specified contact folder.
## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Contacts.Read, Contacts.ReadWrite    |
|Delegated (personal Microsoft account) | Contacts.Read, Contacts.ReadWrite    |
|Application | Contacts.Read, Contacts.ReadWrite |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /me/contacts
GET /users/{id | userPrincipalName}/contacts

GET /me/contactFolders/{id}/contacts
GET /users/{id | userPrincipalName}/contactFolders/{id}/contacts
```
## Optional query parameters
This method supports the [OData Query Parameters](/graph/query-parameters) to help customize the response.
## Request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| Authorization  | string  | Bearer {token}. Required. |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and collection of [Contact](../resources/contact.md) objects in the response body.
## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "contactfolder_get_contacts"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/contactFolders/{id}/contacts
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var contacts = await graphClient.Me.ContactFolders["{contactFolder-id}"].Contacts
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

