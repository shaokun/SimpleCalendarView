//
//  MyCalendarViewController.h
//  MyCalendar
//
//  Created by Shaokun Wu on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"

@interface MyCalendarViewController : UIViewController <CalendarViewDelegate> {
    CalendarView *calendarView;
    IBOutlet UILabel *selectedDateLabel;
    IBOutlet UILabel *selectedYearLabel;
}

@end
