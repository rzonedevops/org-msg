---
title: "message: forward"
description: "Forward a message using either JSON or MIME format."
author: "abheek-das"
ms.localizationpriority: medium
ms.prod: "outlook"
doc_type: apiPageType
---

# message: forward

Namespace: microsoft.graph

Forward a message using either JSON or MIME format.

When using JSON format, you can:
- Specify either a comment or the **body** property of the `message` parameter. Specifying both will return an HTTP 400 Bad Request error.
- Specify either the `toRecipients` parameter or the **toRecipients** property of the `message` parameter. Specifying both or specifying neither will return an HTTP 400 Bad Request error.

When using MIME format:
- Provide the applicable [Internet message headers](https://tools.ietf.org/html/rfc2076) and the [MIME content](https://tools.ietf.org/html/rfc2045), all encoded in **base64** format in the request body.
- Add any attachments and S/MIME properties to the MIME content.

This method saves the message in the **Sent Items** folder.

Alternatively, [create a draft to forward a message](../api/message-createforward.md), and [send](../api/message-send.md) it later.

## Permissions
One of the following permissions are required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Mail.Send    |
|Delegated (personal Microsoft account) | Mail.Send    |
|Application | Mail.Send |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /me/messages/{id}/forward
POST /users/{id | userPrincipalName}/messages/{id}/forward
POST /me/mailFolders/{id}/messages/{id}/forward
POST /users/{id | userPrincipalName}/mailFolders/{id}/messages/{id}/forward
```
## Request headers
| Name       | Type | Description| 
|:---------------|:--------|:----------|
| Authorization  | string  | Bearer {token}. Required |
| Content-Type | string  | Nature of the data in the body of an entity.  Required. <br/> Use `application/json` for a JSON object and `text/plain` for MIME content. |

## Request body
When using JSON format, provide a JSON object in the request body with the following parameters.

| Parameter	   | Type	|Description|
|:---------------|:--------|:----------|
|comment|String|A comment to include. Can be an empty string.|
|toRecipients|[Recipient](../resources/recipient.md) collection|The list of recipients.|

When specifying the body in MIME format, provide the MIME content with the applicable Internet message headers ("To", "CC", "BCC", "Subject"), all encoded in **base64** format in the request body.

## Response

If successful, this method returns `202 Accepted` response code. It does not return anything in the response body.

If the request body includes malformed MIME content, this method returns `400 Bad request` and the following error message: "Invalid base64 string for MIME content".

## Examples
### Example 1: Forward a message using JSON format
Here is an example of how to call this API.
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "message_forward"
}-->
```http
POST https://graph.microsoft.com/v1.0/me/messages/{id}/forward
Content-type: application/json

{
  "comment": "comment-value",
  "toRecipients": [
    {
      "emailAddress": {
        "name": "name-value",
        "address": "address-value"
      }
    }
  ]
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var comment = "comment-value";

var toRecipients = new List<Recipient>()
{
	new Recipient
	{
		EmailAddress = new EmailAddress
		{
			Name = "name-value",
			Address = "address-value"
		}
	}
};

await graphClient.Me.Messages["{message-id}"]
	.Forward(toRecipients,null,comment)
	.Request()
	.PostAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

