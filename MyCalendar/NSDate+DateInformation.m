//
//  NSDate+DateInformation.m
//  MyCalendar
//
//  Created by Shaokun Wu on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSDate+DateInformation.h"


@implementation NSDate (DateInformation)

- (int)day {
    return [self dateInformation].day;
}

- (int)month {
    return [self dateInformation].month;
}

- (int)year {
    return [self dateInformation].year;
}

- (DateInformation) dateInformation {
    return [self dateInformationWithTimeZone:[NSTimeZone systemTimeZone]];
}

- (DateInformation) dateInformationWithTimeZone:(NSTimeZone *)tz {
    DateInformation info;
	
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	[gregorian setTimeZone:tz];
	NSDateComponents *comp = [gregorian components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
        NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
        fromDate:self];
    
	info.day = [comp day];
	info.month = [comp month];
	info.year = [comp year];
	
	info.hour = [comp hour];
	info.minute = [comp minute];
	info.second = [comp second];
	
	info.weekday = [comp weekday];
	
	[gregorian release];
	return info;
}

- (NSDate *) dateByAddingDays:(NSUInteger)days {
	NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
	c.day = days;
	return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

@end