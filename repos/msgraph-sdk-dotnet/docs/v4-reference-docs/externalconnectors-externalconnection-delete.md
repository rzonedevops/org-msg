---
title: "Delete externalConnection"
description: "Deletes an externalConnection object."
author: "mecampos"
ms.localizationpriority: medium
ms.prod: "search"
doc_type: apiPageType
---

# Delete externalConnection
Namespace: microsoft.graph.externalConnectors



Deletes an [externalConnection](../resources/externalconnectors-externalconnection.md) object.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type|Permissions (from least to most privileged)|
|:---|:---|
|Delegated (work or school account)|ExternalConnection.ReadWrite.OwnedBy, ExternalConnection.ReadWrite.All|
|Delegated (personal Microsoft account)|Not applicable|
|Application| ExternalConnection.ReadWrite.OwnedBy, ExternalConnection.ReadWrite.All|

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->
``` http
DELETE /external/connections/{connectionsId}
```

## Request headers
|Name|Description|
|:---|:---|
|Authorization|Bearer {token}. Required.|

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns `202 Accepted` response code. It does not return anything in the response body.

## Examples

### Request



# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "delete_externalconnection",
  "sampleKeys": ["contosohr"]
}
-->
``` http
DELETE https://graph.microsoft.com/v1.0/external/connections/contosohr
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

await graphClient.External.Connections["{externalConnectors.externalConnection-id}"]
	.Request()
	.DeleteAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
The following is an example of the response.

<!-- {
  "blockType": "response",
  "truncated": true
} -->

```http
HTTP/1.1 202 Accepted
```

