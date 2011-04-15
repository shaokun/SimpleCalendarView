//
//  MyCalendarAppDelegate.h
//  MyCalendar
//
//  Created by Shaokun Wu on 4/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyCalendarViewController;

@interface MyCalendarAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MyCalendarViewController *viewController;

@end
