---
title: "Get signIn"
description: "Describes the get method of the signIn resource (entity) from the Microsoft Graph API."
ms.localizationpriority: medium
author: "besiler"
ms.prod: "identity-and-access-reports"
doc_type: apiPageType
---

# Get signIn

Namespace: microsoft.graph

Retrieve a specific Azure AD user sign-in event for your tenant. Sign-ins that are interactive in nature (where a username/password is passed as part of auth token) and successful federated sign-ins are currently included in the sign-in logs.


>[!NOTE]
>This article describes how to export personal data from a device or service. These steps can be used to support your obligations under the General Data Protection Regulation (GDPR). Authorized tenant admins can use Microsoft Graph to correct, update, or delete identifiable information about end users, including customer and employee user profiles or personal data, such as a user's name, work title, address, or phone number, in your [Azure Active Directory (Azure AD)](https://azure.microsoft.com/services/active-directory/) environment.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | AuditLog.Read.All and Directory.Read.All |
|Delegated (personal Microsoft account) | Not supported   |
|Application | AuditLog.Read.All and Directory.Read.All |

> [!IMPORTANT]
> This API has a [known issue](/graph/known-issues#license-check-errors-for-azure-ad-activity-reports) and currently requires consent to both the **AuditLog.Read.All** and **Directory.Read.All** permissions.

Apps must be [properly registered](/azure/active-directory/active-directory-reporting-api-prerequisites-azure-portal) to Azure AD.

In addition to the delegated permissions, the signed-in user needs to belong to one of the following directory roles that allow them to read sign-in reports. To learn more about directory roles, see [Azure AD built-in roles](/azure/active-directory/roles/permissions-reference):
+ Global Administrator
+ Global Reader
+ Reports Reader
+ Security Administrator
+ Security Operator
+ Security Reader

### Viewing applied conditional access (CA) policies in sign-ins
The applied CA policies listed in **appliedConditionalAccessPolicies** property are only available to users and apps with roles that allow them to read [conditional access data](/graph/api/resources/appliedconditionalaccesspolicy). If a user or app has permissions to read sign-in logs but not permission to read conditional access data, the **appliedConditionalAccessPolicies** property in the response will be omitted. The following Azure AD roles grant users permissions to view conditional access data:

+ Global Administrator
+ Global Reader
+ Security Administrator
+ Security Reader
+ Conditional Access Administrator

Applications must have at least one of the following permissions to see [appliedConditionalAccessPolicy](/graph/api/resources/appliedconditionalaccesspolicy) objects in the sign-in logs: 

+ Policy.Read.All
+ Policy.ReadWrite.ConditionalAccess
+ Policy.Read.ConditionalAccess

>**Note:** Azure AD users with any permissions can read sign-in logs in which their user is the actor signing in. This feature helps users spot unexpected activity in their accounts. Users cannot read CA data from their own logs unless they have one of the CA permissions identified above.

## HTTP request

<!-- { "blockType": "ignored" } -->
```http
GET /auditLogs/signIns/{id}
```

## Optional query parameters

This method supports OData query parameters to help customize the response. For details about how to use these parameters, see [OData query parameters](/graph/query-parameters).

## Request headers

| Name      |Description|
|:----------|:----------|
| Authorization  | Bearer {code}|

## Request body

Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and [signIn](../resources/signin.md) object in the response body.

## Example

### Request

Here is an example of the request.


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "get_signin"
}-->

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/auditLogs/signIns/66ea54eb-6301-4ee5-be62-ff5a759b0100
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var signIn = await graphClient.AuditLogs.SignIns["{signIn-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response

Here is an example of the response.
>**Note:** The response object shown here might be shortened for readability.

<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.signIn"
} -->

```http
HTTP/1.1 200 OK
Content-type: application/json

{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#auditLogs/signIns",
    "value": [
        {
            "id": "66ea54eb-6301-4ee5-be62-ff5a759b0100",
            "createdDateTime": "2020-03-13T19:15:41.6195833Z",
            "userDisplayName": "Test Contoso",
            "userPrincipalName": "testaccount1@contoso.com",
            "userId": "26be570a-ae82-4189-b4e2-a37c6808512d",
            "appId": "de8bc8b5-d9f9-48b1-a8ad-b748da725064",
            "appDisplayName": "Graph explorer",
            "ipAddress": "131.107.159.37",
            "clientAppUsed": "Browser",
            "correlationId": "d79f5bee-5860-4832-928f-3133e22ae912",
            "conditionalAccessStatus": "notApplied",
            "isInteractive": true,
            "riskDetail": "none",
            "riskLevelAggregated": "none",
            "riskLevelDuringSignIn": "none",
            "riskState": "none",
            "riskEventTypes": [],
            "resourceDisplayName": "Microsoft Graph",
            "resourceId": "00000003-0000-0000-c000-000000000000",
            "status": {
                "errorCode": 0,
                "failureReason": null,
                "additionalDetails": null
            },
            "deviceDetail": {
                "deviceId": "",
                "displayName": null,
                "operatingSystem": "Windows 10",
                "browser": "Edge 80.0.361",
                "isCompliant": null,
                "isManaged": null,
                "trustType": null
            },
            "location": {
                "city": "Redmond",
                "state": "Washington",
                "countryOrRegion": "US",
                "geoCoordinates": {
                    "altitude": null,
                    "latitude": 47.68050003051758,
                    "longitude": -122.12094116210938
                }
            },
            "appliedConditionalAccessPolicies": [
                {
                    "id": "de7e60eb-ed89-4d73-8205-2227def6b7c9",
                    "displayName": "SharePoint limited access for guest workers",
                    "enforcedGrantControls": [],
                    "enforcedSessionControls": [],
                    "result": "notEnabled"
                },
                {
                    "id": "6701123a-b4c6-48af-8565-565c8bf7cabc",
                    "displayName": "Medium signin risk block",
                    "enforcedGrantControls": [],
                    "enforcedSessionControls": [],
                    "result": "notEnabled"
                },
              ]
        }
    ]
}
```
<!-- uuid: 8fcb5dbc-d5aa-4681-8e31-b001d5168d79
2015-10-25 14:57:30 UTC -->
<!-- {
  "type": "#page.annotation",
  "description": "Get signIn",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": [
  ]
}-->

