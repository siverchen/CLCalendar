//
//  CLConveyorView.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLConveyorView.h"
#import "CLDateManager.h"
#import "CLMonthView.h"
#import "CLDayView.h"


@interface CLConveyorView () <UIScrollViewDelegate, CLMonthViewDelegate> {
    CLMonthView *_calendarViews[3];
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CLDayView *selectDayView;

@end

@implementation CLConveyorView

@synthesize date = _date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setContentSize:(CGSize){self.frame.size.width * 3, self.frame.size.height}];
        [self.scrollView setContentOffset:(CGPoint){self.frame.size.width, 0}];
        [self.scrollView setBounces:NO];
        [self.scrollView setDelegate:self];
        [self addSubview:_scrollView];
    }
    return self;
}

- (id)initWithDate:(NSDate *)date andFrame:(CGRect)frame{
    if (self = [super initWithDate:date andFrame:frame]){
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self.scrollView setPagingEnabled:YES];
        [self.scrollView setContentSize:(CGSize){self.frame.size.width * 3, self.frame.size.height}];
        [self.scrollView setContentOffset:(CGPoint){self.frame.size.width, 0}];
        [self.scrollView setBounces:NO];
        [self.scrollView setDelegate:self];
        _calendarViews[0] = _calendarViews[1] = _calendarViews[2] = nil;
        [self addSubview:_scrollView];
        [self setCenterDate:date];
        self.date = date;
    }
    return self;
}

- (void)setShowChinese:(BOOL)showChinese{
    [_calendarViews[0] setShowChinese:showChinese];
    [_calendarViews[1] setShowChinese:showChinese];
    [_calendarViews[2] setShowChinese:showChinese];
    [super setShowChinese:showChinese];
}

- (void)clearView:(int)index{
    if (_calendarViews[index]){
        [_calendarViews[index] removeFromSuperview];
        _calendarViews[index] = nil;
    }
}

- (void)setCenterDate:(NSDate *)date{
    
    [self clearView:0];
    [self clearView:1];
    [self clearView:2];
    //初始化左侧的月份
    NSDate *lastMonth = [CLDateManager lastMonth:date];
    CLMonthView *leftView = [[CLMonthView alloc] initWithDate:lastMonth andFrame:self.bounds];
    [self.scrollView addSubview:leftView];
    leftView.delegate = self;
    [leftView setFrame:(CGRect){{0, 0},self.frame.size}];
    _calendarViews[0] = leftView;
    
    //初始化中间的月份
    NSDate *currentMonth = [CLDateManager currentMonth:date];
    CLMonthView *centerView = [[CLMonthView alloc] initWithDate:currentMonth andFrame:self.bounds];
    [self.scrollView addSubview:centerView];
    [centerView setFrame:(CGRect){{self.frame.size.width, 0},self.frame.size}];
    centerView.delegate = self;
    _calendarViews[1] = centerView;
    
    //初始化右侧的月份
    NSDate *nextMonth = [CLDateManager nextMonth:date];
    CLMonthView *rightView = [[CLMonthView alloc] initWithDate:nextMonth andFrame:self.bounds];
    [self.scrollView addSubview:rightView];
    rightView.date = nextMonth;
    [rightView setFrame:(CGRect){{self.frame.size.width * 2, 0},self.frame.size}];
    rightView.delegate = self;
    _calendarViews[2] = rightView;
    rightView.date = nextMonth;
}

- (void)selectDate:(NSDate *)date{
    [self setCenterDate:date];
    CLDayView *dayView = [_calendarViews[1] selectDate:date];
    if (dayView){
        self.selectDayView = dayView;
    }
}

- (void)resetPosition:(int)dir{
    CLMonthView *centerView = _calendarViews[1];
    CLMonthView *leftView = _calendarViews[0];
    CLMonthView *rightView = _calendarViews[2];
    if (dir > 0){
        //设置位置
        [self addSubview:rightView];
        [rightView setFrame:self.bounds];
        [leftView removeFromSuperview];
        [centerView removeFromSuperview];
        [self.scrollView setContentOffset:(CGPoint){self.frame.size.width, 0}];
        _calendarViews[0] = centerView;
        _calendarViews[1] = rightView;
        _calendarViews[2] = leftView;
        
        //设置date
        leftView.date = [CLDateManager nextMonth:rightView.date];
        
        if (_selectDayView){
            CLDayView *newSelectView = [leftView selectDate:_selectDayView.date];
            if (newSelectView){
                self.selectDayView = newSelectView;
            }
        }
        [leftView setShowChinese:self.showChinese];
        
    }else if (dir < 0){
        
        [self addSubview:leftView];
        [leftView setFrame:self.bounds];
        [rightView removeFromSuperview];
        [centerView removeFromSuperview];
        [self.scrollView setContentOffset:(CGPoint){self.frame.size.width, 0}];
        _calendarViews[0] = rightView;
        _calendarViews[1] = leftView;
        _calendarViews[2] = centerView;
        
        
        //设置date
        rightView.date = [CLDateManager lastMonth:leftView.date];
        
        if (_selectDayView){
            CLDayView *newSelectView = [rightView selectDate:_selectDayView.date];
            if (newSelectView){
                self.selectDayView = newSelectView;
            }
        }
        [rightView setShowChinese:self.showChinese];
    }
    [_calendarViews[1] setFrame:(CGRect){{self.frame.size.width, 0},self.frame.size}];
    [_calendarViews[0] setFrame:(CGRect){{0, 0},self.frame.size}];
    [_calendarViews[2] setFrame:(CGRect){{self.frame.size.width * 2, 0},self.frame.size}];
    [self.scrollView addSubview:centerView];
    [self.scrollView addSubview:leftView];
    [self.scrollView addSubview:rightView];
    self.date = [_calendarViews[1] date];
}

#pragma mark - UIScrollViewDelegete

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0){
        [self resetPosition:-1];
    }else if (scrollView.contentOffset.x == 2 * scrollView.frame.size.width){
        [self resetPosition:1];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(conveyorView:SelectMonth:)]){
        [_delegate conveyorView:self SelectMonth:self.date];
    }
}



- (void)monthView:(CLMonthView *)monthView selectDayView:(CLDayView *)dayView{
    if (_selectDayView){
        [_selectDayView setBackgroundColor:[UIColor clearColor]];
    }
    [dayView setBackgroundColor:CLRGBA(157, 195, 231, 1)];
    self.selectDayView = dayView;
}







@end
