---
title: "Create device"
description: "Create and register a new device in the organization."
author: "myra-ramdenbourg"
ms.localizationpriority: medium
ms.prod: "directory-management"
doc_type: apiPageType
---

# Create device

Namespace: microsoft.graph

Create and register a new device in the organization.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).


|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | Directory.AccessAsUser.All |
|Delegated (personal Microsoft account) | Not supported.    |
|Application | Not supported. |

The calling user must also be in one of the following [Azure AD roles](/azure/active-directory/roles/permissions-reference): *Global Administrator*, *Intune Administrator*, or *Windows 365 Administrator*.

## HTTP request
<!-- { "blockType": "ignored" } -->
```http
POST /devices

```
## Request headers
| Name       | Description|
|:---------------|:--------|
| Authorization  | Bearer {token}. Required. |
| Content-type | application/json |

## Request body
In the request body, supply a JSON representation of [device](../resources/device.md) object.

## Response

If successful, this method returns `201 Created` response code and [device](../resources/device.md) object in the response body.

## Example
##### Request
Here is an example of the request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_device_from_devices"
}-->
```http
POST https://graph.microsoft.com/v1.0/devices
Content-type: application/json

{
  "accountEnabled":false,
  "alternativeSecurityIds":
  [
    {
      "type":2,
      "key":"base64Y3YxN2E1MWFlYw=="
    }
  ],
  "deviceId":"4c299165-6e8f-4b45-a5ba-c5d250a707ff",
  "displayName":"Test device",
  "operatingSystem":"linux",
  "operatingSystemVersion":"1"
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var device = new Device
{
	AccountEnabled = false,
	AlternativeSecurityIds = new List<AlternativeSecurityId>()
	{
		new AlternativeSecurityId
		{
			Type = 2,
			Key = Convert.FromBase64String("base64Y3YxN2E1MWFlYw==")
		}
	},
	DeviceId = "4c299165-6e8f-4b45-a5ba-c5d250a707ff",
	DisplayName = "Test device",
	OperatingSystem = "linux",
	OperatingSystemVersion = "1"
};

await graphClient.Devices
	.Request()
	.AddAsync(device);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

