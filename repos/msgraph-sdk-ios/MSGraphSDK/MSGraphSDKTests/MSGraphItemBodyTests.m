//
//  MSGraphItemBodyTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/12/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphItemBody.h"

@interface MSGraphItemBodyTests : XCTestCase

@end
//complex type
@implementation MSGraphItemBodyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testDeserializeHtmlGraphItemBody{
    NSDictionary *htmlGraphItemBodyDict = @{@"contentType": @"html", @"content": @"<html>\r\n<div>\r\nHtml Body Test</div>\r\n</html>\r\n"};
    
    MSGraphItemBody * itembody = [[MSGraphItemBody alloc] initWithDictionary:htmlGraphItemBodyDict];
    XCTAssertEqual(itembody.contentType, [MSGraphBodyType html]);
    XCTAssertEqualObjects(itembody.content, htmlGraphItemBodyDict[@"content"]);
    
}
-(void)testDeserializeTextGraphItemBody{
    NSDictionary *htmlGraphItemBodyDict = @{@"contentType": @"text", @"content": @"Html Body Test"};
    
    MSGraphItemBody * itembody = [[MSGraphItemBody alloc] initWithDictionary:htmlGraphItemBodyDict];
    XCTAssertEqual(itembody.contentType, [MSGraphBodyType text]);
    XCTAssertEqualObjects(itembody.content, htmlGraphItemBodyDict[@"content"]);
    
}
-(void)testDeserializeUnknowGraphItemBody{
    NSDictionary *htmlGraphItemBodyDict = @{@"contentType": @"foo", @"content": @"Html Body Test"};
    
    MSGraphItemBody * itembody = [[MSGraphItemBody alloc] initWithDictionary:htmlGraphItemBodyDict];
    XCTAssertEqual(itembody.contentType, [MSGraphBodyType UnknownEnumValue]);
    XCTAssertEqualObjects(itembody.content, htmlGraphItemBodyDict[@"content"]);
    
}
-(void)testDeserializeInvalidGraphItemBody{
    NSDictionary *htmlGraphItemBodyDict = @{@"foo": @"bar", @"test": @"text"};
    
    MSGraphItemBody * itembody = [[MSGraphItemBody alloc] initWithDictionary:htmlGraphItemBodyDict];
    XCTAssertEqual(itembody.contentType, nil);
    XCTAssertEqualObjects(itembody.content, nil);
    
}
@end
