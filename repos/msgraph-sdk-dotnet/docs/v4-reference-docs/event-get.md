---
title: "Get event"
description: "Get the properties and relationships of the specified event object."
author: "iamgirishck"
ms.localizationpriority: high
ms.prod: "outlook"
doc_type: apiPageType
---

# Get event

Namespace: microsoft.graph

Get the properties and relationships of the specified [event](../resources/event.md) object.

Currently, this operation returns event bodies in only HTML format.

There are two scenarios where an app can get an event in another user's calendar:

* If the app has application permissions, or,
* If the app has the appropriate delegated [permissions](#permissions) from one user, and another user has shared a calendar with that user, or, has given delegated access to that user. See [details and an example](/graph/outlook-get-shared-events-calendars).

Since the **event** resource supports [extensions](/graph/extensibility-overview), you can also use the `GET` operation to get custom properties and extension data in an **event** instance.


### Support various time zones

For all GET operations that return events, you can use the `Prefer: outlook.timezone` header to specify the time zone for the event start and end times in the response. 

For example, the following `Prefer: outlook.timezone` header sets the start and end times in the response to Eastern Standard Time.
```http
Prefer: outlook.timezone="Eastern Standard Time"
```

If the event was created in a different time zone, the start and end times will be adjusted to the time zone specified in that `Prefer` header. 
See this [list](../resources/datetimetimezone.md) for the supported time zone names. If the `Prefer: outlook.timezone` header is not specified, the start and end 
times are returned in UTC.

You can use the **OriginalStartTimeZone** and **OriginalEndTimeZone** properties on the **event** resource to 
find out the time zone used when the event was created.


## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Calendars.Read    |
|Delegated (personal Microsoft account) | Calendars.Read    |
|Application | Calendars.Read |

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
GET /me/events/{id}
GET /users/{id | userPrincipalName}/events/{id}
GET /groups/{id}/events/{id}

GET /me/calendar/events/{id}
GET /users/{id | userPrincipalName}/calendar/events/{id}
GET /groups/{id}/calendar/events/{id}

GET /me/calendars/{id}/events/{id}
GET /users/{id | userPrincipalName}/calendars/{id}/events/{id}

GET /me/calendargroups/{id}/calendars/{id}/events/{id}
GET /users/{id | userPrincipalName}/calendargroups/{id}/calendars/{id}/events/{id}
```
## Optional query parameters
This method supports the [OData Query Parameters](/graph/query-parameters) to help customize the response.
## Request headers
| Name       | Type | Description |
|:---------------|:--------|:--------|
| Authorization  | string | Bearer {token}. Required.  |
| Prefer: outlook.timezone  | string | Use this to specify the time zone for start and end times in the response. If not specified, those time values are returned in UTC. Optional. |
| Prefer: outlook.body-content-type | string | The format of the **body** property to be returned in. Values can be "text" or "html". A `Preference-Applied` header is returned as confirmation if this `Prefer` header is specified. If the header is not specified, the **body** property is returned in HTML format. Optional. |

## Request body
Do not supply a request body for this method.

## Response

If successful, this method returns a `200 OK` response code and [event](../resources/event.md) object in the response body.
## Example
##### Request 1
The first example gets the specified event. It specifies the following:

- A `Prefer: outlook.timezone` header to get date time values returned in Pacific Standard Time. 
- A `$select` query parameter to return specific properties. Without a `$select` parameter, all of the event properties will be returned.


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "sampleKeys": ["AAMkAGVmMDEzMTM4LTZmYWUtNDdkNC1hMDZiLTU1OGY5OTZhYmY4OABGAAAAAAAiQ8W967B7TKBjgx9rVEURBwAiIsqMbYjsT5e-T7KzowPTAAAAAAENAAAiIsqMbYjsT5e-T7KzowPTAAAa_WKzAAA="],
  "name": "get_event"
}-->

```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/events/AAMkAGVmMDEzMTM4LTZmYWUtNDdkNC1hMDZiLTU1OGY5OTZhYmY4OABGAAAAAAAiQ8W967B7TKBjgx9rVEURBwAiIsqMbYjsT5e-T7KzowPTAAAAAAENAAAiIsqMbYjsT5e-T7KzowPTAAAa_WKzAAA=?$select=subject,body,bodyPreview,organizer,attendees,start,end,location,hideAttendees 
Prefer: outlook.timezone="Pacific Standard Time"
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var @event = await graphClient.Me.Events["{event-id}"]
	.Request()
	.Header("Prefer","outlook.timezone=\"Pacific Standard Time\"")
	.Select("subject,body,bodyPreview,organizer,attendees,start,end,location,hideAttendees")
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "sampleKeys": ["AAMkAGVmMDEzMTM4LTZmYWUtNDdkNC1hMDZiLTU1OGY5OTZhYmY4OABGAAAAAAAiQ8W967B7TKBjgx9rVEURBwAiIsqMbYjsT5e-T7KzowPTAAAAAAENAAAiIsqMbYjsT5e-T7KzowPTAAAa_WKzAAA="],
  "name": "get_event_multiple_locations"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/events/AAMkAGVmMDEzMTM4LTZmYWUtNDdkNC1hMDZiLTU1OGY5OTZhYmY4OABGAAAAAAAiQ8W967B7TKBjgx9rVEURBwAiIsqMbYjsT5e-T7KzowPTAAAAAAENAAAiIsqMbYjsT5e-T7KzowPTAAAa_WKzAAA=?$select=subject,body,bodyPreview,organizer,attendees,start,end,location,locations
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var @event = await graphClient.Me.Events["{event-id}"]
	.Request()
	.Select("subject,body,bodyPreview,organizer,attendees,start,end,location,locations")
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

