//
//  MSRequestBuilderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/2/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"
@interface MSRequestBuilderTests : MSGraphTestCase

@end

@implementation MSRequestBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testInit{
    MSRequestBuilder *builder = [[MSRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(builder);
    XCTAssertEqualObjects(builder.requestURL, self.testBaseURL);
    XCTAssertEqualObjects(builder.client, self.mockClient);
}
-(void)testInitNil{
    XCTAssertThrows([[MSRequestBuilder alloc] initWithURL:nil client:self.mockClient]);
    XCTAssertThrows([[MSRequestBuilder alloc] initWithURL:self.testBaseURL client:nil]);
}
@end
