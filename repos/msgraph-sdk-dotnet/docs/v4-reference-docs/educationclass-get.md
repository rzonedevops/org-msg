---
title: "Get educationClass"
description: "Retrieve a class from the system."
ms.localizationpriority: medium
author: "mlafleur"
ms.prod: "education"
doc_type: apiPageType
---

# Get educationClass

Namespace: microsoft.graph

Retrieve a class from the system. A class is a universal group with a special property that indicates to the system that the group is a class. Group members represent the students; group admins represent the teachers in the class. If you're using the delegated token, the user will only see classes in which they are members.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) |  EduRoster.ReadBasic  |
|Delegated (personal Microsoft account) |  Not supported  |
|Application | EduRoster.Read.All, EduRoster.ReadWrite.All | 

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /education/classes/{id}
```

## Optional query parameters
You can use `$select` to get specific group properties, including those that are not returned by default.

For more information on OData query options, see [OData Query Parameters](/graph/query-parameters).
## Request headers
| Header       | Value |
|:---------------|:--------|
| Authorization  | Bearer {token}. Required.  |

## Request body
Do not supply a request body for this method.
## Response
If successful, this method returns a `200 OK` response code and an [educationClass](../resources/educationclass.md) object in the response body.

## Example
### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_educationclass"
}
-->

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/education/classes/7e4ec76c-8276-43ef-ba10-9aaa197cb212
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var educationClass = await graphClient.Education.Classes["{educationClass-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

>**Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.educationClass"
}
-->

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#education/classes/$entity",
    "id": "7e4ec76c-8276-43ef-ba10-9aaa197cb212",
    "description": "Leadership 101 training",
    "displayName": "Leadership 101",
    "mailNickname": "Leadership101"
}
```
