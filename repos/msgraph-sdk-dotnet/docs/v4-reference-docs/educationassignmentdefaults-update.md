---
title: "Update educationAssignmentDefaults"
description: "Update the properties of an educationAssignmentDefaults object."
author: "sharad-sharma-msft"
ms.localizationpriority: medium
ms.prod: "education"
doc_type: apiPageType
---

# Update educationAssignmentDefaults
Namespace: microsoft.graph

Update the properties of an [educationAssignmentDefaults](../resources/educationassignmentdefaults.md) object.

Only teachers can update these settings.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type|Permissions (from least to most privileged)|
|:---|:---|
|Delegated (work or school account) |  EduAssignments.ReadWriteBasic, EduAssignments.ReadWrite  |
|Delegated (personal Microsoft account) |  Not supported.  |
|Application | Not supported. |

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->
``` http
PATCH /education/classes/{id}/assignmentDefaults
```

## Request headers
|Name|Description|
|:---|:---|
|Authorization|Bearer {token}. Required.|
|Content-Type|application/json. Required.|

## Request body
In the request body, supply *only* the values for properties that should be updated. Existing properties that are not included in the request body will maintain their previous values or be recalculated based on changes to other property values.

The following table specifies the properties that can be updated.

|Property|Type|Description|
|:---|:---|:---|
|addedStudentAction|educationAddedStudentAction| Class-level default actions for students added after the assignment publication date. Possible values are: `none`, `assignIfOpen`. The default value is `none`.|
|addToCalendarAction|educationAddToCalendarOptions|Optional field to control the **assignment** behavior  for adding **assignments** to students' and teachers' calendars when the **assignment** is published. The possible values are: `none`, `studentsAndPublisher`, `studentsAndTeamOwners`, `unknownFutureValue`, `studentsOnly`. Note that you must use the `Prefer: include-unknown-enum-members` request header to get the following value from this [evolvable enum](/graph/best-practices-concept#handling-future-members-in-evolvable-enumerations): `studentsOnly`. Optional.|
|dueTime|TimeOfDay| Class-level default value for due time field. Default value is `23:59:00`|
|notificationChannelUrl|String| Default Teams channel to send notifications related to the assignment. Default value is `null`.|

## Response

If successful, this method returns a `200 OK` response code and an updated [educationAssignmentDefaults](../resources/educationassignmentdefaults.md) object in the response body.

## Examples

### Request


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "update_educationassignmentdefaults"
}
-->
``` http
PATCH https://graph.microsoft.com/v1.0/education/classes/acdefc6b-2dc6-4e71-b1e9-6d9810ab1793/assignmentDefaults
Content-Type: application/json

{
  "addedStudentAction": "assignIfOpen",
  "notificationChannelUrl": "https://graph.microsoft.com/beta/teams('acdefc6b-2dc6-4e71-b1e9-6d9810ab1793')/channels('3da03fc4-8eac-4459-84fb-1422dc01f65e')"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var educationAssignmentDefaults = new EducationAssignmentDefaults
{
	AddedStudentAction = EducationAddedStudentAction.AssignIfOpen,
	AddToCalendarAction = EducationAddToCalendarOptions.StudentsAndTeamOwners,
	NotificationChannelUrl = "https://graph.microsoft.com/beta/teams('id')/channels('id')"
};

await graphClient.Education.Classes["{educationClass-id}"].AssignmentDefaults
	.Request()
	.UpdateAsync(educationAssignmentDefaults);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
>**Note:** The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.educationAssignmentDefaults"
}
-->
``` http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "addedStudentAction": "assignIfOpen",
  "dueTime": "String",
  "notificationChannelUrl": "https://graph.microsoft.com/beta/teams('acdefc6b-2dc6-4e71-b1e9-6d9810ab1793')/channels('3da03fc4-8eac-4459-84fb-1422dc01f65e')"
}
```

## See also

* [Specify the default channel for education assignment notifications](/graph/education-build-notificationchannelurl)
