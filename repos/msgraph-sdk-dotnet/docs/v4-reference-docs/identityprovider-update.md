---
title: "Update identityProvider"
description: "Update properties in an existing identityProvider"
ms.localizationpriority: high
author: "namkedia"
ms.prod: "identity-and-sign-in"
doc_type: apiPageType
---

# Update identityProvider (deprecated)
Namespace: microsoft.graph

> [!CAUTION]
> This identity provider API is deprecated and will stop returning data after March, 2023. Please use the new [identity provider API](/graph/api/resources/identityproviderbase).

Update properties in an existing [identityProvider](../resources/identityprovider.md).

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
PATCH /identityProviders/{id}
```

## Request headers

|Name|Description|
|:---------------|:----------|
|Authorization|Bearer {token}. Required.|
|Content-Type|application/json. Required.|

## Request body

In the request body, provide a JSON object with one or more properties that need to be updated.

|Property|Type|Description|
|:---------------|:--------|:----------|
|clientId|String|The client ID for the application. This is the client ID obtained when registering the application with the identity provider.|
|clientSecret|String|The client secret for the application. This is the client secret obtained when registering the application with the identity provider.|
|name|String|The display name of the identity provider.|

## Response

If successful, this method returns `204 No Content` response code. If unsuccessful, a `4xx` error will be returned with specific details.

## Example

The following example updates the definition of the token lifetime **identityProvider** and sets it as the organization default.

##### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "update-identityprovider",
  "sampleKeys": ["Amazon-OAuth"]
}-->

```http
PATCH https://graph.microsoft.com/v1.0/identityProviders/Amazon-OAuth
Content-type: application/json

{
    "clientSecret": "1111111111111"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var identityProvider = new IdentityProvider
{
	ClientSecret = "1111111111111"
};

await graphClient.IdentityProviders["{identityProvider-id}"]
	.Request()
	.UpdateAsync(identityProvider);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

