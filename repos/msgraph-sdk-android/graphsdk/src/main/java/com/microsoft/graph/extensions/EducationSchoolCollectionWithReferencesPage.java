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
 * The class for the Education School Collection With References Page.
 */
public class EducationSchoolCollectionWithReferencesPage extends BaseEducationSchoolCollectionWithReferencesPage implements IEducationSchoolCollectionWithReferencesPage {

    /**
     * A collection page for EducationUser.
     *
     * @param response The serialized BaseEducationSchoolCollectionResponse from the service
     * @param builder The request builder for the next collection page
     */
    public EducationSchoolCollectionWithReferencesPage(final BaseEducationSchoolCollectionResponse response, final IEducationSchoolCollectionWithReferencesRequestBuilder builder) {
        super(response, builder);
    }
}
