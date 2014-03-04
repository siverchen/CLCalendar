//
//  CLCommonDefine.h
//  CLCalendar
//
//  Created by chenlei on 14-3-3.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#ifndef CLCalendar_CLCommonDefine_h
#define CLCalendar_CLCommonDefine_h

#define CLRGBA(r, g, b, a)  [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

struct CLDate{
    NSUInteger year;
    NSUInteger month;
    NSUInteger day;
    NSUInteger weekday;
    NSUInteger zh_day;
    NSUInteger zh_month;
    NSUInteger zh_year;
};

typedef struct CLDate CLDate;




#endif
