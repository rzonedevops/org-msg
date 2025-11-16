---
title: "group: renew"
description: "Renews a group's expiration. When a group is renewed, the group expiration is extended by the number of days defined in the policy."
ms.localizationpriority: medium
author: "psaffaie"
ms.prod: "groups"
doc_type: apiPageType
---

# group: renew

Namespace: microsoft.graph

Renews a group's expiration. When a group is renewed, the group expiration is extended by the number of days defined in the policy.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

| Permission type                        | Permissions (from least to most privileged)    |
| :------------------------------------- | :--------------------------------------------- |
| Delegated (work or school account)     | Group.ReadWrite.All or Directory.ReadWrite.All |
| Delegated (personal Microsoft account) | Not supported                                  |
| Application                            | Group.ReadWrite.All or Directory.ReadWrite.All |

## HTTP request

<!-- { "blockType": "ignored" } -->

```http
POST /groups/{id}/renew
```

## Request headers

| Name          | Description               |
| :------------ | :------------------------ |
| Authorization | Bearer {token}. Required. |

## Request body

Do not supply a request body for this method.

## Response

If successful, this method returns `204 No Content` response code. It does not return anything in the response body.

## Example

### Request

# [HTTP](#tab/http)

<!-- {
  "blockType": "request",
  "name": "group_renew"
}-->

```http
POST https://graph.microsoft.com/v1.0/groups/{id}/renew
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

await graphClient.Groups["{group-id}"]
	.Renew()
	.Request()
	.PostAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

<!-- {
  "blockType": "response"
} -->

```http
HTTP/1.1 204 No Content
```

<!-- uuid: 8fcb5dbc-d5aa-4681-8e31-b001d5168d79
2015-10-25 14:57:30 UTC -->
<!-- {
  "type": "#page.annotation",
  "description": "group: renew",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": [
  ]
}-->
