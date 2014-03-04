//
//  CLCalendarView.h
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLCalendarBaseView.h"

@class CLDayView;

@protocol CLMonthViewDelegate;

@interface CLMonthView : CLCalendarBaseView

@property (nonatomic, unsafe_unretained) id <CLMonthViewDelegate> delegate;

- (CLDayView *)selectDate:(NSDate *)date;

@end

@protocol CLMonthViewDelegate <NSObject>

- (void)monthView:(CLMonthView *)monthView selectDayView:(CLDayView *)dayView;

@end
