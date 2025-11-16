//
//  MSURLSessionDownloadTaskTests.m
//  MSGraphSDK
//
//  Created by canviz on 5/31/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"


@interface MSURLSessionDownloadTaskTests : MSGraphTestCase
@property (nonatomic,retain) NSURL *fileLocation;
@end

@implementation MSURLSessionDownloadTaskTests

- (void)setUp {
    [super setUp];
    self.fileLocation = [NSURL URLWithString:@"foo/bar/baz"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testMSURLSessionDownloadTaskInit{
    XCTAssertThrows([[MSURLSessionDownloadTask alloc] initWithRequest:nil client:self.mockClient completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    }]);
    XCTAssertThrows([[MSURLSessionDownloadTask alloc] initWithRequest:self.requestForMock client:nil completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    }]);
    
    MSURLSessionDownloadTask *downloadTask = [[MSURLSessionDownloadTask alloc] initWithRequest:self.requestForMock client:self.mockClient completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    }];
    XCTAssertNotNil(downloadTask);
}
- (void)testMSURLSessionDownloadTaskFailedAuth {
    NSError *authError = [NSError errorWithDomain:@"autherror" code:123 userInfo:@{}];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:nil error:authError];
    
    MSURLSessionDownloadTask *downloadTask = [[MSURLSessionDownloadTask alloc] initWithRequest:self.requestForMock client:self.mockClient completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqual(authError, error);
    }];
    
    XCTAssertEqual(downloadTask.state, MSURLSessionTaskStateTaskCreated);
    [downloadTask execute];
    XCTAssertEqual(downloadTask.state, MSURLSessionTaskStateTaskAuthFailed);
    [self checkCompletionBlockCodeInvoked];
}

- (void)testMSURLSessionDownloadTaskCompletionHandler{
    NSHTTPURLResponse *validResponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:200 HTTPVersion:@"foo" headerFields:@{}];
    
    [self mockURLSession:self.mockHttpProvider downloadTaskCompletionWithRequest:self.requestForMock progress:nil url:_fileLocation response:validResponse error:nil];
    MSURLSessionDownloadTask *downloadTask = [[MSURLSessionDownloadTask alloc] initWithRequest:self.requestForMock client:self.mockClient completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error){
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertEqual(location, _fileLocation);
        XCTAssertEqual(validResponse, response);
    }];

    [downloadTask taskWithRequest:self.requestForMock];
    XCTAssertEqual(downloadTask.state, MSURLSessionTaskStateTaskCompleted);
    [self checkCompletionBlockCodeInvoked];
}
- (void)testMSURLSessionDownloadTaskFailedWithBadResponse{
    NSHTTPURLResponse *badRequest = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:400 HTTPVersion:@"test" headerFields:@{}];
    [self mockURLSession:self.mockHttpProvider downloadTaskCompletionWithRequest:self.requestForMock progress:nil url:_fileLocation response:badRequest error:nil];
    
    MSURLSessionDownloadTask *downloadTask = [[MSURLSessionDownloadTask alloc] initWithRequest:self.requestForMock client:self.mockClient completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error){
        [self completionBlockCodeInvoked];
        XCTAssertNil(location);
        XCTAssertEqual(error.code, 400);
        XCTAssertEqual(response, badRequest);
    }];
    
    [downloadTask taskWithRequest:self.requestForMock];
    XCTAssertEqual(downloadTask.state, MSURLSessionTaskStateTaskCompleted);
    [self checkCompletionBlockCodeInvoked];
}
-(void)testMSURLSessionDownloadTaskReceived304
{
    NSHTTPURLResponse *notModifiedResponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:304 HTTPVersion:@"foo" headerFields:@{}];
    
    [self mockURLSession:self.mockHttpProvider downloadTaskCompletionWithRequest:self.requestForMock progress:nil url:_fileLocation response:notModifiedResponse error:nil];
    MSURLSessionDownloadTask *downloadTask = [[MSURLSessionDownloadTask alloc] initWithRequest:self.requestForMock client:self.mockClient completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error){
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertNil(location);
        XCTAssertEqual(response, notModifiedResponse);
    }];
    [downloadTask taskWithRequest:self.requestForMock];
    XCTAssertEqual(downloadTask.state, MSURLSessionTaskStateTaskCompleted);
    [self checkCompletionBlockCodeInvoked];
}
@end
