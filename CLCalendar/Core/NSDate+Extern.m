//
//  NSDate+Extern.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "NSDate+Extern.h"


NSString *NSStringFromCLDate(CLDate date){
    return [NSString stringWithFormat:@"\n{\nyear : %lu, \nmonth : %lu, \nday : %lu, \nweekday : %lu ,\n chineseday:%lu}", date.year, date.month, date.day, date.weekday, date.zh_day];
}

@implementation NSDate (Extern)

- (NSUInteger)year{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components year];
}

- (NSUInteger)month{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components month];
}

- (NSUInteger)day{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components day];
}

- (NSUInteger)weekDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components weekday];
}

- (NSUInteger)day_zh{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components day];
}


- (NSUInteger)month_zh{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components month];
}

@end
