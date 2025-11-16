---
author: JeremyKelley
title: Update listItem
description: Update the properties on a listItem.
ms.localizationpriority: high
ms.prod: "sharepoint"
doc_type: apiPageType
---
# Update listItem

Namespace: microsoft.graph

Update the properties on a **[listItem][]**.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Sites.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Sites.ReadWrite.All |

## HTTP request

<!-- { "blockType": "ignored" } -->

Update the properties on a listItem.
```http
PATCH https://graph.microsoft.com/v1.0/sites/{site-id}/lists/{list-id}/items/{item-id}
```

Update column values on a listItem.
```http
PATCH https://graph.microsoft.com/v1.0/sites/{site-id}/lists/{list-id}/items/{item-id}/fields
```

## Optional request headers

| Name       | Value | Description
|:-----------|:------|:--------------------------------------------------------
| _if-match_ | etag  | If this request header is included and the eTag provided does not match the current eTag on the item, a `412 Precondition Failed` response is returned and the item will not be updated.

## Request body 
In the request body, supply a JSON representation of a [fieldValueSet][] specifying the fields to update.

## Response 

If successful, this method returns a `200 Ok` response code and a [fieldValueSet][] in the response body for the updated list item.

## Example

The following example updates the **Color** and **Quantity** fields of the list item with new values. All other values on the **listItem** are left alone. 

### Request 


# [HTTP](#tab/http)
<!-- { "blockType": "request", "name": "update-listitem", "scopes": "sites.readwrite.all" } -->

```http
PATCH https://graph.microsoft.com/v1.0/sites/{site-id}/lists/{list-id}/items/{item-id}/fields
Content-Type: application/json

{
    "Color": "Fuchsia",
    "Quantity": 934
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var fieldValueSet = new FieldValueSet
{
	AdditionalData = new Dictionary<string, object>()
	{
		{"Color", "Fuchsia"},
		{"Quantity", "934"}
	}
};

await graphClient.Sites["{site-id}"].Lists["{list-id}"].Items["{listItem-id}"].Fields
	.Request()
	.UpdateAsync(fieldValueSet);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

<!-- { "blockType": "response", "@odata.type": "microsoft.graph.fieldValueSet", "truncated": true } -->

```http
HTTP/1.1 200 Ok
Content-type: application/json

{
  "Name": "Widget",
  "Color": "Fuchsia",
  "Quantity": 934
}
```

[fieldValueSet]: ../resources/fieldvalueset.md
[listItem]: ../resources/listitem.md

<!-- {
  "type": "#page.annotation",
  "description": "",
  "keywords": "",
  "section": "documentation",
  "tocPath": "ListItem/Update",
  "suppressions": [
  ]
} -->

