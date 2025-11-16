//
//  MSGraphThumbnailSet+CustomThumbnailTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/6/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphThumbnailSet_CustomThumbnailTests : MSGraphTestCase
@property NSString *thumbNailsURL;
@end

@implementation MSGraphThumbnailSet_CustomThumbnailTests

- (void)setUp {
    [super setUp];
    self.thumbNailsURL = [NSString stringWithFormat:@"%@/me/drive/items/01GOKJUAHZQA74MZDEQJHJLSYTYSGBYTDQ/thumbnails/0",self.graphUrl];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testMSGraphThumbnailSetRequestBuilderCustomThumbnailWithSize{
    MSGraphThumbnailSetRequestBuilder *thumbnailSetRequestBuilder = [[MSGraphThumbnailSetRequestBuilder alloc] initWithURL:[NSURL URLWithString:_thumbNailsURL] client:self.mockClient];
    MSGraphThumbnailRequestBuilder * thumbnailRequestBuilder = [thumbnailSetRequestBuilder customThumbnailWithSize:@"small"];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/small",_thumbNailsURL]];
    XCTAssertEqualObjects(thumbnailRequestBuilder.request.requestURL, expectedURL);
}

-(void)testMSGraphThumbnailSetCustomThumbnailWithSize{
    NSDictionary *returnDic = @{
                                  @"id": @"0",
                                  @"small": @{ @"height": @64, @"width": @96, @"url": @"https://sn3302files/small"},
                                  @"medium": @{ @"height": @117, @"width": @176, @"url": @"https://sn3302files/medium"},
                                  @"large": @{ @"height": @533, @"width": @800, @"url": @"https://sn3302files/large"}
                                  };
    
    MSGraphThumbnailSetRequestBuilder *thumbnailSetRequestBuilder = [[MSGraphThumbnailSetRequestBuilder alloc] initWithURL:self.testBaseURL client:self.mockClient];
    NSData *returnData = [NSJSONSerialization dataWithJSONObject:returnDic options:0 error:nil];
    //mock
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:returnData response:[[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil] error:nil];
    
    [thumbnailSetRequestBuilder.request getWithCompletion:^(MSGraphThumbnailSet *response, NSError *error) {
        [self completionBlockCodeInvoked];
        MSGraphThumbnail *small = [response customThumbnailWithSize:@"small"];
        XCTAssertNotNil(small);
        XCTAssertEqual(small.height, 64);
        XCTAssertEqual(small.width, 96);
        XCTAssertEqualObjects(small.url, @"https://sn3302files/small");
        
        MSGraphThumbnail *medium = [response customThumbnailWithSize:@"medium"];
        XCTAssertEqual(medium.height, 117);
        XCTAssertEqual(medium.width, 176);
        XCTAssertEqualObjects(medium.url, @"https://sn3302files/medium");
        
        MSGraphThumbnail *large = [response customThumbnailWithSize:@"large"];
        XCTAssertEqual(large.height, 533);
        XCTAssertEqual(large.width, 800);
        XCTAssertEqualObjects(large.url, @"https://sn3302files/large");
        
        MSGraphThumbnail *invalidSize = [response customThumbnailWithSize:@"invalidSize"];
        XCTAssertNil(invalidSize);
    }];
    [self checkCompletionBlockCodeInvoked];
    
}

@end
