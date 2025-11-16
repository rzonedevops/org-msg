---
title: "List messages"
description: "Get the messages in the signed-in user's mailbox (including the Deleted Items and Clutter folders)."
ms.localizationpriority: high
author: "SuryaLashmiS"
ms.prod: "outlook"
doc_type: apiPageType
---

# List messages

Namespace: microsoft.graph

Get the messages in the signed-in user's mailbox (including the Deleted Items and Clutter folders).

Depending on the page size and mailbox data, getting messages from a mailbox can incur multiple requests. The default page size is 10 messages. Use `$top` to customize the page size, within the range of 1 and 1000.

To get the next page of messages, simply apply the entire URL returned in `@odata.nextLink` to the next get-messages request. This URL includes any query parameters you may have specified in the initial request.

Do not try to extract the `$skip` value from the `@odata.nextLink` URL to manipulate responses. This API uses the `$skip` value to keep count of all the items it has gone through in the user's mailbox to return a page of message-type items. It's therefore possible that even in the initial response, the `$skip` value is larger than the page size. For more information, see [Paging Microsoft Graph data in your app](/graph/paging).

Currently, this operation returns message bodies in only HTML format.

There are two scenarios where an app can get messages in another user's mail folder:

* If the app has application permissions, or,
* If the app has the appropriate delegated [permissions](#permissions) from one user, and another user has shared a mail folder with that user, or, has given delegated access to that user. See [details and an example](/graph/outlook-share-messages-folders).

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Mail.ReadBasic, Mail.Read, Mail.ReadWrite    |
|Delegated (personal Microsoft account) | Mail.ReadBasic, Mail.Read, Mail.ReadWrite    |
|Application | Mail.ReadBasic.All, Mail.Read, Mail.ReadWrite |

## HTTP request

To get all the messages in a user's mailbox:

<!-- { "blockType": "ignored" } -->
```http
GET /me/messages
GET /v1.0/users/{id | userPrincipalName}/messages
```

To get messages in a specific folder in the user's mailbox:

<!-- { "blockType": "ignored" } -->
```http
GET https://graph.microsoft.com/beta/me/mailFolders/{id}/messages
GET /users/{id | userPrincipalName}/mailFolders/{id}/messages
```

## Optional query parameters

This method supports the [OData Query Parameters](/graph/query-parameters) to help customize the response.
