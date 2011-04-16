//
//  NSDate+DateInformation.h
//  MyCalendar
//
//  Created by Shaokun Wu on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

struct DateInformation {
    int day;
    int month;
    int year;
    
    int weekday;
    
    int minute;
    int hour;
    int second;
};
typedef struct DateInformation DateInformation;

@interface NSDate (DateInformation)


- (int)day;
- (int)year;

- (DateInformation) dateInformation;
- (DateInformation) dateInformationWithTimeZone:(NSTimeZone *)tz;
- (NSDate *) dateByAddingDays:(NSUInteger)days;

@end
