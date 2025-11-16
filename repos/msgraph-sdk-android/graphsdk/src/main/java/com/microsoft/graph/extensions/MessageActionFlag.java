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
 * The Enum Message Action Flag.
*/
public enum MessageActionFlag
{
    /**
    * any
    */
    any,
    /**
    * call
    */
    call,
    /**
    * do Not Forward
    */
    doNotForward,
    /**
    * follow Up
    */
    followUp,
    /**
    * fyi
    */
    fyi,
    /**
    * forward
    */
    forward,
    /**
    * no Response Necessary
    */
    noResponseNecessary,
    /**
    * read
    */
    read,
    /**
    * reply
    */
    reply,
    /**
    * reply To All
    */
    replyToAll,
    /**
    * review
    */
    review,
    /**
    * For MessageActionFlag values that were not expected from the service
    */
    unexpectedValue
}
