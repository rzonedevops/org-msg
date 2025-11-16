---
title: "Get educationSchool"
description: "Read the properties and relationships of an educationSchool object."
author: "mlafleur"
ms.localizationpriority: medium
ms.prod: "education"
doc_type: apiPageType
---

# Get educationSchool

Namespace: microsoft.graph

Read the properties and relationships of an [educationSchool](../resources/educationschool.md) object.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

| Permission type                        | Permissions (from least to most privileged) |
| :------------------------------------- | :------------------------------------------ |
| Delegated (work or school account)     | EduRoster.ReadBasic                         |
| Delegated (personal Microsoft account) | Not supported.                              |
| Application                            | EduRoster.Read.All, EduRoster.ReadWrite.All |

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->

```http
GET /education/schools/{educationSchoolId}
```

## Optional query parameters

This method supports the same OData query parameters as [Get User](../api/user-get.md#optional-query-parameters). For general information, see [OData query parameters](/graph/query-parameters).

## Request headers

| Name          | Description               |
| :------------ | :------------------------ |
| Authorization | Bearer {token}. Required. |

## Request body

Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and an [educationSchool](../resources/educationschool.md) object in the response body.

## Examples

### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_educationschool"
}
-->

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/education/schools/f2598f43-629c-4ea9-9265-97a34839644e
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var educationSchool = await graphClient.Education.Schools["{educationSchool-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

>**Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.educationSchool"
}
-->

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#education/schools/$entity",
    "id": "f2598f43-629c-4ea9-9265-97a34839644e",
    "displayName": "Business Training Camp",
    "description": null,
    "principalEmail": "aroebuck@principal.edu",
    "principalName": "Amy Roebuck",
    "externalPrincipalId": "14007",
    "externalId": "10001",
    "externalSource": "sis",
    "externalSourceDetail": "SIS",
    "phone": "555-123-4567",
    "address": {
        "city": "Redmond",
        "countryOrRegion": "US",
        "postalCode": "98052",
        "state": "WA",
        "street": "2 Microsoft Way"
    }
}
```
