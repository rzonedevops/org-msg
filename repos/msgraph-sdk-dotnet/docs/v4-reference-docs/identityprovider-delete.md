---
title: "Delete identityProvider"
description: "Delete an existing identityProvider"
ms.localizationpriority: high
author: "namkedia"
ms.prod: "identity-and-sign-in"
doc_type: apiPageType
---

# Delete identityProvider (deprecated)
Namespace: microsoft.graph

> [!CAUTION]
> This identity provider API is deprecated and will stop returning data after March, 2023. Please use the new [identity provider API](/graph/api/resources/identityproviderbase).

Delete an existing [identityProvider](../resources/identityprovider.md).

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account)|IdentityProvider.ReadWrite.All|
|Delegated (personal Microsoft account)| Not supported.|
|Application|Not supported.|

The work or school account must be a global administrator of the tenant.

## HTTP request

<!-- { "blockType": "ignored" } -->
```http
DELETE /identityProviders/{id}
```

## Request headers

|Name|Description|
|:---------------|:----------|
|Authorization|Bearer {token}. Required.|

## Request body

Do not supply a request body for this method.

## Response

If successful, this method returns `204 No Content` response code.

## Example

The following example deletes an **identityProvider**.

##### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "delete-identityprovider_Amazon_OAuth",
  "sampleKeys": ["Amazon-OAuth"]
}-->

```http
DELETE https://graph.microsoft.com/v1.0/identityProviders/Amazon-OAuth
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

await graphClient.IdentityProviders["{identityProvider-id}"]
	.Request()
	.DeleteAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

