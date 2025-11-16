//
//  NSDate+MSSerializationTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/6/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h>
#import "NSDate+MSSerialization.h"


@interface NSDate_MSSerializationTests : XCTestCase

@end

@implementation NSDate_MSSerializationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testMs_toString{
    NSDate *date = [NSDate date];
    NSString *msToString = [date ms_toString];
    XCTAssertNotNil(msToString);

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"];
    NSDate *expectedDate =[formatter dateFromString:msToString];
    XCTAssertEqualObjects([date description], [expectedDate description]);
}

-(void)testMs_dateFromString{

    NSDate *date = [NSDate ms_dateFromString:@"2016-06-07T08:09:53.000+0000"];
    XCTAssertEqualObjects([date description], @"2016-06-07 08:09:53 +0000");
    
    date = [NSDate ms_dateFromString:@"2016-06-07T08:09:53+0000"];
    XCTAssertEqualObjects([date description], @"2016-06-07 08:09:53 +0000");
}
-(void)testMs_dateFromStringFromEastEight{

    NSDate *date = [NSDate ms_dateFromString:@"2016-06-07T08:09:53.000+0800"];
    XCTAssertEqualObjects([date description], @"2016-06-07 00:09:53 +0000");
    
    date = [NSDate ms_dateFromString:@"2016-06-07T08:09:53+0800"];
    XCTAssertEqualObjects([date description], @"2016-06-07 00:09:53 +0000");
}

-(void)testMs_dateFromStringNil{
    
    NSDate *date = [NSDate ms_dateFromString:nil];
    XCTAssertNil(date);
}
@end
