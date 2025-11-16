//
//  MSErrorTest.m
//  MSGraphSDK
//
//  Created by canviz on 6/3/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
@interface MSErrorTest : XCTestCase
@property NSDictionary *errorDictionary;
@end

@implementation MSErrorTest

- (void)setUp {
    [super setUp];
    self.errorDictionary =  @{ @"code" : MSAccessDeniedError,
                               @"message" : @"Foo Bar",
                               @"innererror" :
                                   @{
                                       @"code" : MSGeneralExceptionError
                                    }
                               
                               };
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testErrorWithDictionary {
    MSError *error = [MSError errorWithDictionary:_errorDictionary];
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.code, MSAccessDeniedError);
    XCTAssertEqualObjects(error.innerError.code, MSGeneralExceptionError);
    XCTAssertNil(error.innerError.innerError);
}

- (void)testErrorMatches{
    MSError *error = [MSError errorWithDictionary:_errorDictionary];
    XCTAssertTrue([error matches:MSGeneralExceptionError]);
    XCTAssertTrue([error matches:MSAccessDeniedError]);
    XCTAssertFalse([error matches:MSNotSupportedError]);
}

- (void)testMalformedError{
    MSError *error = [MSError errorWithDictionary:@{@"foo" : @"bar"}];
    XCTAssertTrue([error matches:MSMalformedErrorResponseError]);
}
- (void)testErrorDescrpiton{
    MSError *error = [MSError errorWithDictionary:_errorDictionary];
    NSString *des = [NSString stringWithFormat:@" %@ : %@", [_errorDictionary objectForKey:@"code"], [_errorDictionary objectForKey:@"message"]];
    XCTAssertEqualObjects([error description], des);
}
@end
