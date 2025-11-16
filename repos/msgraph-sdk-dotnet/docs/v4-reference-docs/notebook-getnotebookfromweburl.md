---
title: "notebook: getNotebookFromWebUrl"
description: "Retrieve the properties and relationships of a notebook object using its URL path."
author: "jewan-microsoft"
ms.localizationpriority: medium
ms.prod: "onenote"
doc_type: apiPageType
---

# notebook: getNotebookFromWebUrl

Namespace: microsoft.graph

Retrieve the properties and relationships of a [notebook](../resources/notebook.md) object by using its URL path.

The location can be user notebooks on Microsoft 365, group notebooks, or SharePoint site-hosted team notebooks on Microsoft 365.
## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Notes.Create, Notes.Read, Notes.ReadWrite, Notes.Read.All, Notes.ReadWrite.All    |
|Application | Notes.Read.All, Notes.ReadWrite.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /me/onenote/notebooks/GetNotebookFromWebUrl
POST /users/{id | userPrincipalName}/onenote/notebooks/GetNotebookFromWebUrl
POST /groups/{id}/onenote/notebooks/GetNotebookFromWebUrl
POST /sites/{id}/onenote/notebooks/GetNotebookFromWebUrl
```
## Request headers
| Name       | Type | Description|
|:-----------|:------|:----------|
| Authorization  | string  | Bearer {token}. Required. |
| Accept | string | `application/json` |

## Request body
In the request body, supply a JSON representation of the full URL path to the notebook you want to retrieve.

| Property     | Type        | Description |
|:-------------|:------------|:------------|
| `webUrl`     |`String`     | The URL path of the notebook to retrieve. It can also contain a "onenote:" prefix.|

## Response

If successful, this method returns a `200 OK` response code and a [notebook](../resources/notebook.md) object in the response body.
## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "notebook_fromweburl"
}-->
```http
POST https://graph.microsoft.com/v1.0/me/onenote/notebooks/GetNotebookFromWebUrl
Content-type: application/json

{"webUrl":"webUrl value"}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var webUrl = "webUrl value";

await graphClient.Me.Onenote.Notebooks
	.GetNotebookFromWebUrl(webUrl)
	.Request()
	.PostAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

