//
//  NSDate+Extern.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "NSDate+Extern.h"

@implementation NSDate (Extern)



- (NSInteger)year{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components year];
}

- (NSInteger)month{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components month];
}

- (NSInteger)day{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components day];
}

- (NSInteger)weekDay{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components weekday];
}

@end
