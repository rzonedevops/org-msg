//
//  MSQueryParametersTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/3/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
@interface MSQueryParametersTests : XCTestCase

@end

@implementation MSQueryParametersTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testMSQueryParameters{
    MSQueryParameters *msQueryParameters = [[MSQueryParameters alloc] initWithKey:@"foo" value:@"bar"];
    XCTAssertNotNil(msQueryParameters);
    
    NSMutableString *queryString =[[NSMutableString alloc] initWithString:@"teskey=testvalue"];
    [msQueryParameters appendOptionToQueryString:queryString];
    XCTAssertEqualObjects(queryString, @"teskey=testvalue&foo=bar");
}
-(void)testMSQueryParametersForSpcialValue{
    MSQueryParameters *msQueryParameters = [[MSQueryParameters alloc] initWithKey:@"foo" value:@"bar|bar1"];
    XCTAssertNotNil(msQueryParameters);
    
    NSMutableString *queryString =[[NSMutableString alloc] initWithString:@"teskey=testvalue"];
    [msQueryParameters appendOptionToQueryString:queryString];
    XCTAssertEqualObjects(queryString, @"teskey=testvalue&foo=bar%7Cbar1");
}
@end
