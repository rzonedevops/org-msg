---
title: "List agreements"
description: "Retrieve a list of agreement objects."
ms.localizationpriority: medium
doc_type: apiPageType
ms.prod: "governance"
author: "raprakasMSFT"
---

# List agreements

Namespace: microsoft.graph

Retrieve a list of [agreement](../resources/agreement.md) objects.
## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type                        | Permissions (from least to most privileged)              |
|:--------------------------------------|:---------------------------------------------------------|
|Delegated (work or school account)     | Agreement.Read.All |
|Delegated (personal Microsoft account) | Not supported. |
|Application                            | Not supported. |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /identityGovernance/termsOfUse/agreements
```

## Optional query parameters
This method supports the `$select`, `$filter`, and `$top` [OData query parameters](/graph/query-parameters) to help customize the response.

## Request headers
| Name         | Type        | Description |
|:-------------|:------------|:------------|
| Authorization | string | Bearer \{token\}. Required. |

## Request body
Do not supply a request body for this method.
## Response
If successful, this method returns a `200 OK` response code and collection of [agreement](../resources/agreement.md) objects in the response body.
## Examples
### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_agreements"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/identityGovernance/termsOfUse/agreements
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var agreements = await graphClient.IdentityGovernance.TermsOfUse.Agreements
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
>**Note:** The response object shown here might be shortened for readability. 
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.agreement",
  "isCollection": true
} -->
```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#agreements",
    "value": [
        {
            "id": "0ec9f6a6-159d-4dd8-a563-1f0b5935e80b",
            "displayName": "All users terms of use",
            "termsExpiration": null,
            "userReacceptRequiredFrequency": "P90D",
            "isViewingBeforeAcceptanceRequired": false,
            "isPerDeviceAcceptanceRequired": false
        },
        {
            "id": "920f5775-d5d7-454b-861f-14685bb24e2c",
            "displayName": "ToU",
            "termsExpiration": null,
            "userReacceptRequiredFrequency": "P90D",
            "isViewingBeforeAcceptanceRequired": false,
            "isPerDeviceAcceptanceRequired": false
        },
        {
            "id": "94410bbf-3d3e-4683-8149-f034e55c39dd",
            "displayName": "Contoso ToU for guest users",
            "termsExpiration": null,
            "userReacceptRequiredFrequency": null,
            "isViewingBeforeAcceptanceRequired": true,
            "isPerDeviceAcceptanceRequired": false
        }
    ]
}
```

<!-- uuid: 8fcb5dbc-d5aa-4681-8e31-b001d5168d79
2015-10-25 14:57:30 UTC -->
<!--
{
  "type": "#page.annotation",
  "description": "List agreements",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": [
  ]
}
-->
