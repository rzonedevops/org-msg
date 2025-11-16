//
//  MSLoggerTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/15/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSLogger.h"
#import "OCMock.h"

@interface MSLoggerTests : XCTestCase
@property(nonatomic, retain) MSLogger * mockLogger;
@end

@implementation MSLoggerTests

- (void)setUp {
    [super setUp];
    self.mockLogger = OCMPartialMock([[MSLogger alloc] initWithLogLevel:MSLogLevelLogError]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithLogLevelWithNoLevel {
    MSLogger *mslogger = [[MSLogger alloc] init];
    XCTAssertEqual(mslogger.logLevel, 0);
}
- (void)testInitWithLogLevelWithLevel {
    MSLogger *mslogger = [[MSLogger alloc] initWithLogLevel:MSLogLevelLogError];
    XCTAssertEqual(mslogger.logLevel, MSLogLevelLogError);
    
    mslogger = [[MSLogger alloc] initWithLogLevel:MSLogLevelLogWarn];
    XCTAssertEqual(mslogger.logLevel, MSLogLevelLogWarn);
    
    mslogger = [[MSLogger alloc] initWithLogLevel:MSLogLevelLogInfo];
    XCTAssertEqual(mslogger.logLevel, MSLogLevelLogInfo);
    
    mslogger = [[MSLogger alloc] initWithLogLevel:MSLogLevelLogDebug];
    XCTAssertEqual(mslogger.logLevel, MSLogLevelLogDebug);
    
    //unkown level
    mslogger = [[MSLogger alloc] initWithLogLevel:5];
    XCTAssertEqual(mslogger.logLevel, 5);
}
-(void)testMSLoggerDelegateWithLogError{
    [self assertWriteMessage:@"Graph SDK ERROR : test logger" LogLevel:MSLogLevelLogError formatter:@"test logger"];
}
-(void)testMSLoggerDelegateWithLogWarn{
    [self assertWriteMessage:@"Graph SDK WARNING : test logger" LogLevel:MSLogLevelLogWarn formatter:@"test logger"];
}
-(void)testMSLoggerDelegateWithLogInfo{
    [self assertWriteMessage:@"Graph SDK INFO : test logger" LogLevel:MSLogLevelLogInfo formatter:@"test logger"];
}
-(void)testMSLoggerDelegateWithLogDebug{
    [self assertWriteMessage:@"Graph SDK DEBUG : test logger" LogLevel:MSLogLevelLogDebug formatter:@"test logger"];
}
-(void)testMSLoggerDelegateWithLogVerbose{
    [self assertWriteMessage:@"Graph SDK VERBOSE : test logger" LogLevel:MSLogLevelLogVerbose formatter:@"test logger"];
}
-(void)testMSLoggerDelegateWithLogUnknown{
    [self assertWriteMessage:@"Graph SDK 100 : test logger" LogLevel:100 formatter:@"test logger"];
}
-(void)testMSLoggerDelegateWithNilFormatter{
    id<MSLogger> msloggerDelegate = [[MSLogger alloc] initWithLogLevel:MSLogLevelLogError];
    [msloggerDelegate setLogLevel:MSLogLevelLogInfo];
    NSString *message = nil;
    [self getWriteMessage:&message];
    [msloggerDelegate logWithLevel:MSLogLevelLogError message:nil];
    XCTAssertNil(message);
}
-(void)assertWriteMessage:(NSString *)expectedMessage LogLevel:(MSLogLevel)level formatter:(NSString *)formatter{
    
    NSString *logLevel = nil;
    switch (level) {
        case MSLogLevelLogError:
            logLevel = @"ERROR :";
            break;
        case MSLogLevelLogWarn:
            logLevel = @"WARNING :";
            break;
        case MSLogLevelLogInfo:
            logLevel = @"INFO :";
            break;
        case MSLogLevelLogDebug:
            logLevel = @"DEBUG : ";
            break;
        case MSLogLevelLogVerbose:
            logLevel = @"VERBOSE :";
            break;
        default:
            break;
    }
    NSString *message = nil;
    [self getWriteMessage:&message];
    [self.mockLogger setLogLevel:level];
    [self.mockLogger logWithLevel:level message:formatter];
    NSString *expectedstring =[NSString stringWithFormat:@"Graph SDK %@ %@",logLevel, formatter];
    XCTAssertEqualObjects(message, expectedstring);
}
-(void)getWriteMessage:(NSString * __strong *)message{
    OCMStub([self.mockLogger writeMessage:[OCMArg any]]).andDo(^(NSInvocation *invocation){
        NSString *receivedMessage = nil;
        [invocation getArgument:&receivedMessage atIndex:2];
        *message = receivedMessage;
    });
}
@end
