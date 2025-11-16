//
//  MSGraphSDKVersionTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDKVersion.h"
@interface MSGraphSDKVersionTests : XCTestCase

@end

@implementation MSGraphSDKVersionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphSdkVersion {
    XCTAssertNotNil(MSGraphSdkVersion);
    XCTAssertEqualObjects(MSGraphSdkVersion, @"0.10.1");
}


@end
