@class CalendarView;

@protocol CalendarViewDelegate

- (void) calendarViewDateSelected:(CalendarView *)calendarView date:(NSDate *)date;

@end