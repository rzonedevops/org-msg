---
title: "Create externalGroup"
description: "Create a new externalGroup object."
author: "sacampbe-msft"
ms.localizationpriority: medium
ms.prod: "search"
doc_type: apiPageType
---

# Create externalGroup
Namespace: microsoft.graph.externalConnectors



Create a new [externalGroup](../resources/externalconnectors-externalgroup.md) object.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

| Permission type                        | Permissions (from least to most privileged) |
|:---------------------------------------|:--------------------------------------------|
| Delegated (work or school account)     | ExternalItem.ReadWrite.OwnedBy, ExternalItem.ReadWrite.All |
| Delegated (personal Microsoft account) | Not supported                               |
| Application                            | ExternalItem.ReadWrite.OwnedBy, ExternalItem.ReadWrite.All |

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->
``` http
POST /external/connections/{connectionsId}/groups
```

## Request headers

| Name          | Description                 |
|:--------------|:----------------------------|
| Authorization | Bearer {token}. Required.   |
| Content-Type  | application/json. Required. |

## Request body
In the request body, supply a JSON representation of the **externalGroup** object.

You can specify the following properties when creating an **externalGroup**.

| Property    | Type   | Description                                                                                                              |
|:------------|:-------|:-------------------------------------------------------------------------------------------------------------------------|
| id          | String | The unique ID of the external group within a connection. It must be alphanumeric and can be up to 128 characters long. Required. |
| displayName | String | The friendly name of the external group. Optional.                                                                      |
| description | String | The description of the external group. Optional.                                                                         |



## Response

If successful, this method returns a `201 Created` response code and an **externalGroup** object in the response body.

## Example

### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_externalgroup_from_connection",
  "sampleKeys": ["contosohr"]
}
-->

``` http
POST https://graph.microsoft.com/v1.0/external/connections/contosohr/groups
Content-Type: application/json

{
  "id": "31bea3d537902000",
  "displayName": "Contoso Marketing",
  "description": "The product marketing team"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var externalGroup = new Microsoft.Graph.ExternalConnectors.ExternalGroup
{
	Id = "31bea3d537902000",
	DisplayName = "Contoso Marketing",
	Description = "The product marketing team"
};

await graphClient.External.Connections["{externalConnectors.externalConnection-id}"].Groups
	.Request()
	.AddAsync(externalGroup);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.externalConnectors.externalGroup"
}
-->

``` http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": "31bea3d537902000",
  "displayName": "Contoso Marketing",
  "description": "The product marketing team"
}
```
