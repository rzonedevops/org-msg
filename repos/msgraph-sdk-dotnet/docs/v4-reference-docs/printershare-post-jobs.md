---
title: Create printJob for a printerShare
description: Create a new printJob for a printerShare. 
author: nilakhan
ms.localizationpriority: medium
ms.prod: cloud-printing
doc_type: apiPageType
---

# Create printJob for a printerShare
Namespace: microsoft.graph

Create a new [printJob](../resources/printJob.md) for a [printerShare](../resources/printerShare.md). 

Also creates a new [printDocument](../resources/printDocument.md) associated with the printJob.

> **Note:** A user can submit up to ~10000 print jobs in 10 days.

## Permissions
One of the following permissions is required to call this API. To learn more, including how to choose permissions, see [Permissions](/graph/permissions-reference).

In addition to the following permissions, the user or app's tenant must have an active Universal Print subscription and have a permission that grants [Get printerShare](printerShare-get.md) access.

|Permission type | Permissions (from least to most privileged) |
|:---------------|:--------------------------------------------|
|Delegated (work or school account)| PrintJob.ReadWriteBasic, PrintJob.ReadWrite, PrintJob.ReadWriteBasic.All, PrintJob.ReadWrite.All |
|Delegated (personal Microsoft account)|Not Supported.|
|Application| Not Supported. |

## HTTP request

<!-- {
  "blockType": "ignored"
}
-->
``` http
POST /print/shares/{printerShareId}/jobs
```

## Request headers
|Name|Description|
|:---|:---|
|Authorization|Bearer {token}. Required.|
|Content-Type|application/json. Required.|

## Request body
In the request body, supply a JSON representation of a [printJob](../resources/printjob.md) object. The printJob object should only contain **configuration** property. All properties of **configuration** are nullable. All other fields, including job and document IDs, are set automatically during resource creation and should not be provided in request.

Right now, Universal Print supports only one **printDocument** per **printJob** object.

## Response

If successful, this method returns a `201 Created` response code and a [printJob](../resources/printjob.md) object and associated [printDocument](../resources/printDocument.md) in the response body. 

## Examples

### Request

# [HTTP](#tab/http)
<!-- {
  "blockType": "request",
  "name": "create_printjob_from__2"
}
-->
``` http
POST https://graph.microsoft.com/v1.0/print/shares/{printerShareId}/jobs
Content-Type: application/json

{
  "configuration": {
    "feedOrientation": "longEdgeFirst",
    "pageRanges": [
      {
        "start": 1,
        "end": 1
      }
    ],
    "quality": "medium",
    "dpi": 600,
    "orientation": "landscape",
    "copies": 1,
    "duplexMode": "oneSided",
    "colorMode": "blackAndWhite",
    "inputBin": "by-pass-tray",
    "outputBin": "output-tray",
    "mediaSize": "A4",
    "margin": {
      "top": 0,
      "bottom": 0,
      "left": 0,
      "right": 0
    },
    "mediaType": "stationery",
    "finishings": null,
    "pagesPerSheet": 1,
    "multipageLayout": "clockwiseFromBottomLeft",
    "collate": false,
    "scaling": "shrinkToFit",
    "fitPdfToPage": false
  }
}
```

# [C#](#tab/csharp)

```csharp

GraphServiceClient graphClient = new GraphServiceClient( authProvider );

var printJob = new PrintJob
{
	Configuration = new PrintJobConfiguration
	{
		FeedOrientation = PrinterFeedOrientation.LongEdgeFirst,
		PageRanges = new List<IntegerRange>()
		{
			new IntegerRange
			{
				Start = 1,
				End = 1
			}
		},
		Quality = PrintQuality.Medium,
		Dpi = 600,
		Orientation = PrintOrientation.Landscape,
		Copies = 1,
		DuplexMode = PrintDuplexMode.OneSided,
		ColorMode = PrintColorMode.BlackAndWhite,
		InputBin = "by-pass-tray",
		OutputBin = "output-tray",
		MediaSize = "A4",
		Margin = new PrintMargin
		{
			Top = 0,
			Bottom = 0,
			Left = 0,
			Right = 0
		},
		MediaType = "stationery",
		Finishings = null,
		PagesPerSheet = 1,
		MultipageLayout = PrintMultipageLayout.ClockwiseFromBottomLeft,
		Collate = false,
		Scaling = PrintScaling.ShrinkToFit,
		FitPdfToPage = false
	}
};

await graphClient.Print.Shares["{printerShare-id}"].Jobs
	.Request()
	.AddAsync(printJob);

```


 For details about how to [add the SDK](/graph/sdks/sdk-installation) to your project and [create an authProvider](/graph/sdks/choose-authentication-providers) instance, see the [SDK documentation](/graph/sdks/sdks-overview).

### Response
**Note:** The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.printJob"
}
-->
``` http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#print/printJobs/$entity",
  "id": "1825",
  "createdDateTime": "2020-10-14T05:16:49-07:00",
  "isFetchable": false,
  "redirectedFrom": null,
  "redirectedTo": null,
  "createdBy": {
    "id": "{userId}",
    "displayName": "{username}",
    "ipAddress": null,
    "userPrincipalName": "{userupn}"
  },
  "status": {
    "state": "paused",
    "description": "The job is not a candidate for processing yet.",
    "isAcquiredByPrinter": false,
    "details": [
      "uploadPending"
    ]
  },
  "configuration": {
    "quality": "medium",
    "dpi": 600,
    "feedOrientation": "longEdgeFirst",
    "orientation": "landscape",
    "duplexMode": "oneSided",
    "copies": 1,
    "colorMode": "blackAndWhite",
    "inputBin": "by-pass-tray",
    "outputBin": "output-tray",
    "mediaSize": "A4",
    "mediaType": "stationery",
    "finishings": null,
    "pagesPerSheet": 1,
    "multipageLayout": "clockwiseFromBottomLeft",
    "collate": false,
    "scaling": "shrinkToFit",
    "fitPdfToPage": false,
    "pageRanges": [
      {
        "start": 1,
        "end": 1
      }
    ],
    "margin": {
      "top": 0,
      "bottom": 0,
      "left": 0,
      "right": 0
    }
  },
  "documents": [
    {
      "id": "1477576d-5dab-4ea9-865c-c0b82cd70bd5",
      "displayName": "",
      "contentType": "",
      "size": 0
    }
  ]
}
```

