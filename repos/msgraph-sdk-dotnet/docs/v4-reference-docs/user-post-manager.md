---
title: "Assign manager"
description: "Assign a user's manager."
ms.localizationpriority: medium
author: "yyuank"
ms.prod: "users"
doc_type: apiPageType
---

# Assign manager

Namespace: microsoft.graph

Assign a user's manager.
> [!NOTE]
> You cannot assign direct reports; instead, use this API.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | User.ReadWrite.All, Directory.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | User.ReadWrite.All, Directory.ReadWrite.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
PUT /users/{id}/manager/$ref
```
## Request headers
| Header       | Value |
|:---------------|:----------|
| Authorization  | Bearer {token}. Required. |
| Content-type   | application/json. Required.|

## Request body
In the request body, supply a JSON object and pass an `@odata.id` parameter with the read URL of the [directoryObject](../resources/directoryobject.md), [user](../resources/user.md), or [organizational contact](../resources/orgcontact.md) object to be added.

## Response

If successful, this method returns `204 No Content` response code. It does not return anything in the response body.

## Example
##### Request
The following is an example of the request. The request body is a JSON object with an `@odata.id` parameter and the read URL for the [user](../resources/user.md) object to be assigned as a manager.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_manager_from_group"
}-->
```http
PUT https://graph.microsoft.com/v1.0/users/10f17b99-784c-4526-8747-aec8a3159d6a/manager/$ref
Content-type: application/json

{
  "@odata.id": "https://graph.microsoft.com/v1.0/users/6ea91a8d-e32e-41a1-b7bd-d2d185eed0e0"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

await graphClient.Users["{user-id}"].Manager.Reference
	.Request()
	.PutAsync("6ea91a8d-e32e-41a1-b7bd-d2d185eed0e0");

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

