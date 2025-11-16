---
title: "Permanently delete an item (directory object)"
description: "Permanently delete a recently deleted application, group, service principal, or user from deleted items."
author: "keylimesoda"
ms.localizationpriority: medium
ms.prod: "directory-management"
doc_type: apiPageType
---

# Permanently delete an item (directory object)

Namespace: microsoft.graph

Permanently delete a recently deleted [application](../resources/application.md), [group](../resources/group.md), [servicePrincipal](../resources/serviceprincipal.md), or [user](../resources/user.md) object from [deleted items](../resources/directory.md). After an item is permanently deleted, it **cannot** be restored.

Administrative units **cannot** be permanently deleted by using the **deletedItems** API. Soft-deleted administrative units will be permanently deleted 30 days after initial deletion unless they are restored.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

### For applications and service principals:


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Application.ReadWrite.All, Directory.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Application.ReadWrite.OwnedBy, Application.ReadWrite.All |

The calling user must be the owner of the application or the calling app must be assigned one of the following [Azure AD roles](/azure/active-directory/roles/permissions-reference):
+ Global Administrator
+ Application Administrator
+ Cloud Application Administrator
+ Hybrid Identity Administrator

### For users:

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | User.ReadWrite.All |
|Delegated (personal Microsoft account) | Not supported. |
|Application | Not supported. |

The signed-in user needs to have one of the following roles: *Global Administrator* or *User Administrator*.

### For groups:

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Group.ReadWrite.All |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Not supported. |

The requestor needs to have one of the following roles: *Global Administrator* or *Groups Administrator*.

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
DELETE /directory/deletedItems/{id}
```
## Request headers
| Name       | Description|
|:---------------|:----------|
| Authorization  | Bearer &lt;code&gt; *Required*|
| Accept  | application/json |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns `204 No Content` response code. It does not return anything in the response body.

## Example
##### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "delete_directory_deleteditem"
}-->
```http
DELETE https://graph.microsoft.com/v1.0/directory/deletedItems/{object-id}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

await graphClient.Directory.DeletedItems["{directoryObject-id}"]
	.Request()
	.DeleteAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

