---
author: JeremyKelley
ms.date: 09/10/2017
title: Convert to other formats
ms.localizationpriority: high
ms.prod: "sharepoint"
description: "Use this API to retrieve the contents of an item in a specific format."
doc_type: apiPageType
---
# Download a file in another format

Namespace: microsoft.graph

> [!WARNING]
> **This endpoint requires TLS 1.2 to function normally.** Microsoft announced the deprecation of TLS 1.0 and 1.1 for Office 365 and Azure AD services. Although Microsoft Graph still supports these two protocols, you might experience transport-level errors. For more information about the TLS 1.0 and 1.1 deprecation, see [Enable support for TLS 1.2 in your environment](/troubleshoot/azure/active-directory/enable-support-tls-environment).

Use this API to retrieve the contents of an item in a specific format.
Not all files can be converted into all formats.

To download the item in its original format, see [download an item's contents](driveitem-get-content.md).

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

| Permission type                        | Permissions (from least to most privileged) |
|:---------------------------------------|:------------------------------------|
| Delegated (work or school account)     | Files.Read, Files.ReadWrite, Files.Read.All, Files.ReadWrite.All, Sites.Read.All, Sites.ReadWrite.All |
| Delegated (personal Microsoft account) | Files.Read, Files.ReadWrite, Files.Read.All, Files.ReadWrite.All |
| Application                            | Files.Read.All, Files.ReadWrite.All, Sites.Read.All, Sites.ReadWrite.All |

## HTTP request

<!-- { "blockType": "ignored" } -->

```http
GET /drive/items/{item-id}/content?format={format}
GET /drive/root:/{path and filename}:/content?format={format}
```

## Query parameters

| Parameter      | Type  | Description                                                    |
|:----------|:-------|:---------------------------------------------------------------|
| _format_  | string | Specify the format the item's content should be downloaded as. |

### Format options

The following values are valid for the **format** parameter:

| Format value | Description                        | Supported source extensions
|:-------------|:-----------------------------------|----------------------------
| pdf          | Converts the item into PDF format. | csv, doc, docx, odp, ods, odt, pot, potm, potx, pps, ppsx, ppsxm, ppt, pptm, pptx, rtf, xls, xlsx

## Optional request headers

| Name            | Value   | Description                                                                                                                                              |
|:----------------|:--------|:---------------------------------------------------------------------------------------------------------------------------------------------------------|
| _if-none-match_ | String  | If this request header is included and the eTag (or cTag) provided matches the current tag on the file, an `HTTP 304 Not Modified` response is returned. |

## Example

# [HTTP](#tab/http)
<!-- { "blockType": "request", "name": "convert-item-content", "scopes": "files.read" } -->

```msgraph-interactive
GET /me/drive/items/{item-id}/content?format={format}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var queryOptions = new List<QueryOption>()
{
	new QueryOption("format", "{format}")
};

var stream = await graphClient.Me.Drive.Items["{driveItem-id}"].Content
	.Request( queryOptions )
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

