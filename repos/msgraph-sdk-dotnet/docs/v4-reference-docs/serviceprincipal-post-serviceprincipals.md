---
title: "Create serviceprincipal"
description: "Create a new serviceprincipal object."
author: "sureshja"
ms.localizationpriority: high
doc_type: apiPageType
ms.prod: "applications"
---

# Create servicePrincipal

Namespace: microsoft.graph

Create a new [servicePrincipal](../resources/serviceprincipal.md) object.

> [!IMPORTANT]
> Adding [**passwordCredential**](../resources/passwordcredential.md) when creating servicePrincipals is not supported. Use the [addPassword](serviceprincipal-addpassword.md) method to add passwords or secrets for a servicePrincipal.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Application.ReadWrite.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Application.ReadWrite.OwnedBy, Application.ReadWrite.All |

For multi-tenant apps, the calling user must also be in one of the following [Azure AD roles](/azure/active-directory/roles/permissions-reference):

+ Global Administrator
+ Application Administrator
+ Cloud Application Administrator roles

For single-tenant apps where the calling user is a non-admin user but is the owner of the backing application, the user must have the *Application Developer* role.

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /servicePrincipals
```

## Request headers
| Name       | Description|
|:-----------|:----------|
| Authorization | Bearer {token}. Required.  |
| Content-Type | application/json. Required. |

## Request body
In the request body, supply a JSON representation of a [servicePrincipal](../resources/serviceprincipal.md) object. The request body must contain **appId**.

## Response

If successful, this method returns a `201 Created` response code and a [servicePrincipal](../resources/serviceprincipal.md) object in the response body.

## Examples
### Request
Here is an example of the request.


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_serviceprincipal_from_serviceprincipals"
}-->
```http
POST https://graph.microsoft.com/v1.0/servicePrincipals
Content-type: application/json

{
  "appId": "65415bb1-9267-4313-bbf5-ae259732ee12"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var servicePrincipal = new ServicePrincipal
{
	AppId = "65415bb1-9267-4313-bbf5-ae259732ee12"
};

await graphClient.ServicePrincipals
	.Request()
	.AddAsync(servicePrincipal);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
Here is an example of the response. 

> **Note:** The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.servicePrincipal"
} -->
```http
HTTP/1.1 201 Created
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#servicePrincipals/$entity",
    "id": "59e617e5-e447-4adc-8b88-00af644d7c92",
    "deletedDateTime": null,
    "accountEnabled": true,
    "appDisplayName": "My App",
    "appId": "65415bb1-9267-4313-bbf5-ae259732ee12",
    "appOwnerOrganizationId": "1bc1c026-2f7b-48a5-98da-afa2fd8bc7bc",
    "appRoleAssignmentRequired": false,
    "displayName": "foo",
    "homepage": null,
    "logoutUrl": null,
    "publisherName": "Contoso",
    "replyUrls": [],
    "servicePrincipalNames": [
        "f1bd758f-4a1a-4b71-aa20-a248a22a8928"
    ],
    "tags": [],
    "addIns": [],
    "appRoles": [],
    "info": {
        "termsOfServiceUrl": null,
        "supportUrl": null,
        "privacyStatementUrl": null,
        "marketingUrl": null,
        "logoUrl": null
    },
    "keyCredentials": [],
    "oauth2PermissionScopes": [],
    "passwordCredentials": []
}
```

