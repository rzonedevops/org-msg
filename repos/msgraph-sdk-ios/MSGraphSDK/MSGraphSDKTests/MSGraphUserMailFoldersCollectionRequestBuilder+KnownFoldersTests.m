//
//  MSGraphUserMailFoldersCollectionRequestBuilder+KnownFoldersTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/7/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphUserMailFoldersCollectionRequestBuilder_KnownFoldersTests : MSGraphTestCase

@end

@implementation MSGraphUserMailFoldersCollectionRequestBuilder_KnownFoldersTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInbox {
    MSGraphUserMailFoldersCollectionRequestBuilder * requestBuilder =[[MSGraphUserMailFoldersCollectionRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    
    MSGraphMailFolderRequestBuilder *inboxRequestBuilder = [requestBuilder inbox];
    XCTAssertNotNil(requestBuilder);
    NSString *expectedUrl = [NSString stringWithFormat:@"%@/inbox",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([inboxRequestBuilder.request.requestURL absoluteString], expectedUrl);
}
- (void)testDrafts {
    MSGraphUserMailFoldersCollectionRequestBuilder * requestBuilder =[[MSGraphUserMailFoldersCollectionRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    
    MSGraphMailFolderRequestBuilder *draftsRequestBuilder = [requestBuilder drafts];
    XCTAssertNotNil(requestBuilder);
    NSString *expectedUrl = [NSString stringWithFormat:@"%@/drafts",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([draftsRequestBuilder.request.requestURL absoluteString], expectedUrl);
}
- (void)testSentItems {
    MSGraphUserMailFoldersCollectionRequestBuilder * requestBuilder =[[MSGraphUserMailFoldersCollectionRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    
    MSGraphMailFolderRequestBuilder *sentItemsRequestBuilder = [requestBuilder sentItems];
    XCTAssertNotNil(requestBuilder);
    NSString *expectedUrl = [NSString stringWithFormat:@"%@/sentItems",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([sentItemsRequestBuilder.request.requestURL absoluteString], expectedUrl);
}
- (void)testDeletedItems {
    MSGraphUserMailFoldersCollectionRequestBuilder * requestBuilder =[[MSGraphUserMailFoldersCollectionRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    
    MSGraphMailFolderRequestBuilder *deletedItemsRequestBuilder = [requestBuilder deletedItems];
    XCTAssertNotNil(requestBuilder);
    NSString *expectedUrl = [NSString stringWithFormat:@"%@/deletedItems",[self.testBaseURL absoluteString]];
    XCTAssertEqualObjects([deletedItemsRequestBuilder.request.requestURL absoluteString], expectedUrl);
}
@end
