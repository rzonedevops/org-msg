---
title: "Add a scopedRoleMember"
description: "Assign an Azure Active Directory (Azure AD) role with administrative unit scope."
ms.localizationpriority: medium
author: "DougKirschner"
ms.prod: "directory-management"
doc_type: apiPageType
---

# Add a scopedRoleMember

Namespace: microsoft.graph

Assign an Azure Active Directory (Azure AD) role with administrative unit scope. For a list of roles that can be assigned with administrative unit scope, see [Assign Azure AD roles with administrative unit scope](/azure/active-directory/roles/admin-units-assign-roles).

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | RoleManagement.ReadWrite.Directory    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | RoleManagement.ReadWrite.Directory |

To assign Azure AD roles with an administrative unit scope, the calling principal must be assigned one of the following [Azure AD roles](/azure/active-directory/roles/permissions-reference):

* Privileged Role Administrator
* Global Administrator

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /directory/administrativeUnits/{id}/scopedRoleMembers
```
## Request headers
| Name      |Description|
|:----------|:----------|
| Authorization  | Bearer {token}. Required.|
| Content-type | application/json. Required. |

## Request body
In the request body, supply a JSON representation of [scopedRoleMembership](../resources/scopedrolemembership.md) object.

## Response

If successful, this method returns `201 Created` response code and [scopedRoleMembership](../resources/scopedrolemembership.md) object in the response body.

## Example
##### Request
Here is an example of the request.


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_scopedrolemembership_from_administrativeunit"
}-->
```http
POST https://graph.microsoft.com/v1.0/directory/administrativeUnits/{id}/scopedRoleMembers
Content-type: application/json

{
  "roleId": "roleId-value",
  "roleMemberInfo": {
    "id": "id-value"
  }
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var scopedRoleMembership = new ScopedRoleMembership
{
	RoleId = "roleId-value",
	RoleMemberInfo = new Identity
	{
		Id = "id-value"
	}
};

await graphClient.Directory.AdministrativeUnits["{administrativeUnit-id}"].ScopedRoleMembers
	.Request()
	.AddAsync(scopedRoleMembership);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

