---
title: "Update accessPackageCatalog"
description: "Update the properties of an accessPackageCatalog object."
author: "markwahl-msft"
ms.localizationpriority: medium
ms.prod: "governance"
doc_type: apiPageType
---
# Update accessPackageCatalog

Namespace: microsoft.graph


Update an existing [accessPackageCatalog](../resources/accesspackagecatalog.md) object to change one or more of its properties, such as the display name or description.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type|Permissions (from least to most privileged)|
|:---|:---|
|Delegated (work or school account)     | EntitlementManagement.ReadWrite.All |
|Delegated (personal Microsoft account) | Not supported. |
|Application                            | EntitlementManagement.ReadWrite.All |

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->
``` http
PATCH /identityGovernance/entitlementManagement/catalogs/{accessPackageCatalogId}
```

## Request headers
|Name|Description|
|:---|:---|
|Authorization|Bearer {token}. Required.|
|Content-Type|application/json. Required.|

## Request body
In the request body, supply *only* the values for properties that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values.

The following table specifies the properties that can be updated.


|Property|Type|Description|
|:---|:---|:---|
|displayName|String|The access package catalog name.|
|description|String|The description of the access package catalog.|
|catalogType|accessPackageCatalogType|Whether the catalog is created by a user or entitlement management. The possible values are: `userManaged`, `serviceDefault`, `serviceManaged`, `unknownFutureValue`.|
|state|accessPackageCatalogState|Has the value `published` if the access packages are available for management. The possible values are: `unpublished`, `published`, `unknownFutureValue`.|
|isExternallyVisible|Boolean|Whether the access packages in this catalog can be requested by users outside of the tenant.|



## Response
If successful, this method returns a `204 No Content` response code.



## Examples

### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "update_accesspackagecatalog"
}
-->
```http
PATCH https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/catalogs/{accessPackageCatalogId}
Content-Type: application/json

{
  "displayName":"Catalog One"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var accessPackageCatalog = new AccessPackageCatalog
{
	DisplayName = "Catalog One"
};

await graphClient.IdentityGovernance.EntitlementManagement.Catalogs["{accessPackageCatalog-id}"]
	.Request()
	.UpdateAsync(accessPackageCatalog);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

<!-- {
  "blockType": "response"
}
-->
```http
HTTP/1.1 204 No Content
Content-Type: application/json

```

