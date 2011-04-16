//
//  MyCalendarViewController.m
//  MyCalendar
//
//  Created by Shaokun Wu on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCalendarViewController.h"

@implementation MyCalendarViewController

- (void)calendarViewDateSelected:(CalendarView *)calendarView date:(NSDate *)date {
    selectedDateLabel.text = [NSString stringWithFormat:@"%@", date];
//    NSLog(@"%@", date);
}

- (void)dealloc
{
    [calendarView release];
    [selectedDateLabel release];
    [selectedYearLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"CalendarView" owner:nil options:nil];

    for (id currentObject in objects) {
        if ([currentObject isKindOfClass:[CalendarView class]]) {
            calendarView = (CalendarView *)currentObject;
            CGRect frame = calendarView.frame;
            frame.origin.y = 53;
            calendarView.frame = frame;
            calendarView.delegate = self;
            
            [calendarView addObserver:self forKeyPath:@"selectedMonth" options:NSKeyValueObservingOptionNew context:nil];

            [calendarView addObserver:self forKeyPath:@"selectedYear" options:NSKeyValueObservingOptionNew context:nil];
            break;
        }
    }

    [self.view addSubview:calendarView];
    
    selectedYearLabel.text = [NSString stringWithFormat:@"Year of %d", calendarView.selectedYear];

}

- (void)viewDidUnload
{
    [selectedDateLabel release];
    selectedDateLabel = nil;
    [selectedYearLabel release];
    selectedYearLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@", keyPath);
    selectedYearLabel.text = [NSString stringWithFormat:@"Year of %d", calendarView.selectedYear];
}

@end
