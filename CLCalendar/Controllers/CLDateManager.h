//
//  CLDateManager.h
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CLDateManager : NSObject

+ (instancetype)manager;

+ (NSUInteger)dayCount:(NSDate *)date;

+ (NSDate *)firstMonthDay:(NSDate *)date;

+ (NSDate *)firstYearDay:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;

+ (NSDate *)nextMonth:(NSDate *)date;

+ (NSDate *)currentMonth:(NSDate *)date;

+ (BOOL)Date:(NSDate *)sdate
isSameDayWithDate:(NSDate *)date;

+ (NSDate *)NSDateFromCLDate:(CLDate)date;

+ (NSString *)chineseDay:(NSDate *)date;

- (NSString *)festival:(NSDate *)date;

@end
