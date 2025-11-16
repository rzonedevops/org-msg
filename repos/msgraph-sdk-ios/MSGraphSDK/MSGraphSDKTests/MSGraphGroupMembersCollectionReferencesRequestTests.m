//
//  MSGraphGroupMembersCollectionReferencesRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphGroupMembersCollectionReferencesRequestTests : MSGraphTestCase
@property (nonatomic, retain) NSURL *groupMembersRequestURL;
@property (nonatomic, retain) MSGraphClient *client;
@property (nonatomic, retain) NSHTTPURLResponse *OKresponse;
@property (nonatomic, retain) NSHTTPURLResponse *Response403;
@end
//EntityCollectionReferenceRequest tests
@implementation MSGraphGroupMembersCollectionReferencesRequestTests

- (void)setUp {
    [super setUp];
    self.groupMembersRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/groups/groupId/members/$ref",self.graphUrl]];
    self.requestForMock = [[NSMutableURLRequest alloc] initWithURL:self.groupMembersRequestURL];
    self.OKresponse = [[NSHTTPURLResponse alloc] initWithURL:_groupMembersRequestURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    self.Response403 = [[NSHTTPURLResponse alloc] initWithURL:_groupMembersRequestURL statusCode:MSClientErrorCodeForbidden HTTPVersion:@"foo" headerFields:nil];

    
    [MSGraphClient setAuthenticationProvider:self.mockAuthProvider];
    [MSGraphClient setHttpProvider:self.mockHttpProvider];
    self.client = [MSGraphClient client];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphGroupMembersCollectionReferencesRequestInit {
    MSGraphGroupMembersCollectionReferencesRequestBuilder *builder = [[[_client groups:@"groupId"] members] references];
    XCTAssertNotNil(builder);
    XCTAssertEqualObjects(builder.requestURL, _groupMembersRequestURL);
}

-(void)testAddDirectoryObjectWithOk{
    
    MSGraphUser *userToCreate = [[MSGraphUser alloc] init];
    userToCreate.entityId = @"userId";
    NSData *postData = [NSJSONSerialization dataWithJSONObject:@{@"@odata.id":[NSString stringWithFormat:@"%@/directoryObjects/%@",self.graphUrl,userToCreate.entityId]} options:0 error:nil];
    
    NSDictionary *dierctoryDict = @{@"id":@"testId",@"@odata.type":@"testType"};
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:dierctoryDict options:0 error:nil];
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:responseData response:_OKresponse error:nil];
    MSURLSessionDataTask * task = [[[[[_client groups:@"groupId"] members] references] request] addDirectoryObject:userToCreate withCompletion:^(MSGraphDirectoryObject *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqualObjects(response.entityId, dierctoryDict[@"id"]);
        XCTAssertEqualObjects(response.oDataType, dierctoryDict[@"@odata.type"]);
    }];
    [self checkRequest:task Method:@"POST" URL:_groupMembersRequestURL];
    XCTAssertEqualObjects(task.request.HTTPBody, postData);
    [self checkCompletionBlockCodeInvoked];
}

-(void)testAddDirectoryObjectWith403Response{
    MSGraphUser *userToCreate = [[MSGraphUser alloc] init];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:_Response403 error:nil];
    [[[[[_client groups:@"groupId"] members] references] request] addDirectoryObject:userToCreate withCompletion:^(MSGraphDirectoryObject *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeForbidden);
    }];
    [self checkCompletionBlockCodeInvoked];
}
@end
