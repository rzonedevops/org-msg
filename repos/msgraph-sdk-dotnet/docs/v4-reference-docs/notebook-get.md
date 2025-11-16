---
title: "Get notebook"
description: "Retrieve the properties and relationships of a notebook object."
author: "jewan-microsoft"
ms.localizationpriority: medium
ms.prod: "onenote"
doc_type: apiPageType
---

# Get notebook

Namespace: microsoft.graph

Retrieve the properties and relationships of a [notebook](../resources/notebook.md) object.
## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Notes.Create, Notes.Read, Notes.ReadWrite, Notes.Read.All, Notes.ReadWrite.All    |
|Delegated (personal Microsoft account) | Notes.Create, Notes.Read, Notes.ReadWrite    |
|Application | Notes.Read.All, Notes.ReadWrite.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /me/onenote/notebooks/{id}
GET /users/{id | userPrincipalName}/onenote/notebooks/{id}
GET /groups/{id}/onenote/notebooks/{id}
GET /sites/{id}/onenote/notebooks/{id}
```
## Optional query parameters
This method supports the `select` and `expand` [OData Query Parameters](/graph/query-parameters) to help customize the response.

Valid `expand` values for notebooks are `sections` and `sectionGroups`.

## Request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| Authorization  | string  | Bearer {token}. Required. |
| Accept | string | `application/json` |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and a [notebook](../resources/notebook.md) object in the response body.
## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_notebook",
  "sampleKeys": ["1-e13f257d-78c6-46cf-ae8c-13686517ac5f"]
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/onenote/notebooks/1-e13f257d-78c6-46cf-ae8c-13686517ac5f
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var notebook = await graphClient.Me.Onenote.Notebooks["{notebook-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

