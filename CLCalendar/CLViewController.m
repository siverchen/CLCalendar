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
#import "NSDate+Extern.h"

@interface CLViewController () {
    CLCalendarView *calendarView;
}

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

- (void)ShowChinese:(UISwitch *)s{
    [calendarView setShowChinese:s.on];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    calendarView = [[CLCalendarView alloc] initWithDate:[NSDate date] andFrame:self.view.bounds];
    [self.view addSubview:calendarView];
    
    
    
//    [calendarView selectDate:(CLDate){2014,4,19}];
    
    NSLog(@"%@", NSStringFromCLDate(calendarView.current));
    
    UILabel *control = [[UILabel alloc] initWithFrame:(CGRect){CGPointZero,{100, 50}}];
    [control setTextAlignment:NSTextAlignmentCenter];
    [control setText:@"显示农历"];
    
    [self.view addSubview:control];
    
    
    UISwitch *s = [[UISwitch alloc] init];
    [s addTarget:self action:@selector(ShowChinese:) forControlEvents:UIControlEventValueChanged];
    s.center = (CGPoint){160, 500};
    
    [control setCenter:(CGPoint){160, 475}];
    
    [self.view addSubview:s];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
