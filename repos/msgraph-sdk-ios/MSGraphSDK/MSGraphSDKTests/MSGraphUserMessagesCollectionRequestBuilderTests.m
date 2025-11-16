//
//  MSGraphUserMessagesCollectionRequestBuilderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphUserMessagesCollectionRequestBuilderTests : MSGraphTestCase

@end
//CollectionRequestBuilder tests
@implementation MSGraphUserMessagesCollectionRequestBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphUserMessagesCollectionRequestBuilderInit {
    MSGraphUserMessagesCollectionRequestBuilder *requestBuilder = [[MSGraphUserMessagesCollectionRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(requestBuilder);
    XCTAssertEqualObjects(requestBuilder.requestURL, self.testBaseURL);
    XCTAssertEqualObjects(requestBuilder.client, self.mockClient);
}
- (void)testGetMessageRequestBuilderInit {
    NSString *messageId = @"AAMkADdhZTdhZjgxLTQzNDMtNGY5ZS04MDlkLThkM2E4N2Q4ZGE5MwBGAAAAAACXEUYc36v1RKhxupm0C73VBwDSgdiHnD3UTZ-LhQEVoM4pAAAAAAEMAADSgdiHnD3UTZ-LhQEVoM4pAADNWLEhAAA=";
    MSGraphUserMessagesCollectionRequestBuilder *messageCollectionRequestBuilder = [[MSGraphUserMessagesCollectionRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    MSGraphMessageRequestBuilder *messageRequestBuilder = [messageCollectionRequestBuilder message:messageId];
    XCTAssertNotNil(messageRequestBuilder);
    XCTAssertEqualObjects(messageRequestBuilder.client, self.mockClient);
    NSURL *expectedURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[self.testBaseURL absoluteString],messageId]];
    XCTAssertEqualObjects(messageRequestBuilder.requestURL, expectedURL);
}

@end
