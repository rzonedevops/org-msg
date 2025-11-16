//
//  NSJSONSerialization+ResponseHelperTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/7/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"

@interface NSJSONSerialization_ResponseHelperTests : XCTestCase
@property NSURL * testurl;
@property NSData * mockData;
@end

@implementation NSJSONSerialization_ResponseHelperTests

- (void)setUp {
    [super setUp];
    self.testurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",MSGraphApiEndpoint,MSGraphApiVersion]];
    self.mockData = [NSJSONSerialization dataWithJSONObject:@{@"initKey":@"initData"} options:0 error:nil];
   // self.testError = [NSError errorWithDomain:@"testError" code:123 userInfo:@{}];
}
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testDictionaryWithOKResponse {
    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] initWithURL:_testurl
                                                                 statusCode:MSExpectedResponseCodesOK
                                                                HTTPVersion:@"foo" headerFields:nil];
    NSError *parseError = nil;
    NSDictionary *retDic = [NSJSONSerialization dictionaryWithResponse:urlResponse
                                                          responseData:_mockData error:&parseError];
    
    XCTAssertNotNil(retDic);
    XCTAssertNil(parseError);
    XCTAssertEqualObjects([retDic objectForKey:@"initKey"], @"initData");
    
}
- (void)testDictionaryNilWithOKResponse {
    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] initWithURL:_testurl
                                                                 statusCode:MSExpectedResponseCodesOK
                                                                HTTPVersion:@"foo" headerFields:nil];
    NSError *parseError = nil;
    NSDictionary *retDic = [NSJSONSerialization dictionaryWithResponse:urlResponse
                                                          responseData:nil error:&parseError];
    
    XCTAssertNil(retDic);
    XCTAssertNil(parseError);
}

- (void)testDictionaryWith401Response {
    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] initWithURL:_testurl
                                                                 statusCode:MSClientErrorCodeUnauthorized
                                                                HTTPVersion:@"foo" headerFields:nil];
    NSData *errorData = [NSJSONSerialization dataWithJSONObject:@{@"error":@{@"code":@"Unauthorized", @"message": @"401 error"}} options:0 error:nil];
    NSError *parseError = nil;
    NSDictionary *retDic = [NSJSONSerialization dictionaryWithResponse:urlResponse
                                                          responseData:errorData error:&parseError];
    
    XCTAssertNil(retDic);
    XCTAssertNotNil(parseError);
    
    XCTAssertEqual(parseError.code, MSClientErrorCodeUnauthorized);
    XCTAssertEqual(parseError.domain, MSErrorDomain);
    NSDictionary *useInfo = parseError.userInfo;
    XCTAssertNotNil(useInfo);
    
    MSError *userInfoError = [useInfo objectForKey:@"error"];
    XCTAssertEqualObjects(userInfoError.code, @"Unauthorized");
    XCTAssertEqualObjects(userInfoError.message, @"401 error");
}
- (void)testDictionaryNilDataWith401 {
    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] initWithURL:_testurl
                                                                 statusCode:MSClientErrorCodeUnauthorized
                                                                HTTPVersion:@"foo" headerFields:nil];
    NSError *parseError = nil;
    NSDictionary *retDic = [NSJSONSerialization dictionaryWithResponse:urlResponse
                                                          responseData:nil error:&parseError];
    
    XCTAssertNil(retDic);
    XCTAssertNotNil(parseError);
    
    XCTAssertEqual(parseError.code, MSClientErrorCodeUnauthorized);
    XCTAssertEqual(parseError.domain, MSErrorDomain);
}

-(void)testErrorWithStatusCodeWithNilDic{
    NSError *error = [NSJSONSerialization errorWithStatusCode:MSClientErrorCodeNotFound responseDictionary:nil];
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, MSErrorDomain);
    XCTAssertNotNil(error.userInfo);
    XCTAssertNil([error.userInfo objectForKey:@"error"]);
}
-(void)testErrorWithStatusCodeWithErrorDic{
    
    NSDictionary *errorDic = @{@"error":@{@"code":@"Not Found", @"message": @"404 error"}};
    NSError *error = [NSJSONSerialization errorWithStatusCode:MSClientErrorCodeNotFound responseDictionary:errorDic];
    XCTAssertNotNil(error);
    XCTAssertEqualObjects(error.domain, MSErrorDomain);
    XCTAssertEqual(error.code, MSClientErrorCodeNotFound);
    
    NSDictionary *useInfo = error.userInfo;
    XCTAssertNotNil(useInfo);
    MSError *userInfoError = [useInfo objectForKey:@"error"];
    XCTAssertEqualObjects(userInfoError.code, @"Not Found");
    XCTAssertEqualObjects(userInfoError.message, @"404 error");
}

-(void)testErrorFromResponse{
    
    XCTAssertThrows([NSJSONSerialization errorFromResponse:nil responseObject:nil]);
    
    NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] initWithURL:_testurl
                                                                 statusCode:MSClientErrorCodeInternalServerError
                                                                HTTPVersion:@"foo" headerFields:nil];
    NSError *error1 = [NSJSONSerialization errorFromResponse:urlResponse responseObject:nil];
    XCTAssertNotNil(error1);
    XCTAssertEqual(error1.code, MSClientErrorCodeInternalServerError);
    XCTAssertEqualObjects(error1.domain, MSErrorDomain);
    XCTAssertNotNil(error1.userInfo);
}
@end
