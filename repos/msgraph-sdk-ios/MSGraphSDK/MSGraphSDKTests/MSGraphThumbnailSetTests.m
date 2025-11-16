//
//  MSGraphThumbnailSetTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/12/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphThumbnail.h"
#import "MSGraphThumbnailSet.h"

@interface MSGraphThumbnailSetTests : XCTestCase

@end

//Entity type test
@implementation MSGraphThumbnailSetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testDeserializeGraphThumbnailSet{
    NSDictionary *returnDic = @{
                                @"id": @"0",
                                @"small": @{ @"height": @64, @"width": @96, @"url": @"https://sn3302files/small"},
                                @"medium": @{ @"height": @117, @"width": @176, @"url": @"https://sn3302files/medium"},
                                @"large": @{ @"height": @533, @"width": @800, @"url": @"https://sn3302files/large"}
                                };
    MSGraphThumbnailSet *msgraphThumbnailSet = [[MSGraphThumbnailSet alloc] initWithDictionary:returnDic];
    XCTAssertEqual(msgraphThumbnailSet.entityId, returnDic[@"id"]);
    
    
    MSGraphThumbnail * expectedSmallThumbnail = [[MSGraphThumbnail alloc] initWithDictionary:returnDic[@"small"]];
    XCTAssertEqual(msgraphThumbnailSet.small.height, expectedSmallThumbnail.height);
    XCTAssertEqual(msgraphThumbnailSet.small.width, expectedSmallThumbnail.width);
    XCTAssertEqualObjects(msgraphThumbnailSet.small.url, expectedSmallThumbnail.url);
    
    MSGraphThumbnail * expectedMediumThumbnail = [[MSGraphThumbnail alloc] initWithDictionary:returnDic[@"medium"]];
    XCTAssertEqual(msgraphThumbnailSet.medium.height, expectedMediumThumbnail.height);
    XCTAssertEqual(msgraphThumbnailSet.medium.width, expectedMediumThumbnail.width);
    XCTAssertEqualObjects(msgraphThumbnailSet.medium.url, expectedMediumThumbnail.url);
    
    MSGraphThumbnail * expectedLargeThumbnail = [[MSGraphThumbnail alloc] initWithDictionary:returnDic[@"large"]];
    XCTAssertEqual(msgraphThumbnailSet.large.height, expectedLargeThumbnail.height);
    XCTAssertEqual(msgraphThumbnailSet.large.width, expectedLargeThumbnail.width);
    XCTAssertEqualObjects(msgraphThumbnailSet.large.url, expectedLargeThumbnail.url);
    
}
-(void)testDeserializeInvalidGraphThumbnailSet{
    NSDictionary *returnDic = @{
                                @"foo": @"bar",
                                @"test": @"text"
                                };
    MSGraphThumbnailSet *msgraphThumbnailSet = [[MSGraphThumbnailSet alloc] initWithDictionary:returnDic];
    XCTAssertNil(msgraphThumbnailSet.entityId);
    XCTAssertNil(msgraphThumbnailSet.small);
    XCTAssertNil(msgraphThumbnailSet.medium);
    XCTAssertNil(msgraphThumbnailSet.large);
}
@end
