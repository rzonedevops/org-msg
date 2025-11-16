//
//  NSArray+MSSerializationTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/6/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import "MSObject.h"
#import "NSArray+MSSerialization.h"
#import "MSDate.h"
@interface NSArray_MSSerializationTests : XCTestCase

@end

@implementation NSArray_MSSerializationTests

- (void)setUp {
    [super setUp];
    
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testArrayFromItemWithMSObject {
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    
    MSObject *unitDict = [[MSObject alloc] initWithDictionary:@{@"foo":@"bar"}];
    MSDate *msDate = [MSDate dateWithYear:2016 month:6 day:7];
    NSArray *unitArray = @[msDate, @"teststring", unitDict];
    
    [testArray addObject:unitDict];
    [testArray addObject:msDate];
    [testArray addObject:unitArray];
    
    NSArray *outArray = [testArray arrayFromItem];
    
    XCTAssertTrue([outArray[0] isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([outArray[0] objectForKey:@"foo"], @"bar");
    
    XCTAssertTrue([outArray[1] isKindOfClass:[NSString class]]);
    XCTAssertEqualObjects(outArray[1], @"2016-06-07");
    
    XCTAssertTrue([outArray[2] isKindOfClass:[NSArray class]]);
    XCTAssertTrue([outArray[2][0] isKindOfClass:[NSString class]]);
    XCTAssertEqualObjects(outArray[2][0], @"2016-06-07");
    
    XCTAssertTrue([outArray[2][1] isKindOfClass:[NSString class]]);
    XCTAssertEqualObjects(outArray[2][1], @"teststring");
    
    XCTAssertTrue([outArray[2][2] isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([outArray[2][2] objectForKey:@"foo"], @"bar");
}

- (void)testArrayFromItemWithNormal{
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    [testArray addObject:@"teststring"];
    [testArray addObject:[NSJSONSerialization dataWithJSONObject:@{@"zx":@"qa"} options:0 error:nil]];
    NSArray *outArray = [testArray arrayFromItem];
    XCTAssertEqualObjects(outArray[0], @"teststring");
    XCTAssertTrue([outArray[1] isKindOfClass:[NSData class]]);
    
}

@end
