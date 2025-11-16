---
title: "List identityProviders"
description: "Retrieve all identityProviders"
ms.localizationpriority: high
author: "namkedia"
ms.prod: "identity-and-sign-in"
doc_type: apiPageType
---

# List identityProviders (deprecated)
Namespace: microsoft.graph

> [!CAUTION]
> This identity provider API is deprecated and will stop returning data after March, 2023. Please use the new [identity provider API](/graph/api/resources/identityproviderbase).

Retrieve all [identityProviders](../resources/identityprovider.md) in the directory.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account)|IdentityProvider.Read.All, IdentityProvider.ReadWrite.All|
|Delegated (personal Microsoft account)| Not supported.|
|Application|Not supported.|

The work or school account must be a global administrator of the tenant.

## HTTP request

<!-- { "blockType": "ignored" } -->
```http
GET /identityProviders
```

## Request headers

|Name|Description|
|:---------------|:----------|
|Authorization|Bearer {token}. Required.|

## Request body

Do not supply a request body for this method.

## Response

If successful, this method returns `200 OK` response code and a collection of [identityProviders](../resources/identityprovider.md) in JSON representation in the response body.

## Example

The following example retrieves all **identityProvider**.

##### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "list-identityproviders"
}-->

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/identityProviders
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var identityProviders = await graphClient.IdentityProviders
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

