---
title: "Get agreement"
description: "Retrieve the properties and relationships of an agreement object."
ms.localizationpriority: medium
doc_type: apiPageType
ms.prod: "governance"
author: "raprakasMSFT"
---

# Get agreement

Namespace: microsoft.graph

Retrieve the properties and relationships of an [agreement](../resources/agreement.md) object.
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
GET /identityGovernance/termsOfUse/agreements/{id}
```

## Optional query parameters
This method supports the `$select` [OData query parameter](/graph/query-parameters) to help customize the response.

## Request headers
| Name         | Type        | Description |
|:-------------|:------------|:------------|
| Authorization | string | Bearer \{token\}. Required. |

## Request body
Do not supply a request body for this method.
## Response
If successful, this method returns a `200 OK` response code and [agreement](../resources/agreement.md) object in the response body.
## Examples

### Example 1: Retrieve an agreement

#### Request

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_agreement"
}-->
```
GET https://graph.microsoft.com/v1.0/identityGovernance/termsOfUse/agreements/0ec9f6a6-159d-4dd8-a563-1f0b5935e80b
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var agreement = await graphClient.IdentityGovernance.TermsOfUse.Agreements["{agreement-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

#### Response
>**Note:** The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.agreement"
} -->
```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#agreements/$entity",
    "id": "0ec9f6a6-159d-4dd8-a563-1f0b5935e80b",
    "displayName": "All users terms of use",
    "termsExpiration": null,
    "userReacceptRequiredFrequency": "P90D",
    "isViewingBeforeAcceptanceRequired": false,
    "isPerDeviceAcceptanceRequired": false
}
```


### Example 2: Retrieve an agreement and its related files

#### Request

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_agreement_files"
}-->
```
GET https://graph.microsoft.com/v1.0/identityGovernance/termsOfUse/agreements/093b947f-8363-4979-a47d-4c52b33ee1be?$expand=files
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var agreement = await graphClient.IdentityGovernance.TermsOfUse.Agreements["{agreement-id}"]
	.Request()
	.Expand("files")
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

#### Response
>**Note:** The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.agreement"
} -->
```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#agreements(files())/$entity",
    "id": "0ec9f6a6-159d-4dd8-a563-1f0b5935e80b",
    "displayName": "All users terms of use",
    "termsExpiration": null,
    "userReacceptRequiredFrequency": "P90D",
    "isViewingBeforeAcceptanceRequired": false,
    "isPerDeviceAcceptanceRequired": false,
    "files": [
        {
            "id": "681b73a7-e9ae-4f2d-aca5-9e857599cd15",
            "fileName": "ToU.pdf",
            "displayName": "Contoso Terms of Use",
            "language": "en-GB",
            "isDefault": true,
            "isMajorVersion": false,
            "createdDateTime": "2022-03-02T14:11:32.885186Z",
            "fileData": null
        }
    ]
}
```

<!-- uuid: 8fcb5dbc-d5aa-4681-8e31-b001d5168d79
2015-10-25 14:57:30 UTC -->
<!--
{
  "type": "#page.annotation",
  "description": "Get agreement",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": [
  ]
}
-->
