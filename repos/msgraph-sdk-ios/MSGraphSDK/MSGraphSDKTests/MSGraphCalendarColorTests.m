//
//  MSGraphCalendarColorTests.m
//  MSGraphSDK
//
//  Created by canviz on 6/12/16.
//  Copyright © 2016 Microsoft. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MSGraphCalendarColor.h"
#import "MSGraphCalendar.h"

@interface MSGraphCalendarColorTests : XCTestCase
@property (nonatomic,retain) NSDictionary *calendarDict;
@property (nonatomic,retain) MSGraphCalendar *calendar;
@end

@implementation MSGraphCalendarColorTests

- (void)setUp {
    [super setUp];
    self.calendarDict = @{@"id": @"demoCalendarId", @"name": @"Calendar", @"color": @"auto", @"changeKey": @"demoCalendarChangeKey"};
    self.calendar = [[MSGraphCalendar alloc] initWithDictionary:_calendarDict];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCalendarAutoColor {
    [self AssertCalendarColor:_calendar Color:@"auto"];
}
- (void)testCalendarlightBlueColor {
    [_calendar setColor:[MSGraphCalendarColor lightBlue]];
    [self AssertCalendarColor:_calendar Color:@"lightBlue"];
}
- (void)testCalendarlightGreenColor {
    [_calendar setColor:[MSGraphCalendarColor lightGreen]];
    [self AssertCalendarColor:_calendar Color:@"lightGreen"];
}
- (void)testCalendarlightOrangeColor {
    [_calendar setColor:[MSGraphCalendarColor lightOrange]];
    [self AssertCalendarColor:_calendar Color:@"lightOrange"];
}
- (void)testCalendarlightGrayColor {
    [_calendar setColor:[MSGraphCalendarColor lightGray]];
    [self AssertCalendarColor:_calendar Color:@"lightGray"];
}
- (void)testCalendarlightYellowColor {
    [_calendar setColor:[MSGraphCalendarColor lightYellow]];
    [self AssertCalendarColor:_calendar Color:@"lightYellow"];
}
- (void)testCalendarlightTealColor {
    [_calendar setColor:[MSGraphCalendarColor lightTeal]];
    [self AssertCalendarColor:_calendar Color:@"lightTeal"];
}
- (void)testCalendarlightPinkColor {
    [_calendar setColor:[MSGraphCalendarColor lightPink]];
    [self AssertCalendarColor:_calendar Color:@"lightPink"];
}
- (void)testCalendarlightBrownColor {
    [_calendar setColor:[MSGraphCalendarColor lightBrown]];
    [self AssertCalendarColor:_calendar Color:@"lightBrown"];
}
- (void)testCalendarlightRedColor {
    [_calendar setColor:[MSGraphCalendarColor lightRed]];
    [self AssertCalendarColor:_calendar Color:@"lightRed"];

}
- (void)testCalendarmaxColorColor {
    [_calendar setColor:[MSGraphCalendarColor maxColor]];
    [self AssertCalendarColor:_calendar Color:@"maxColor"];

}
- (void)testCalendarUnknownEnumValueColor {
    NSDictionary *calendarDict = @{@"id": @"demoCalendarId", @"name": @"Calendar", @"color": @"test", @"changeKey": @"demoCalendarChangeKey"};
    MSGraphCalendar *calendar = [[MSGraphCalendar alloc] initWithDictionary:calendarDict];
    XCTAssertEqual(calendar.color, [MSGraphCalendarColor UnknownEnumValue]);
    XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorEndOfEnum);
    XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor UnknownEnumValue]);
    XCTAssertNil([calendar.color ms_toString]);
}
-(void)AssertCalendarColor:(MSGraphCalendar *)calendar Color:(NSString*)color{
    if([color isEqualToString:@"lightBlue"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightBlue]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightBlue);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightBlue]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightBlue");
    }
    else if([color isEqualToString:@"lightGreen"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightGreen]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightGreen);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightGreen]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightGreen");
    }
    else if([color isEqualToString:@"lightOrange"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightOrange]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightOrange);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightOrange]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightOrange");
    }
    else if([color isEqualToString:@"lightGray"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightGray]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightGray);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightGray]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightGray");
    }
    else if([color isEqualToString:@"lightYellow"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightYellow]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightYellow);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightYellow]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightYellow");
    }
    else if([color isEqualToString:@"lightTeal"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightTeal]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightTeal);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightTeal]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightTeal");
    }
    else if([color isEqualToString:@"lightPink"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightPink]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightPink);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightPink]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightPink");
    }
    else if([color isEqualToString:@"lightBrown"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightBrown]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightBrown);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightBrown]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightBrown");
    }
    else if([color isEqualToString:@"lightRed"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor lightRed]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorLightRed);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor lightRed]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"lightRed");
    }
    else if([color isEqualToString:@"maxColor"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor maxColor]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorMaxColor);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor maxColor]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"maxColor");
    }
    else if([color isEqualToString:@"auto"])
    {
        XCTAssertEqual(calendar.color, [MSGraphCalendarColor auto]);
        XCTAssertEqual([calendar.color enumValue], MSGraphCalendarColorAuto);
        XCTAssertEqual([MSGraphCalendarColor calendarColorWithEnumValue:[calendar.color enumValue]], [MSGraphCalendarColor auto]);
        XCTAssertEqualObjects([calendar.color ms_toString], @"auto");
    }
    else {
        XCTAssertTrue(NO);
    }
}
@end
