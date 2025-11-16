---
title: "Create child folder"
description: "Use this API to create a new child mailfolder."
author: "abheek-das"
ms.localizationpriority: medium
ms.prod: "outlook"
doc_type: apiPageType
---

# Create child folder

Namespace: microsoft.graph

Use this API to create a new child [mailFolder](../resources/mailfolder.md).

If you intend a new folder to be hidden, you must set the **isHidden** property to `true` on creation.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

| Permission type | Permissions (from least to most privileged) |
|:----------------|:--------------------------------------------|
|Delegated (work or school account) | Mail.ReadWrite    |
|Delegated (personal Microsoft account) | Mail.ReadWrite    |
|Application | Mail.ReadWrite |

## HTTP request

<!-- { "blockType": "ignored" } -->

```http
POST /me/mailFolders/{id}/childFolders
POST /users/{id | userPrincipalName}/mailFolders/{id}/childFolders
```

Specify the parent folder in the query URL as a folder ID, or a well-known folder name. For a list of supported well-known folder names, see [mailFolder resource type](../resources/mailfolder.md).

## Request headers

| Header | Value |
|:-------|:------|
| Authorization | `Bearer {token}`. Required. |
| Content-Type | `application/json`. Required. |

## Request body

In the request body, provide a JSON object with the following parameters. **displayName** and **isHidden** are the only writable property for a
[mailFolder](../resources/mailfolder.md) object.

| Parameter | Type | Description |
|:----------|:-----|:------------|
|displayName|String|The display name of the new folder.|
|isHidden|Boolean|Indicates whether the new folder is hidden. The default value is `false`. Setting the property is optional. Once set, you cannot update this property. See more information in [Hidden mail folders](../resources/mailfolder.md#hidden-mail-folders)|

## Response

If successful, this method returns `201 Created` response code and a [mailFolder](../resources/mailfolder.md) resource in the response body.

## Example

##### Request

Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_mailfolder_from_mailfolder"
}-->

```http
POST https://graph.microsoft.com/v1.0/me/mailFolders/{id}/childFolders
Content-type: application/json

{
  "displayName": "displayName-value",
  "isHidden": true
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var mailFolder = new MailFolder
{
	DisplayName = "displayName-value",
	IsHidden = true
};

await graphClient.Me.MailFolders["{mailFolder-id}"].ChildFolders
	.Request()
	.AddAsync(mailFolder);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

