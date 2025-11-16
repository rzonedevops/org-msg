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
 * The Enum Mdm App Config Key Type.
*/
public enum MdmAppConfigKeyType
{
    /**
    * string Type
    */
    stringType,
    /**
    * integer Type
    */
    integerType,
    /**
    * real Type
    */
    realType,
    /**
    * boolean Type
    */
    booleanType,
    /**
    * token Type
    */
    tokenType,
    /**
    * For MdmAppConfigKeyType values that were not expected from the service
    */
    unexpectedValue
}
