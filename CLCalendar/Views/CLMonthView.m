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
#define CL_WEEKVIEW_HEIGHT 30

@interface CLMonthView ()

@property (nonatomic, strong) NSMutableArray *dayViews;
@property (nonatomic, strong) CLDayView *selectDayView;
@property (nonatomic, strong) UIView *weekView;


@end

@implementation CLMonthView

@synthesize date = _date;

- (void)dealloc{
    _delegate = nil;
}

- (id)initWithDate:(NSDate *)date andFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _date = date;
        self.dayViews = [NSMutableArray array];
        self.weekView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {self.frame.size.width, CL_WEEKVIEW_HEIGHT}}];
        [self addSubview:_weekView];
        [self drawWeekDay];
        [self drawDates];
    }
    return self;
}

- (void)setShowChinese:(BOOL)showChinese{
    for (CLDayView *dayView in self.dayViews){
        [dayView setShowChinese:showChinese];
    }
    [super setShowChinese:showChinese];
}

- (void)drawWeekDay{
    float left = 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    for (NSString *symbol in [dateFormatter veryShortWeekdaySymbols]){
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){{left, 0}, {CL_DAYVIEW_WIDTH, CL_WEEKVIEW_HEIGHT}}];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:symbol];
        [label setFont:[UIFont systemFontOfSize:12]];
        [self.weekView addSubview:label];
        left += CL_DAYVIEW_WIDTH;
    }
    
    
}

- (void)drawDates{
    for (CLDayView *view in [self dayViews]){
        [view removeFromSuperview];
    }
    [self.dayViews removeAllObjects];
    int weekDay = (int)[self.date weekDay];
    float left = (weekDay - 1) * CL_DAYVIEW_WIDTH;
    float top = CL_WEEKVIEW_HEIGHT;
    
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
        [self.dayViews addObject:dayView];
        [dayView addTarget:self action:@selector(selectDay:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (CLDayView *)selectDate:(NSDate *)date{
    for (CLDayView *dayView in [self dayViews]){
        if ([CLDateManager Date:date isSameDayWithDate:dayView.date]){
            [dayView setBackgroundColor:CLRGBA(157, 195, 231, 1)];
            return dayView;
        }
    }
    return nil;
}


- (void)setDate:(NSDate *)date{
    _date = date;
    [self drawDates];
}


- (void)selectDay:(CLDayView *)dayView{
    if (_delegate && [_delegate respondsToSelector:@selector(monthView:selectDayView:)]){
        [_delegate monthView:self selectDayView:dayView];
    }
}






@end
