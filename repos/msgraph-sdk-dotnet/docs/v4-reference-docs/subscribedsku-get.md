---
title: "Get subscribedSku"
description: "Retrieve a specific commercial subscription that an organization has acquired."
ms.localizationpriority: medium
author: "SumitParikh"
ms.prod: "directory-management"
doc_type: apiPageType
---

# Get subscribedSku

Namespace: microsoft.graph

Get a specific commercial subscription that an organization has acquired.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Organization.Read.All, Directory.Read.All, Directory.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Organization.Read.All, Directory.Read.All, Organization.ReadWrite.All, Directory.ReadWrite.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /subscribedSkus/{id}
```
## Optional query parameters
This method does **not** support the [OData Query Parameters](/graph/query-parameters) to help customize the response (e.g. $filter is not supported here).

## Request headers

| Name       | Description|
|:-----------|:----------|
| Authorization  | Bearer {token}. Required. |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and [subscribedSku](../resources/subscribedsku.md) object in the response body.
## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_subscribedsku",
  "sampleKeys": ["dcd219dd-bc68-4b9b-bf0b-4a33a796be35_c7df2760-2c81-4ef7-b578-5b5392b571df"]
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/subscribedSkus/dcd219dd-bc68-4b9b-bf0b-4a33a796be35_c7df2760-2c81-4ef7-b578-5b5392b571df
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var subscribedSku = await graphClient.SubscribedSkus["{subscribedSku-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

