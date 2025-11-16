---
title: "List members of an educationClass"
description: "Retrieves the teachers and students for a class. Note that if the delegated token is used, members can only be seen by other members of the class."
ms.localizationpriority: medium
author: "mmast-msft"
ms.prod: "education"
doc_type: apiPageType
---

# List members of an educationClass

Namespace: microsoft.graph

Retrieves the [educationUser](../resources/educationuser.md) members of an [educationClass](../resources/educationclass.md).

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

| Permission type                        | Permissions (from least to most privileged)                         |
| :------------------------------------- | :------------------------------------------------------------------ |
| Delegated (work or school account)     | EduRoster.ReadBasic                                                 |
| Delegated (personal Microsoft account) | Not supported                                                       |
| Application                            | EduRoster.Read.All, EduRoster.ReadWrite.All plus Member.Read.Hidden |

> [!NOTE]
> Note that if the delegated token is used, members can only see information about their own classes.

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /education/classes/{id}/members
```

## Optional query parameters

This method supports the [OData query parameters](/graph/query-parameters) to help customize the response, including `$search`, `$count`, and `$filter`.

When items are added or updated for this resource, they are specially indexed for use with the `$count` and `$search` query parameters. There can be a slight delay between when an item is added or updated and when it is available in the index.

For more information on OData query options, see [OData query parameters](/graph/query-parameters).

## Request headers
| Header       | Value |
|:---------------|:--------|
| Authorization  | Bearer {token}. Required.  |

## Request body
Do not supply a request body for this method.
## Response
If successful, this method returns a `200 OK` response code and a collection of [educationUser](../resources/educationuser.md) objects in the response body.
## Example
##### Request
The following is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_educationclass_members"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/education/classes/7e4ec76c-8276-43ef-ba10-9aaa197cb212/members
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var members = await graphClient.Education.Classes["{educationClass-id}"].Members
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

