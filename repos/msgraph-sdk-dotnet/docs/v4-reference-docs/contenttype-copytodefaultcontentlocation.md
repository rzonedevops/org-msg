---
author: swapnil1993
title: "contentType: copyToDefaultContentLocation"
description: "Copy a file to a default content location in a content type."
ms.localizationpriority: medium
doc_type: apiPageType
ms.prod: "sites-and-lists"
---

# contentType: copyToDefaultContentLocation
Namespace: microsoft.graph


Copy a file to a default content location in a [content type][contentType]. The file can then be added as a default file or template via a POST operation.

## Permissions  

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

  

|Permission type | Permissions (from least to most privileged) |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Sites.ReadWrite.All, Sites.Manage.All, Sites.FullControl.All  |
|Delegated (personal Microsoft account) | Not supported. |
|Application | Sites.ReadWrite.All, Sites.Manage.All, Sites.FullControl.All |

  

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->

```http
POST /sites/{siteId}/contentTypes/{contentTypeId}/copyToDefaultContentLocation 
```

## Request headers
|Name|Description|
|:---|:---|
|Authorization|Bearer {token}. Required.|
|Content-Type|application/json. Required.|

## Request body
In the request body, supply a JSON representation of the parameters.

The following table shows the parameters that can be used with this action.


|Parameter|Type|Description|
|-|-|-|
|sourceFile| [itemReference](../resources/itemreference.md) |Metadata about the source file that needs to be copied to the default content location. Required.|
|destinationFileName| string |Destination filename. |

## Response


If successful, this call returns a `204 No Content` response.

## Example

### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "contenttype_copytodefaultcontentlocation"
}
-->
```http
POST https://graph.microsoft.com/v1.0/sites/{siteId}/contentTypes/{contentTypeId}/copyToDefaultContentLocation 
Content-Type: application/json

{
   "sourceFile":{
      "sharepointIds":{
         "listId":"e2ecf63b-b0fd-48f7-a54a-d8c15479e3b0",
         "listItemId":"2"
      }
   },
   "destinationFileName":"newname.txt"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var sourceFile = new ItemReference
{
	SharepointIds = new SharepointIds
	{
		ListId = "e2ecf63b-b0fd-48f7-a54a-d8c15479e3b0",
		ListItemId = "2"
	}
};

var destinationFileName = "newname.txt";

await graphClient.Sites["{site-id}"].ContentTypes["{contentType-id}"]
	.CopyToDefaultContentLocation(sourceFile,destinationFileName)
	.Request()
	.PostAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response


<!-- { "blockType": "response" } -->

```http
HTTP/1.1 204 No Content
```

  

[contentType]: ../resources/contentType.md
