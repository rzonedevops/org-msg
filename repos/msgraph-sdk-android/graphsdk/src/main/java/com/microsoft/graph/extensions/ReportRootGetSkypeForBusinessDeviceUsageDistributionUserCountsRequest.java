// ------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
// ------------------------------------------------------------------------------

package com.microsoft.graph.extensions;

import com.microsoft.graph.concurrency.*;
import com.microsoft.graph.core.*;
import com.microsoft.graph.extensions.*;
import com.microsoft.graph.http.*;
import com.microsoft.graph.generated.*;
import com.microsoft.graph.options.*;
import com.microsoft.graph.serializer.*;

import java.util.Arrays;
import java.util.EnumSet;

// This file is available for extending, afterwards please submit a pull request.

/**
 * The class for the Report Root Get Skype For Business Device Usage Distribution User Counts Request.
 */
public class ReportRootGetSkypeForBusinessDeviceUsageDistributionUserCountsRequest extends BaseReportRootGetSkypeForBusinessDeviceUsageDistributionUserCountsRequest implements IReportRootGetSkypeForBusinessDeviceUsageDistributionUserCountsRequest {

    /**
     * The request for this ReportRootGetSkypeForBusinessDeviceUsageDistributionUserCounts
     *
     * @param requestUrl The request url
     * @param client The service client
     * @param requestOptions The options for this request
     */
    public ReportRootGetSkypeForBusinessDeviceUsageDistributionUserCountsRequest(final String requestUrl, final IBaseClient client, final java.util.List<Option> requestOptions) {
        super(requestUrl, client, requestOptions);
    }
}
