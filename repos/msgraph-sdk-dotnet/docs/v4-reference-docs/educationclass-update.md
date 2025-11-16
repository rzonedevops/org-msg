---
title: "Update educationClass"
description: "Update the properties of a class."
author: "mlafleur"
ms.localizationpriority: medium
ms.prod: "education"
doc_type: apiPageType
---

# Update educationClass

Namespace: microsoft.graph

Update the properties of an [educationClass](../resources/educationclass.md) object.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) |  Not supported.  |
|Delegated (personal Microsoft account) | Not supported.   |
|Application | EduRoster.ReadWrite.All | 

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
PATCH /education/classes/{id}
```
## Request headers
| Header       | Value |
|:---------------|:--------|
| Authorization  | Bearer {token}. Required.  |
| Content-Type  | application/json  |

## Request body
In the request body, supply the values for relevant fields that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values. For best performance, don't include existing values that haven't changed.

| Property             | Type                                               | Description                                                        |
| :------------------- | :------------------------------------------------- | :----------------------------------------------------------------- |
| displayName          | String                                             | Name of the class.                                                 |
| mailNickname         | String                                             | Mail name for sending email to all members, if this is enabled.    |
| description          | String                                             | Description of the class.                                          |
| createdBy            | [identitySet](../resources/identityset.md)         | Entity who created the class                                       |
| classCode            | String                                             | Class code used by the school to identify the class.               |
| externalId           | String                                             | ID of the class from the syncing system.                           |
| externalSource       | educationExternalSource                            | How this class was created. Possible values are: `sis`, `manual`   |
| externalSourceDetail | String                                             | The name of the external source this resources was generated from. |
| grade                | String                                             | Grade level of the class.                                          |
| term                 | [educationTerm](../resources/educationterm.md)     | Term for this class.                                               |

## Response
If successful, this method returns a `200 OK` response code and an updated [educationClass](../resources/educationclass.md) object in the response body.
## Example
##### Request
The following is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "update_educationclass"
}-->
```http
PATCH https://graph.microsoft.com/v1.0/education/classes/{class-id}
Content-type: application/json

{
  "description": "History - World History 1",
  "displayName": "World History Level 1",
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var educationClass = new EducationClass
{
	Description = "History - World History 1",
	DisplayName = "World History Level 1"
};

await graphClient.Education.Classes["{educationClass-id}"]
	.Request()
	.UpdateAsync(educationClass);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

