//
//  MSGraphProfilePhotoStreamRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphProfilePhotoStreamRequestTests : MSGraphTestCase
@property (nonatomic)  NSURL *profilePhotoStreamURL;
@property (nonatomic)  NSHTTPURLResponse *OKresponse;
@property (nonatomic)  NSHTTPURLResponse *response403;
@property (nonatomic)  NSURL *fileUrl;
@property (nonatomic)  MSGraphProfilePhotoStreamRequest *streamRequest;
@end

//MSGraphProfilePhotoStreamRequest
@implementation MSGraphProfilePhotoStreamRequestTests

- (void)setUp {
    [super setUp];
    self.profilePhotoStreamURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/photo/$value",self.graphUrl]];
    self.requestForMock = [[NSMutableURLRequest alloc] initWithURL:_profilePhotoStreamURL];
    self.OKresponse = [[NSHTTPURLResponse alloc] initWithURL:_profilePhotoStreamURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    self.response403= [[NSHTTPURLResponse alloc] initWithURL:_profilePhotoStreamURL statusCode:MSClientErrorCodeForbidden HTTPVersion:@"foo" headerFields:nil];
    self.fileUrl = [NSURL URLWithString:@"file://foo/download"];
    
    self.streamRequest = [[MSGraphProfilePhotoStreamRequest alloc] initWithURL:_profilePhotoStreamURL client:self.mockClient];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testInitAndDownloadWithCompletionOK{
    
    XCTAssertThrows([[MSGraphProfilePhotoStreamRequest alloc] initWithURL:nil client:self.mockClient]);
    XCTAssertThrows([[MSGraphProfilePhotoStreamRequest alloc] initWithURL:_profilePhotoStreamURL client:nil]);
    
    XCTAssertNotNil(_streamRequest);
    XCTAssertEqualObjects(_streamRequest.requestURL, _profilePhotoStreamURL);
    XCTAssertEqualObjects(_streamRequest.client, self.mockClient);
    
    [self downloadTaskCompletionWithRequest:self.requestForMock progress:nil url:_fileUrl response:_OKresponse error:nil];
    MSURLSessionDownloadTask *task = [_streamRequest downloadWithCompletion:^(NSURL *location, NSURLResponse *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqualObjects(location, _fileUrl);
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse*)response).statusCode, MSExpectedResponseCodesOK);
    }];
    [self checkRequest:task Method:@"GET" URL:_profilePhotoStreamURL];
    [self checkCompletionBlockCodeInvoked];
}
-(void)testDownloadWithCompletionWith403Response{
   
    [self downloadTaskCompletionWithRequest:self.requestForMock progress:nil url:_fileUrl response:_response403 error:nil];
    [_streamRequest downloadWithCompletion:^(NSURL *location, NSURLResponse *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(location);
        XCTAssertNotNil(response);
        XCTAssertEqual(((NSHTTPURLResponse*)response).statusCode, MSClientErrorCodeForbidden);
    }];
    [self checkCompletionBlockCodeInvoked];
}
-(void)testDownloadWithCompletionWithError{
    NSError* testError = [NSError errorWithDomain:@"testError" code:123 userInfo:@{}];
    [self downloadTaskCompletionWithRequest:self.requestForMock progress:nil url:_fileUrl response:nil error:testError];
    MSURLSessionDownloadTask *task = [_streamRequest downloadWithCompletion:^(NSURL *location, NSURLResponse *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqualObjects(location,_fileUrl);
        XCTAssertNil(response);
        XCTAssertEqual(error.code, 123);
    }];
    [self checkRequest:task Method:@"GET" URL:_profilePhotoStreamURL];
    [self checkCompletionBlockCodeInvoked];
}

-(void)testUploadFromDataOK{
    NSDictionary *demoDict = @{@"id": @"200X400", @"height": @400, @"width": @200};
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:demoDict options:0 error:nil];
    [self uploadTaskFromDataCompletionWithRequest:self.requestForMock progress:nil responseData:responseData response:_OKresponse error:nil];
    
    MSURLSessionUploadTask *task = [_streamRequest uploadFromData:responseData completion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqualObjects(response.entityId, demoDict[@"id"]);
        XCTAssertEqual(response.height, 400);
        XCTAssertEqual(response.width, 200);
        
    }];
    [self checkRequest:task Method:@"PUT" URL:_profilePhotoStreamURL];
    [self checkCompletionBlockCodeInvoked];
}
-(void)testUploadFromDataWith403Response{
    [self uploadTaskFromDataCompletionWithRequest:self.requestForMock progress:nil responseData:nil response:_response403 error:nil];
    
    [_streamRequest uploadFromData:[NSJSONSerialization dataWithJSONObject:@{@"test":@"value"} options:0 error:nil] completion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeForbidden);
    }];
    [self checkCompletionBlockCodeInvoked];
}
-(void)testUploadFromDataWithError{
    NSError* testError = [NSError errorWithDomain:@"testError" code:123 userInfo:@{}];
    [self uploadTaskFromDataCompletionWithRequest:self.requestForMock progress:nil responseData:nil response:nil error:testError];
    
    MSURLSessionUploadTask *task = [_streamRequest uploadFromData:[NSJSONSerialization dataWithJSONObject:@{@"test":@"value"} options:0 error:nil] completion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 123);
        XCTAssertEqual(error.domain, @"testError");
    }];
    [self checkRequest:task Method:@"PUT" URL:_profilePhotoStreamURL];
    [self checkCompletionBlockCodeInvoked];
}

-(void)testUploadFromFileOK{
    NSDictionary *demoDict = @{@"id": @"200X400", @"height": @400, @"width": @200};
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:demoDict options:0 error:nil];
    [self uploadTaskFromFileURLCompletionWithRequest:self.requestForMock progress:nil fileURL:_fileUrl responseData:responseData response:_OKresponse error:nil];
    
    MSURLSessionUploadTask *task = [_streamRequest uploadFromFile:_fileUrl completion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqualObjects(response.entityId, demoDict[@"id"]);
        XCTAssertEqual(response.height, 400);
        XCTAssertEqual(response.width, 200);
    }];
    [self checkRequest:task Method:@"PUT" URL:_profilePhotoStreamURL];
    [self checkCompletionBlockCodeInvoked];
}
-(void)testUploadFromFileError{
    NSError* testError = [NSError errorWithDomain:@"testError" code:123 userInfo:@{}];
    [self uploadTaskFromFileURLCompletionWithRequest:self.requestForMock progress:nil fileURL:_fileUrl responseData:nil response:_OKresponse error:testError];
    
    MSURLSessionUploadTask *task = [_streamRequest uploadFromFile:_fileUrl completion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 123);
        XCTAssertEqual(error.domain, @"testError");
    }];
    [self checkRequest:task Method:@"PUT" URL:_profilePhotoStreamURL];
    [self checkCompletionBlockCodeInvoked];
}
-(void)testUploadFromFileWith403Response{
    [self uploadTaskFromFileURLCompletionWithRequest:self.requestForMock progress:nil fileURL:_fileUrl responseData:nil response:_response403 error:nil];
    
    [_streamRequest uploadFromFile:_fileUrl completion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeForbidden);
    }];
    [self checkCompletionBlockCodeInvoked];
}
@end
