---
title: "Download printDocument binary file"
description: Download the binary file associated with the document.
author: nilakhan
ms.localizationpriority: medium
ms.prod: cloud-printing
doc_type: apiPageType
---

# Download printDocument binary file

Namespace: microsoft.graph

Download the binary file associated with a [printDocument](../resources/printdocument.md). Calling this method yields a redirect response with a pre-authenticated URL that can be used to download the payload.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

In addition to the following permissions, the user or app's tenant must have an active Universal Print subscription and have a permission that grants grants [Get printer](printer-get.md) access.

| Permission type                        | Permissions (from least to most privileged)                  |
| :------------------------------------- | :----------------------------------------------------------- |
| Delegated (work or school account)     | PrintJob.Read, PrintJob.Read.All, PrintJob.ReadWrite, PrintJob.ReadWrite.All |
| Delegated (personal Microsoft account) | Not Supported.                                               |
| Application                            | PrintJob.Read.All, PrintJob.ReadWrite.All                    |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /print/printers/{printerId}/jobs/{printJobId}/documents/{printDocumentId}/$value
```
## Request headers
| Name          | Description               |
| :------------ | :------------------------ |
| Authorization | Bearer {token}. Required. |

## Request body
Do not supply a request body for this method.

## Response
If successful, this method returns `302 Found` and the pre-authenticated download URL in the Location header.

## Examples
The following example shows how to call this API to acquire a pre-authenticated download URL. To start the download, follow the redirect URL in the response.

### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_document_value"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/print/printers/{printerId}/jobs/{printJobId}/documents/{printDocumentId}/$value
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var stream = await graphClient.Print.Printers["{printer-id}"].Jobs["{printJob-id}"].Documents["{printDocument-id}"].Content
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

<!-- {
  "blockType": "response",
  "truncated": true
} -->
```http
HTTP/1.1 302 Found
Location: https://print.print.microsoft.com/downloads/bd260b1a-044e-4ca6-afa9-17d9a587d254?tempauthtoken={accesstoken}
```
