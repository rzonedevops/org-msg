---
title: "Get dataPolicyOperation"
description: "Retrieve the properties of the dataPolicyOperation object."
ms.localizationpriority: medium
author: "dkershaw10"
ms.prod: "identity-and-sign-in"
doc_type: apiPageType
---

# Get dataPolicyOperation

Namespace: microsoft.graph

Retrieve the properties of a **dataPolicyOperation** object.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) |  User.Export.All, User.Read.All  |
|Delegated (personal Microsoft account) |  Not applicable  |
|Application | User.Export.All, User.Read.All | 

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /dataPolicyOperations/{id}
```

## Request headers
| Name      |Description|
|:----------|:----------|
| Authorization  | Bearer {token}|

## Request body
Do not supply a request body for this method.
## Response
If successful, this method returns a `200 OK` response code and a [dataPolicyOperation](../resources/datapolicyoperation.md) object in the response body.
## Example
##### Request

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_datapolicyoperation"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/dataPolicyOperations/{id}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var dataPolicyOperation = await graphClient.DataPolicyOperations["{dataPolicyOperation-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

