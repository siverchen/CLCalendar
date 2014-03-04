//
//  CLCalanderView.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLCalendarView.h"
#import "CLCalendarHeaderView.h"
#import "CLConveyorView.h"
#import "CLMonthView.h"
#import "NSDate+Extern.h"
#import "CLDateManager.h"

@interface CLCalendarView () <CLConveyorViewDelegate> {
}

@property (nonatomic, strong) CLCalendarHeaderView *headerView;
@property (nonatomic, strong) CLConveyorView *conveyorView;

@end



@implementation CLCalendarView

@synthesize date = _date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}

- (id)initWithDate:(NSDate *)date andFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        CGRect headerFrame = (CGRect){{0, CL_HEADERVIEW_TOP}, {frame.size.width, CL_HEADERVIEW_HEIGHT}};
        self.headerView = [[CLCalendarHeaderView alloc] initWithDate:date andFrame:headerFrame];
        [self addSubview:_headerView];
        
        
        CGRect bodyFrame = (CGRect){{0, CL_HEADERVIEW_HEIGHT + CL_HEADERVIEW_TOP}, {frame.size.width, frame.size.height - CL_HEADERVIEW_HEIGHT - CL_HEADERVIEW_TOP}};
        self.conveyorView = [[CLConveyorView alloc] initWithDate:date andFrame:bodyFrame];
        [self.conveyorView setDelegate:self];
        [self addSubview:_conveyorView];
        
        _date = date;
        
    }
    return self;
}

- (void)selectDate:(CLDate)date{
    NSDate *sdate = [CLDateManager NSDateFromCLDate:date];
    [self.headerView setDate:sdate];
    [self.conveyorView selectDate:sdate];
    _date = sdate;
}

- (CLDate)current{
    CLDate date = (CLDate){
        self.date.year,
        self.date.month,
        self.date.day,
        self.date.weekDay,
        self.date.day_zh
    };
    return date;
}

- (void)setShowChinese:(BOOL)showChinese{
    [self.conveyorView setShowChinese:showChinese];
    [super setShowChinese:showChinese];
}



#pragma mark - CLCalendarViewDelegate

- (void)conveyorView:(CLConveyorView *)conveyorView
         SelectMonth:(NSDate *)date{
    [self.headerView setDate:date];
}

@end
