#import "CalendarButton.h"

@implementation CalendarButton

@synthesize date;


+ (CalendarButton *)createCalendarButton:(NSDate *)date gray:(BOOL)gray {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];

    CalendarButton *button = [CalendarButton buttonWithType:UIButtonTypeCustom];
    button.date = date;
    button.alpha = gray ? 0.7 : 0.8;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%d", [comps day]] forState:UIControlStateNormal];
//    [button setTitle:[NSString stringWithFormat:@"%d", [date dateInformation].day] forState:UIControlStateNormal];
    
    
    
    NSDate *today = [NSDate date];
    NSDateComponents *components = [calendar components:unitFlags fromDate:today];
    components.hour = 0;
    components.minute = 0;

    NSDate *todayMidnight = [calendar dateFromComponents:components];
    
    if ([date isEqualToDate:todayMidnight]) {
        [button setBackgroundImage:[UIImage imageNamed:@"today.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"todayselected.png"] forState:UIControlStateSelected];
    } else {
        [button setBackgroundImage:[UIImage imageNamed:@"datecell.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"datecellselected.png"] forState:UIControlStateSelected];
    }
    
    return button;
}

- (void)dealloc {
    [self.date release];
    [super dealloc];
}

@end
