---
title: "Delete appRoleAssignedTo"
description: "Delete an appRoleAssignment granted for a service principal."
ms.localizationpriority: medium
doc_type: apiPageType
ms.prod: "applications"
author: "sureshja"
---

# Delete appRoleAssignedTo

Namespace: microsoft.graph

Deletes an [appRoleAssignment](../resources/approleassignment.md) that a user, group, or client service principal has been granted for a resource service principal.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | AppRoleAssignment.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | AppRoleAssignment.ReadWrite.All |

## HTTP request

You can address the service principal using either its **id** or **appId**. **id** and **appId** are referred to as the **Object ID** and **Application (Client) ID**, respectively, in the Azure portal

<!-- { "blockType": "ignored" } -->

```http
DELETE /servicePrincipals/{id}/appRoleAssignedTo/{appRoleAssignment-id}
DELETE /servicePrincipals(appId='{appId}')/appRoleAssignedTo/{appRoleAssignment-id}
```

> [!NOTE]
> As a best practice, we recommend you use this method to delete app role assignments, instead of the [Delete appRoleAssignments ](serviceprincipal-delete-approleassignments.md) method which deletes through the **appRoleAssignments** relationship of the assigned user, group, or service principal.

## Request headers

| Name       | Description|
|:---------------|:--------|
| Authorization  | Bearer {token}. Required. |

## Request body

Do not supply a request body for this method.

## Response

If successful, this method returns `204 No Content` response code. It does not return anything in the response body.

## Examples

### Request

Here is an example of the request to delete an app role assignment from the resource service principal.



# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "serviceprincipal_delete_approleassignedto"
}-->

```http
DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{resource-SP-id}/appRoleAssignedTo/{appRoleAssignment-id}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

await graphClient.ServicePrincipals["{servicePrincipal-id}"].AppRoleAssignedTo["{appRoleAssignment-id}"]
	.Request()
	.DeleteAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

The following is an example of the response.

<!-- {
  "blockType": "response",
  "truncated": true
} -->

```http
HTTP/1.1 204 No Content
```

<!-- uuid: 8fcb5dbc-d5aa-4681-8e31-b001d5168d79
2015-10-25 14:57:30 UTC -->
<!--
{
  "type": "#page.annotation",
  "description": "Delete appRoleAssignment",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": [
  ]
}
-->

