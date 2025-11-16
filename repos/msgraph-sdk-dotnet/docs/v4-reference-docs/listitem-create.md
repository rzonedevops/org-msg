---
author: JeremyKelley
ms.date: 09/11/2017
title: Create a new entry in a SharePoint list
ms.localizationpriority: high
ms.prod: "sharepoint"
description: "Create a new listItem in a list."
doc_type: apiPageType
---
# Create a new item in a list

Namespace: microsoft.graph

Create a new [listItem][] in a [list][].

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Sites.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Sites.ReadWrite.All |

## HTTP request

<!-- { "blockType": "ignored" } -->

```http
POST https://graph.microsoft.com/v1.0/sites/{site-id}/lists/{list-id}/items
```

## Request body

In the request body, supply a JSON representation of the [listItem][] resource to create.

## Example

Here is an example of how to create a new generic list item.


# [HTTP](#tab/http)
<!-- { "blockType": "request", "name": "create-listitem", "scopes": "sites.readwrite.all" } -->

```http
POST https://graph.microsoft.com/v1.0/sites/{site-id}/lists/{list-id}/items
Content-Type: application/json

{
  "fields": {
    "Title": "Widget",
    "Color": "Purple",
    "Weight": 32
  }
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var listItem = new ListItem
{
	Fields = new FieldValueSet
	{
		AdditionalData = new Dictionary<string, object>()
		{
			{"Title", "Widget"},
			{"Color", "Purple"},
			{"Weight", "32"}
		}
	}
};

await graphClient.Sites["{site-id}"].Lists["{list-id}"].Items
	.Request()
	.AddAsync(listItem);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

