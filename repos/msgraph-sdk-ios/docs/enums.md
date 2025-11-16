# Enumerations in the Microsoft Graph SDK for iOs

## Boxed Types
Each Enumeration type is represented by a combination of a typical NS_ENUM definition and a boxed class.

For example, the 'DayOfWeek' enumeration has the following definitions:

```objc
typedef NS_ENUM(NSInteger, MSGraphDayOfWeekValue){

	MSGraphDayOfWeekSunday = 0,
	MSGraphDayOfWeekMonday = 1,
	MSGraphDayOfWeekTuesday = 2,
	MSGraphDayOfWeekWednesday = 3,
	MSGraphDayOfWeekThursday = 4,
	MSGraphDayOfWeekFriday = 5,
	MSGraphDayOfWeekSaturday = 6,
    MSGraphDayOfWeekEndOfEnum
};

@interface MSGraphDayOfWeek : NSObject

+(MSGraphDayOfWeek*) sunday;
+(MSGraphDayOfWeek*) monday;
+(MSGraphDayOfWeek*) tuesday;
+(MSGraphDayOfWeek*) wednesday;
+(MSGraphDayOfWeek*) thursday;
+(MSGraphDayOfWeek*) friday;
+(MSGraphDayOfWeek*) saturday;

+(MSGraphDayOfWeek*) UnknownEnumValue;

@property (nonatomic, readonly) MSGraphDayOfWeekValue enumValue;

@end
```

The class method defined for each enumeration value returns a singleton instance of the boxed class. As there is no public way to initialize a new instance of an enumeration boxed type, it is generally safe to perform comparison via equality, i.e. `myDayOfWeek == [MSGraphDayOfWeek tuesday]`.

Enumerations can be used in switch statements by using the `enumValue` property:

```objc
switch (myDayOfWeek.enumValue) {
    case MSGraphDayOfWeekSunday:
        // do something
        break;
    ...
    case MSGraphDayOfWeekSaturday:
        // do something
        break;

    default:
        // MSGraphDayOfWeekEndOfEnum, or other unknown enum value
        break;
}
```

## Unknown Enumeration Values

In the event that the service returns an enumeration value that is not recognized in the current version of the SDK it will deserialize to `[{MyEnumType} UnknownEnumValue]`, with a corresponding `.enumValue` of `{MyEnumType}EndOfEnum`.


## Collections of Enumerations
Enumerations are represented in collections by their boxed types. For example:
```objc
// Setting a collection property
MSGraphRecurrencePattern *recurrence = [[MSGraphRecurrencePattern alloc] init];
recurrence.daysOfWeek = @[[MSGraphDayOfWeek monday], [MSGraphDayOfWeek thursday], [MSGraphDayOfWeek friday]];

// Reading a collection property
for (MSGraphDayOfWeek *day in recurrence.daysOfWeek) {
    // Do something with day
}
```

