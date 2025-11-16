//
//  MSGraphClient+DefaultConfigurationTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
#import "OCMock.h"



@interface MSGraphClient_DefaultConfigurationTests : XCTestCase

@end

@implementation MSGraphClient_DefaultConfigurationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetAuthenticationProvider {
    MSGraphClientConfiguration * msgraphClientConfiguration = [MSGraphClientConfiguration defaultConfiguration];
    XCTAssertNil(msgraphClientConfiguration.authenticationProvider);
    id mockAuthenticationProvider = OCMProtocolMock(@protocol(MSAuthenticationProvider));
    
    //not nil
    [MSGraphClient setAuthenticationProvider:mockAuthenticationProvider];
    XCTAssertNotNil(msgraphClientConfiguration.authenticationProvider);
    XCTAssertEqualObjects([msgraphClientConfiguration authenticationProvider], mockAuthenticationProvider);
    
    //set nil
    XCTAssertNotNil(msgraphClientConfiguration.authenticationProvider);
    [MSGraphClient setAuthenticationProvider:nil];
    XCTAssertNil([msgraphClientConfiguration authenticationProvider]);
    
}
- (void)testSetHttpProvider {
    MSGraphClientConfiguration * msgraphClientConfiguration = [MSGraphClientConfiguration defaultConfiguration];
    XCTAssertNotNil(msgraphClientConfiguration.httpProvider);
    
    id mockMSHttpProvider = OCMProtocolMock(@protocol(MSHttpProvider));
    
    XCTAssertNotEqualObjects(msgraphClientConfiguration.httpProvider, mockMSHttpProvider);
    [MSGraphClient setHttpProvider:mockMSHttpProvider];
    XCTAssertNotNil(msgraphClientConfiguration.httpProvider);
    XCTAssertEqualObjects(msgraphClientConfiguration.httpProvider, mockMSHttpProvider);
    
    //nil test
    [MSGraphClient setHttpProvider:nil];
    XCTAssertNil(msgraphClientConfiguration.httpProvider);
    
}
- (void)testSetLogger {
    MSGraphClientConfiguration * msgraphClientConfiguration = [MSGraphClientConfiguration defaultConfiguration];
    XCTAssertNotNil(msgraphClientConfiguration.logger);
    
    id mockMSLogger = OCMProtocolMock(@protocol(MSLogger));
    
    [MSGraphClient setLogger:mockMSLogger];
    XCTAssertNotNil(msgraphClientConfiguration.logger);
    XCTAssertEqualObjects(msgraphClientConfiguration.logger, mockMSLogger);

    
    [MSGraphClient setLogger:nil];
    XCTAssertNil(msgraphClientConfiguration.logger);
    
}


-(void)testSetClient{
    id mockAuthenticationProvider = OCMProtocolMock(@protocol(MSAuthenticationProvider));
    MSLogger *logger = [[MSLogger alloc] init];
    id mockMSHttpProvider = OCMProtocolMock(@protocol(MSHttpProvider));
    
    [MSGraphClient setAuthenticationProvider:mockAuthenticationProvider];
    [MSGraphClient setLogger:logger];
    [MSGraphClient setHttpProvider:mockMSHttpProvider];
    [MSGraphClient setApiEndpoint:@"https://foo/bar"];
    
    MSGraphClient *client =[MSGraphClient client];
    XCTAssertNotNil(client);
    XCTAssertEqualObjects([client.baseURL absoluteString], @"https://foo/bar");
    XCTAssertEqualObjects(client.httpProvider, mockMSHttpProvider);
    XCTAssertEqualObjects(client.authenticationProvider, mockAuthenticationProvider);
    XCTAssertEqualObjects(client.logger, logger);
    
    [client setLogLevel:MSLogLevelLogDebug];
    MSLogger * loggerOut = client.logger;
    XCTAssertEqual(loggerOut.logLevel, MSLogLevelLogDebug);
    
    //restore
    [MSGraphClient setApiEndpoint:[NSString stringWithFormat:@"%@/%@",MSGraphApiEndpoint,MSGraphApiVersion]];
}
@end
