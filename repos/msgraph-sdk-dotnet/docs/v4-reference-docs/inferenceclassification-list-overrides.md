---
title: "List overrides"
description: "Get the overrides that a user has set up to always classify messages from certain senders in specific ways."
ms.localizationpriority: medium
author: "abheek-das"
ms.prod: mail
doc_type: apiPageType
---

# List overrides

Namespace: microsoft.graph

Get the overrides that a user has set up to always classify messages from certain senders in specific ways.

Each override corresponds to an SMTP address of a sender. Initially, a user does not have any overrides.
## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Mail.Read    |
|Delegated (personal Microsoft account) | Mail.Read    |
|Application | Mail.Read |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /me/inferenceClassification/overrides
GET /users/{id}/inferenceClassification/overrides
```

## Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| Authorization  | string  | Bearer {token}. Required. |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and a collection of [inferenceClassificationOverride](../resources/inferenceclassificationoverride.md) objects in the response body.
An empty collection is returned if the user doesn't have any overrides set up.
## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_overrides"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/inferenceClassification/overrides
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var overrides = await graphClient.Me.InferenceClassification.Overrides
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

