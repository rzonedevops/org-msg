---
title: "Add Named Item"
description: Add a new name to the collection of the given scope using the user's locale for the formula.
ms.localizationpriority: medium
author: "ruoyingl"
ms.prod: workbooks-and-charts
doc_type: apiPageType
---

# Add Named Item

Namespace: microsoft.graph

Adds a new name to the collection of the given scope using the user's locale for the formula.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Files.ReadWrite, Sites.Read.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Sites.Read.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /me/drive/items/{id}/workbook/names/add
POST /me/drive/root:/{item-path}:/workbook/names/add
POST /me/drive/items/{id}/workbook/worksheets/{id|name}/names/add
POST /me/drive/root:/{item-path}:/workbook/worksheets/{id|name}/names/add

```
## Request headers
| Name       | Description|
|:---------------|:----------|
| Authorization  | Bearer {token}. Required. |
| Workbook-Session-Id  | Workbook session Id that determines if changes are persisted or not. Optional.|

## Request body
In the request body, provide a JSON object with the following parameters.

| Parameter	   | Type	|Description|
|:---------------|:--------|:----------|
|name|string|The name of the named item.|
|reference|Json|The formula or the range that the name will refer to.|
|comment|string|The comment associated with the named item|

## Response

If successful, this method returns `200 OK` response code and [WorkbookNamedItem](../resources/nameditem.md) object in the response body.


## Example
Here is an example of how to call this API.

##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "NamedItemcollection_add_1"
}-->
```http
POST https://graph.microsoft.com/v1.0/me/drive/items/{id}/workbook/names/add
Content-type: application/json

{
  "name": "test5",
  "reference": "=Sheet1!$F$15:$N$27",
  "comment": "Comment for the named item"
}


```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var name = "test5";

var reference = JsonDocument.Parse(@"""=Sheet1!$F$15:$N$27""");

var comment = "Comment for the named item";

await graphClient.Me.Drive.Items["{driveItem-id}"].Workbook.Names
	.Add(name,reference,comment)
	.Request()
	.PostAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

