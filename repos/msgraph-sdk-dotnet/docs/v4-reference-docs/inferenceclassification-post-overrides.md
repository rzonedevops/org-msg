---
title: "Create inferenceClassificationOverride"
description: "Create an override for a sender identified by an SMTP address. Future messages from that SMTP address will be consistently classified "
ms.localizationpriority: medium
author: "abheek-das"
ms.prod: mail
doc_type: apiPageType
---

# Create inferenceClassificationOverride

Namespace: microsoft.graph

Create an override for a sender identified by an SMTP address. Future messages from that SMTP address will be consistently classified
as specified in the override.

**Note**

- If an override already exists with the same SMTP address, then the **classifyAs** and **name** fields of that override are updated with the provided values.
- The maximum number of overrides supported for a mailbox is 1000, based on unique sender SMTP addresses.
- The POST operation supports creating only one override at a time.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Mail.ReadWrite    |
|Delegated (personal Microsoft account) | Mail.ReadWrite    |
|Application | Mail.ReadWrite |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /me/inferenceClassification/overrides
POST /users/{id}/inferenceClassification/overrides
```
## Request headers
| Name       | Type | Description|
|:---------------|:--------|:----------|
| Authorization  | string  | Bearer {token}. Required. |
| Content-Type | string  | Nature of the data in the body of an entity. Required. |

## Request body
In the request body, supply a JSON representation of [inferenceClassificationOverride](../resources/inferenceclassificationoverride.md) object.

## Response

If successful, this method returns `201 Created` response code and an [inferenceClassificationOverride](../resources/inferenceclassificationoverride.md) object in the response body.

## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_inferenceclassificationoverride_from_inferenceclassification"
}-->
```http
POST https://graph.microsoft.com/v1.0/me/inferenceClassification/overrides
Content-type: application/json

{
  "classifyAs": "focused",
  "senderEmailAddress": {
    "name": "Samantha Booth",
    "address": "samanthab@adatum.onmicrosoft.com"
  }
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var inferenceClassificationOverride = new InferenceClassificationOverride
{
	ClassifyAs = InferenceClassificationType.Focused,
	SenderEmailAddress = new EmailAddress
	{
		Name = "Samantha Booth",
		Address = "samanthab@adatum.onmicrosoft.com"
	}
};

await graphClient.Me.InferenceClassification.Overrides
	.Request()
	.AddAsync(inferenceClassificationOverride);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

