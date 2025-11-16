//
//  MSGraphDriveItemSearchRequestBuilderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/12/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphDriveItemSearchRequestBuilder()
@property (nonatomic, getter=q) NSString * q;
@end

@interface MSGraphDriveItemSearchRequestBuilderTests : MSGraphTestCase
@property (nonatomic, retain) MSGraphClient *client;
@end
//MethodRequestBuilder tests 
@implementation MSGraphDriveItemSearchRequestBuilderTests

- (void)setUp {
    [super setUp];
    [MSGraphClient setAuthenticationProvider:self.mockAuthProvider];
    [MSGraphClient setHttpProvider:self.mockHttpProvider];
    self.client = [MSGraphClient client];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphDriveItemSearchRequestBuilderInit {
    MSGraphDriveItemSearchRequestBuilder *builder = [[[[_client me] drive] root] searchWithQ:@"(name='test')"];
    XCTAssertNotNil(builder);
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/drive/root/microsoft.graph.search",self.graphUrl]];
    XCTAssertEqualObjects(builder.requestURL, expectedURL);
    XCTAssertEqualObjects(builder.q, @"(name='test')");
    
    builder = [[[[_client me] drive] root] searchWithQ:nil];
    XCTAssertEqualObjects(builder.q, nil);
}

@end
