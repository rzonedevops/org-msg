---
title: "event: delta"
description: "Get a set of events that have been added, deleted, or updated in a **calendarView** (a range of events) "
ms.localizationpriority: high
author: "iamgirishck"
ms.prod: "outlook"
doc_type: apiPageType
---

# event: delta

Namespace: microsoft.graph

Get a set of [event](../resources/event.md) resources that have been added, deleted, or updated in a **calendarView** (a range of events defined by start and end dates) of the user's primary calendar.

Typically, synchronizing events in a **calendarView** in a local store entails a round of multiple **delta** function calls. The initial call is a full synchronization, and every subsequent **delta** call in the same round gets the incremental changes (additions, deletions, or updates). This allows you to maintain and synchronize a local store of events in the specified **calendarView**, without having to fetch all the events of that calendar from the server every time.

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
GET /me/calendarView/delta?startDateTime={start_datetime}&endDateTime={end_datetime}
GET /users/{id}/calendarView/delta?startDateTime={start_datetime}&endDateTime={end_datetime}

```

## Query parameters

Tracking changes in events incurs a round of one or more **delta** function calls. If you use any query parameter 
(other than `$deltatoken` and `$skiptoken`), you must specify 
it in the initial **delta** request. Microsoft Graph automatically encodes any specified parameters 
into the token portion of the `@odata.nextLink` or `@odata.deltaLink` URL provided in the response. You only need to specify any desired query parameters once upfront. 
In subsequent requests, simply copy and apply the `@odata.nextLink` or `@odata.deltaLink` URL from the previous response, as that URL already 
includes the encoded, desired parameters.


| Query parameter	   | Type	|Description|
|:---------------|:--------|:----------|
|startDateTime|String|The start date and time of the time range, represented in ISO 8601 format. For example, "2015-11-08T19:00:00.0000000".|
|endDateTime|String|The end date and time of the time range, represented in ISO 8601 format. For example, "2015-11-08T20:00:00.0000000".|
| $deltatoken | string | A [state token](/graph/delta-query-overview) returned in the `@odata.deltaLink` URL of the previous **delta** function call for the same calendar view, indicating the completion of that round of change tracking. Save and apply the entire `@odata.deltaLink` URL including this token in the first request of the next round of change tracking for that calendar view.|
| $skiptoken | string | A [state token](/graph/delta-query-overview) returned in the `@odata.nextLink` URL of the previous **delta** function call, indicating there are further changes to be tracked in the same calendar view. |

### OData query parameters
- Expect a **delta** function call on a **calendarView** to return the same properties you'd normally get from a `GET /calendarview` request. You cannot use `$select` to get only a subset of those properties.

- There are other OData query parameters that the **delta** function for **calendarView** doesn't support: `$expand`, `$filter`,`$orderby`, and `$search`. 


## Request headers
| Name       | Type | Description |
|:---------------|:----------|:----------|
| Authorization  | string  | Bearer {token}. Required. |
| Content-Type  | string  | application/json. Required. |
| Prefer | string  | odata.maxpagesize={x}. Optional. |
| Prefer | string | {Time zone}. Optional, UTC assumed if absent.|

## Response

If successful, this method returns a `200 OK` response code and [event](../resources/event.md) collection object in the response body.

Within a round of **delta** function calls bound by the date range of a **calendarView**, you may find a **delta** call returning two types of events under `@removed` with the reason `deleted`: 
- Events that are within the date range and that have been deleted since the previous **delta** call.
- Events that are _outside_ the date range and that have been added, deleted, or updated since the the previous **delta** call.

Filter the events under `@removed` for the date range that your scenario requires.

## Example
##### Request

The following example shows how to make a single **delta** function call, and limit the maximum number of events 
in the response body to 2.

To track changes in a calendar view, you would make one or more **delta** function calls, with 
appropriate [state tokens](/graph/delta-query-overview), to get the set of incremental changes since the last delta query. 


# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "event_delta"
}-->
```msgraph-interactive
GET https://graph.microsoft.com/v1.0/me/calendarView/delta?startdatetime={start_datetime}&enddatetime={end_datetime}

Prefer: odata.maxpagesize=2
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var queryOptions = new List<QueryOption>()
{
	new QueryOption("startdatetime", "{start_datetime}"),
	new QueryOption("enddatetime", "{end_datetime}")
};

var delta = await graphClient.Me.CalendarView
	.Delta()
	.Request( queryOptions )
	.GetAsync();

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

