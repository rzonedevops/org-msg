//
//  MSGraphClientConfiguration+DefaultConfigurationTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphSDK.h"
#import "OCMock.h"


@interface MSGraphClientConfiguration_DefaultConfigurationTests : XCTestCase

@end

@implementation MSGraphClientConfiguration_DefaultConfigurationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDefaultConfiguration{
    MSGraphClientConfiguration * msgraphClientConfiguration = [MSGraphClientConfiguration defaultConfiguration];
    XCTAssertNotNil(msgraphClientConfiguration);
    
    XCTAssertTrue([msgraphClientConfiguration.httpProvider isKindOfClass:[MSURLSessionManager class]]);
    XCTAssertTrue([msgraphClientConfiguration.logger isKindOfClass:[MSLogger class]]);
    MSLogger *logger = msgraphClientConfiguration.logger;
    XCTAssertEqual(logger.logLevel, MSLogLevelLogError);
    
    NSString *expectedApiEndpoint = [NSString stringWithFormat:@"%@/%@", MSGraphApiEndpoint, MSGraphApiVersion];
    XCTAssertEqualObjects(msgraphClientConfiguration.apiEndpoint , expectedApiEndpoint);
}


@end
