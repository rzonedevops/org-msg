//
//  MSExpandOptionsTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/3/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
#import "MSFunctionParameters.h"

@interface MSOptionsTests : XCTestCase
@property NSMutableString *basicString;
@property NSString *firstKey;
@property NSString *firstValue;
@end

@implementation MSOptionsTests

- (void)setUp {
    [super setUp];
    self.firstKey = @"foo", self.firstValue = @"bar";
    self.basicString = [[NSMutableString alloc] initWithFormat:@"?%@=%@",_firstKey,_firstValue];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testMSExpandOptions{
    MSExpandOptions *msExpandOptions = [MSExpandOptions expand:@"thumb"];
    XCTAssertNotNil(msExpandOptions);
    XCTAssertEqualObjects(msExpandOptions.key, @"$expand");
    XCTAssertEqualObjects(msExpandOptions.value, @"thumb");

    NSMutableString *queryString = [_basicString mutableCopy];
    [msExpandOptions appendOptionToQueryString:queryString];
    NSString *expectedString = [NSString stringWithFormat:@"%@&$expand=thumb",_basicString];
    XCTAssertEqualObjects(queryString, expectedString);
}

-(void)testMSFunctionParameters{
    MSFunctionParameters *msFunctionParameters = [[MSFunctionParameters alloc] initWithKey:_firstKey value:_firstValue];
    XCTAssertNotNil(msFunctionParameters);
    XCTAssertEqualObjects(msFunctionParameters.key, _firstKey);
    XCTAssertEqualObjects(msFunctionParameters.value, _firstValue);
    
    NSMutableString *queryString = [_basicString mutableCopy];
    [msFunctionParameters appendOptionToFunctionParams:queryString];
    NSString *expectedString = [NSString stringWithFormat:@"%@,foo='bar'",_basicString];
    XCTAssertEqualObjects(queryString, expectedString);
}
-(void)testMSFunctionParametersWithNilValue{
    MSFunctionParameters *msFunctionParameters = [[MSFunctionParameters alloc] initWithKey:_firstKey value:nil];
    XCTAssertNotNil(msFunctionParameters);
    XCTAssertEqualObjects(msFunctionParameters.key, _firstKey);
    XCTAssertEqualObjects(msFunctionParameters.value, nil);
    
    NSMutableString *queryString = [_basicString mutableCopy];
    [msFunctionParameters appendOptionToFunctionParams:queryString];
    NSString *expectedString = [NSString stringWithFormat:@"%@,foo=(null)",_basicString];
    XCTAssertEqualObjects(queryString, expectedString);
}
-(void)testMSHeaderOptions{
    MSHeaderOptions *hearderOptions =[[MSHeaderOptions alloc] initWithKey:_firstKey value:_firstValue];
    XCTAssertNotNil(hearderOptions);
    XCTAssertEqualObjects(hearderOptions.key, _firstKey);
    XCTAssertEqualObjects(hearderOptions.value, _firstValue);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"xxcc", @"token", nil];
    [hearderOptions appendOptionToHeaders:dic];
    XCTAssertEqual([dic count], 2);
    XCTAssertEqualObjects([dic objectForKey:_firstKey], _firstValue);
    XCTAssertEqualObjects([dic objectForKey:@"token"], @"xxcc");
}
-(void)testMSIfMatch{
    MSIfMatch *msIfMatch = [MSIfMatch entityTags:_firstValue];
    XCTAssertNotNil(msIfMatch);
    XCTAssertEqualObjects(msIfMatch.key, @"If-Match");
    XCTAssertEqualObjects(msIfMatch.value, _firstValue);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"xxcc", @"token", nil];
    [msIfMatch appendOptionToHeaders:dic];
    XCTAssertEqual([dic count], 2);
    XCTAssertEqualObjects([dic objectForKey:@"If-Match"], _firstValue);
    XCTAssertEqualObjects([dic objectForKey:@"token"], @"xxcc");
}
-(void)testMSIfNoneMatch{
    MSIfNoneMatch *msIfNoneMatch = [MSIfNoneMatch entityTags:_firstValue];
    XCTAssertNotNil(msIfNoneMatch);
    XCTAssertEqualObjects(msIfNoneMatch.key, @"If-None-Match");
    XCTAssertEqualObjects(msIfNoneMatch.value, _firstValue);
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"xxcc", @"token", nil];
    [msIfNoneMatch appendOptionToHeaders:dic];
    XCTAssertEqual([dic count], 2);
    XCTAssertEqualObjects([dic objectForKey:@"If-None-Match"], _firstValue);
    XCTAssertEqualObjects([dic objectForKey:@"token"], @"xxcc");
}
-(void)testMSOrderByOptions{
    MSOrderByOptions *msOrderByOptions = [MSOrderByOptions orderBy:@"name"];
    XCTAssertNotNil(msOrderByOptions);
    XCTAssertEqualObjects(msOrderByOptions.key, @"$orderby");
    XCTAssertEqualObjects(msOrderByOptions.value, @"name");
    
    NSMutableString *queryString = [_basicString mutableCopy];
    [msOrderByOptions appendOptionToQueryString:queryString];
    NSString *expectedString = [NSString stringWithFormat:@"%@&%@=%@",_basicString, msOrderByOptions.key, msOrderByOptions.value];
    XCTAssertEqualObjects(queryString, expectedString);
}
-(void)testMSSelectOptions{
    MSSelectOptions *msSelectOptions = [MSSelectOptions select:@"name"];
    XCTAssertNotNil(msSelectOptions);
    XCTAssertEqualObjects(msSelectOptions.key, @"$select");
    XCTAssertEqualObjects(msSelectOptions.value, @"name");
    
    NSMutableString *queryString = [_basicString mutableCopy];
    [msSelectOptions appendOptionToQueryString:queryString];
    NSString *expectedString = [NSString stringWithFormat:@"%@&%@=%@",_basicString, msSelectOptions.key, msSelectOptions.value];
    XCTAssertEqualObjects(queryString, expectedString);
}
-(void)testMSTopOptions{
    MSTopOptions *msTopOptions = [MSTopOptions top:10];
    XCTAssertNotNil(msTopOptions);
    XCTAssertEqualObjects(msTopOptions.key, @"$top");
    XCTAssertEqualObjects(msTopOptions.value, @"10");
    
    NSMutableString *queryString = [_basicString mutableCopy];
    [msTopOptions appendOptionToQueryString:queryString];
    NSString *expectedString = [NSString stringWithFormat:@"%@&%@=%@",_basicString, msTopOptions.key, msTopOptions.value];
    XCTAssertEqualObjects(queryString, expectedString);
}
@end
