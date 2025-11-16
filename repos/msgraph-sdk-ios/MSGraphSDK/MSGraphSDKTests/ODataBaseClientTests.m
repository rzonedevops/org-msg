//
//  ODataBaseClientTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/2/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "MSGraphSDK.h"

@interface ODataBaseClientTests : XCTestCase

@end

@implementation ODataBaseClientTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testInit{
    id mockMSAuthenticationProvider = OCMProtocolMock(@protocol(MSAuthenticationProvider));
    id mockMSHttpProvider = OCMProtocolMock(@protocol(MSHttpProvider));
    NSString *url =@"https://foo.com/bar/baz";
    ODataBaseClient *client = [[ODataBaseClient alloc] initWithURL:url httpProvider:mockMSHttpProvider authenticationProvider:mockMSAuthenticationProvider];
    XCTAssertNotNil(client);
    XCTAssertEqualObjects([client.baseURL absoluteString], url);
    XCTAssertEqualObjects(client.httpProvider, mockMSHttpProvider);
    XCTAssertEqualObjects(client.authenticationProvider, mockMSAuthenticationProvider);
}
-(void)testInitNil{
    id mockMSAuthenticationProvider = OCMProtocolMock(@protocol(MSAuthenticationProvider));
    id mockMSHttpProvider = OCMProtocolMock(@protocol(MSHttpProvider));
    NSString *url =@"https://foo.com/bar/baz";
    
    ODataBaseClient *client = [[ODataBaseClient alloc] initWithURL:nil httpProvider:mockMSHttpProvider authenticationProvider:mockMSAuthenticationProvider];
    XCTAssertNotNil(client);
    XCTAssertNil(client.baseURL);
    
    client = [[ODataBaseClient alloc] initWithURL:url httpProvider:nil authenticationProvider:mockMSAuthenticationProvider];
    XCTAssertNotNil(client);
    XCTAssertNil(client.httpProvider);
    
    client = [[ODataBaseClient alloc] initWithURL:url httpProvider:mockMSHttpProvider authenticationProvider:nil];
    XCTAssertNotNil(client);
    XCTAssertNil(client.authenticationProvider);
}
@end
