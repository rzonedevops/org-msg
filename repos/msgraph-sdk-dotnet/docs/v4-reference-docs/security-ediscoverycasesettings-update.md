---
title: "Update ediscoveryCaseSettings"
description: "Update the properties of an ediscoveryCaseSettings object."
author: "SeunginLyu"
ms.localizationpriority: medium
ms.prod: "ediscovery"
doc_type: "apiPageType"
---

# Update ediscoveryCaseSettings
Namespace: microsoft.graph.security



Update the properties of an [ediscoveryCaseSettings](../resources/security-ediscoverycasesettings.md) object.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

|Permission type|Permissions (from least to most privileged)|
|:---|:---|
|Delegated (work or school account)|eDiscovery.ReadWrite.All|
|Delegated (personal Microsoft account)|Not supported.|
|Application|Not supported.|

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->
``` http
PATCH /security/cases/ediscoveryCases/{ediscoveryCaseId}/settings
```

## Request headers
|Name|Description|
|:---|:---|
|Authorization|Bearer {token}. Required.|
|Content-Type|application/json. Required.|

## Request body



|Property|Type|Description|
|:---|:---|:---|
|redundancyDetection|[microsoft.graph.security.redundancyDetectionSettings](../resources/security-redundancydetectionsettings.md)|Redundancy (email threading and near duplicate detection) settings for an eDiscovery case. Optional.|
|topicModeling|[microsoft.graph.security.topicModelingSettings](../resources/security-topicmodelingsettings.md)|Topic modeling (Themes) settings for an eDiscovery case. Optional.|
|ocr|[microsoft.graph.security.ocrSettings](../resources/security-ocrsettings.md)|The OCR (Optical Character Recognition) settings for the eDiscovery case. Optional.|



## Response

If successful, this method returns a `204 No Content` response code.

## Examples

### Request
The following is an example of a request.

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "update_ediscoverycasesettings"
}
-->
``` http
PATCH https://graph.microsoft.com/v1.0/security/cases/ediscoveryCases/{ediscoveryCaseId}/settings
Content-Type: application/json

{
  "@odata.type": "#microsoft.graph.security.ediscoveryCaseSettings",
  "redundancyDetection": {
    "@odata.type": "microsoft.graph.security.redundancyDetectionSettings"
  },
  "topicModeling": {
    "@odata.type": "microsoft.graph.security.topicModelingSettings"
  },
  "ocr": {
    "@odata.type": "microsoft.graph.security.ocrSettings"
  }
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var ediscoveryCaseSettings = new Microsoft.Graph.Security.EdiscoveryCaseSettings
{
	RedundancyDetection = new RedundancyDetectionSettings
	{
	},
	TopicModeling = new TopicModelingSettings
	{
	},
	Ocr = new OcrSettings
	{
	}
};

await graphClient.Security.Cases.EdiscoveryCases["{security.ediscoveryCase-id}"].Settings
	.Request()
	.UpdateAsync(ediscoveryCaseSettings);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
The following is an example of the response.

<!-- {
  "blockType": "response",
  "truncated": true
}
-->
``` http
HTTP/1.1 204 No Content
```
