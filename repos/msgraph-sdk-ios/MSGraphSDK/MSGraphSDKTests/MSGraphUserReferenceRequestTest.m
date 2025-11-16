//
//  MSGraphUserReferenceRequestTest.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphUserReferenceRequestTest : MSGraphTestCase
@property (nonatomic) NSURL *userReferenceURL;
@end
//EntityReferenceRequest test
@implementation MSGraphUserReferenceRequestTest

- (void)setUp {
    [super setUp];
    self.userReferenceURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/manager/$ref",self.graphUrl]];
    self.requestForMock = [[NSMutableURLRequest alloc] initWithURL:_userReferenceURL];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphUserReferenceRequestInit {
    MSGraphUserReferenceRequest *request = [[MSGraphUserReferenceRequest alloc] initWithURL:_userReferenceURL client:self.mockClient];
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.requestURL, _userReferenceURL);
    XCTAssertEqualObjects(request.client, self.mockClient);
    
    XCTAssertThrows([[MSGraphUserReferenceRequest alloc] initWithURL:nil client:self.mockClient]);
    XCTAssertThrows([[MSGraphUserReferenceRequest alloc] initWithURL:_userReferenceURL client:nil]);
    XCTAssertThrows([[MSGraphUserReferenceRequest alloc] initWithURL:nil client:nil]);
}
- (void)testMSGraphUserReferenceRequestDeleteWithOK {
    MSGraphUserReferenceRequest *request = [[MSGraphUserReferenceRequest alloc] initWithURL:_userReferenceURL client:self.mockClient];
    
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:_userReferenceURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:OKresponse error:nil];
    MSURLSessionDataTask *task = [request deleteWithCompletion:^(NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
    }];
    [self checkRequest:task Method:@"DELETE" URL:_userReferenceURL];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testMSGraphUserReferenceRequestDeleteWith403 {
    MSGraphUserReferenceRequest *request = [[MSGraphUserReferenceRequest alloc] initWithURL:_userReferenceURL client:self.mockClient];
    
    NSHTTPURLResponse *Response403 = [[NSHTTPURLResponse alloc] initWithURL:_userReferenceURL statusCode:MSClientErrorCodeForbidden HTTPVersion:@"foo" headerFields:nil];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:Response403 error:nil];
    MSURLSessionDataTask *task = [request deleteWithCompletion:^(NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeForbidden);
    }];
    [self checkRequest:task Method:@"DELETE" URL:_userReferenceURL];
    [self checkCompletionBlockCodeInvoked];
}
@end
