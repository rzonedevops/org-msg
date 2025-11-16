//
//  MSCollectionTests.m
//  MSGraphSDK
//
//  Created by canviz on 5/19/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSCollection.h"
@interface MSCollectionTests : XCTestCase
//@property (nonatomic) MSCollection *msCollection;
@end

@implementation MSCollectionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitWithArray {
    NSArray *array = @[@"ArrayItem1",@"ArrayItem2"];
    NSString *link = @"testCollectionString";
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"testDic",@"dictKey1", nil];
    
    MSCollection *msCollection = [[MSCollection alloc] initWithArray:array nextLink:link additionalData:dic];
    XCTAssertNotNil(msCollection);
    XCTAssertEqual(msCollection.value, array);
    XCTAssertTrue([msCollection.nextLink.absoluteString isEqualToString:link]);
    XCTAssertEqual(msCollection.additionalData, dic);
    
}
- (void)testArrayFromItem {
    
    MSObject *object1 = [[MSObject alloc] initWithDictionary:@{@"key1":@"bar1"}];
    MSObject *object2 = [[MSObject alloc] initWithDictionary:@{@"key2":@"bar2"}];
    NSArray *array = @[object1,object2];
    
    MSCollection *msCollection = [[MSCollection alloc] initWithArray:array nextLink:nil additionalData:nil];
    NSArray *retArray = [msCollection arrayFromItem];
    XCTAssertNotNil(retArray);
    XCTAssertEqual([retArray count], 2);
    XCTAssertEqual([[retArray objectAtIndex:0] objectForKey:@"key1"], @"bar1");
}
@end
