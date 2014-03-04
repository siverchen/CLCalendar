//
//  CLCalanderView.h
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLCalendarBaseView.h"


#define CL_HEADERVIEW_HEIGHT 30
#define CL_HEADERVIEW_TOP 50

@protocol CLCalendarViewDelegate;

@interface CLCalendarView : CLCalendarBaseView


/**
 *	@brief	获取当前显示的日期
 *
 *	@return	NSDate date
 */
- (CLDate)current;

/**
 *	@brief	选择目标日期
 *
 *	@param 	date 	目标日期: Year, month, day, weekday
 */
- (void)selectDate:(CLDate)date;


/**
 *	@brief	是否显示农历
 *
 *	@param 	show 	YES 显示
 */
- (void)showChineseDate:(BOOL)show;







@end

@protocol CLCalendarViewDelegate <NSObject>

- (void)calendarView:(CLCalendarView *)calendarView
      didSelectedDay:(CLDate)date;

@end
