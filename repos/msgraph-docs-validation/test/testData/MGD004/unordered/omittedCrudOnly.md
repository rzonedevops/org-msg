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
|[Update accessPackage](../api/accesspackage-update.md)|None|Update the properties of an **accesspackage** object. |
|[Create accessPackage](../api/entitlementmanagement-post-accesspackages.md)|[accessPackage](accesspackage.md)|Create a new **accesspackage** object. |
|[Delete accessPackage](../api/accesspackage-delete.md)|None|Delete an **accesspackage**. |
