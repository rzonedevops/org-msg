//
//  MSRequestOptionsTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/3/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
@interface MSRequestOptionsTests : XCTestCase

@end

@implementation MSRequestOptionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testMSRequestOptionsInit{
    MSRequestOptions *requestOption = [[MSRequestOptions alloc] initWithKey:@"foo" value:@"bar"];
    XCTAssertNotNil(requestOption);
    XCTAssertEqualObjects(requestOption.key, @"foo");
    XCTAssertEqualObjects(requestOption.value, @"bar");
}
-(void)testMSRequestOptionsInitNil{
    MSRequestOptions *requestOption = [[MSRequestOptions alloc] initWithKey:nil value:@"bar"];
    XCTAssertNotNil(requestOption);
    XCTAssertNil(requestOption.key);
    XCTAssertEqualObjects(requestOption.value, @"bar");
    
    requestOption = [[MSRequestOptions alloc] initWithKey:@"foo" value:nil];
    XCTAssertNotNil(requestOption);
    XCTAssertNil(requestOption.value);
    XCTAssertEqualObjects(requestOption.key, @"foo");
}
@end
