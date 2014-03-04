//
//  CLDateManager.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLDateManager.h"
#import "NSDate+Extern.h"

@implementation CLDateManager


+ (NSUInteger)dayCount:(NSDate *)date{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    NSInteger month = components.month;
    NSInteger year = components.year;
    
    NSUInteger count = 0;
    
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12){
        count = 31;
    }else if (month == 4 || month == 6 || month == 9 || month == 11){
        count = 30;
    }else{
        if (year % 4 == 0){
            count = 29;
        }else{
            count = 28;
        }
    }
    return count;
}

+ (NSDate *)firstMonthDay:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)firstYearDay:(NSDate *)date{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    [components setMonth:1];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)lastMonth:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    if (components.month == 1){
        components.year--;
    }
    
    if (components.month == 1){
        components.month = 12;
    }else{
        components.month--;
    }
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)nextMonth:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    if (components.month == 12){
        components.year++;
    }
    if (components.month == 12){
        components.month = 1;
    }else{
        components.month++;
    }
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)currentMonth:(NSDate *)date{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.firstWeekday = 4;
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [calendar dateFromComponents:components];
}

+ (BOOL)Date:(NSDate *)sdate isSameDayWithDate:(NSDate *)date{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *scomponents = [calendar components:unitFlags fromDate:sdate];
    [scomponents setHour:0];
    [scomponents setMinute:0];
    [scomponents setSecond:0];
    
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return  [[calendar dateFromComponents:components] timeIntervalSince1970] == [[calendar dateFromComponents:scomponents] timeIntervalSince1970];

}


+ (NSDate *)NSDateFromCLDate:(CLDate)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:date.year];
    [components setMonth:date.month];
    [components setDay:date.day];
    return [calendar dateFromComponents:components];
    
}


+ (NSString *)chineseDay:(NSUInteger)day{
    NSString *prefix = nil;
    if (day <= 10){
        prefix = @"初";
    }else if (day > 10 && day < 20){
        prefix = @"十";
    }else if (day == 20){
        prefix = @"二";
    }else if (day > 20 && day < 30){
        prefix = @"廿";
    }else{
        prefix = @"三";
    }
    NSString *subfix = nil;
    switch (day % 10) {
        case 1:
            subfix = @"一";
            break;
        case 2:
            subfix = @"二";
            break;
        case 3:
            subfix = @"三";
            break;
        case 4:
            subfix = @"四";
            break;
        case 5:
            subfix = @"五";
            break;
        case 6:
            subfix = @"六";
            break;
        case 7:
            subfix = @"七";
            break;
        case 8:
            subfix = @"八";
            break;
        case 9:
            subfix = @"九";
            break;
        case 0:
            subfix = @"十";
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@%@", prefix, subfix];
    
}


@end
