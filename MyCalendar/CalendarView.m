#import "CalendarView.h"
#import "CalendarButton.h"
#import "GridView.h"
#import "NSDate+DateInformation.h"

@implementation CalendarView

@synthesize delegate, calendarButtonSelected, selectedMonth, selectedYear;

- (void)setSelectedMonth:(int)month {
    selectedMonth = month;
    monthLabel.text = [NSString stringWithFormat:@"%d", month];
}

//- (int)monthOfDate:(NSDate *)date {
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
//    NSCalendar *calendar = [NSCalendar currentCalendar];
// 
//    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
//    
//    return [comps month];
//}
//
//- (int)yearOfDate:(NSDate *)date {
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
//    NSCalendar *calendar = [NSCalendar currentCalendar];
// 
//    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
//    
//    return [comps year];
//}

- (void)updateButtons {
    for (UIView *subview in gridView.subviews) {
        [subview removeFromSuperview];
    }
    self.calendarButtonSelected = nil;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    
    int month = self.selectedMonth;
    int year = self.selectedYear;
    
    comps.day = 1;
    comps.year = year;
    comps.month = month;
    
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit
        inUnit:NSMonthCalendarUnit
        forDate:[cal dateFromComponents:comps]];
    
    NSDate *firstDate = [cal dateFromComponents:comps];
    
    [comps setDay:range.length];
    NSDate *lastDate = [cal dateFromComponents:comps];
    
    NSDate *previousDate = [firstDate dateByAddingTimeInterval:-24 * 60 * 60];
    NSDate *nextDate = [lastDate dateByAddingTimeInterval:24 * 60 * 60];
    NSRange lastRange = [cal rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:previousDate];
    
    NSArray *titles = [NSArray arrayWithObjects:
        NSLocalizedString(@"一", nil),
        NSLocalizedString(@"二", nil),
        NSLocalizedString(@"三", nil),
        NSLocalizedString(@"四", nil),
        NSLocalizedString(@"五", nil),
        NSLocalizedString(@"六", nil),
        NSLocalizedString(@"日", nil), nil];
    
    for (NSString *title in titles) {
        UILabel *label = [[UILabel new] autorelease];
        label.text = title;
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12.0];
//        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"datecell.png"]];
        label.alpha = 0.8;
        
        [gridView addSubview:label];
    }
    
    int weekday = [firstDate dateInformation].weekday;
    NSCalendar *gregorian = [[NSCalendar alloc]
        initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDate];
//    int weekday = [weekdayComponents weekday];
    
    if (weekday == 1) weekday = 8;
    int lastDay = lastRange.length - (weekday - 2) + 1;
    
    NSDate *date;
    
    for (int d = 0; d < (weekday - 2); d++) {
        comps.day = lastDay++;
        comps.month = [previousDate dateInformation].month;
        comps.year = [previousDate year];
        date = [gregorian dateFromComponents:comps];
        CalendarButton *button = [CalendarButton createCalendarButton:date gray:YES];
        [button addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];

        [gridView addSubview:button];
    }
    
    for (int d = 0; d < range.length; d++) {
        date = [firstDate dateByAddingDays:d];
//        comps.day = d + 1;
//        comps.month = month;
//        comps.year = year;
//        date = [gregorian dateFromComponents:comps];
        
        CalendarButton *button = [CalendarButton createCalendarButton:date gray:NO];
        [button addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [gridView addSubview:button];
    }
    
    int n = 49 - gridView.subviews.count;
    for (int d = 0; d < n; d++) {
        comps.day = d + 1;
        comps.month = [nextDate dateInformation].month;
        comps.year = [nextDate dateInformation].year;
        date = [gregorian dateFromComponents:comps];
        
        CalendarButton *button = [CalendarButton createCalendarButton:date gray:YES];
        [button addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        [gridView addSubview:button];
    }
    
    [gregorian release];
}

- (void)awakeFromNib {
    gridView.cols = 7;
    gridView.width = gridView.frame.size.width / 7;
    gridView.margin = 0;
    
    NSDate *now = [NSDate date];
    int month = [now dateInformation].month;
    int year = [now dateInformation].year;

    self.selectedYear = year;
    self.selectedMonth = month;
    
    [self updateButtons];
}

- (IBAction)selectPreviousMonth:(id)sender {
    int month = self.selectedMonth - 1;
    
    if (month > 0) {
        self.selectedMonth = month;
    } else {
        self.selectedMonth = 12;
        self.selectedYear = self.selectedYear - 1;
    }
    
    [self updateButtons];
}

- (IBAction)selectNextMonth:(id)sender {
    int month = self.selectedMonth + 1;
    
    if (month <= 12) {
        self.selectedMonth = month;
    } else {
        self.selectedMonth = 1;
        self.selectedYear = self.selectedYear + 1;
    }
    
    [self updateButtons];
}

- (void)dateSelected:(CalendarButton *)button {
    self.calendarButtonSelected.selected = NO;
    
    button.selected = YES;
    
    NSDate *date = button.date;
    [self.delegate calendarViewDateSelected:self date:date];
    
    self.calendarButtonSelected = button;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    [previousButton release];
    [nextButton release];
    [gridView release];
    [monthLabel release];
    [super dealloc];
}

@end
