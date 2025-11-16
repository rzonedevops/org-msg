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

/**
 * The Enum Location Type.
*/
public enum LocationType
{
    /**
    * default
    */
    DEFAULT,
    /**
    * conference Room
    */
    conferenceRoom,
    /**
    * home Address
    */
    homeAddress,
    /**
    * business Address
    */
    businessAddress,
    /**
    * geo Coordinates
    */
    geoCoordinates,
    /**
    * street Address
    */
    streetAddress,
    /**
    * hotel
    */
    hotel,
    /**
    * restaurant
    */
    restaurant,
    /**
    * local Business
    */
    localBusiness,
    /**
    * postal Address
    */
    postalAddress,
    /**
    * For LocationType values that were not expected from the service
    */
    unexpectedValue
}
