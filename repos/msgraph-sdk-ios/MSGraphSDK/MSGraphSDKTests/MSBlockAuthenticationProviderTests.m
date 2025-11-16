//
//  MSBlockAuthenticationProviderTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/15/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"
#import "MSBlockAuthenticationProvider.h"

@interface MSBlockAuthenticationProvider ()
@property (nonatomic, copy) MSAuthenticationBlock authBlock;
@end

@interface MSBlockAuthenticationProviderTests : MSGraphTestCase
@property (nonatomic,retain) id <MSAuthenticationProvider> authenticationProvider;
@end

@implementation MSBlockAuthenticationProviderTests

- (void)setUp {
    [super setUp];
    self.authenticationProvider = nil;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSBlockAuthenticationProviderInit {
    MSAuthenticationBlock expectedProviderBlock = ^(NSMutableURLRequest *request, MSAuthenticationCompletion completion){
        
    };
    
    MSBlockAuthenticationProvider *authProvider = [MSBlockAuthenticationProvider providerWithBlock:expectedProviderBlock];
    XCTAssertNotNil(authProvider);
    XCTAssertEqualObjects(authProvider.authBlock, expectedProviderBlock);
}

-(void)testAppendAuthenticationHeadersDelegateOK{
    __block BOOL bComoletionBlockInvoked = NO, bAuthBlockInvoked = NO;
    
    NSURL *authRequestUrl = [NSURL URLWithString:@"https://foo/bar"];
    NSMutableURLRequest *authRequest = [[NSMutableURLRequest alloc] initWithURL:authRequestUrl];
    MSAuthenticationCompletion completionBlockCode = ^(NSMutableURLRequest *request, NSError *error){
        bComoletionBlockInvoked = YES;
        XCTAssertEqualObjects(request, authRequest);
        XCTAssertEqualObjects(request.allHTTPHeaderFields[@"Authorization"], @"bearer demoaccesstoken");
        XCTAssertNil(error);
    };
    

    MSBlockAuthenticationProvider *authProvider = [MSBlockAuthenticationProvider providerWithBlock:^(NSMutableURLRequest *request, MSAuthenticationCompletion completion) {
        bAuthBlockInvoked = YES;
        XCTAssertEqualObjects(request, authRequest);
        XCTAssertEqualObjects(request.URL, authRequestUrl);
        XCTAssertEqualObjects(completion, completionBlockCode);
        
        NSString *oauthAuthorizationHeader = [NSString stringWithFormat:@"bearer demoaccesstoken"];
        [request setValue:oauthAuthorizationHeader forHTTPHeaderField:@"Authorization"];
        completion(request,nil);
        
    }];
    
    self.authenticationProvider = authProvider;
    [self.authenticationProvider appendAuthenticationHeaders:authRequest completion:completionBlockCode];
    
    XCTAssertTrue(bAuthBlockInvoked,@"Auth block was not invoked");
    XCTAssertTrue(bComoletionBlockInvoked,@"Completion block was not invoked");
    
}
-(void)testAppendAuthenticationHeadersDelegateError{
     __block BOOL bComoletionBlockInvoked = NO, bAuthBlockInvoked = NO;
    NSURL *authRequestUrl = [NSURL URLWithString:@"https://foo/bar"];
    NSMutableURLRequest *authRequest = [[NSMutableURLRequest alloc] initWithURL:authRequestUrl];
    
    MSBlockAuthenticationProvider *authProvider = [MSBlockAuthenticationProvider providerWithBlock:^(NSMutableURLRequest *request, MSAuthenticationCompletion completion) {
        bComoletionBlockInvoked = YES;
        XCTAssertEqualObjects(request, authRequest);
        XCTAssertEqualObjects(request.URL, authRequestUrl);
        
        completion(nil,[NSError errorWithDomain:@"testError" code:123 userInfo:@{}]);
        
    }];
    
    self.authenticationProvider = authProvider;
    [self.authenticationProvider appendAuthenticationHeaders:authRequest completion:^(NSMutableURLRequest *request, NSError *error) {
        bAuthBlockInvoked = YES;
        XCTAssertNil(request);
        XCTAssertNotNil(authRequest);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 123);
        XCTAssertEqual(error.domain, @"testError");
    }];
    XCTAssertTrue(bAuthBlockInvoked,@"Auth block was not invoked");
    XCTAssertTrue(bComoletionBlockInvoked,@"Completion block was not invoked");
}
-(void)testAppendAuthenticationHeadersDelegateWithNilAuthBlockCode{
    XCTAssertThrows([MSBlockAuthenticationProvider providerWithBlock:nil]);
}
@end
