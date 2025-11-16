//
//  MSCollectionRequestTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/1/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphTestCase.h"
@interface MSCollectionRequestTests : MSGraphTestCase
@property (nonatomic,retain) NSArray *values;
@end

@implementation MSCollectionRequestTests

- (void)setUp {
    [super setUp];
    NSDictionary *firstObject = @{@"foo" : @"Bar" };
    NSDictionary *secondObject = @{@"baz" : @"qux" };
    self.values = @[firstObject, secondObject];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testMSCollectionRequest{
    MSCollectionRequest *collectionRequest = [[MSCollectionRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(collectionRequest);
    

    NSDictionary *responseObject = @{ MSCollectionValueKey :_values, MSODataNextContext : @"foo" };
    
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] response:OKresponse error:nil];
    
    MSURLSessionDataTask *dataTask = [collectionRequest collectionTaskWithRequest:self.requestForMock odObjectWithDictionary:^id(NSDictionary *response) {
        [self castBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertTrue([_values containsObject:response]);
        return @[response];
        
    } completion:^(MSCollection *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertNil(error);
        XCTAssertNotNil(response.value);
        XCTAssertEqual([response.value count], _values.count);
        [response.value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
            XCTAssertTrue([obj isKindOfClass:[NSArray class]]);
            XCTAssertEqual([obj count], 1);
            XCTAssertTrue([_values containsObject:obj[0]]);
        }];
        
        XCTAssertEqualObjects([response.nextLink absoluteString], [responseObject objectForKey:MSODataNextContext]);
        XCTAssertEqualObjects(response.additionalData, responseObject);
        
    }];
    [dataTask taskWithRequest:self.requestForMock];
    [self checkCastAndCompletionBlockCodeInvoked];
    
}
- (void)testMSCollectionRequestWithNilResponse{
    MSCollectionRequest *collectionRequest = [[MSCollectionRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];

    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:nil error:nil];
    
    MSURLSessionDataTask *dataTask = [collectionRequest collectionTaskWithRequest:self.requestForMock odObjectWithDictionary:^MSObject *(NSDictionary *response) {
        // This should never get called if the response was nil
        XCTAssert(NO);
    } completion:^(MSCollection *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNil(error);
    }];
    
    [dataTask taskWithRequest:self.requestForMock];
    [self checkCompletionBlockCodeInvoked];
    
}
- (void)testMSCollectionRequestWithBadResponse{
   NSHTTPURLResponse *Badresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSClientErrorCodeBadRequest HTTPVersion:@"foo" headerFields:nil];
    MSCollectionRequest *collectionRequest = [[MSCollectionRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    
    [self dataTaskCompletionWithRequest:self.requestForMock data:nil response:Badresponse error:nil];
    
    MSURLSessionDataTask *dataTask = [collectionRequest collectionTaskWithRequest:self.requestForMock odObjectWithDictionary:^MSObject *(NSDictionary *response) {
        // This should never get called if the response was nil
        XCTAssert(NO);
    } completion:^(MSCollection *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, MSClientErrorCodeBadRequest);
    }];
    
    [dataTask taskWithRequest:self.requestForMock];
    [self checkCompletionBlockCodeInvoked];
}

-(void)testMSCollectionRequestWithNilOdObject{
    MSCollectionRequest *collectionRequest = [[MSCollectionRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    XCTAssertNotNil(collectionRequest);

    NSDictionary *responseObject = @{ MSCollectionValueKey : _values, MSODataNextContext : @"foo" };
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] response:OKresponse error:nil];
    
    MSURLSessionDataTask *dataTask = [collectionRequest collectionTaskWithRequest:self.requestForMock odObjectWithDictionary:^id (NSDictionary *response) {
        [self castBlockCodeInvoked];
        XCTAssertNotNil(response);
        XCTAssertTrue([_values containsObject:response]);
        if([response.allKeys  containsObject:@"foo"]){
            return nil;
        }
        else{
            return @[response];
        }
    } completion:^(MSCollection *response, NSError *error) {
        [self completionBlockCodeInvoked];
        XCTAssertNil(response);
        XCTAssertNil(error);
    }];
    [dataTask taskWithRequest:self.requestForMock];
    [self checkCastAndCompletionBlockCodeInvoked];
}

-(void)testMSCollectionRequestWithEmptyValue{
    MSCollectionRequest *collectionRequest = [[MSCollectionRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    NSDictionary *responseObject = @{ MSCollectionValueKey : @[], MSODataNextContext : @"foo" };
    
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] response:OKresponse error:nil];
    
    MSURLSessionDataTask *dataTask = [collectionRequest collectionTaskWithRequest:self.requestForMock odObjectWithDictionary:^MSObject *(NSDictionary *response) {
        XCTAssert(NO);
        return nil;
        }
     completion:^(MSCollection *response, NSError *error) {
         [self completionBlockCodeInvoked];
        XCTAssertNotNil(response);
         XCTAssertNotNil(response.value);
         XCTAssertEqual(response.value.count,0);
        XCTAssertNil(error);
    }];
    [dataTask taskWithRequest:self.requestForMock];
    [self checkCompletionBlockCodeInvoked];
    
}
-(void)testMSCollectionRequestWithNilNextLink{
    MSCollectionRequest *collectionRequest = [[MSCollectionRequest alloc] initWithURL:self.testBaseURL client:self.mockClient];
    NSDictionary *responseObject = @{ MSCollectionValueKey : _values};
    
    NSHTTPURLResponse *OKresponse = [[NSHTTPURLResponse alloc] initWithURL:self.testBaseURL statusCode:MSExpectedResponseCodesOK HTTPVersion:@"foo" headerFields:nil];
    [self dataTaskCompletionWithRequest:self.requestForMock data:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] response:OKresponse error:nil];
    
    MSURLSessionDataTask *dataTask = [collectionRequest collectionTaskWithRequest:self.requestForMock
                                                          odObjectWithDictionary:^id(NSDictionary *response) {
                                                              [self castBlockCodeInvoked];
                                                              return response;
                                                          }
                                                                      completion:^(MSCollection *response, NSError *error) {
                                                                          [self completionBlockCodeInvoked];
                                                                          XCTAssertNotNil(response);
                                                                          XCTAssertNotNil(response.value);
                                                                          XCTAssertNil(response.nextLink);
                                                                          XCTAssertNil(error);
                                                                      }];
    [dataTask taskWithRequest:self.requestForMock];
    [self checkCastAndCompletionBlockCodeInvoked];
}

@end
