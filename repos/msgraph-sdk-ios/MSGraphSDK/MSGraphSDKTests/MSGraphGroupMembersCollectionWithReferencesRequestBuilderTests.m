//
//  MSGraphGroupMembersCollectionWithReferencesRequestBuilderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphGroupMembersCollectionWithReferencesRequestBuilderTests : MSGraphTestCase
@property (nonatomic, retain) MSGraphClient *client;
@end
//CollectionWithReferencesRequestBuilder test
@implementation MSGraphGroupMembersCollectionWithReferencesRequestBuilderTests

- (void)setUp {
    [super setUp];
    [MSGraphClient setAuthenticationProvider:self.mockAuthProvider];
    self.client = [MSGraphClient client];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphUserMessagesCollectionRequestBuilderInit {
    MSGraphGroupMembersCollectionWithReferencesRequestBuilder *requestBuilder = [[MSGraphGroupMembersCollectionWithReferencesRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(requestBuilder);
    XCTAssertEqualObjects(requestBuilder.requestURL, self.testBaseURL);
    XCTAssertEqualObjects(requestBuilder.client, self.mockClient);
}
- (void)testMSGraphUserMessagesCollectionRequestBuilderInitFromClient {
    MSGraphGroupMembersCollectionWithReferencesRequestBuilder *requestBuilder = [[_client groups:@"groupId"] members];
    XCTAssertNotNil(requestBuilder);
    
    MSGraphGroupMembersCollectionWithReferencesRequest *request = [requestBuilder request];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/groups/groupId/members",self.graphUrl]];
    XCTAssertEqualObjects(request.requestURL,expectedURL);
}

-(void)testGetDirectoryObjectBuilder{
    MSGraphGroupMembersCollectionWithReferencesRequestBuilder *requestBuilder = [[MSGraphGroupMembersCollectionWithReferencesRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    MSGraphDirectoryObjectRequestBuilder *directory = [requestBuilder directoryObject:@"directoryObjectId"];
    XCTAssertNotNil(directory);
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/directoryObjectId",self.testBaseURL]];
    XCTAssertEqualObjects(directory.requestURL,expectedURL);
    
}
-(void)testGetDirectoryObjectBuilderFromClient{
    MSGraphDirectoryObjectRequestBuilder *requestBuilder = [[[_client groups:@"groupId"] members] directoryObject:@"directoryObjectId"];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/groups/groupId/members/directoryObjectId",self.graphUrl]];
    XCTAssertEqualObjects(requestBuilder.requestURL,expectedURL);
    
}
-(void)testGetReferencesBuilderFromClient{
    MSGraphGroupMembersCollectionReferencesRequestBuilder *requestBuilder = [[[_client groups:@"groupId"] members] references];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/groups/groupId/members/$ref",self.graphUrl]];
    XCTAssertEqualObjects(requestBuilder.requestURL,expectedURL);
    
}
@end
