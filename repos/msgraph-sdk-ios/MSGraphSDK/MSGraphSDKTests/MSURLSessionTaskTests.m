//
//  MSURLSessionTaskTests.m
//  MSGraphSDK
//
//  Created by canviz on 5/29/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSURLSessionTaskTests : MSGraphTestCase
@end

@implementation MSURLSessionTaskTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}
- (void)testInitFailsWithNilClient{
    XCTAssertThrows([[MSURLSessionTask alloc] initWithRequest:[NSMutableURLRequest requestWithURL:self.testBaseURL] client:nil]);
}
- (void)testInitFailsWithNilRequest{
    XCTAssertThrows([[MSURLSessionTask alloc] initWithRequest:nil client:self.mockClient]);
}

- (void)testInitMSURLSessionTaskState{
    MSURLSessionTask *msURLSessionTask= [[MSURLSessionTask alloc] initWithRequest:self.requestForMock client:self.mockClient];
    XCTAssertEqual(msURLSessionTask.state, MSURLSessionTaskStateTaskCreated);
    XCTAssertEqual(msURLSessionTask.client, self.mockClient);
}

- (void)testMSURLSessionTaskAuthFailed{
    NSError *authError = [NSError errorWithDomain:@"autherror" code:123 userInfo:@{}];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:authError];
    
    MSURLSessionTask *msURLSessionTask= [[MSURLSessionTask alloc] initWithRequest:self.requestForMock client:self.mockClient];
    XCTAssertThrows([msURLSessionTask execute]);
    XCTAssertEqual(msURLSessionTask.state, MSURLSessionTaskStateTaskAuthFailed);
}
- (void)testMSURLSessionTaskWithSuccessAuth{
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    
    MSURLSessionTask *msURLSessionTask= [[MSURLSessionTask alloc] initWithRequest:self.requestForMock client:self.mockClient];
    XCTAssertThrows([msURLSessionTask execute]);
    XCTAssertEqual(msURLSessionTask.state, MSURLSessionTaskStateTaskExecuting);
}
- (void)testCancelMSURLSessionTask{
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    
    id mockNSURLSessionTask = OCMClassMock([NSURLSessionTask class]);
    MSURLSessionTask *msURLSessionTask= [[MSURLSessionTask alloc] initWithRequest:self.requestForMock client:self.mockClient];
    id mockMSSessionTask = OCMPartialMock(msURLSessionTask);
    OCMStub([mockMSSessionTask taskWithRequest:[OCMArg any]]).andReturn(mockNSURLSessionTask);
    
    [mockMSSessionTask execute];
    OCMVerify([mockNSURLSessionTask resume]);
    XCTAssertEqual(msURLSessionTask.state, MSURLSessionTaskStateTaskExecuting);
    
    [msURLSessionTask cancel];
    OCMVerify([mockNSURLSessionTask cancel]);
    XCTAssertEqual(msURLSessionTask.state, MSURLSessionTaskStateTaskCanceled);
    [mockMSSessionTask stopMocking];
}
@end
