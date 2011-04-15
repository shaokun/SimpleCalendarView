@interface CalendarButton : UIButton {
}

@property (nonatomic, retain) NSDate *date;

+ (CalendarButton *)createCalendarButton:(NSDate *)date gray:(BOOL)gray;

@end