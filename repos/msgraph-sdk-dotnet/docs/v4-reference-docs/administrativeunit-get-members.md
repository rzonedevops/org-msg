---
title: "Get a member"
description: "Use this API to get a specific member (user, group, or device) in an administrative unit."
author: "DougKirschner"
ms.localizationpriority: medium
ms.prod: "directory-management"
doc_type: apiPageType
---

# Get a member

Namespace: microsoft.graph

Use this API to get a specific member (user, group, or device) in an administrative unit.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | AdministrativeUnit.Read.All, Directory.Read.All, AdministrativeUnit.ReadWrite.All, Directory.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | AdministrativeUnit.Read.All, Directory.Read.All, AdministrativeUnit.ReadWrite.All, Directory.ReadWrite.All |

## HTTP request

```http
GET /directory/administrativeUnits/{id}/members/{id}
```
## Request headers
| Name      |Description|
|:----------|:----------|
| Authorization  | Bearer {token}. Required. |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and a [user](../resources/user.md), [group](../resources/group.md), or [device](../resources/device.md) object in the response body.

## Example

### Request
Here is an example of the request.


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_administrativeunit_members"
} -->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/directory/administrativeUnits/8a07f5a8-edc9-4847-bbf2-dde106594bf4/members/5bde3e51-d13b-4db1-9948-fe4b109d11a7
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var directoryObject = await graphClient.Directory.AdministrativeUnits["{administrativeUnit-id}"].Members["{directoryObject-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
Here is an example of the response.
>**Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.administrativeUnit"
} -->
```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#directoryObjects/$entity",
    "@odata.type": "#microsoft.graph.user",
    "id": "5bde3e51-d13b-4db1-9948-fe4b109d11a7",
    "businessPhones": [
        "8006427676"
    ],
    "displayName": "MOD Administrator",
    "givenName": "MOD",
    "jobTitle": null,
    "mail": "admin@M365x214355.onmicrosoft.com",
    "mobilePhone": "5555555555",
    "officeLocation": null,
    "preferredLanguage": "en-US",
    "surname": "Administrator",
    "userPrincipalName": "admin@M365x214355.onmicrosoft.com"
}
```
