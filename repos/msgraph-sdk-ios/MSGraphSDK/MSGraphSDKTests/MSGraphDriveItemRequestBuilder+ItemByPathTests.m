//
//  MSGraphDriveItemRequestBuilder+ItemByPathTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/6/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphDriveItemRequestBuilder_ItemByPathTests : MSGraphTestCase

@end

@implementation MSGraphDriveItemRequestBuilder_ItemByPathTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItemByPath {
    MSGraphDriveItemRequestBuilder * builder = [[[MSGraphDriveItemRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient] itemByPath:@"notebooks"];
    NSString *expectedUrlString = [NSString stringWithFormat:@"%@:/notebooks:/",self.testBaseURL];
    XCTAssertEqualObjects([builder.requestURL absoluteString], expectedUrlString);
}

@end
