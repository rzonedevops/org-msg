---
title: "Create schema"
description: "Create the schema for a Microsoft Search connection."
author: "mecampos"
ms.localizationpriority: medium
ms.prod: "search"
doc_type: apiPageType
---

# Create schema
Namespace: microsoft.graph.externalConnectors

Create a new [schema](../resources/externalconnectors-schema.md) object.

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
```http
POST /external/connections/{id}/schema
```
In the request body, supply a JSON representation of a [schema](../resources/externalconnectors-schema.md) object.

When you register a custom item schema, the **schema** object **must** have the **baseType** property set to `microsoft.graph.externalItem` and **must** contain the **properties** property. The **properties** object **must** contain at least one property, up to a maximum of 128.

## Response

If successful, this method returns a `202 Accepted` response code and a URL in the `Location` response header that can be used to [get the operation status](../api/externalconnectors-connectionoperation-get.md).

## Examples

### Example: Register custom schema asynchronously

#### Request

The following is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_schema_from_connection_async",
  "sampleKeys": ["contosohr"]
}-->

```http
POST https://graph.microsoft.com/v1.0/external/connections/contosohr/schema
Content-type: application/json

{
  "baseType": "microsoft.graph.externalItem",
  "properties": [
    {
      "name": "ticketTitle",
      "type": "String",
      "isSearchable": "true",
      "isRetrievable": "true",
      "labels": [
        "title"
      ]
    },
    {
      "name": "priority",
      "type": "String",
      "isQueryable": "true",
      "isRetrievable": "true",
      "isSearchable": "false"
    },
    {
      "name": "assignee",
      "type": "String",
      "isRetrievable": "true"
    }
  ]
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var schema = new Microsoft.Graph.ExternalConnectors.Schema
{
	BaseType = "microsoft.graph.externalItem",
	Properties = new List<Microsoft.Graph.ExternalConnectors.Property>()
	{
		new Microsoft.Graph.ExternalConnectors.Property
		{
			Name = "ticketTitle",
			Type = Microsoft.Graph.ExternalConnectors.PropertyType.String,
			IsSearchable = true,
			IsRetrievable = true,
			Labels = new List<Microsoft.Graph.ExternalConnectors.Label>()
			{
				Microsoft.Graph.ExternalConnectors.Label.Title
			}
		},
		new Microsoft.Graph.ExternalConnectors.Property
		{
			Name = "priority",
			Type = Microsoft.Graph.ExternalConnectors.PropertyType.String,
			IsQueryable = true,
			IsRetrievable = true,
			IsSearchable = false
		},
		new Microsoft.Graph.ExternalConnectors.Property
		{
			Name = "assignee",
			Type = Microsoft.Graph.ExternalConnectors.PropertyType.String,
			IsRetrievable = true
		}
	}
};

await graphClient.External.Connections["{externalConnectors.externalConnection-id}"].Schema
	.Request()
	.AddAsync(schema);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

#### Response

The following is an example of the response.

<!-- {
  "blockType": "response",
  "truncated": true
} -->

```http
HTTP/1.1 202 Accepted
Location: https://graph.microsoft.com/v1.0/external/connections/contosohr/operations/616bfeed-666f-4ce0-8cd9-058939010bfc
```
