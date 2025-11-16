//
//  MSNameConflictTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/3/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"

@interface MSNameConflictTests : XCTestCase
@property NSMutableString *basicString;
@end

@implementation MSNameConflictTests

- (void)setUp {
    [super setUp];
    self.basicString = [[NSMutableString alloc] initWithString:@"?foo=bar"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testFailMSNameConflict{
    MSNameConflict *msNameConflict = [MSNameConflict fail];
    XCTAssertNotNil(msNameConflict);
    XCTAssertEqualObjects(msNameConflict.key, @"@name.conflictBehavior");
    XCTAssertEqualObjects(msNameConflict.value, @"fail");
    NSMutableString *queryString = [_basicString mutableCopy];
    [msNameConflict appendOptionToQueryString:queryString];
    NSString *expectedString = [NSString stringWithFormat:@"%@&%@=%@",_basicString,msNameConflict.key, msNameConflict.value];
    XCTAssertEqualObjects(queryString, expectedString);
}
-(void)testReplaceMSNameConflict{
    MSNameConflict *msNameConflict = [MSNameConflict replace];
    XCTAssertNotNil(msNameConflict);
    XCTAssertEqualObjects(msNameConflict.key, @"@name.conflictBehavior");
    XCTAssertEqualObjects(msNameConflict.value, @"replace");
    NSMutableString *queryString = [_basicString mutableCopy];
    [msNameConflict appendOptionToQueryString:queryString];
    NSString * expectedString = [NSString stringWithFormat:@"%@&%@=%@",_basicString, msNameConflict.key, msNameConflict.value];
    XCTAssertEqualObjects(queryString, expectedString);
}
-(void)testRenameMSNameConflict{
    MSNameConflict *msNameConflict = [MSNameConflict rename];
    XCTAssertNotNil(msNameConflict);
    XCTAssertEqualObjects(msNameConflict.key, @"@name.conflictBehavior");
    XCTAssertEqualObjects(msNameConflict.value, @"rename");
    NSMutableString *queryString = [_basicString mutableCopy];
    [msNameConflict appendOptionToQueryString:queryString];
    NSString * expectedString = [NSString stringWithFormat:@"%@&%@=%@",_basicString, msNameConflict.key, msNameConflict.value];
    XCTAssertEqualObjects(queryString, expectedString);
}
@end
