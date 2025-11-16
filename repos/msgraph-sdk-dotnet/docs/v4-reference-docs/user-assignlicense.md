---
title: "assignLicense"
description: "Add or remove subscriptions for the user. You can also enable and disable specific plans associated with a subscription."
author: "jconley76"
ms.localizationpriority: high
ms.prod: "users"
doc_type: apiPageType
---

# user: assignLicense

Namespace: microsoft.graph
Add or remove subscriptions for the user. You can also enable and disable specific plans associated with a subscription.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | User.ReadWrite.All, Directory.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | User.ReadWrite.All, Directory.ReadWrite.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /users/{id | userPrincipalName}/assignLicense
```
## Request headers
| Header       | Value |
|:---------------|:--------|
| Authorization  | Bearer {token}. Required.  |
| Content-Type  | application/json  |

## Request body
In the request body, provide a JSON object with the following parameters.

| Parameter	   | Type	|Description|
|:---------------|:--------|:----------|
|addLicenses|[assignedLicense](../resources/assignedlicense.md) collection|A collection of [assignedLicense](../resources/assignedlicense.md) objects that specify the licenses to add. You can disable plans associated with a license by setting the **disabledPlans** property on an [assignedLicense](../resources/assignedlicense.md) object.|
|removeLicenses|Guid collection|A collection of GUIDs that identify the licenses to remove.|

## Response

If successful, this method returns `200 OK` response code and [user](../resources/user.md) object in the response body.

## Example
Here is an example of how to call this API.
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "user_assignlicense"
}-->
```http
POST https://graph.microsoft.com/v1.0/me/assignLicense
Content-type: application/json

{
  "addLicenses": [
    {
      "disabledPlans": [ "11b0131d-43c8-4bbb-b2c8-e80f9a50834a" ],
      "skuId": "45715bb8-13f9-4bf6-927f-ef96c102d394"
    }
  ],
  "removeLicenses": [ "bea13e0c-3828-4daa-a392-28af7ff61a0f" ]
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var addLicenses = new List<AssignedLicense>()
{
	new AssignedLicense
	{
		DisabledPlans = new List<Guid>()
		{
			Guid.Parse("11b0131d-43c8-4bbb-b2c8-e80f9a50834a")
		},
		SkuId = Guid.Parse("45715bb8-13f9-4bf6-927f-ef96c102d394")
	}
};

var removeLicenses = new List<Guid>()
{
	Guid.Parse("bea13e0c-3828-4daa-a392-28af7ff61a0f")
};

await graphClient.Me
	.AssignLicense(addLicenses,removeLicenses)
	.Request()
	.PostAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

