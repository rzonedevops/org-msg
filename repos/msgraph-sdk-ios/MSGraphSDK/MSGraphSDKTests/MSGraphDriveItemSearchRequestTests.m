//
//  MSGraphDriveItemSearchRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/12/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphDriveItemSearchRequest()
@property (nonatomic, getter=q) NSString * q;
@end

@interface MSGraphDriveItemSearchRequestTests : MSGraphTestCase
@property (nonatomic, retain) MSGraphClient *client;
@property (nonatomic, retain) NSData *responseData;
@property (nonatomic,retain) MSCollection *expectedCollection;
@end

//MethodRequest test
@implementation MSGraphDriveItemSearchRequestTests

- (void)setUp {
    [super setUp];
    
    MSGraphDriveItem *driveItem1 = [[MSGraphDriveItem alloc] init];
    driveItem1.entityId = @"testid1";
    driveItem1.name = @"testname1";
    
    MSGraphDriveItem *driveItem2 = [[MSGraphDriveItem alloc] init];
    driveItem2.entityId = @"testid2";
    driveItem2.name = @"testname2";
    
    NSDictionary *reponseDict = @{
                                  @"@odata.context": @"https://graph.microsoft.com/v1.0/$metadata#Collection(driveItem)",
                                  @"@odata.nextLink": @"https://graph.microsoft.com/v1.0/me/drive/root/microsoft.graph.search(q='test')",
                                  @"value": @[[driveItem1 dictionaryFromItem], [driveItem2 dictionaryFromItem]]
                                  };
    self.responseData = [NSJSONSerialization dataWithJSONObject:reponseDict options:0 error:nil];
    self.expectedCollection = [[MSCollection alloc] initWithArray:reponseDict[@"value"] nextLink:reponseDict[@"@odata.nextLink"] additionalData:reponseDict];
    
    
    [MSGraphClient setAuthenticationProvider:self.mockAuthProvider];
    [MSGraphClient setHttpProvider:self.mockHttpProvider];
    self.client = [MSGraphClient client];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphDriveItemSearchRequest {
    MSGraphDriveItemSearchRequest *request = [[[[[_client me] drive] root] searchWithQ:@"test"] request];
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.q, @"test");
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/drive/root/microsoft.graph.search",self.graphUrl]];
    XCTAssertEqualObjects(request.requestURL, expectedURL);

    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:_responseData response:OKresponse error:nil];
    
    MSURLSessionDataTask *task = [request executeWithCompletion:^(MSCollection *response, MSGraphDriveItemSearchRequest *nextRequest, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqual([response.value count], [_expectedCollection.value  count]);
        MSGraphDriveItem * driveItem1 = response.value[0];
        XCTAssertEqualObjects(driveItem1.entityId, _expectedCollection.value[0][@"id"]);
        XCTAssertEqualObjects(driveItem1.name, _expectedCollection.value[0][@"name"]);
        
        MSGraphDriveItem * driveItem2 = response.value[1];
        XCTAssertEqualObjects(driveItem2.entityId, _expectedCollection.value[1][@"id"]);
        XCTAssertEqualObjects(driveItem2.name, _expectedCollection.value[1][@"name"]);
        
        XCTAssertEqualObjects(response.nextLink, _expectedCollection.nextLink);
        XCTAssertTrue([response.additionalData isEqualToDictionary:_expectedCollection.additionalData]);
        XCTAssertNotNil(nextRequest);
        XCTAssertEqualObjects([nextRequest requestURL], _expectedCollection.nextLink);
    }];
    expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/drive/root/microsoft.graph.search(q='test')",self.graphUrl]];
    [self checkRequest:task Method:@"GET" URL:expectedURL];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testMSGraphDriveItemSearchRequestWithNilQ{
    MSGraphDriveItemSearchRequest *request = [[[[[_client me] drive] root] searchWithQ:nil] request];
    XCTAssertNotNil(request);
    XCTAssertEqualObjects(request.q, nil);
    MSURLSessionDataTask *task = [request executeWithCompletion:^(MSCollection *response, MSGraphDriveItemSearchRequest *nextRequest, NSError *error) {
    }];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/drive/root/microsoft.graph.search(q=null)",self.graphUrl]];
    [self checkRequest:task Method:@"GET" URL:expectedURL];
}
- (void)testMSGraphDriveItemSearchRequestWith401Response{
    NSHTTPURLResponse *Response401 = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSClientErrorCodeUnauthorized HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:Response401 error:nil];
    
    [[[[[[_client me] drive] root] searchWithQ:@"test"] request] executeWithCompletion:^(MSCollection *response, MSGraphDriveItemSearchRequest *nextRequest, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNil(nextRequest);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeUnauthorized);
        XCTAssertEqualObjects(error.domain, MSErrorDomain);
    }];
    [self checkCompletionBlockCodeInvoked];
}
@end
