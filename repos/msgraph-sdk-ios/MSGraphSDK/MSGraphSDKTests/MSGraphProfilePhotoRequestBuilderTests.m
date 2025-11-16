//
//  MSGraphProfilePhotoRequestBuilderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSRequest()

@property NSMutableArray *options;

@end

@interface MSGraphProfilePhotoRequestBuilderTests : MSGraphTestCase

@end
//EntityRequestBuilder tests
@implementation MSGraphProfilePhotoRequestBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testMSGraphProfilePhotoRequestBuilderInit{
    MSGraphProfilePhotoRequestBuilder *requestBuilder = [[MSGraphProfilePhotoRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(requestBuilder);
    XCTAssertEqualObjects(requestBuilder.requestURL, self.testBaseURL);
    XCTAssertEqualObjects(requestBuilder.client, self.mockClient);
}
-(void)testMSGraphProfilePhotoRequestBuilderInitNil{
    XCTAssertThrows([[MSGraphProfilePhotoRequestBuilder alloc] initWithURL:nil client:self.mockClient]);
    XCTAssertThrows([[MSGraphProfilePhotoRequestBuilder alloc] initWithURL:self.testBaseURL client:nil]);
}

- (void)testMSGraphProfilePhotoRequestBuilderWithNilOption {
    MSGraphProfilePhotoRequestBuilder *requestBuilder = [[MSGraphProfilePhotoRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    
    MSGraphProfilePhotoRequest *request = [requestBuilder request];
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.requestURL, self.testBaseURL);
    XCTAssertEqualObjects(request.client, self.mockClient);
    XCTAssertEqual(request.options.count, 0);
}

- (void)testMSGraphProfilePhotoRequestBuilderWithValidOption {
    MSGraphProfilePhotoRequestBuilder *requestBuilder = [[MSGraphProfilePhotoRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    
    MSSelectOptions *selectOption =[MSSelectOptions select:@"width,height"];
    MSExpandOptions *expandOption = [MSExpandOptions expand:@"foo"];
    
    MSGraphProfilePhotoRequest *request = [requestBuilder requestWithOptions:@[selectOption, expandOption]];
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.requestURL, self.testBaseURL);
    XCTAssertEqualObjects(request.client, self.mockClient);
    XCTAssertEqual(request.options.count, 2);
    
    [request.options enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[MSSelectOptions class]]){
            XCTAssertEqualObjects(((MSSelectOptions *)obj).key, selectOption.key);
             XCTAssertEqualObjects(((MSSelectOptions *)obj).value, selectOption.value);
        }
        else if([obj isKindOfClass:[MSExpandOptions class]]){
            XCTAssertEqualObjects(((MSExpandOptions *)obj).key, expandOption.key);
            XCTAssertEqualObjects(((MSExpandOptions *)obj).value, expandOption.value);
        }
        else{
            XCTAssertThrows(YES);
        }
    }];
}
- (void)testMSGraphProfilePhotoRequestBuilderWithInValidOption {
    MSGraphProfilePhotoRequestBuilder *requestBuilder = [[MSGraphProfilePhotoRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    NSArray *invalidOption =@[@"foo", @"bar"];
    XCTAssertThrows([requestBuilder requestWithOptions:invalidOption]);
}
@end
