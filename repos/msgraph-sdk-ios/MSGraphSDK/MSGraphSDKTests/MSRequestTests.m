//
//  MSRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/1/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"
@interface MSRequest ()

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      body:(NSData *)body
                                   headers:(NSDictionary *)headers;
@end

@interface MSURLSessionDataTask()

@property (strong) void (^completionHandler)(NSDictionary *dictionary, NSError *error);

@end

@interface MSRequestTests : MSGraphTestCase
@property (nonatomic,retain) NSData * demoData;
@property (nonatomic,retain) NSURL *demoFileLocation;
@property (nonatomic,retain) MSRequest *msRequest;
@property (nonatomic,retain) NSHTTPURLResponse *OKresponse;
@property (nonatomic,retain) NSHTTPURLResponse *Badresponse;
@property (nonatomic,retain) NSError *testError;
@end

@implementation MSRequestTests

- (void)setUp {
    [super setUp];
    self.demoData = [NSJSONSerialization dataWithJSONObject:@{@"initKey":@"initData"} options:0 error:nil];
    self.demoFileLocation = [NSURL URLWithString:@"foo/bar/baz"];
    
    MSHeaderOptions *msRequestOption = [[MSHeaderOptions alloc] initWithKey:@"foo" value:@"bar"];
    NSArray *optionArray = [NSArray arrayWithObject:msRequestOption];
    self.msRequest = [[MSRequest alloc] initWithURL:self.testBaseURL options:optionArray client:self.mockClient];
    
    self.OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    self.Badresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSClientErrorCodeBadRequest HTTPVersion:@"foo" headerFields:nil];
    self.testError = [NSError errorWithDomain:@"testError" code:123 userInfo:@{}];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit{
    MSRequest * request = [[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.requestURL, self.testBaseURL);
    XCTAssertEqual(request.client, self.mockClient);
}
-(void)testAllOptionMethod{
    MSRequest *selectRequest =[[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    selectRequest = [selectRequest select:@"id,mail,displayName"];
    NSMutableURLRequest *nsRequest = [selectRequest requestWithMethod:@"GET" body:nil headers:nil];
    NSString *expectedURLString = [NSString stringWithFormat:@"%@?$select=id,mail,displayName",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([nsRequest.URL absoluteString], expectedURLString);
    
    MSRequest *expandRequest = [[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    expandRequest = [expandRequest expand:@"messages,events"];
    nsRequest = [expandRequest requestWithMethod:@"GET" body:nil headers:nil];
    expectedURLString = [NSString stringWithFormat:@"%@?$expand=messages,events",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([nsRequest.URL absoluteString], expectedURLString);
    
    MSRequest *orderbyRequest = [[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    expandRequest = [orderbyRequest orderBy:@"displayName"];
    nsRequest = [orderbyRequest requestWithMethod:@"GET" body:nil headers:nil];
    expectedURLString = [NSString stringWithFormat:@"%@?$orderby=displayName",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([nsRequest.URL absoluteString], expectedURLString);
    
    MSRequest *topRequest = [[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    topRequest = [topRequest top:20];
    nsRequest = [topRequest requestWithMethod:@"GET" body:nil headers:nil];
    expectedURLString = [NSString stringWithFormat:@"%@?$top=20",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([nsRequest.URL absoluteString], expectedURLString);
    
    MSRequest *ifMatchRequest = [[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    ifMatchRequest = [ifMatchRequest ifMatch:@"737060cd8c284d8af7ad3082f209582d"];
    nsRequest = [ifMatchRequest requestWithMethod:@"GET" body:nil headers:nil];
    XCTAssertEqual([nsRequest.allHTTPHeaderFields objectForKey:@"If-Match"], @"737060cd8c284d8af7ad3082f209582d");
    
    MSRequest *ifNoneMatchRequest = [[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    ifNoneMatchRequest = [ifNoneMatchRequest ifNoneMatch:@"737060cd8c284d8af7ad3082f209582d"];
    nsRequest = [ifNoneMatchRequest requestWithMethod:@"GET" body:nil headers:nil];
    XCTAssertEqual([nsRequest.allHTTPHeaderFields objectForKey:@"If-None-Match"], @"737060cd8c284d8af7ad3082f209582d");
}
-(void)testAllNilOptionMethod{
    MSRequest *reqQequest =[[MSRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNoThrow([reqQequest select:nil]);
    XCTAssertNoThrow([reqQequest expand:nil]);
    XCTAssertNoThrow([reqQequest orderBy:nil]);
    reqQequest = [reqQequest ifMatch:nil];
    reqQequest = [reqQequest ifNoneMatch:nil];
    NSMutableURLRequest *nsRequest = [reqQequest requestWithMethod:@"GET" body:nil headers:nil];
    XCTAssertNil([nsRequest.allHTTPHeaderFields objectForKey:@"If-Match"]);
    XCTAssertNil([nsRequest.allHTTPHeaderFields objectForKey:@"If-None-Match"]);
}
- (void)testRequestInitWithNil{
    XCTAssertThrows([[MSRequest alloc] initWithURL:nil client:self.mockClient]);
    XCTAssertThrows([[MSRequest alloc] initWithURL:self.testBaseURL client:nil]);
}
- (void)testRequestWithInvalidOptions{
    NSArray *invalidOptions = @[@"foo", @"Bar"];
    XCTAssertThrows([[MSRequest alloc] initWithURL:self.testBaseURL options:invalidOptions client:self.mockClient]);
}

-(void)testRequestWithMethod{
    XCTAssertNotNil(_msRequest);
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"bodykey":@"bodyvalue"} options:0 error:nil];
    NSMutableURLRequest *testURLRequest = [_msRequest requestWithMethod:@"PUT" body:body headers:@{@"extraKey":@"extraValue"}];
    XCTAssertNotNil(testURLRequest);
    
    XCTAssertEqualObjects(testURLRequest.HTTPMethod, @"PUT");
    XCTAssertEqualObjects(testURLRequest.HTTPBody, body);
    XCTAssertEqual([testURLRequest.allHTTPHeaderFields count], 3);
    XCTAssertEqualObjects([testURLRequest.allHTTPHeaderFields objectForKey:@"extraKey"], @"extraValue");
}


- (void)testTaskWithNilRequest{
    MSRequest *testRequest = [[MSRequest alloc] initWithURL:self.testBaseURL options:nil client:self.mockClient];
    XCTAssertThrows([testRequest taskWithRequest:nil odObjectWithDictionary:nil completion:nil]);
}
-(void)testTaskWithRequest{
    NSDictionary *responseObject = @{@"baz" : @"qux"};
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
    
    NSMutableURLRequest *testURLRequest = [_msRequest requestWithMethod:@"POST" body:nil headers:nil];
    [self dataTaskCompletionWithRequest:testURLRequest data:responseData response:_OKresponse error:nil];
    
    NSDictionary *odObject = @{@"foo" : @"bar"};
    MSURLSessionDataTask *dataTask = [_msRequest taskWithRequest:testURLRequest odObjectWithDictionary:^id(NSDictionary *response) {
        [self castBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertEqual(response.count, 1);
        XCTAssertEqualObjects([response objectForKey:@"barz"], [responseObject objectForKey:@"barz"]);
        return odObject;
        
    } completion:^(id response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertNil(error);
        XCTAssertEqual(response, odObject);
    }];
    
    [dataTask taskWithRequest:testURLRequest];
    [self checkCastAndCompletionBlockCodeInvoked];
}
-(void)testTaskWithRequestWithErrorResponse{
    NSMutableURLRequest *testURLRequest = [_msRequest requestWithMethod:@"GET" body:nil headers:nil];
    [self dataTaskCompletionWithRequest:testURLRequest data:nil response:_Badresponse error:nil];
    
    MSURLSessionDataTask *dataTask = [_msRequest taskWithRequest:testURLRequest odObjectWithDictionary:^id(NSDictionary *response) {
        XCTAssert(NO);
    } completion:^(id response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertEqual(error.code, _Badresponse.statusCode);
    }];
    [dataTask taskWithRequest:testURLRequest];
    [self checkCompletionBlockCodeInvoked];
}

-(void)testUploadTaskWithRequestFromFile{
    NSDictionary *odObject = @{@"foo" : @"bar"};
    NSMutableURLRequest *testURLRequest = [_msRequest requestWithMethod:@"POST" body:nil headers:nil];
    [self uploadTaskFromFileURLCompletionWithRequest:testURLRequest progress:nil fileURL:_demoFileLocation responseData:_demoData response:_OKresponse error:nil];
    
    MSURLSessionUploadTask *uploadTask = [_msRequest uploadTaskWithRequest:testURLRequest fromFile:_demoFileLocation odobjectWithDictionary:^id(NSDictionary *response) {
        [self castBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertEqualObjects([response objectForKey:@"initKey"],@"initData");
        return odObject;
    } completionHandler:^(id response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqualObjects(response, odObject);
    }];
    [uploadTask taskWithRequest:testURLRequest];
    [self checkCastAndCompletionBlockCodeInvoked];
}
-(void)testUploadTaskWithRequestFromFileWithErrorResponse{
    NSMutableURLRequest *testURLRequest = [_msRequest requestWithMethod:@"POST" body:nil headers:nil];
    [self uploadTaskFromFileURLCompletionWithRequest:testURLRequest progress:nil fileURL:_demoFileLocation responseData:_demoData response:nil error:_testError];
    
    MSURLSessionUploadTask *uploadTask = [_msRequest uploadTaskWithRequest:testURLRequest fromFile:_demoFileLocation odobjectWithDictionary:^id(NSDictionary *response) {
         XCTAssert(NO);
    } completionHandler:^(id response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertEqualObjects(error, _testError);
    }];
    [uploadTask taskWithRequest:testURLRequest];
    
    [self checkCompletionBlockCodeInvoked];
}
-(void)testUploadTaskWithRequestFromData{
    NSMutableURLRequest *testURLRequest = [_msRequest requestWithMethod:@"POST" body:nil headers:nil];
    [self uploadTaskFromDataCompletionWithRequest:testURLRequest progress:nil responseData:_demoData response:_OKresponse error:nil];
    
    MSURLSessionUploadTask *uploadTask = [_msRequest uploadTaskWithRequest:testURLRequest fromData:_demoData odobjectWithDictionary:^id(NSDictionary *response) {
        [self castBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertEqualObjects([response objectForKey:@"initKey"],@"initData");
        return @"cast test";
        
    } completionHandler:^(id response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqualObjects(response, @"cast test");
        XCTAssertNil(error);
    }];
    [uploadTask taskWithRequest:testURLRequest];
    [self checkCastAndCompletionBlockCodeInvoked];
}
-(void)testUploadTaskWithRequestFromDataWithErrorResponse{
    
    NSData * uploadData = [NSJSONSerialization dataWithJSONObject:@{@"foo" : @"bar"} options:0 error:nil];
    NSMutableURLRequest *testURLRequest = [_msRequest requestWithMethod:@"POST" body:nil headers:nil];
    [self uploadTaskFromDataCompletionWithRequest:testURLRequest progress:nil responseData:_demoData response:_Badresponse error:nil];
    
    MSURLSessionUploadTask *uploadTask = [_msRequest uploadTaskWithRequest:testURLRequest fromData:uploadData odobjectWithDictionary:^id(NSDictionary *response) {
        XCTAssert(NO);
        return nil;
        
    } completionHandler:^(id response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertEqual(error.code, _Badresponse.statusCode);
    }];
    
    [uploadTask taskWithRequest:testURLRequest];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testRequestWithHeaderOptions{
    MSHeaderOptions *testHeaders = [[MSHeaderOptions alloc] initWithKey:@"foo" value:@"Bar"];
    MSRequest *msRequest = [[MSRequest alloc] initWithURL:self.testBaseURL options:@[testHeaders] client:self.mockClient];
    NSMutableURLRequest *testRequest = [msRequest requestWithMethod:@"GET" body:nil headers:nil];
    
    NSMutableURLRequest *expectedRequest = [NSMutableURLRequest requestWithURL:self.testBaseURL];
    [expectedRequest setValue:testHeaders.value forHTTPHeaderField:testHeaders.key];
    
    XCTAssertEqualObjects(testRequest.URL, expectedRequest.URL);
    XCTAssertEqualObjects(testRequest.HTTPMethod, expectedRequest.HTTPMethod);
    XCTAssertEqualObjects(testRequest.HTTPBody, expectedRequest.HTTPBody);
    XCTAssertEqual([testRequest.allHTTPHeaderFields objectForKey:@"foo"], [expectedRequest.allHTTPHeaderFields objectForKey:@"foo"]);
}
@end
