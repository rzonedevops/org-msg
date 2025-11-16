---
title: "Create unifiedRoleAssignment"
description: "Create a new unifiedRoleAssignment object."
ms.localizationpriority: medium
author: "DougKirschner"
ms.prod: "directory-management"
doc_type: "apiPageType"
---

# Create unifiedRoleAssignment

Namespace: microsoft.graph

Create a new [unifiedRoleAssignment](../resources/unifiedroleassignment.md) object.

## Permissions


One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

### For the directory (Azure AD) provider

| Permission type                        | Permissions (from least to most privileged) |
|:---------------------------------------|:--------------------------------------------|
| Delegated (work or school account)     | RoleManagement.ReadWrite.Directory |
| Delegated (personal Microsoft account) | Not supported. |
| Application                            | RoleManagement.ReadWrite.Directory |

### For the entitlement management provider

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) |  EntitlementManagement.ReadWrite.All   |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | EntitlementManagement.ReadWrite.All |

## HTTP request

Create a role assignment for the directory provider:

<!-- { "blockType": "ignored" } -->

```http
POST /roleManagement/directory/roleAssignments
```

Create a role assignment for the entitlement management provider:

<!-- { "blockType": "ignored" } -->

```http
POST /roleManagement/entitlementManagement/roleAssignments
```


## Request headers

| Name          | Description   |
|:--------------|:--------------|
| Authorization | Bearer {token} |

## Request body

In the request body, supply a JSON representation of [unifiedRoleAssignment](../resources/unifiedroleassignment.md) object. The request must have either a scope defined in Azure Active Directory (Azure AD) specified by **directoryScopeId**, or an application-specific scope specified by the **appScopeId**. Examples of Azure AD scopes are tenant (`/`), administrative unit, or application. For more information on appScope, see [appScope](../resources/appscope.md).

The following table shows the properties that are required when you create a [unifiedRoleAssignment](../resources/unifiedroleassignment.md) object.

| Parameter | Type | Description|
|:---------------|:--------|:----------|
|roleDefinitionId|String| Identifier of the role definition the assignment is for.|
|principalId|String| The identifier of the principal to which the assignment is granted. |
|directoryScopeId|String|Identifier of the directory object representing the scope of the assignment. Either this property or **appScopeId** is required. The scope of an assignment determines the set of resources for which the principal has been granted access. Directory scopes are shared scopes stored in the directory that are understood by multiple applications. Use `/` for tenant-wide scope. Use **appScopeId** to limit the scope to an application only.|
|appScopeId|String|Identifier of the app-specific scope when the assignment scope is app-specific. Either this property or **directoryScopeId** is required. App scopes are scopes that are defined and understood by this application only. Use `/` for tenant-wide app scopes. Use **directoryScopeId** to limit the scope to particular directory objects, for example, administrative units.|

## Response

If successful, this method returns a `201 Created` response code and a new [unifiedRoleAssignment](../resources/unifiedroleassignment.md) object in the response body.

## Examples

### Example 1: Create a role assignment with tenant scope

#### Request

The following is an example of the request. Note the use of the roleTemplateId for roleDefinitionId. roleDefinitionId can be either the service-wide template Id or the directory-specific roleDefinitionId.



# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_unifiedroleassignment_from_rbacapplication"
}-->

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
Content-type: application/json

{ 
    "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
    "roleDefinitionId": "c2cf284d-6c41-4e6b-afac-4b80928c9034",
    "principalId": "f8ca5a85-489a-49a0-b555-0a6d81e56f0d",
    "directoryScopeId": "/"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var unifiedRoleAssignment = new UnifiedRoleAssignment
{
	RoleDefinitionId = "c2cf284d-6c41-4e6b-afac-4b80928c9034",
	PrincipalId = "f8ca5a85-489a-49a0-b555-0a6d81e56f0d",
	DirectoryScopeId = "/"
};

await graphClient.RoleManagement.Directory.RoleAssignments
	.Request()
	.AddAsync(unifiedRoleAssignment);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

#### Response

The following is an example of the response.

> **Note:** The response object shown here might be shortened for readability. 

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.unifiedRoleAssignment"
} -->

```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleAssignments/$entity",
    "id": "YUb1sHQtUEyvox7IA_Eu_mm3jqnUe4lEhvatluHVi2I-1",
    "roleDefinitionId": "c2cf284d-6c41-4e6b-afac-4b80928c9034",
    "principalId": "f8ca5a85-489a-49a0-b555-0a6d81e56f0d",
    "directoryScopeId": "/"
}
```

### Example 2 : Create a role assignment with administrative unit scope

#### Request

The following example assigns the User Administrator role to a principal with administrative unit scope.



# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_unifiedroleassignment_over_administrativeunit"
}-->

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
Content-type: application/json

{
    "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
    "roleDefinitionId": "fe930be7-5e62-47db-91af-98c3a49a38b1",
    "principalId": "f8ca5a85-489a-49a0-b555-0a6d81e56f0d",
    "directoryScopeId": "/administrativeUnits/5d107bba-d8e2-4e13-b6ae-884be90e5d1a"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var unifiedRoleAssignment = new UnifiedRoleAssignment
{
	RoleDefinitionId = "fe930be7-5e62-47db-91af-98c3a49a38b1",
	PrincipalId = "f8ca5a85-489a-49a0-b555-0a6d81e56f0d",
	DirectoryScopeId = "/administrativeUnits/5d107bba-d8e2-4e13-b6ae-884be90e5d1a"
};

await graphClient.RoleManagement.Directory.RoleAssignments
	.Request()
	.AddAsync(unifiedRoleAssignment);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

#### Response

The following is an example of the response.

> **Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.unifiedRoleAssignment"
} -->

```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/directory/roleAssignments/$entity",
    "id": "BH21sHQtUEyvox7IA_Eu_mm3jqnUe4lEhvatluHIWb7-1",
    "roleDefinitionId": "fe930be7-5e62-47db-91af-98c3a49a38b1",
    "principalId": "f8ca5a85-489a-49a0-b555-0a6d81e56f0d",
    "directoryScopeId": "/administrativeUnits/5d107bba-d8e2-4e13-b6ae-884be90e5d1a"
}
```

### Example 3 : Create a role assignment with application scope

#### Request

The following example assigns a principal the Application Administrator role at application scope. The object ID of the application registration is 661e1310-bd76-4795-89a7-8f3c8f855bfc.



# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_unifiedroleassignment_over_application"
}-->

```http
POST https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
Content-type: application/json

{
    "@odata.type": "#microsoft.graph.unifiedRoleAssignment",
    "principalId": "6b937a9d-c731-465b-a844-2d5b5368c161",
    "roleDefinitionId": "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3",
    "directoryScopeId": "/661e1310-bd76-4795-89a7-8f3c8f855bfc"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var unifiedRoleAssignment = new UnifiedRoleAssignment
{
	PrincipalId = "6b937a9d-c731-465b-a844-2d5b5368c161",
	RoleDefinitionId = "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3",
	DirectoryScopeId = "/661e1310-bd76-4795-89a7-8f3c8f855bfc"
};

await graphClient.RoleManagement.Directory.RoleAssignments
	.Request()
	.AddAsync(unifiedRoleAssignment);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

#### Response

The following is an example of the response.

> **Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.unifiedRoleAssignment"
} -->

```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#roleManagement/directory/roleAssignments/$entity",
    "@odata.id": "https://graph.microsoft.com/v2/22350cac-d84b-466b-8c2c-f9326746709a/roleAssignments/kl2Jm9Msx0SdAqasLV6lw516k2sxx1tGqEQtW1NowWEQEx5mdr2VR4mnjzyPhVv8-1",
    "id": "kl2Jm9Msx0SdAqasLV6lw516k2sxx1tGqEQtW1NowWEQEx5mdr2VR4mnjzyPhVv8-1",
    "principalId": "6b937a9d-c731-465b-a844-2d5b5368c161",
    "principalOrganizationId": "22350cac-d84b-466b-8c2c-f9326746709a",
    "resourceScope": "/661e1310-bd76-4795-89a7-8f3c8f855bfc",
    "directoryScopeId": "/661e1310-bd76-4795-89a7-8f3c8f855bfc",
    "roleDefinitionId": "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3"
}
```

### Example 4: Create a role assignment with access package catalog scope

#### Request

The following is an example of the request.


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_unifiedroleassignment3_from_rbacapplication_4"
}-->

```http
POST https://graph.microsoft.com/v1.0/roleManagement/entitlementManagement/roleAssignments
Content-type: application/json

{
    "principalId": "679a9213-c497-48a4-830a-8d3d25d94ddc",
    "roleDefinitionId": "ae79f266-94d4-4dab-b730-feca7e132178",
    "appScopeId": "/AccessPackageCatalog/beedadfe-01d5-4025-910b-84abb9369997"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var unifiedRoleAssignment = new UnifiedRoleAssignment
{
	PrincipalId = "679a9213-c497-48a4-830a-8d3d25d94ddc",
	RoleDefinitionId = "ae79f266-94d4-4dab-b730-feca7e132178",
	AppScopeId = "/AccessPackageCatalog/beedadfe-01d5-4025-910b-84abb9369997"
};

await graphClient.RoleManagement.EntitlementManagement.RoleAssignments
	.Request()
	.AddAsync(unifiedRoleAssignment);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

#### Response

The following is an example of the response.

> **Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.unifiedRoleAssignment"
} -->

```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#roleManagement/entitlementManagement/roleAssignments/$entity",
    "id": "f3092518-7874-462e-93e9-0cd6c11ffc52",
    "principalId": "679a9213-c497-48a4-830a-8d3d25d94ddc",
    "roleDefinitionId": "ae79f266-94d4-4dab-b730-feca7e132178",
    "appScopeId": "/AccessPackageCatalog/beedadfe-01d5-4025-910b-84abb9369997"
}
```

<!-- uuid: 16cd6b66-4b1a-43a1-adaf-3a886856ed98
2019-02-04 14:57:30 UTC -->
<!-- {
  "type": "#page.annotation",
  "description": "Create unifiedRoleAssignment",
  "keywords": "",
  "section": "documentation",
  "tocPath": ""
}-->

