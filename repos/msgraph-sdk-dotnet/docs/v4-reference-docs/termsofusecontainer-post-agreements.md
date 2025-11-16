---
title: "Create agreement"
description: "Create a new agreement object."
ms.localizationpriority: medium
doc_type: apiPageType
ms.prod: "governance"
author: "raprakasMSFT"
---

# Create agreement

Namespace: microsoft.graph

Create a new [agreement](../resources/agreement.md) object.
## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type                        | Permissions (from least to most privileged)              |
|:--------------------------------------|:---------------------------------------------------------|
|Delegated (work or school account)     | Agreement.ReadWrite.All |
|Delegated (personal Microsoft account) | Not supported. |
|Application                            | Not supported. |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /identityGovernance/termsOfUse/agreements
```
## Request headers
| Name         | Description |
|:-------------|:------------|
| Authorization | Bearer \{token\}. Required. |
| Content-type  | application/json. Required. |

## Request body
In the request body, supply a JSON representation of an [agreement](../resources/agreement.md) object.

The following table shows the properties that are required when you create an agreement.

| Property     | Type        | Description |
|:-------------|:------------|:------------|
|displayName|String|Display name of the agreement.|
|isViewingBeforeAcceptanceRequired|Boolean|Indicates whether the user has to expand and view the agreement before accepting.|
|fileName|String|Name of the agreement file (for example, TOU.pdf).|
|isDefault|Boolean|Indicates whether this is the default agreement file if the language matches the client preference. If none of the files are marked as default, the first one is treated as default.|
|language|String|The language of the agreement file in the format "languagecode2-country/regioncode2". "languagecode2" is a lowercase two-letter code derived from ISO 639-1, while "country/regioncode2" is derived from ISO 3166 and usually consists of two uppercase letters, or a BCP-47 language tag. For example, U.S. English is `en-US`.|
|data|Binary|Data that represents the terms of use for the PDF document.|

## Response
If successful, this method returns a `201, Created` response code and an [agreement](../resources/agreement.md) object in the response body.

## Example
### Request
In the request body, supply a JSON representation of the [agreement](../resources/agreement.md) object.


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_agreement_from_agreements"
}-->
```http
POST https://graph.microsoft.com/v1.0/identityGovernance/termsOfUse/agreements
Content-type: application/json

{
  "displayName": "Contoso ToU for guest users",
  "isViewingBeforeAcceptanceRequired": true,
  "files": [
    {
      "fileName": "TOU.pdf",
      "language": "en",
      "isDefault": true,
      "fileData": {
        "data": "SGVsbG8gd29ybGQ=//truncated-binary"
      }
    }
  ]
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var agreement = new Agreement
{
	DisplayName = "Contoso ToU for guest users",
	IsViewingBeforeAcceptanceRequired = true,
	Files = new AgreementFilesCollectionPage()
	{
		new AgreementFileLocalization
		{
			FileName = "TOU.pdf",
			Language = "en",
			IsDefault = true,
			FileData = new AgreementFileData
			{
				Data = Convert.FromBase64String("SGVsbG8gd29ybGQ=//truncated-binary")
			}
		}
	}
};

await graphClient.IdentityGovernance.TermsOfUse.Agreements
	.Request()
	.AddAsync(agreement);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
>**Note:** The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.agreement"
} -->
```http
HTTP/1.1 201 Created
Content-type: application/json

{
  "displayName": "MSGraph Sample",
  "isViewingBeforeAcceptanceRequired": true,
  "id": "093b947f-8363-4979-a47d-4c52b33ee1be"
}
```

<!-- uuid: 8fcb5dbc-d5aa-4681-8e31-b001d5168d79
2015-10-25 14:57:30 UTC -->
<!--
{
  "type": "#page.annotation",
  "description": "Create agreement",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": [
  ]
}
-->


