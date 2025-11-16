//
//  MSGraphTestCase.m
//  MSGraphSDK
//
//  Created by canviz on 5/28/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import "MSGraphTestCase.h"

@implementation MSGraphTestCase

- (void)setUp {
    [super setUp];
    self.graphUrl = [NSString stringWithFormat:@"%@/%@",MSGraphApiEndpoint,MSGraphApiVersion];
    
    self.testBaseURL = [NSURL URLWithString:@"https://foo.com/bar/baz"];
    self.requestForMock = [[NSMutableURLRequest alloc] initWithURL:self.testBaseURL];
    
    self.mockAuthProvider = OCMProtocolMock(@protocol(MSAuthenticationProvider));
    self.mockHttpProvider = OCMProtocolMock(@protocol(MSHttpProvider));
    self.mockClient = OCMPartialMock([[ODataBaseClient alloc] initWithURL:[self.testBaseURL absoluteString] httpProvider:self.mockHttpProvider authenticationProvider:self.mockAuthProvider]);
    
    self.bCompletionBlockInvoked = NO;
    self.bCastBlockInvoked = NO;

}
- (void) setAuthProvider:(id <MSAuthenticationProvider> )mockAuthProvider
appendHeaderResponseWith:(NSMutableURLRequest *)request
                   error:(NSError *)error
{
    OCMStub([mockAuthProvider appendAuthenticationHeaders:[OCMArg any] completion:[OCMArg any]])
        .andDo(^(NSInvocation *invocation){
            void (^completionHandler)(NSMutableURLRequest *request, NSError *error);
        [invocation getArgument:&completionHandler atIndex:3];
        completionHandler(request, error);
    });
}

//MSURLSessionDataTask mock
-(OCMStubRecorder *) dataTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                                              data:(NSData *)data
                                          response:(NSHTTPURLResponse *)response
                                             error:(NSError *)error
{
    return [self mockURLSession:self.mockHttpProvider dataTaskCompletionWithRequest:mockRequest data:data response:response error:error dataTask:nil];
}

- (OCMStubRecorder *) dataTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                                               data:(NSData *)data
                                           response:(NSHTTPURLResponse *)response
                                              error:(NSError *)error
                                           dataTask:(NSURLSessionDataTask *)task
{
    return [self mockURLSession:self.mockHttpProvider dataTaskCompletionWithRequest:mockRequest data:data response:response error:error dataTask:task];
}

- (OCMStubRecorder *) mockURLSession:( id <MSHttpProvider> )mockSession
       dataTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                                data:(NSData *)data
                            response:(NSHTTPURLResponse *)response
                               error:(NSError *)error
{
    return [self mockURLSession:mockSession dataTaskCompletionWithRequest:mockRequest data:data response:response error:error dataTask:nil];
}

- (OCMStubRecorder *)mockURLSession:(id<MSHttpProvider>)mockSession
      dataTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                               data:(NSData *)data
                           response:(NSHTTPURLResponse *)response
                              error:(NSError *)error
                           dataTask:(NSURLSessionDataTask *)task
{
    OCMStubRecorder *sessionStub = OCMStub([mockSession dataTaskWithRequest:mockRequest completionHandler:[OCMArg any]])
    .andDo(^(NSInvocation *invocation){
        MSDataCompletionHandler completionHandler;
        [invocation getArgument:&completionHandler atIndex:3];
        completionHandler(data, response, error);
    });
    return [self sessionStub:sessionStub returnsTask:task];
}

//MSURLSessionDownloadTask mock
- (OCMStubRecorder *) mockURLSession:(id <MSHttpProvider> )mockSession
   downloadTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                            progress:(NSProgress *)progress
                                 url:(NSURL *)location
                            response:(NSHTTPURLResponse *)response
                               error:(NSError *)error
{
    return [self mockURLSession:mockSession downloadTaskCompletionWithRequest:mockRequest progress:progress url:location response:response error:error downloadTask:nil];
}

- (OCMStubRecorder *)downloadTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                                              progress:(NSProgress *)progress
                                                   url:(NSURL *)location
                                              response:(NSHTTPURLResponse *)response
                                                 error:(NSError *)error
{
    return [self downloadTaskCompletionWithRequest:mockRequest progress:progress url:location response:response error:error downloadTask:nil];
}

- (OCMStubRecorder *)downloadTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                                              progress:(NSProgress *)progress
                                                   url:(NSURL *)location
                                              response:(NSHTTPURLResponse *)response
                                                 error:(NSError *)error
                                          downloadTask:(NSURLSessionDownloadTask *)task
{
    return [self mockURLSession:self.mockHttpProvider downloadTaskCompletionWithRequest:mockRequest progress:progress url:location response:response error:error downloadTask:task];
}


- (OCMStubRecorder *)mockURLSession:(id<MSHttpProvider>)session
  downloadTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                           progress:(NSProgress *)progress
                                url:(NSURL *)location
                           response:(NSHTTPURLResponse *)response
                              error:(NSError *)error
                       downloadTask:(NSURLSessionDownloadTask *)task
{
    OCMStubRecorder *sessionStub = OCMStub([session downloadTaskWithRequest:mockRequest progress:[OCMArg anyObjectRef] completionHandler:[OCMArg any]])
    .andDo(^(NSInvocation *invocation){
        MSRawDownloadCompletionHandler completionHandler;
        NSProgress * __autoreleasing *taskProgress;
        [invocation getArgument:&taskProgress atIndex:3];
        if (progress){
            *taskProgress = progress;
        }
        [invocation getArgument:&completionHandler atIndex:4];
        completionHandler(location, response, error);
    });
    
    return [self sessionStub:sessionStub returnsTask:task];
}

//MSURLSessionUploadTask mock
- (OCMStubRecorder *)uploadTaskFromDataCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                                                    progress:(NSProgress *)progress
                                                responseData:(NSData *)responseData
                                                    response:(NSHTTPURLResponse *)response
                                                       error:(NSError *)error
{
    OCMStubRecorder *sessionStub = OCMStub([self.mockHttpProvider uploadTaskWithRequest:mockRequest fromData:[OCMArg any] progress:[OCMArg anyObjectRef]
                                                                      completionHandler:[OCMArg any]])
    .andDo(
           ^(NSInvocation *invocation){
               void (^reponseCompletionHandler)(NSData *, NSURLResponse *, NSError *);
               [invocation getArgument:&reponseCompletionHandler atIndex:5];
               reponseCompletionHandler(responseData, response, error);
           });
    return [self sessionStub:sessionStub returnsTask:nil];
    
}
- (OCMStubRecorder *)uploadTaskFromFileURLCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                                                       progress:(NSProgress *)progress
                                                        fileURL:(NSURL *)fileURL
                                                   responseData:(NSData *)responseData
                                                       response:(NSHTTPURLResponse *)response
                                                          error:(NSError *)error
{
    OCMStubRecorder *sessionStub = OCMStub([self.mockHttpProvider uploadTaskWithRequest:mockRequest fromFile:[OCMArg any] progress:[OCMArg anyObjectRef] completionHandler:[OCMArg any]])
    .andDo(^(NSInvocation *invocation){
        MSRawUploadCompletionHandler completionHandler;
        [invocation getArgument:&completionHandler atIndex:5];
        completionHandler(responseData, response, error);
    });
    return [self sessionStub:sessionStub returnsTask:nil];
    
}


- (OCMStubRecorder *) mockURLSession:(id <MSHttpProvider> )mockSession
     uploadTaskCompletionWithRequest:(NSMutableURLRequest *)mockRequest
                            progress:(NSProgress *)progress
                                data:(NSData *)data
                            response:(NSHTTPURLResponse *)response
                               error:(NSError *)error
                          uploadTask:(NSURLSessionUploadTask *)task
{
    OCMStubRecorder *sessionStub = OCMStub([mockSession uploadTaskWithRequest:mockRequest fromFile:[OCMArg any] progress:[OCMArg anyObjectRef] completionHandler:[OCMArg any]])
    .andDo(^(NSInvocation *invocation){
        MSRawUploadCompletionHandler completionHandler;
        [invocation getArgument:&completionHandler atIndex:5];
        completionHandler(data, response, error);
    });
    return [self sessionStub:sessionStub returnsTask:task];
}
- (OCMStubRecorder *)sessionStub:(OCMStubRecorder *)sessionStub returnsTask:(NSURLSessionTask *)task
{
    if (task){
        return sessionStub.andReturn(task);
    }
    return sessionStub;
}

-(void)checkRequest:(MSURLSessionTask *)task  Method:(NSString *)method URL:(NSURL *)url{
    XCTAssertEqualObjects(task.request.URL, url);
    XCTAssertEqualObjects(task.request.HTTPMethod, method);
}
-(void)castBlockCodeInvoked{
    _bCastBlockInvoked = YES;
}
-(void)completionBlockCodeInvoked{
    _bCompletionBlockInvoked = YES;
}
-(void)checkCompletionBlockCodeInvoked{
    XCTAssertTrue(_bCompletionBlockInvoked);
}
-(void)checkCastAndCompletionBlockCodeInvoked{
    XCTAssertTrue(_bCastBlockInvoked);
    XCTAssertTrue(_bCompletionBlockInvoked);
}

- (void)tearDown {

    [super tearDown];
}

@end
