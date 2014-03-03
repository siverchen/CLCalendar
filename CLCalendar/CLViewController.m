//
//  CLViewController.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLViewController.h"
#import "CLMonthView.h"
#import "CLDateManager.h"
#import "CLCalendarView.h"

@interface CLViewController ()

@end

@implementation CLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLCalendarView *calendarView = [[CLCalendarView alloc] initWithDate:[NSDate date] andFrame:self.view.bounds];
    [self.view addSubview:calendarView];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
