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
    if (s.tag == 2){
        [calendarView setShowChinese:s.on];
    }else{
        [calendarView setShowFestival:s.on];
    }
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
    s.center = (CGPoint){80, 510};
    [s setTag:2];
    
    [control setCenter:(CGPoint){80, 485}];
    
    [self.view addSubview:s];
    
    
    
    
    UILabel *control1 = [[UILabel alloc] initWithFrame:(CGRect){CGPointZero,{100, 50}}];
    [control1 setTextAlignment:NSTextAlignmentCenter];
    [control1 setText:@"显示节日"];
    
    [self.view addSubview:control1];
    
    
    UISwitch *st = [[UISwitch alloc] init];
    [st addTarget:self action:@selector(ShowChinese:) forControlEvents:UIControlEventValueChanged];
    st.center = (CGPoint){240, 510};
    [st setTag:1];
    
    [control1 setCenter:(CGPoint){240, 485}];
    
    [self.view addSubview:st];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
