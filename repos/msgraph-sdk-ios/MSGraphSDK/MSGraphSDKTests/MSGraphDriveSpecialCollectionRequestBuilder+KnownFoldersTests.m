//
//  MSGraphDriveSpecialCollectionRequestBuilder+KnownFoldersTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/7/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"
@interface MSGraphDriveSpecialCollectionRequestBuilder_KnownFoldersTests : MSGraphTestCase

@end

@implementation MSGraphDriveSpecialCollectionRequestBuilder_KnownFoldersTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testApproot {
    MSGraphDriveSpecialCollectionRequestBuilder *collectionRequestBuilder = [[MSGraphDriveSpecialCollectionRequestBuilder alloc] initWithURL:[NSURL URLWithString:@"https://test/collection"] client:self.mockClient];
    MSGraphDriveItemRequestBuilder *approtRequestBuilder = [collectionRequestBuilder approot];
    
    XCTAssertNotNil(approtRequestBuilder);
    XCTAssertEqualObjects([approtRequestBuilder.request.requestURL absoluteString], @"https://test/collection/approot");
}

@end
