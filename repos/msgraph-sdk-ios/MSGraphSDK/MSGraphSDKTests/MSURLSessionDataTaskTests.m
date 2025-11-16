//
//  MSURLSessionDataTask.m
//  MSGraphSDK
//
//  Created by canviz on 5/30/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"


@interface MSURLSessionDataTaskTests : MSGraphTestCase
@end

@implementation MSURLSessionDataTaskTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}
- (void)testMSURLSessionDataTaskInit{
    XCTAssertThrows([[MSURLSessionDataTask alloc] initWithRequest:nil client:self.mockClient completion:^(NSDictionary *dictionary, NSError *error) {
    }]);
    XCTAssertThrows([[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:nil completion:^(NSDictionary *dictionary, NSError *error) {
    }]);
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion: nil];
    XCTAssertNotNil(dataTask);
}
- (void)testDataTaskAuthFailedWithoutCompletion{
    NSError *authError = [NSError errorWithDomain:@"authError" code:123 userInfo:@{}];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:nil error:authError];
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion:nil];
    XCTAssertNoThrow([dataTask execute]);
}
- (void)testMSURLSessionDataTaskFailedAuth {
    NSError *authError = [NSError errorWithDomain:@"autherror" code:123 userInfo:@{}];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:nil error:authError];
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion:^(NSDictionary *request, NSError *error){
        [self completionBlockCodeInvoked];
        XCTAssertEqual(authError, error);
    }];
    XCTAssertEqual(dataTask.state, MSURLSessionTaskStateTaskCreated);
    [dataTask execute];
    XCTAssertEqual(dataTask.state, MSURLSessionTaskStateTaskAuthFailed);
    [self checkCompletionBlockCodeInvoked];
}
- (void)testMSURLSessionDataTaskDidStart{
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    id mockNSTask = OCMClassMock([NSURLSessionDataTask class]);
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion:nil];
    
    MSURLSessionDataTask *mockMSDataTask = OCMPartialMock(dataTask);
    OCMStub([mockMSDataTask taskWithRequest:[OCMArg any]])
    .andReturn(mockNSTask);
    
    
    OCMStub([mockNSTask resume])
    .andDo(^(NSInvocation *invocation){
    });
    
    [mockMSDataTask execute];
    XCTAssertEqual(mockMSDataTask.state, MSURLSessionTaskStateTaskExecuting);
    OCMVerify([mockNSTask resume]);
    OCMVerify([mockMSDataTask taskWithRequest:[OCMArg any]]);
    [mockNSTask stopMocking];
}
- (void)testMSURLSessionDataTaskWithConnectionError{
    NSError *connectionError = [NSError errorWithDomain:@"connectionError" code:123 userInfo:@{}];
    self.requestForMock.HTTPMethod = @"PUT";
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:nil error:connectionError];
    
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion:^(NSDictionary *response, NSError *error){
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertEqual(error, connectionError);
    }];
    
    [dataTask execute];
    XCTAssertNotNil(self.requestForMock.allHTTPHeaderFields[@"Content-Type"]);
    OCMVerify([self.mockHttpProvider dataTaskWithRequest:self.requestForMock completionHandler:[OCMArg any]]);
    [self checkCompletionBlockCodeInvoked];
}
- (void)testMSURLSessionDataTaskWithNoCompletionHandler{
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:nil error:nil];
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion:nil];
    
    XCTAssertNoThrow([dataTask execute]);
    OCMVerify([self.mockHttpProvider dataTaskWithRequest:self.requestForMock completionHandler:[OCMArg any]]);
}
- (void)testMSURLSessionDataTaskCompletionHandlerWithValidResponse{
    NSDictionary *responseBody = @{@"foo" : @"bar" };
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:responseBody options:0 error:nil];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:200 HTTPVersion:@"foo" headerFields:nil];
    
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:responseData response:response error:nil];
    
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion:^(NSDictionary *responseDict, NSError *error){
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertEqual([responseDict count], 1);
        XCTAssertTrue([[responseDict objectForKey:@"foo"] isEqualToString:@"bar"]);
    }];
    
    [dataTask execute];
    XCTAssertEqual(dataTask.state, MSURLSessionTaskStateTaskCompleted);
    [self checkCompletionBlockCodeInvoked];
}
- (void)testMSURLSessionDataTaskCompletionHandlerWith401Response{
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:401 HTTPVersion:@"foo" headerFields:nil];
    
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:response error:nil];
    
    MSURLSessionDataTask *dataTask = [[MSURLSessionDataTask alloc] initWithRequest:self.requestForMock client:self.mockClient completion:^(NSDictionary *responseDict, NSError *error){
        [self completionBlockCodeInvoked];
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 401);
        XCTAssertNil(responseDict);
    }];
    
    [dataTask execute];
    XCTAssertEqual(dataTask.state, MSURLSessionTaskStateTaskCompleted);
    [self checkCompletionBlockCodeInvoked];
}
@end
