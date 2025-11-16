---
title: "Get schema"
description: "Read the properties and relationships of a schema object."
author: "mecampos"
ms.localizationpriority: medium
ms.prod: "search"
doc_type: apiPageType
---

# Get schema
Namespace: microsoft.graph.externalConnectors

Read the properties and relationships of a [schema](../resources/externalconnectors-schema.md) object.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type|Permissions (from least to most privileged)|
|:---|:---|
|Delegated (work or school account)|ExternalConnection.ReadWrite.OwnedBy, ExternalConnection.Read.All, ExternalConnection.ReadWrite.All|
|Delegated (personal Microsoft account)|Not applicable|
|Application| ExternalConnection.ReadWrite.OwnedBy, ExternalConnection.Read.All, ExternalConnection.ReadWrite.All|

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->
``` http
GET /external/connections/{connectionsId}/schema
```

## Optional query parameters

This method does not support [OData query parameters](/graph/query-parameters) to customize the response.

## Request headers
|Name|Description|
|:---|:---|
|Authorization|Bearer {token}. Required.|

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and a [schema](../resources/externalconnectors-schema.md) object in the response body.

## Examples

### Request



# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_schema",
  "sampleKeys": ["contosohr"]
}
-->
``` http
GET https://graph.microsoft.com/v1.0/external/connections/contosohr/schema
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var schema = await graphClient.External.Connections["{externalConnectors.externalConnection-id}"].Schema
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
**Note:** The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.externalConnectors.schema"
}
-->
``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "value": {
    "baseType": "String",
    "properties": [
      {
        "name": "ticketTitle",
        "type": "string",
        "isSearchable": true,
        "isRetrievable": true,
        "labels": [
          "title"
        ]
      },
      {
        "name": "priority",
        "type": "string",
        "isQueryable": true,
        "isRetrievable": true,
        "isRefinable": true,
        "isSearchable": false
      },
      {
        "name": "assignee",
        "type": "string",
        "isRetrievable": true
      }
    ]
  }
}
```

