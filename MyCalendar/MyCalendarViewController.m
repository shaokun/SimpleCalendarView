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
    NSLog(@"%@", date);
}

- (void)dealloc
{
    [calendarView release];
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
            break;
        }
    }

    [self.view addSubview:calendarView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
