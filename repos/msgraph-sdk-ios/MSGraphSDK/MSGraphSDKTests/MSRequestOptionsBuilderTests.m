//
//  MSRequestOptionsBuilderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/3/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
#import "MSFunctionParameters.h"
@interface MSRequestOptionsBuilderTests : XCTestCase

@end

@implementation MSRequestOptionsBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testMSRequestOptionsBuilder{

    MSHeaderOptions *msTokenHeader = [[MSHeaderOptions alloc] initWithKey:@"token" value:@"xxxzz"];
    MSHeaderOptions *msConentTypeHeader = [[MSHeaderOptions alloc] initWithKey:@"contenttype" value:@"text"];
    
    MSSelectOptions *msSelectOptions = [MSSelectOptions select:@"DisplayName"];
    MSTopOptions *msTopOptions = [MSTopOptions top:10];
    
    MSFunctionParameters *msFunctionParameters1 = [[MSFunctionParameters alloc] initWithKey:@"searchName" value:@"foo"];
    MSFunctionParameters *msFunctionParameters2 = [[MSFunctionParameters alloc] initWithKey:@"type" value:@"bar"];

    NSArray *optionArray = @[msTokenHeader, msSelectOptions, msFunctionParameters1, msConentTypeHeader, msTopOptions, msFunctionParameters2];
    MSRequestOptionsBuilder *msRequestOptionsBuilder = [MSRequestOptionsBuilder optionsWithArray:optionArray];
    XCTAssertNotNil(msRequestOptionsBuilder);
    
    XCTAssertEqualObjects([msRequestOptionsBuilder queryOptions], @"?$select=DisplayName&$top=10");
    NSDictionary *headerDic = [msRequestOptionsBuilder headers];
    XCTAssertEqual([headerDic count], 2);
    XCTAssertEqualObjects(headerDic[msTokenHeader.key], msTokenHeader.value);
    XCTAssertEqualObjects(headerDic[msConentTypeHeader.key], msConentTypeHeader.value);
    XCTAssertEqualObjects([msRequestOptionsBuilder functionParams], @"(searchName='foo',type='bar')");
    
}

@end
