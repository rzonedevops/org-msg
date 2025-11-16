
//
//  MSGraphUserWithReferenceRequestBuilderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"
@interface MSGraphUserWithReferenceRequestBuilderTests : MSGraphTestCase

@end
//EntityWithReferenceRequestBuilder test
@implementation MSGraphUserWithReferenceRequestBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testMSGraphUserWithReferenceRequestBuilderInit{
    MSGraphUserWithReferenceRequestBuilder *requestBuilder = [[MSGraphUserWithReferenceRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(requestBuilder);
    XCTAssertEqualObjects(requestBuilder.requestURL, self.testBaseURL);
    XCTAssertEqualObjects(requestBuilder.client, self.mockClient);
}
-(void)testMSGraphUserWithReferenceRequestBuilderReference{
    MSGraphUserWithReferenceRequestBuilder *userWithReferenceRequestBuilder = [[MSGraphUserWithReferenceRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    MSGraphUserReferenceRequestBuilder *userReferenceRequestBuilder = [userWithReferenceRequestBuilder reference];
    XCTAssertNotNil(userReferenceRequestBuilder);
    XCTAssertEqualObjects(userReferenceRequestBuilder.client, self.mockClient);
    NSURL *expectedURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@/$ref",[self.testBaseURL absoluteString]]];
    XCTAssertEqualObjects(userReferenceRequestBuilder.requestURL, expectedURL);
}
@end
