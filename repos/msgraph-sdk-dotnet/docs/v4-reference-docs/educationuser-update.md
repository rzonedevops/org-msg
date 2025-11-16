---
title: "Update educationUser"
description: "Update the properties of an educationUser object."
author: "mlafleur"
ms.localizationpriority: medium
ms.prod: "education"
doc_type: apiPageType
---

# Update educationUser

Namespace: microsoft.graph

Update the properties of an [educationUser](../resources/educationuser.md) object.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) |  Not supported.  |
|Delegated (personal Microsoft account) |  Not supported.  |
|Application | EduRoster.ReadWrite.All |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
PATCH /education/me
PATCH /education/users/{id}
```
## Request headers
| Header       | Value |
|:---------------|:--------|
| Authorization  | Bearer {token}. Required.  |
| Content-Type  | application/json  |

## Request body
In the request body, supply the values for relevant fields that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values. For best performance, don't include existing values that haven't changed.

| Property             | Type                                                               | Description                                                                                                                                                                                                                                                                                                                                                 |
| :------------------- | :----------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| accountEnabled       | Boolean                                                            | **True** if the account is enabled; otherwise, **false**. This property is required when a user is created. Supports $filter.                                                                                                                                                                                                                               |
| assignedLicenses     | [assignedLicense](../resources/assignedlicense.md) collection      | The licenses that are assigned to the user. Not nullable.                                                                                                                                                                                                                                                                                                   |
| assignedPlans        | [assignedPlan](../resources/assignedplan.md) collection            | The plans that are assigned to the user. Read-only. Not nullable.                                                                                                                                                                                                                                                                                           |
| businessPhones       | String collection                                                  | The telephone numbers for the user. **Note:** Although this is a string collection, only one number can be set for this property.                                                                                                                                                                                                                           |
| createdBy            | [identitySet](../resources/identityset.md)                         | Entity who created the user.                                                                                                                                                                                                                                                                                                                                |
| department           | String                                                             | The name for the department in which the user works. Supports $filter.                                                                                                                                                                                                                                                                                      |
| displayName          | String                                                             | The name displayed in the address book for the user. This is usually the combination of the user's first name, middle initial, and last name. This property is required when a user is created and it cannot be cleared during updates. Supports $filter and $orderby.                                                                                      |
| externalSource       | educationExternalSource                                            | Where this user was created from. Possible values are: `sis`, `manual`.                                                                                                                                                                                                                                                                                     |
| externalSourceDetail | String                                                             | The name of the external source this resources was generated from.                                                                                                                                                                                                                                                                                          |
| givenName            | String                                                             | The given name (first name) of the user. Supports $filter.                                                                                                                                                                                                                                                                                                  |
| mail                 | String                                                             | The SMTP address for the user; for example, "jeff@contoso.onmicrosoft.com". Read-Only. Supports $filter.                                                                                                                                                                                                                                                    |
| mailingAddress       | [physicalAddress](../resources/physicaladdress.md)                 | Mail address of user.                                                                                                                                                                                                                                                                                                                                       |
| mailNickname         | String                                                             | The mail alias for the user. This property must be specified when a user is created. Supports $filter.                                                                                                                                                                                                                                                      |
| middleName           | String                                                             | The middle name of user.                                                                                                                                                                                                                                                                                                                                    |
| mobilePhone          | String                                                             | The primary cellular telephone number for the user.                                                                                                                                                                                                                                                                                                         |
| onPremisesInfo       | [educationOnPremisesInfo](../resources/educationonpremisesinfo.md) | Additional information used to associate the AAD user with it's Active Directory counterpart.                                                                                                                                                                                                                                                               |
| passwordPolicies     | String                                                             | Specifies password policies for the user. This value is an enumeration with one possible value being "DisableStrongPassword", which allows weaker passwords than the default policy to be specified. "DisablePasswordExpiration" can also be specified. The two can be specified together; for example: "DisablePasswordExpiration, DisableStrongPassword". |
| passwordProfile      | [passwordProfile](../resources/passwordprofile.md)                 | Specifies the password profile for the user. The profile contains the user's password. This property is required when a user is created. The password in the profile must satisfy minimum requirements as specified by the **passwordPolicies** property. By default, a strong password is required.                                                        |
| preferredLanguage    | String                                                             | The preferred language for the user. Should follow ISO 639-1 Code; for example, "en-US".                                                                                                                                                                                                                                                                    |
| primaryRole          | educationUserRole                                                  | Default role for a user. The user's role might be different in an individual class. Possible values are: `student`, `teacher`, `none`, `unknownFutureValue`.                                                                                                                                                                                                |
| provisionedPlans     | [provisionedPlan](../resources/provisionedplan.md) collection      | The plans that are provisioned for the user. Read-only. Not nullable.                                                                                                                                                                                                                                                                                       |
| residenceAddress     | [physicalAddress](../resources/physicaladdress.md)                 | Address where user lives.                                                                                                                                                                                                                                                                                                                                   |
| student              | [educationStudent](../resources/educationstudent.md)               | If the primary role is student, this block will contain student specific data.                                                                                                                                                                                                                                                                              |
| surname              | String                                                             | The user's surname (family name or last name). Supports $filter.                                                                                                                                                                                                                                                                                            |
| teacher              | [educationTeacher](../resources/educationteacher.md)               | If the primary role is teacher, this block will contain teacher specific data.                                                                                                                                                                                                                                                                              |
| usageLocation        | String                                                             | A two-letter country code (ISO standard 3166). Required for users who will be assigned licenses due to a legal requirement to check for availability of services in countries or regions. Examples include: "US", "JP", and "GB". Not nullable. Supports $filter.                                                                                           |
| userPrincipalName    | String                                                             | The user principal name (UPN) of the user.                                                                                                                                                                                                                                                                                                                  |
| userType             | String                                                             | A string value that can be used to classify user types in your directory, such as "Member" and "Guest". Supports $filter.                                                                                                                                                                                                                                   |

## Response
If successful, this method returns a `200 OK` response code and updated [educationUser](../resources/educationuser.md) object in the response body.
## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "update_educationuser"
}-->
```http
PATCH https://graph.microsoft.com/v1.0/education/users/{user-id}
Content-type: application/json

{
  "displayName": "Rogelio Cazares",
  "givenName": "Rogelio",
  "middleName": "Fernando",
  "surname": "Cazares",
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var educationUser = new EducationUser
{
	DisplayName = "Rogelio Cazares",
	GivenName = "Rogelio",
	MiddleName = "Fernando",
	Surname = "Cazares"
};

await graphClient.Education.Users["{educationUser-id}"]
	.Request()
	.UpdateAsync(educationUser);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

