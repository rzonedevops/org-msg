---
author: swapnil1993
ms.date: 08/30/2020
title: "Create a columnDefinition in a site"
description: "Create a site column."
ms.localizationpriority: medium
doc_type: apiPageType
ms.prod: "sites-and-lists"
---

# Create a columnDefinition in a site
Namespace: microsoft.graph

Create a column for a [site][site] with a request that specifies a [columnDefinition][columnDefinition].

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

  

|Permission type | Permissions (from least to most privileged) |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Sites.Manage.All, Sites.FullControl.All |
|Delegated (personal Microsoft account) | Not supported. |
|Application | Sites.Manage.All, Sites.FullControl.All |

  

## HTTP request

<!-- { "blockType": "ignored" } -->
```http
POST /sites/{site-id}/columns
```

## Request body

In the request body, supply a JSON representation of the [columnDefinition][] resource to add.  

## Response

If successful, this method returns a `201 Created` response code and [columnDefinition][] object in the response body.

## Example

### Request

# [HTTP](#tab/http)
<!-- { "blockType": "request", "name": "site_post_columns" } -->
```http
POST https://graph.microsoft.com/v1.0/sites/{site-id}/columns
Content-Type: application/json

{
   "description":"test",
   "enforceUniqueValues":false,
   "hidden":false,
   "indexed":false,
   "name":"Title",
   "text":{
      "allowMultipleLines":false,
      "appendChangesToExistingText":false,
      "linesForEditing":0,
      "maxLength":255
   }
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var columnDefinition = new ColumnDefinition
{
	Description = "test",
	EnforceUniqueValues = false,
	Hidden = false,
	Indexed = false,
	Name = "Title",
	Text = new TextColumn
	{
		AllowMultipleLines = false,
		AppendChangesToExistingText = false,
		LinesForEditing = 0,
		MaxLength = 255
	}
};

await graphClient.Sites["{site-id}"].Columns
	.Request()
	.AddAsync(columnDefinition);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

<!-- { "blockType": "response", "@type": "microsoft.graph.columnDefinition", "truncated": true } -->

  

```http
HTTP/1.1 201 Created
Content-type: application/json

{
   "description":"test",
   "displayName":"Title",
   "enforceUniqueValues":false,
   "hidden":false,
   "id":"99ddcf45-e2f7-4f17-82b0-6fba34445103",
   "indexed":false,
   "name":"Title",
   "text":{
      "allowMultipleLines":false,
      "appendChangesToExistingText":false,
      "linesForEditing":0,
      "maxLength":255
   }
}
```

  

[columnDefinition]: ../resources/columnDefinition.md
[site]: ../resources/site.md
  

