---
title: "Get domain"
description: "Retrieve the properties and relationships of domain object."
author: "adimitui"
ms.localizationpriority: medium
ms.prod: "directory-management"
doc_type: apiPageType
---

# Get domain

Namespace: microsoft.graph

Retrieve the properties and relationships of domain object.

## Permissions

One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Domain.Read.All, Domain.ReadWrite.All, Directory.Read.All    |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Domain.Read.All, Domain.ReadWrite.All, Directory.Read.All  |

The work or school account needs to belong to one of the following roles:

* Global Administrator
* User Administrator
* Helpdesk Administrator
* Service Support Administrator
* Billing Administrator
* Mailbox Administrator
* Partner Tier1 Support
* Partner Tier2 Support
* Directory Readers
* Directory Writers
* AdHoc License Administrator
* Application Administrator
* Security Reader
* Security Administrator
* Privileged Role Administrator
* Cloud Application Administrator
* Customer LockBox Access Approver
* Dynamics 365 Administrator
* Power BI Administrator
* Azure Information Protection Administrator
* Desktop Analytics Administrator
* License Administrator
* Microsoft Managed Desktop Administrator
* Authentication Administrator
* Privileged Authentication Administrator
* Teams Communications Administrator
* Teams Communications Support Engineer
* Teams Communications Support Specialist
* Teams Administrator
* Insights Administrator
* Compliance Data Administrator
* Security Operator
* Kaizala Administrator
* Global Reader
* Volume Licensing Business Center User
* Volume Licensing Service Center User
* Modern Commerce User
* Microsoft Store for Business User
* Directory Reviewer

## HTTP request

<!-- { "blockType": "ignored" } -->
```http
GET /domains/{id}
```

> For {id}, specify the domain with its fully qualified domain name.

## Optional query parameters

This method supports the [OData Query Parameters](/graph/query-parameters) to help customize the response.

## Request headers

| Name      |Description|
|:----------|:----------|
| Authorization  | Bearer {token}. Required. |
| Content-Type  | application/json |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and [domain](../resources/domain.md) object in the response body.
## Example
##### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "sampleKeys": ["M365x214355.onmicrosoft.com"],
  "name": "get_domain"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/domains/M365x214355.onmicrosoft.com
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var domain = await graphClient.Domains["{domain-id}"]
	.Request()
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

