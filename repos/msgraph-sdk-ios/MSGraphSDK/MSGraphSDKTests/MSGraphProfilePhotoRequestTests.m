//
//  MSGraphProfilePhotoRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"


@interface MSGraphProfilePhotoRequest()
- (NSMutableURLRequest *)get;
- (NSMutableURLRequest *)update:(MSGraphProfilePhoto *)profilePhoto;
@end

@interface MSGraphProfilePhotoRequestTests : MSGraphTestCase
@property (nonatomic) NSURL *profilePhotoURL;
@property (nonatomic) MSGraphProfilePhotoRequest *profilePhotoRequest;
@property (nonatomic) NSHTTPURLResponse *OKresponse;
@end

//EntityRequest tests
@implementation MSGraphProfilePhotoRequestTests

- (void)setUp {
    [super setUp];
    self.profilePhotoURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/photo",self.graphUrl]];
    self.requestForMock = [[NSMutableURLRequest alloc] initWithURL:self.profilePhotoURL];
    self.OKresponse = [[NSHTTPURLResponse alloc] initWithURL:_profilePhotoURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    
    self.profilePhotoRequest = [[MSGraphProfilePhotoRequest alloc] initWithURL:_profilePhotoURL client:self.mockClient];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testMSGraphProfilePhotoRequestSelect {
    MSGraphProfilePhotoRequest *profilePhotoRequest = [_profilePhotoRequest select:@"width"];
    NSString *expectedUrl = [NSString stringWithFormat:@"%@?$select=width",[self.profilePhotoURL absoluteString]];
    NSMutableURLRequest * nsrequest = [profilePhotoRequest get];
    XCTAssertEqualObjects(nsrequest.URL, [NSURL URLWithString:expectedUrl]);
}
- (void)testMSGraphProfilePhotoRequestExpand {
    MSGraphProfilePhotoRequest *profilePhotoRequest = [_profilePhotoRequest expand:@"value"];
    NSString *expectedUrl = [NSString stringWithFormat:@"%@?$expand=value",[self.profilePhotoURL absoluteString]];
    NSMutableURLRequest * nsrequest = [profilePhotoRequest get];
    XCTAssertEqualObjects(nsrequest.URL, [NSURL URLWithString:expectedUrl]);
}


- (void)testMSGraphProfilePhotoRequestGetWithOKCompletion {
    NSDictionary *demoDict = @{@"@odata.context": @"https://graph.microsoft.com/v1.0/$metadata#users('8f98666a-8888-6666-5555-fa1204dec445')/photo/$entity", @"@odata.mediaContentType": @"image/jpeg", @"@odata.mediaEtag": @"\"86124EBD\"", @"id": @"648X648", @"height": @648, @"width": @648};
    NSData *demoData = [NSJSONSerialization dataWithJSONObject:demoDict options:0 error:nil];
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:demoData response:_OKresponse error:nil];
    MSURLSessionDataTask *task = [_profilePhotoRequest getWithCompletion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqualObjects(response.entityId, demoDict[@"id"]);
        XCTAssertEqual(response.width, [demoDict[@"width"] intValue]);
        XCTAssertEqual(response.height, [demoDict[@"height"] intValue]);
    }];
    [self checkRequest:task Method:@"GET" URL:self.profilePhotoURL];
    [self checkCompletionBlockCodeInvoked];
}

- (void)testMSGraphProfilePhotoRequestGetWithErrorCompletion {
    NSHTTPURLResponse *Response401 = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSClientErrorCodeUnauthorized HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:Response401 error:nil];
    
    [_profilePhotoRequest getWithCompletion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertEqual(error.code, (NSInteger)MSClientErrorCodeUnauthorized);
        XCTAssertEqualObjects(error.domain, MSErrorDomain);
        
    }];
    [self checkCompletionBlockCodeInvoked];
}

- (void)testMSGraphProfilePhotoRequestUpdateWithOKCompletion {
    NSDictionary *demoDict = @{@"id": @"200X400", @"height": @400, @"width": @200};
    MSGraphProfilePhoto *profilePhoto = [[MSGraphProfilePhoto alloc] initWithDictionary:demoDict];
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:demoDict options:0 error:nil];

    [self dataTaskCompletionWithRequest:self.requestForMock data:responseData response:_OKresponse error:nil];
    
    MSURLSessionDataTask *task = [_profilePhotoRequest update:profilePhoto withCompletion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
        XCTAssertNotNil(response);
        XCTAssertEqual(response.width, profilePhoto.width);
        XCTAssertEqual(response.height, profilePhoto.height);
        
    }];
    [self checkRequest:task Method:@"PATCH" URL:self.profilePhotoURL];
    [self checkCompletionBlockCodeInvoked];
    
}
- (void)testMSGraphProfilePhotoRequestUpdateWithErrorCompletion {
    NSDictionary *demoDict = @{@"id": @"200X400", @"height": @400, @"width": @200};
    MSGraphProfilePhoto *profilePhoto = [[MSGraphProfilePhoto alloc] initWithDictionary:demoDict];
    NSHTTPURLResponse *Response500 = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSClientErrorCodeInternalServerError HTTPVersion:@"foo" headerFields:nil];
    
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:Response500 error:nil];
    
    MSURLSessionDataTask *task = [_profilePhotoRequest update:profilePhoto withCompletion:^(MSGraphProfilePhoto *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertEqual(error.code, (NSInteger)MSClientErrorCodeInternalServerError);
        XCTAssertEqualObjects(error.domain, MSErrorDomain);
        
    }];
    [self checkRequest:task Method:@"PATCH" URL:self.profilePhotoURL];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testMSGraphProfilePhotoRequestDeleteWithOKCompletion {
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:_OKresponse error:nil];
    
    MSURLSessionDataTask *task = [_profilePhotoRequest deleteWithCompletion:^(NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(error);
    }];
    [self checkRequest:task Method:@"DELETE" URL:self.profilePhotoURL];
    [self checkCompletionBlockCodeInvoked];
}

- (void)testMSGraphProfilePhotoRequestDeleteWithErrorCompletion {
    NSHTTPURLResponse *response403= [[NSHTTPURLResponse alloc] initWithURL:self.profilePhotoURL statusCode:MSClientErrorCodeForbidden HTTPVersion:@"foo" headerFields:nil];
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:response403 error:nil];
    MSURLSessionDataTask *task = [_profilePhotoRequest deleteWithCompletion:^(NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertEqual(error.code, (NSInteger)MSClientErrorCodeForbidden);
        XCTAssertEqualObjects(error.domain, MSErrorDomain);
    }];
    [self checkRequest:task Method:@"DELETE" URL:self.profilePhotoURL];
    [self checkCompletionBlockCodeInvoked];
}

@end
