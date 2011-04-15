#import "CalendarViewDelegate.h"

@class GridView, CalendarButton;

@interface CalendarView : UIView {
    id<CalendarViewDelegate> delegate;
    IBOutlet GridView *gridView;
    IBOutlet UIButton *previousButton;
    IBOutlet UIButton *nextButton;
    IBOutlet UILabel *monthLabel;
}

@property (nonatomic, assign) int selectedMonth;
@property (nonatomic, assign) int selectedYear;
@property (nonatomic, assign) id<CalendarViewDelegate> delegate;
@property (nonatomic, assign) CalendarButton *calendarButtonSelected;

@end
