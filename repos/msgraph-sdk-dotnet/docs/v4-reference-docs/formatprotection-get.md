---
title: "Get FormatProtection"
description: "Retrieve the properties and relationships of formatprotection object."
ms.localizationpriority: medium
author: "ruoyingl"
ms.prod: workbooks-and-charts
doc_type: apiPageType
---

# Get FormatProtection

Namespace: microsoft.graph

Retrieve the properties and relationships of formatprotection object.
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
GET /me/drive/items/{id}/workbook/names/{name}/range/format/protection
GET /me/drive/root:/{item-path}:/workbook/names/{name}/range/format/protection
GET /me/drive/items/{id}/workbook/worksheets/{id|name}/range(<address>)/format/protection
GET /me/drive/root:/{item-path}:/workbook/worksheets/{id|name}/range(<address>)/format/protection
GET /me/drive/items/{id}/workbook/tables/{id|name}/columns/{id|name}/range/format/protection
GET /me/drive/root:/{item-path}:/workbook/tables/{id|name}/columns/{id|name}/range/format/protection
```
## Optional query parameters
This method supports the [OData Query Parameters](/graph/query-parameters) to help customize the response.

## Request headers
| Name      |Description|
|:----------|:----------|
| Authorization  | Bearer {token}. Required. |


## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and [FormatProtection](../resources/formatprotection.md) object in the response body.
## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_formatprotection"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/drive/items/{id}/workbook/names/{name}/range/format/protection
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var workbookFormatProtection = await graphClient.Me.Drive.Items["{driveItem-id}"].Workbook.Names["{workbookNamedItem-id}"]
	.Range().Format.Protection
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

