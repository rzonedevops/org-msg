//
//  MSGraphClient+BaseTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/6/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"

@interface MSGraphClient_BaseTests : MSGraphTestCase
@property MSGraphClientConfiguration * clientConfiguration;
@end

@implementation MSGraphClient_BaseTests

- (void)setUp {
    [super setUp];
    _clientConfiguration = [[MSGraphClientConfiguration alloc] init];
    _clientConfiguration.authenticationProvider = self.mockAuthProvider;
    _clientConfiguration.httpProvider = self.mockHttpProvider;
    _clientConfiguration.apiEndpoint = [self.testBaseURL absoluteString];
    _clientConfiguration.logger = OCMProtocolMock(@protocol(MSLogger));
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-(void)testClientWithConfig{
    MSGraphClient *msgraphClient = [MSGraphClient clientWithConfig:_clientConfiguration];
    XCTAssertEqualObjects(msgraphClient.baseURL, [NSURL URLWithString: _clientConfiguration.apiEndpoint]);
    XCTAssertEqualObjects(msgraphClient.httpProvider, _clientConfiguration.httpProvider);
    XCTAssertEqualObjects(msgraphClient.authenticationProvider, _clientConfiguration.authenticationProvider);
    XCTAssertEqualObjects(msgraphClient.logger, _clientConfiguration.logger);
}
-(void)testClientWithNilConfig{
    XCTAssertThrows([MSGraphClient clientWithConfig:nil]);
}
-(void)testClientWithNilApiEndpoint{
    _clientConfiguration.apiEndpoint = nil;
    XCTAssertThrows([MSGraphClient clientWithConfig:self.clientConfiguration]);
}
-(void)testClientWithNilHttpProvider{
    _clientConfiguration.httpProvider = nil;
    XCTAssertThrows([MSGraphClient clientWithConfig:self.clientConfiguration]);
}
-(void)testClientWithNilHttpAuthenticationProvider{
    _clientConfiguration.authenticationProvider = nil;
    XCTAssertThrows([MSGraphClient clientWithConfig:_clientConfiguration]);
}
-(void)testClientWithNilLog{
    _clientConfiguration.logger = nil;
    MSGraphClient *msgraphClient = [MSGraphClient clientWithConfig:_clientConfiguration];
    XCTAssertEqualObjects(msgraphClient.baseURL, [NSURL URLWithString: _clientConfiguration.apiEndpoint]);
    XCTAssertEqualObjects(msgraphClient.httpProvider, _clientConfiguration.httpProvider);
    XCTAssertEqualObjects(msgraphClient.authenticationProvider, _clientConfiguration.authenticationProvider);
    XCTAssertNil(msgraphClient.logger);
}
@end
