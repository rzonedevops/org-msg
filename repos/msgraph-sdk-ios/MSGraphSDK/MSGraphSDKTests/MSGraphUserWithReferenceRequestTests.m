//
//  MSGraphUserWithReferenceRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphUserWithReferenceRequestTests : MSGraphTestCase
@property (nonatomic) NSURL *userWithReferenceURL;
@property (nonatomic) NSDictionary *userDict;
@property (nonatomic) NSData *responseData;
@end
//EntityWithReferenceRequest test
@implementation MSGraphUserWithReferenceRequestTests

- (void)setUp {
    [super setUp];
    self.userWithReferenceURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/manager",self.graphUrl]];
    self.requestForMock = [[NSMutableURLRequest alloc] initWithURL:_userWithReferenceURL];
    self.userDict = @{@"@odata.context": @"https://graph.microsoft.com/v1.0/$metadata#directoryObjects/$entity",@"@odata.type": @"#microsoft.graph.user",
                      @"id": @"a17d6891-cec7-4133-9c0c-ec2dd567da9f",
                      @"businessPhones": @[@"555.111.2001"],
                      @"displayName": @"Katie Jordan",
                      @"jobTitle": @"Dispatcher",
                      @"mail": @"katiej@cand3.onmicrosoft.com",
                      @"officeLocation": @"Contoso HQ",
                      @"preferredLanguage": @"en-US",
                      @"userPrincipalName": @"katiej@cand3.onmicrosoft.com"
                      };
    self.responseData = [NSJSONSerialization dataWithJSONObject:_userDict options:0 error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphUserWithReferenceRequestInit {
    MSGraphUserWithReferenceRequest *request = [[MSGraphUserWithReferenceRequest alloc] initWithURL:_userWithReferenceURL client:self.mockClient];
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.requestURL, _userWithReferenceURL);
    XCTAssertEqualObjects(request.client, self.mockClient);
}
- (void)testGetWithCompletionOK {
    MSGraphUserWithReferenceRequest *request = [[MSGraphUserWithReferenceRequest alloc] initWithURL:_userWithReferenceURL client:self.mockClient];
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:_userWithReferenceURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:self.responseData response:OKresponse error:nil];
    MSURLSessionDataTask *task = [request getWithCompletion:^(MSGraphUser *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        MSGraphUser *expectedUser = [[MSGraphUser alloc] initWithDictionary:_userDict];
        XCTAssertEqualObjects(response.entityId, expectedUser.entityId);
        XCTAssertEqualObjects(response.displayName, expectedUser.displayName);
        XCTAssertEqual(response.businessPhones.count, expectedUser.businessPhones.count);
        XCTAssertEqualObjects(response.businessPhones[0], expectedUser.businessPhones[0]);
        XCTAssertEqualObjects(response.jobTitle, expectedUser.jobTitle);
        XCTAssertEqualObjects(response.mail, expectedUser.mail);
        XCTAssertEqualObjects(response.officeLocation, expectedUser.officeLocation);
        XCTAssertEqualObjects(response.preferredLanguage, expectedUser.preferredLanguage);
        XCTAssertEqualObjects(response.userPrincipalName, expectedUser.userPrincipalName);
    }];
    [self checkRequest:task Method:@"GET" URL:_userWithReferenceURL];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testGetWithCompletion401Response {
    MSGraphUserWithReferenceRequest *request = [[MSGraphUserWithReferenceRequest alloc] initWithURL:_userWithReferenceURL client:self.mockClient];
    NSHTTPURLResponse *Response401 = [[NSHTTPURLResponse alloc] initWithURL:_userWithReferenceURL statusCode:MSClientErrorCodeUnauthorized HTTPVersion:@"foo" headerFields:nil];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:self.responseData response:Response401 error:nil];
    MSURLSessionDataTask *task = [request getWithCompletion:^(MSGraphUser *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeUnauthorized);
        XCTAssertEqualObjects(error.domain, MSErrorDomain);
    }];
    [self checkRequest:task Method:@"GET" URL:_userWithReferenceURL];
    [self completionBlockCodeInvoked];
}
- (void)testGetWithCompletionClientError {
    MSGraphUserWithReferenceRequest *request = [[MSGraphUserWithReferenceRequest alloc] initWithURL:_userWithReferenceURL client:self.mockClient];
    NSError *testError = [NSError errorWithDomain:@"testError" code:123 userInfo:@{}];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:self.responseData response:nil error:testError];
    MSURLSessionDataTask *task = [request getWithCompletion:^(MSGraphUser *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, testError.code);
        XCTAssertEqualObjects(error.domain, testError.domain);
    }];
    [self checkRequest:task Method:@"GET" URL:_userWithReferenceURL];
    [self completionBlockCodeInvoked];
}
@end
