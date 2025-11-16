---
title: "Create registeredUser"
description: "Add a registered user for the device."
author: "myra-ramdenbourg"
ms.localizationpriority: medium
ms.prod: "directory-management"
doc_type: apiPageType
---

# Create registeredUser

Namespace: microsoft.graph

Add a registered user for the device.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Directory.AccessAsUser.All |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Not supported. |

## HTTP request

You can address the device using either its **id** or **deviceId**.
<!-- { "blockType": "ignored" } -->
```http
POST /devices/{id}/registeredUsers/$ref
POST /devices(deviceId='{deviceId}')/registeredUsers/$ref
```
## Request headers
| Name       | Description|
|:---------------|:--------|
| Authorization  | Bearer {token}. Required. |

## Request body
In the request body, supply a JSON representation of [directoryObject](../resources/directoryobject.md) object.

## Response

If successful, this method returns a `204 No Content` response code.

## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_directoryobject_from_device_2"
}-->
```http
POST https://graph.microsoft.com/v1.0/devices/{id}/registeredUsers/$ref
Content-type: application/json

{
  "@odata.id": "https://graph.microsoft.com/v1.0/directoryObjects/{id}"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var directoryObject = new DirectoryObject
{
	Id = "{id}"
};

await graphClient.Devices["{device-id}"].RegisteredUsers.References
	.Request()
	.AddAsync(directoryObject);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

