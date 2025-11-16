# Handling errors in the Microsoft Graph SDK for iOS
Errors in the Microsoft Graph SDK for iOS behave just like errors returned from the service.

Anytime you make a request against the service there is the potential for an error. You will see that all requests to the service can return an error. The error returned is a native `NSError` object, and inside of the NSErrors user dictionary you can obtain the MSError object.

## Checking the Error
There are a few different types of errors that can occur during a network call. These error types are defined in [MSConstants.h](../MSGraphSDK/MSGraphCoreSDK/Core/MSConstants.h). To retrieve any info about the error, look in the userInfo dictionary with the key defined by `MSErrorKey`.

### Client Errors

To check if an error is a client error, you can call `[error isClientError]` and  `[error clientError]`, like this:

```objc
[[[[[graphClient me] drive] items:@"foo"] request] getWithCompletion:^(MSGraphDriveItem *item, NSError *error){
    if (error && [error isClientError]){
        [self handleClientError:[error clientError]];
    }
}];
```

To check the code of an error, you can call the matches method on an error:

```objc
if ([msError matches:@"accessDenied"]){
    // handle access denied error
}
```

Each error object has a message as well as code. This message is for debugging purpose and is not be meant to be displayed to the user. Common error codes have been defined in [MSErrorCodes.h](../MSGraphSDK/MSGraphCoreSDK/Errors/MSErrorCodes.h).


