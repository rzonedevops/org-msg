---
title: "RangeSort: apply"
description: "Perform a sort operation."
author: "lumine2008"
ms.localizationpriority: medium
ms.prod: "excel"
doc_type: apiPageType
---

# RangeSort: apply

Namespace: microsoft.graph

Perform a sort operation.
## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Files.ReadWrite    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Not supported. |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /me/drive/items/{id}/workbook/names/{name}/range/sort/apply
POST /me/drive/root:/{item-path}:/workbook/names/{name}/range/sort/apply
POST /me/drive/items/{id}/workbook/worksheets/{id|name}/range(address='<address>')/sort/apply
POST /me/drive/root:/{item-path}:/workbook/worksheets/{id|name}/range(address='<address>')/sort/apply
POST /me/drive/items/{id}/workbook/tables/{id|name}/columns/{id|name}/range/sort/apply
POST /me/drive/root:/{item-path}:/workbook/tables/{id|name}/columns/{id|name}/range/sort/apply

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
|fields|WorkbookSortField collection|The list of conditions to sort on.|
|matchCase|boolean|Optional. Whether to have the casing impact string ordering.|
|hasHeaders|boolean|Optional. Whether the range has a header.|
|orientation|string|Optional. Whether the operation is sorting rows or columns.  The possible values are: `Rows`, `Columns`.|
|method|string|Optional. The ordering method used for Chinese characters.  The possible values are: `PinYin`, `StrokeCount`.|

## Response

If successful, this method returns `200 OK` response code. It does not return anything in the response body.

## Example
Here is an example of how to call this API.
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "rangesort_apply"
}-->
```http
POST https://graph.microsoft.com/v1.0/me/drive/items/{id}/workbook/names/{name}/range/sort/apply
Content-type: application/json

{
  "fields": [
    {
      "key": 99,
      "sortOn": "sortOn-value",
      "ascending": true,
      "color": "color-value",
      "dataOption": "dataOption-value",
      "icon": {
        "set": "set-value",
        "index": 99
      }
    }
  ],
  "matchCase": true,
  "hasHeaders": true,
  "orientation": "orientation-value",
  "method": "method-value"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var fields = new List<WorkbookSortField>()
{
	new WorkbookSortField
	{
		Key = 99,
		SortOn = "sortOn-value",
		Ascending = true,
		Color = "color-value",
		DataOption = "dataOption-value",
		Icon = new WorkbookIcon
		{
			Set = "set-value",
			Index = 99
		}
	}
};

var matchCase = true;

var hasHeaders = true;

var orientation = "orientation-value";

var method = "method-value";

await graphClient.Me.Drive.Items["{driveItem-id}"].Workbook.Names["{workbookNamedItem-id}"]
	.Range().Sort
	.Apply(matchCase,hasHeaders,orientation,method,fields)
	.Request()
	.PostAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

