//
//  MSURLSessionManagerTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/15/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
#import "MSNSURLSessionTaskDelegate.h"
#import "OCMock.h"


@interface MSURLSessionManager()
@property (strong, nonatomic) NSURLSessionConfiguration *urlSessionConfiguration;
@property (strong, nonatomic) NSURLSession *urlSession;
@property (strong, nonatomic) NSMutableDictionary *taskDelegates;
@end

@interface MSURLSessionTaskDelegate()
@property (strong, nonatomic) NSProgress *progress;
@property (strong, nonatomic) NSMutableData *mutableData;
@property (strong, nonatomic) NSURL *downloadPath;
@property (strong, nonatomic) MSURLSessionTaskCompletion completion;
@end

@interface MSURLSessionManagerTests : XCTestCase
@property (nonatomic,retain) MSURLSessionManager * sessionManager;

@property (nonatomic,retain) id<MSHttpProvider> httpProviderDelegate;

@property (nonatomic,retain) NSURL * requestURL;
@property (nonatomic,retain) NSURLRequest *request;
@property (nonatomic) __block BOOL bComoletionBlockInvoked;
@end

@implementation MSURLSessionManagerTests

- (void)setUp {
    [super setUp];
    
   // self.OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    //self.Badresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSClientErrorCodeBadRequest HTTPVersion:@"foo" headerFields:nil];
    self.requestURL = [NSURL URLWithString:@"https://foo/bar"];
    self.request = [[NSURLRequest alloc] initWithURL:_requestURL];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.sessionManager = [[MSURLSessionManager alloc] initWithSessionConfiguration:config];
    
    self.httpProviderDelegate = _sessionManager;
    self.bComoletionBlockInvoked = NO;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
}

- (void)testMSURLSessionManagerInitWithNilconfig{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    MSURLSessionManager * initSessionManager = [[MSURLSessionManager alloc] initWithSessionConfiguration:nil];
    XCTAssertNotNil(initSessionManager);
    XCTAssertEqualObjects(initSessionManager.urlSession.configuration, config);
    XCTAssertEqualObjects(initSessionManager.urlSession.delegate, initSessionManager);
}
- (void)testMSURLSessionManagerInit{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    MSURLSessionManager * initSessionManager = [[MSURLSessionManager alloc] initWithSessionConfiguration:config];
    XCTAssertNotNil(initSessionManager);
    XCTAssertNotNil(initSessionManager.urlSessionConfiguration);
    XCTAssertEqualObjects(initSessionManager.urlSessionConfiguration, config);
    
    XCTAssertNotNil(initSessionManager.urlSessionConfiguration);
    XCTAssertEqualObjects(initSessionManager.urlSession.configuration, config);
    XCTAssertEqualObjects(initSessionManager.urlSession.delegate, initSessionManager);
}

//MSHttpProviderDelegate => dataTaskWithRequest success
-(void)testMSURLSessionManagerInitAndMSHttpProviderDelegateDataTaskWithRequestWithOk{
    
    NSDictionary *returnDic = @{@"testkey":@"testvalue"};
    NSData *returnData = [NSJSONSerialization dataWithJSONObject:returnDic options:0 error:nil];
    
    MSDataCompletionHandler msdataCompletion =^(NSData *data, NSURLResponse *response, NSError *error) {
        _bComoletionBlockInvoked = YES;
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, MSExpectedResponseCodesOK);
        XCTAssertNotNil(data);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        XCTAssertNotNil(dict);
        XCTAssertTrue([dict isEqualToDictionary:returnDic]);
    };
    id<NSURLSessionDataDelegate> nsURLSessionDataDelegate = _sessionManager;
    
    NSURLSessionDataTask *datatask = [_httpProviderDelegate dataTaskWithRequest:_request completionHandler:msdataCompletion];
    XCTAssertNotNil(datatask);
    MSURLSessionTaskDelegate * msUrlsessionTaskDelegate = [_sessionManager.taskDelegates objectForKey:@(datatask.taskIdentifier)];
    XCTAssertNotNil(msUrlsessionTaskDelegate);
    XCTAssertEqualObjects(msUrlsessionTaskDelegate.completion, msdataCompletion);
    
    [nsURLSessionDataDelegate URLSession:_sessionManager.urlSession dataTask:datatask didReceiveData:returnData];
    
    [self mockMSURLSessionTaskDelegateDidCompleteWithError:msUrlsessionTaskDelegate task:datatask statusCode:MSExpectedResponseCodesOK bpath:NO];
    [nsURLSessionDataDelegate URLSession:_sessionManager.urlSession task:datatask didCompleteWithError:nil];
    XCTAssertTrue(_bComoletionBlockInvoked,@"MSDataCompletionHandler was not invoked");
}
//MSHttpProviderDelegate => dataTaskWithRequest errorResponse
-(void)testMSHttpProviderDelegateDataTaskWithRequestWith403Response{
    MSDataCompletionHandler msdataCompletion =^(NSData *data, NSURLResponse *response, NSError *error) {
        _bComoletionBlockInvoked = YES;
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, MSClientErrorCodeForbidden);
        XCTAssertNil(data);
    };
    
    NSURLSessionDataTask *datatask = [_httpProviderDelegate dataTaskWithRequest:_request completionHandler:msdataCompletion];
    MSURLSessionTaskDelegate * msUrlsessionTaskDelegate = [_sessionManager.taskDelegates objectForKey:@(datatask.taskIdentifier)];
    
    [self mockMSURLSessionTaskDelegateDidCompleteWithError:msUrlsessionTaskDelegate task:datatask statusCode:MSClientErrorCodeForbidden bpath:NO];
    id<NSURLSessionDataDelegate> nsURLSessionDataDelegate = _sessionManager;
    [nsURLSessionDataDelegate URLSession:_sessionManager.urlSession task:datatask didCompleteWithError:nil];
    XCTAssertTrue(_bComoletionBlockInvoked);
}
//MSHttpProviderDelegate => downloadTaskWithRequest success
-(void)testMSHttpProviderDelegateDownloadTaskWithRequestWithOk{
    NSURL *returnLocation = [NSURL URLWithString:@"file://test/foo"];
    MSRawDownloadCompletionHandler downloadCompletion = ^(NSURL *location, NSURLResponse *response, NSError *error){
        _bComoletionBlockInvoked = YES;
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, MSExpectedResponseCodesOK);
        XCTAssertEqualObjects(location, returnLocation);
    };
    
    NSURLSessionDownloadTask *downloadtask = [_httpProviderDelegate downloadTaskWithRequest:_request progress:nil completionHandler:downloadCompletion];
    XCTAssertNotNil(downloadtask);
    MSURLSessionTaskDelegate * msUrlsessionTaskDelegate = [_sessionManager.taskDelegates objectForKey:@(downloadtask.taskIdentifier)];
    XCTAssertNotNil(msUrlsessionTaskDelegate);
    XCTAssertEqualObjects(msUrlsessionTaskDelegate.completion, downloadCompletion);
    
    [self mockMSURLSessionTaskDelegateDidCompleteWithError:msUrlsessionTaskDelegate task:downloadtask statusCode:MSExpectedResponseCodesOK bpath:YES];
    id<NSURLSessionDownloadDelegate> nsURLSessionDownloadDelegate = _sessionManager;
    [nsURLSessionDownloadDelegate URLSession:_sessionManager.urlSession downloadTask:downloadtask didFinishDownloadingToURL:returnLocation];
    
    XCTAssertTrue(_bComoletionBlockInvoked,@"MSRawDownloadCompletionHandler was not invoked");
}
//MSHttpProviderDelegate => downloadTaskWithRequest 401error
-(void)testMSHttpProviderDelegateDownloadTaskWithRequestWith401Response{
    MSRawDownloadCompletionHandler downloadCompletion = ^(NSURL *location, NSURLResponse *response, NSError *error){
        _bComoletionBlockInvoked = YES;
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, MSClientErrorCodeUnauthorized);
        XCTAssertNil(location);
    };
    
    NSURLSessionDownloadTask *downloadtask = [_httpProviderDelegate downloadTaskWithRequest:_request progress:nil completionHandler:downloadCompletion];
    MSURLSessionTaskDelegate * msUrlsessionTaskDelegate = [_sessionManager.taskDelegates objectForKey:@(downloadtask.taskIdentifier)];
    
    [self mockMSURLSessionTaskDelegateDidCompleteWithError:msUrlsessionTaskDelegate task:downloadtask statusCode:MSClientErrorCodeUnauthorized bpath:NO];
    id<NSURLSessionTaskDelegate> nsURLSessionTaskDelegate = _sessionManager;
    [nsURLSessionTaskDelegate URLSession:_sessionManager.urlSession task:downloadtask didCompleteWithError:nil];
    XCTAssertTrue(_bComoletionBlockInvoked);
}

//MSHttpProviderDelegate => UploadTaskWithRequestFrom data success
-(void)testMSHttpProviderDelegateUploadTaskFromDataWithRequest{
    MSRawUploadCompletionHandler uploadCompletion = ^(NSData *data, NSURLResponse *response, NSError *error) {
        _bComoletionBlockInvoked = YES;
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, MSExpectedResponseCodesOK);
        XCTAssertNil(data);
    };
    
    NSDictionary *uploadDic = @{@"testkey":@"testvalue"};
    NSData *uploadData = [NSJSONSerialization dataWithJSONObject:uploadDic options:0 error:nil];
    
   NSURLSessionUploadTask * uploadtask = [_httpProviderDelegate uploadTaskWithRequest:_request fromData:uploadData progress:nil completionHandler:uploadCompletion];
    XCTAssertNotNil(uploadtask);
    MSURLSessionTaskDelegate * msUrlsessionTaskDelegate = [_sessionManager.taskDelegates objectForKey:@(uploadtask.taskIdentifier)];
    XCTAssertNotNil(msUrlsessionTaskDelegate);
    XCTAssertEqualObjects(msUrlsessionTaskDelegate.completion, uploadCompletion);
    
    [self mockMSURLSessionTaskDelegateDidCompleteWithError:msUrlsessionTaskDelegate task:uploadtask statusCode:MSExpectedResponseCodesOK bpath:NO];
    id<NSURLSessionTaskDelegate> nsURLSessionTaskDelegate = _sessionManager;
    [nsURLSessionTaskDelegate URLSession:_sessionManager.urlSession task:uploadtask didCompleteWithError:nil];
    XCTAssertTrue(_bComoletionBlockInvoked,@"MSRawUploadCompletionHandler was not invoked");
}
//MSHttpProviderDelegate => UploadTaskWithRequestFrom file success
-(void)testMSHttpProviderDelegateUploadTaskFromFileWithRequest{
    MSRawUploadCompletionHandler uploadCompletion = ^(NSData *data, NSURLResponse *response, NSError *error) {
        _bComoletionBlockInvoked = YES;
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, MSExpectedResponseCodesOK);
        XCTAssertNil(data);
    };

    NSURL *uploadFileURL = [NSURL URLWithString:@"file://test/foo"];
    NSURLSessionUploadTask * uploadtask = [_httpProviderDelegate uploadTaskWithRequest:_request fromFile:uploadFileURL progress:nil completionHandler:uploadCompletion];
    XCTAssertNotNil(uploadtask);
    MSURLSessionTaskDelegate * msUrlsessionTaskDelegate = [_sessionManager.taskDelegates objectForKey:@(uploadtask.taskIdentifier)];
    XCTAssertNotNil(msUrlsessionTaskDelegate);
    XCTAssertEqualObjects(msUrlsessionTaskDelegate.completion, uploadCompletion);
    
    [self mockMSURLSessionTaskDelegateDidCompleteWithError:msUrlsessionTaskDelegate task:uploadtask statusCode:MSExpectedResponseCodesOK bpath:NO];
    id<NSURLSessionTaskDelegate> nsURLSessionTaskDelegate = _sessionManager;
    [nsURLSessionTaskDelegate URLSession:_sessionManager.urlSession task:uploadtask didCompleteWithError:nil];
    XCTAssertTrue(_bComoletionBlockInvoked);
}

//MSHttpProviderDelegate => UploadTaskWithRequestFromData 404
-(void)testMSHttpProviderDelegateUploadTaskWithRequestWith404Response{
    MSRawUploadCompletionHandler uploadCompletion = ^(NSData *data, NSURLResponse *response, NSError *error) {
        _bComoletionBlockInvoked = YES;
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse *)response).statusCode, MSClientErrorCodeNotFound);
        XCTAssertNil(data);
    };
    
    NSData *uploadData = [NSJSONSerialization dataWithJSONObject:@{@"testkey":@"testvalue"} options:0 error:nil];
    
    NSURLSessionUploadTask * uploadtask = [_httpProviderDelegate uploadTaskWithRequest:_request fromData:uploadData progress:nil completionHandler:uploadCompletion];
    MSURLSessionTaskDelegate * msUrlsessionTaskDelegate = [_sessionManager.taskDelegates objectForKey:@(uploadtask.taskIdentifier)];
    
    [self mockMSURLSessionTaskDelegateDidCompleteWithError:msUrlsessionTaskDelegate task:uploadtask statusCode:MSClientErrorCodeNotFound bpath:NO];
    id<NSURLSessionTaskDelegate> nsURLSessionTaskDelegate = _sessionManager;
    [nsURLSessionTaskDelegate URLSession:_sessionManager.urlSession task:uploadtask didCompleteWithError:nil];
    XCTAssertTrue(_bComoletionBlockInvoked);
}

-(void)mockMSURLSessionTaskDelegateDidCompleteWithError:(MSURLSessionTaskDelegate *)msUrlsessionTaskDelegate task:(NSURLSessionTask *)task statusCode:(NSInteger)statusCode bpath:(BOOL)bpath{
    MSURLSessionTaskDelegate *mockMSURLSessionTaskDelegate = OCMPartialMock(msUrlsessionTaskDelegate);
    OCMStub([mockMSURLSessionTaskDelegate task:task didCompleteWithError:[OCMArg any]])
    .andDo(^(NSInvocation *invocation){
        NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:_requestURL statusCode:statusCode HTTPVersion:@"foo" headerFields:nil];
        if(bpath){
            mockMSURLSessionTaskDelegate.completion(mockMSURLSessionTaskDelegate.downloadPath, response, nil);
        }
        else{
            mockMSURLSessionTaskDelegate.completion(mockMSURLSessionTaskDelegate.mutableData, response, nil);
        }
        
    }
    );
}
@end
