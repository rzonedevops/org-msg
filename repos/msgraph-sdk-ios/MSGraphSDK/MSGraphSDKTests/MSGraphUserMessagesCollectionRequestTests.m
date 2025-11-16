//
//  MSGraphUserMessagesCollectionRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/8/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"
@interface MSGraphUserMessagesCollectionRequestTests : MSGraphTestCase
@property (nonatomic, retain) NSURL *messageCollectionRequestURL;
@property (nonatomic,retain) NSData *responseData;
@property (nonatomic,retain) MSCollection *expectedCollection;
@property (nonatomic,retain) MSGraphUserMessagesCollectionRequest *request;
@end
//CollectionRequest test
@implementation MSGraphUserMessagesCollectionRequestTests

- (void)setUp {
    [super setUp];
    self.messageCollectionRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/messages",self.graphUrl]];
    self.requestForMock = [[NSMutableURLRequest alloc] initWithURL:_messageCollectionRequestURL];
    
    NSDictionary * messagesDict = @{@"@odata.context": @"https://graph.microsoft.com/v1.0/$metadata#users('me')/messages(id,subject)",
                          @"@odata.nextLink": @"https://graph.microsoft.com/v1.0/users/me/messages?$select=id,subject&$top=2&$skip=172",
                          @"value":@[@{@"@odata.etag": @"W/\"CQAAABYAAADSgdiHnD3UTZ/LhQEVoM4pAADNaIGn\"",
                                       @"id": @"AAMkADdhZTdhZjgxLTQzNDMtNGY5ZS04MDlkLThkM2E4N2Q4ZGE5MwBGAAAAAACXEUYc36v1RKhxupm0C73VBwDSgdiHnD3UTZ-LhQEVoM4pAAAAAAEMAADSgdiHnD3UTZ-LhQEVoM4pAADNWLEhAAA=",
                              @"subject": @"Welcome to the test.onmicrosoft.com network on Yammer"
                          },
                        @{
                            @"@odata.etag": @"W/\"CQAAABYAAADSgdiHnD3UTZ/LhQEVoM4pAADNaIIC\"",
                            @"id": @"AAMkADdhZTdhZjgxLTQzNDMtNGY5ZS04MDlkLThkM2E4N2Q4ZGE5MwBGAAAAAACXEUYc36v1RKhxupm0C73VBwDSgdiHnD3UTZ-LhQEVoM4pAAAAAAEMAADSgdiHnD3UTZ-LhQEVoM4pAADJfmleAAA=",
                            @"subject": @"View your Office 365 Business Essentials (Month to Month) billing statement"
                         }
                       ]
                          };
    self.expectedCollection = [[MSCollection alloc] initWithArray:messagesDict[@"value"] nextLink:messagesDict[@"@odata.nextLink"] additionalData:nil];
    self.responseData = [NSJSONSerialization dataWithJSONObject:messagesDict options:0 error:nil];
    
    self.request = [[MSGraphUserMessagesCollectionRequest alloc] initWithURL:_messageCollectionRequestURL client:self.mockClient];
    [self setAuthProvider:self.mockAuthProvider appendHeaderResponseWith:self.requestForMock error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMSGraphUserMessagesCollectionRequestInit {
    XCTAssertNotNil(_request);
    XCTAssertEqualObjects(_request.requestURL, _messageCollectionRequestURL);
    XCTAssertEqualObjects(_request.client, self.mockClient);
}
- (void)testGetWithCompletionOK {
    MSGraphUserMessagesCollectionRequest *request = [[_request select:@"id,subject"] top:2];
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:_messageCollectionRequestURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:_responseData response:OKresponse error:nil];
    
    MSURLSessionDataTask *task = [request getWithCompletion:^(MSCollection *response, MSGraphUserMessagesCollectionRequest *nextRequest, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertEqual([response.value count], _expectedCollection.value.count);
        [response.value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for(NSDictionary * message in _expectedCollection.value){
                if([((MSGraphMessage *)obj).entityId isEqualToString:message[@"id"]]){
                    XCTAssertEqualObjects(((MSGraphMessage *)obj).subject, message[@"subject"]);
                    break;
                }
            }
        }];
        XCTAssertEqualObjects(nextRequest.requestURL, _expectedCollection.nextLink);
        XCTAssertEqualObjects(nextRequest.client, self.mockClient);
        XCTAssertNil(error);
    }];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/messages?$select=id,subject&$top=2",self.graphUrl]];
    [self checkRequest:task Method:@"GET" URL:expectedURL];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testGetWithCompletion401Response {
    MSGraphUserMessagesCollectionRequest *request = [[_request select:@"id,subject"] top:2];
    NSHTTPURLResponse *Response401 = [[NSHTTPURLResponse alloc] initWithURL:_messageCollectionRequestURL statusCode:MSClientErrorCodeUnauthorized HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:Response401 error:nil];
    
    MSURLSessionDataTask *task = [request getWithCompletion:^(MSCollection *response, MSGraphUserMessagesCollectionRequest *nextRequest, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNil(nextRequest);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeUnauthorized);
        XCTAssertEqualObjects(error.domain, MSErrorDomain);
    }];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/messages?$select=id,subject&$top=2",self.graphUrl]];
    [self checkRequest:task Method:@"GET" URL:expectedURL];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testGetWithCompletionClientError {
    NSError *testError = [NSError errorWithDomain:@"testError" code:123 userInfo:@{}];
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:nil error:testError];
    
    MSURLSessionDataTask *task = [_request getWithCompletion:^(MSCollection *response, MSGraphUserMessagesCollectionRequest *nextRequest, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNil(nextRequest);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, testError.code);
        XCTAssertEqualObjects(error.domain, testError.domain);
    }];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/messages",self.graphUrl]];
    [self checkRequest:task Method:@"GET" URL:expectedURL];
    [self checkCompletionBlockCodeInvoked];
}

- (void)testAddMessageOK {
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:_messageCollectionRequestURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    NSDictionary *postDict = @{@"subject":@"test message", @"body": @{@"contentType": @"text", @"content": @"test content"}, @"toRecipients": @[@{@"emailAddress": @{@"name":@"Tester User", @"address": @"tester@test.onmicrosoft.com"}}],@"isDraft": @false};
    MSGraphMessage *postMessage = [[MSGraphMessage alloc] initWithDictionary:postDict];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:nil];
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:postData response:OKresponse error:nil];
    
    MSGraphUserMessagesCollectionRequest * __weak weakRequest = _request;
    MSURLSessionDataTask *task = [weakRequest addMessage:postMessage withCompletion:^(MSGraphMessage *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertEqualObjects(response.subject, postMessage.subject);
        XCTAssertNil(error);
    }];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/messages",self.graphUrl]];
    [self checkRequest:task Method:@"POST" URL:expectedURL];
    [self checkCompletionBlockCodeInvoked];
}
- (void)testAddMessage401Response {
    NSHTTPURLResponse *Response401 = [[NSHTTPURLResponse alloc] initWithURL:_messageCollectionRequestURL statusCode:MSClientErrorCodeUnauthorized HTTPVersion:@"foo" headerFields:nil];
    NSDictionary *postDict = @{@"subject":@"test message", @"body": @{@"contentType": @"text", @"content": @"test content"}, @"toRecipients": @[@{@"emailAddress": @{@"name":@"Tester User", @"address": @"tester@test.onmicrosoft.com"}}],@"isDraft": @false};
    MSGraphMessage *postMessage = [[MSGraphMessage alloc] initWithDictionary:postDict];

    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:Response401 error:nil];
    
    MSGraphUserMessagesCollectionRequest * __weak weakRequest = _request;
    MSURLSessionDataTask *task = [weakRequest addMessage:postMessage withCompletion:^(MSGraphMessage *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeUnauthorized);
        XCTAssertEqualObjects(error.domain, MSErrorDomain);
    }];
    NSURL *expectedURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/me/messages",self.graphUrl]];
    [self checkRequest:task Method:@"POST" URL:expectedURL];
    [self checkCompletionBlockCodeInvoked];
}
@end
