//
//  CLCalendarView.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLMonthView.h"
#import "NSDate+Extern.h"
#import "CLDayView.h"
#import "CLDateManager.h"

#define CL_DAYVIEW_WIDTH (320 / 7)
#define CL_DAYVIEW_HEIGHT 60

@interface CLMonthView ()


@end

@implementation CLMonthView

@synthesize date = _date;

- (id)initWithDate:(NSDate *)date andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _date = date;
        [self drawDates];
    }
    return self;
}

- (void)drawDates{
    for (UIView *view in [self subviews]){
        [view removeFromSuperview];
    }
    int weekDay = (int)[self.date weekDay];
    float left = (weekDay - 1) * CL_DAYVIEW_WIDTH;
    float top = 0;
    
    NSUInteger count = [CLDateManager dayCount:self.date];
    NSDate *date = self.date;
    for (int i = 0; i < count; i++){
        if ((i + weekDay - 1) % 7 == 0 && i){
            top += CL_DAYVIEW_HEIGHT;
            left = 0;
        }
        CLDayView *dayView = [[CLDayView alloc] initWithDate:date andFrame:(CGRect){{left, top}, {CL_DAYVIEW_WIDTH, CL_DAYVIEW_HEIGHT}}];
        date = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:date] ;
        [self addSubview:dayView];
        left += CL_DAYVIEW_WIDTH;
    }
}


- (void)setDate:(NSDate *)date{
    _date = date;
    [self drawDates];
}


- (void)selectDay:(CLDayView *)dayView{
    NSLog(@"%@", dayView.date);
}






@end
