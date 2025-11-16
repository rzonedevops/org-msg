---
title: "List schools"
description: "Retrieve a list of schools in which the class is taught."
author: "mmast-msft"
ms.localizationpriority: medium
ms.prod: "education"
doc_type: apiPageType
---

# List schools

Namespace: microsoft.graph

Retrieve a list of schools in which the class is taught.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

| Permission type                        | Permissions (from least to most privileged) |
| :------------------------------------- | :------------------------------------------ |
| Delegated (work or school account)     | EduRoster.ReadBasic                         |
| Delegated (personal Microsoft account) | Not supported.                              |
| Application                            | EduRoster.Read.All, EduRoster.ReadWrite.All |

## HTTP request

<!-- { "blockType": "ignored" } -->
```http
GET /education/classes/{id}/schools
```

## Optional query parameters

This method supports the [OData Query Parameters](/graph/query-parameters) to help customize the response.

## Request headers

| Header        | Value                     |
| :------------ | :------------------------ |
| Authorization | Bearer {token}. Required. |

## Request body

Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and a collection of [educationSchool](../resources/educationschool.md) objects in the response body.

## Example

### Request

The following is an example of the request.

# [HTTP](#tab/http)

<!-- {
  "blockType": "request",
  "name": "get_schools_1"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/education/classes/7e4ec76c-8276-43ef-ba10-9aaa197cb212/schools
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var schools = await graphClient.Education.Classes["{educationClass-id}"].Schools
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

The following is an example of the response.

>**Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.educationSchool",
  "isCollection": true
} -->
```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#Collection(microsoft.graph.educationSchool)",
    "value": [
        {
            "id": "8a07f5a8-edc9-4847-bbf2-dde106594bf4",
            "displayName": "Management Fast Track",
            "description": null,
            "principalEmail": "aroebuck@principal.edu",
            "principalName": "Amy Roebuck",
            "externalPrincipalId": "14008",
            "externalId": "10002",
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
    ]
}
```

<!-- uuid: 8fcb5dbc-d5aa-4681-8e31-b001d5168d79
2015-10-25 14:57:30 UTC -->
<!-- {
  "type": "#page.annotation",
  "description": "List schools",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": [
  ]
}-->
