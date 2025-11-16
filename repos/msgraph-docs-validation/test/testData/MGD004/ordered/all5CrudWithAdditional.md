---
title: "accessPackage resource type"
description: "An access package defines the collections of resource roles and the policies for how one or more users can get access to those resources."
author: "markwahl-msft"
ms.localizationpriority: medium
ms.prod: "governance"
doc_type: resourcePageType
---
# accessPackage resource type

Namespace: microsoft.graph

In [Azure AD Entitlement Management](entitlementmanagement-overview.md), an access package defines the collections of resource roles and the policies for how one or more users can get access to those resources.

Each access package is referenced by a single access package catalog, and has links to the resources from that catalog via the resource-specific role scopes that define the access the package provides.  An access package also links to the access package assignment policies, each of which define who can request or be assigned an access package assignment.

## Methods

|Method|Return type|Description|
|:---|:---|:---|
|[List accessPackages](../api/entitlementmanagement-list-accesspackages.md)|[accessPackage](accesspackage.md) collection|Retrieve a list of **accesspackage** objects. |
|[Create accessPackage](../api/entitlementmanagement-post-accesspackages.md)|[accessPackage](accesspackage.md)|Create a new **accesspackage** object. |
|[Get accessPackage](../api/accesspackage-get.md)|[accessPackage](accesspackage.md)|Read properties and relationships of an **accesspackage** object. |
|[Update accessPackage](../api/accesspackage-update.md)|None|Update the properties of an **accesspackage** object. |
|[Delete accessPackage](../api/accesspackage-delete.md)|None|Delete an **accesspackage**. |
| [List incompatibleAccessPackages](../api/accesspackage-list-incompatibleaccesspackages.md) | [accessPackage](accesspackage.md) collection | Retrieve a list of the incompatible **accesspackage** objects for this access package. |
| [Add accessPackage to incompatibleAccessPackages](../api/accesspackage-post-incompatibleaccesspackage.md) | None | Add a link to indicate another **accesspackage** is incompatible with a specified access package. |
| [Remove accessPackage from incompatibleAccessPackages](../api/accesspackage-delete-incompatibleaccesspackage.md) | None | Remove a link that indicated an **accesspackage** was incompatible. |
| [List incompatibleGroups](../api/accesspackage-list-incompatiblegroups.md) | [group](group.md) collection | Retrieve a list of the incompatible **group** objects for this access package. |
| [Add group to incompatibleGroups](../api/accesspackage-post-incompatiblegroup.md) | None | Add a link to indicate membership of a **group** is incompatible with a specified access package. |
| [Remove group from incompatibleGroups](../api/accesspackage-delete-incompatiblegroup.md) | None | Remove a link that indicated a **group** membership was incompatible.|
| [List accessPackagesIncompatibleWith](../api/accesspackage-list-accesspackagesincompatiblewith.md) | [accessPackage](accesspackage.md) collection | Retrieve a list of the  **accesspackage** objects which list this access package as incompatible. |
|[filterByCurrentUser](../api/accesspackage-filterbycurrentuser.md)|[accessPackage](../resources/accesspackage.md) collection|Retrieve the list of **accessPackage** objects filtered on the signed-in user.|
|[getApplicablePolicyRequirements](../api/accesspackage-getapplicablepolicyrequirements.md)|[accessPackageAssignmentRequestRequirements](../resources/accesspackageassignmentrequestrequirements.md) collection|Retrieve a list of **accessPackageAssignmentRequestRequirement** objects with request requirements. |
