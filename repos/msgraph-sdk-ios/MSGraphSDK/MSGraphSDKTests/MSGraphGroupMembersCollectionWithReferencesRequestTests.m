
//
//  MSGraphGroupMembersCollectionWithReferencesRequestTests.m
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

@interface MSGraphGroupMembersCollectionWithReferencesRequestTests : MSGraphTestCase
@property (nonatomic, retain) MSGraphClient *client;
@property (nonatomic,retain) NSData *responseData;
@property (nonatomic,retain) MSCollection *expectedCollection;
@end
//CollectionWithReferencesRequest
@implementation MSGraphGroupMembersCollectionWithReferencesRequestTests

- (void)setUp {
    [super setUp];

    NSDictionary *membersDic =@{
        @"@odata.context": @"https://graph.microsoft.com/v1.0/$metadata#directoryObjects",
        @"@odata.nextLink": @"https://graph.microsoft.com/v1.0/groups/4b9bfa31-1111-2222-0000-2e6094e5207d/members?$top=2",
        @"value": @[@{
                      @"@odata.type": @"#microsoft.graph.user",
                      @"id": @"8f98666a-0000-1111-2222-fa1204dec445",
                      @"businessPhones": @[
                                         @"+1 100011"
                                         ],
                      @"displayName": @"Tester Cindy",
                      @"givenName": @"Cindy",
                      @"jobTitle": @"Tester",
                      @"mail": @"cindy@test.onmicrosoft.com",
                      @"mobilePhone": @"+1 100011",
                      @"userPrincipalName": @"cindy@test.onmicrosoft.com"
                  }
                  ]
        };
    self.expectedCollection = [[MSCollection alloc] initWithArray:membersDic[@"value"] nextLink:membersDic[@"@odata.nextLink"] additionalData:membersDic];
    self.responseData = [NSJSONSerialization dataWithJSONObject:membersDic options:0 error:nil];

    
    [MSGraphClient setAuthenticationProvider:self.mockAuthProvider];
    [MSGraphClient setHttpProvider:self.mockHttpProvider];
    self.client = [MSGraphClient client];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testMSGraphGroupMembersCollectionWithReferencesRequest{
    MSGraphGroupMembersCollectionWithReferencesRequest *reqest = [[[_client groups:@"groupid"] members] request];
    XCTAssertNotNil(reqest);
    
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:_responseData response:OKresponse error:nil];
    
    MSURLSessionDataTask *task = [[reqest top:1] getWithCompletion:^(MSCollection *response, MSGraphGroupMembersCollectionWithReferencesRequest *nextRequest, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqual([response.value count], [_expectedCollection.value  count]);
        MSGraphDirectoryObject * directoryObject = response.value[0];
        XCTAssertEqualObjects(directoryObject.entityId, _expectedCollection.value[0][@"id"]);
        XCTAssertEqualObjects(response.nextLink, _expectedCollection.nextLink);
        XCTAssertTrue([response.additionalData isEqualToDictionary:_expectedCollection.additionalData]);
        XCTAssertNotNil(nextRequest);
        XCTAssertEqualObjects([nextRequest requestURL], _expectedCollection.nextLink);
    }];
    [self checkRequest:task Method:@"GET" URL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/groups/groupid/members?$top=1",self.graphUrl]]];
    [self checkCompletionBlockCodeInvoked];
}
-(void)testExpand{
    MSGraphGroupMembersCollectionWithReferencesRequest *request = [[[[_client groups:@"groupId"] members] request] expand:@"testwz"];
    XCTAssertEqual(request.options.count, 1);
    XCTAssertTrue([request.options[0] isKindOfClass:[MSExpandOptions class]]);
    MSExpandOptions *expand =request.options[0];
    XCTAssertEqualObjects(expand.key, @"$expand");
    XCTAssertEqualObjects(expand.value, @"testwz");
}
-(void)testSelect{
    MSGraphGroupMembersCollectionWithReferencesRequest *request = [[[[_client groups:@"groupId"] members] request] select:@"testselect"];
    XCTAssertEqual(request.options.count, 1);
    XCTAssertTrue([request.options[0] isKindOfClass:[MSSelectOptions class]]);
    MSSelectOptions *select =request.options[0];
    XCTAssertEqualObjects(select.key, @"$select");
    XCTAssertEqualObjects(select.value, @"testselect");
}
-(void)testTop{
    MSGraphGroupMembersCollectionWithReferencesRequest *request = [[[[_client groups:@"groupId"] members] request] top:5];
    XCTAssertEqual(request.options.count, 1);
    XCTAssertTrue([request.options[0] isKindOfClass:[MSTopOptions class]]);
    MSTopOptions *top =request.options[0];
    XCTAssertEqualObjects(top.key, @"$top");
    XCTAssertEqualObjects(top.value, @"5");
}
-(void)testFilter{
    MSRequestOptions *filterOption = [[MSRequestOptions alloc] initWithKey:@"$filter" value:@"displayName eq 'tester'"];
    MSGraphGroupMembersCollectionWithReferencesRequest *request = [[[_client groups:@"groupId"] members] requestWithOptions:@[filterOption]];
    XCTAssertEqual(request.options.count, 1);
    XCTAssertTrue([request.options[0] isKindOfClass:[MSRequestOptions class]]);
    MSRequestOptions *option =request.options[0];
    XCTAssertEqualObjects(option.key, filterOption.key);
    XCTAssertEqualObjects(option.value, filterOption.value);
}
-(void)testSkip{
    MSRequestOptions *skipOption = [[MSRequestOptions alloc] initWithKey:@"$skip" value:@"10"];
    MSGraphGroupMembersCollectionWithReferencesRequest *request = [[[_client groups:@"groupId"] members] requestWithOptions:@[skipOption]];
    XCTAssertEqual(request.options.count, 1);
    XCTAssertTrue([request.options[0] isKindOfClass:[MSRequestOptions class]]);
    MSRequestOptions *option =request.options[0];
    XCTAssertEqualObjects(option.key, skipOption.key);
    XCTAssertEqualObjects(option.value, skipOption.value);
}
-(void)testOrderBy{
    MSRequestOptions *orderbyOption = [[MSRequestOptions alloc] initWithKey:@"$ordery" value:@"mail"];
    MSGraphGroupMembersCollectionWithReferencesRequest *request = [[[_client groups:@"groupId"] members] requestWithOptions:@[orderbyOption]];
    XCTAssertEqual(request.options.count, 1);
    XCTAssertTrue([request.options[0] isKindOfClass:[MSRequestOptions class]]);
    MSRequestOptions *option =request.options[0];
    XCTAssertEqualObjects(option.key, orderbyOption.key);
    XCTAssertEqualObjects(option.value, orderbyOption.value);
}
@end
