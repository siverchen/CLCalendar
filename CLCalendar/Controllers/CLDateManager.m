//
//  CLDateManager.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLDateManager.h"
#import "NSDate+Extern.h"

@interface CLDateManager ()

@property (nonatomic, strong) NSMutableDictionary *festivals;

@end

@implementation CLDateManager

- (id)init{
    if (self = [super init]){
        self.festivals = [NSMutableDictionary dictionary];
    }
    return self;
}


+ (instancetype)manager{
    static CLDateManager *manager = nil;
    if (!manager){
        manager = [[CLDateManager alloc] init];
    }
    return manager;
}

+ (NSDictionary *)AllFestival{
    return @{
            @"e-1-1" : @"元旦",
            @"z-1-1" : @"春节",
            @"z-1-15" : @"元宵节",
            @"e-2-14" : @"情人节",
            @"e-3-8" : @"妇女节",
            @"e-3-12" : @"植树节",
            @"e-4-1" : @"愚人节",
            @"e-5-1" : @"劳动节",
            @"e-5-4" : @"青年节",
            @"s-e-5-2-7" : @"母亲节",
            @"z-5-5" : @"端午节",
            @"e-6-1" : @"儿童节",
            @"s-e-6-3-7" : @"父亲节",
            @"e-7-1" : @"建党",
            @"z-7-7" : @"七夕",
            @"e-8-1" : @"建军节",
            @"z-8-15" : @"中秋节",
            @"e-9-10" : @"教师节",
            @"z-9-9" : @"重阳节",
            @"e-10-1" : @"国庆节",
            @"s-e-11-4-4" : @"感恩节",
            @"e-12-5" : @"圣诞节",
            @"s-z-12-e-1" : @"除夕"
            };
}


- (NSString *)festival:(NSDate *)date{
    
    NSString *key = [NSString stringWithFormat:@"%lu-%lu", date.month, date.day];
    NSString *year = [NSString stringWithFormat:@"e%lu", date.year];
    NSMutableDictionary *f = [self.festivals objectForKey:year];
    if (f && [f objectForKey:key]){
        return [f objectForKey:key];
    }else if (!f){
        f = [NSMutableDictionary dictionary];
        NSDictionary *all = [[self class] AllFestival];
        for (NSString *skey in all){
            NSArray *array = [skey componentsSeparatedByString:@"-"];
            NSString *action = [array objectAtIndex:0];
            char s = [action characterAtIndex:0];
            if (s == 'e'){
                NSString *mkey = [NSString stringWithFormat:@"%@-%@", [array objectAtIndex:1], [array objectAtIndex:2]];;
                NSString *mvalue = [all objectForKey:skey];
                if (mkey && mvalue){
                    [f setValue:mvalue forKey:mkey];
                }
            }
        }
        [self.festivals setValue:f forKey:year];
        if ([f objectForKey:key]){
            return [f objectForKey:key];
        }
    }
    
    
    key = [NSString stringWithFormat:@"%lu-%lu", date.month_zh, date.day_zh];
    year = [NSString stringWithFormat:@"z%lu", date.year];
    f = [self.festivals objectForKey:year];
    if (f){
        return [f objectForKey:key];
    }else{
        f = [NSMutableDictionary dictionary];
        NSDictionary *all = [[self class] AllFestival];
        for (NSString *skey in all){
            NSArray *array = [skey componentsSeparatedByString:@"-"];
            NSString *action = [array objectAtIndex:0];
            char s = [action characterAtIndex:0];
            if (s == 'z'){
                NSString *mkey = [NSString stringWithFormat:@"%@-%@", [array objectAtIndex:1], [array objectAtIndex:2]];
                NSString *mvalue = [all objectForKey:skey];
                if (mkey && mvalue){
                    [f setValue:mvalue forKey:mkey];
                }
            }
        }
        [self.festivals setValue:f forKey:year];
        return [f objectForKey:key];
    }
    return nil;
    
}


+ (CLDate)gregorFromChinese:(CLDate)date{
    NSCalendar *chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:date.year];
    [components setMonth:date.month];
    [components setDay:date.day];
    NSDate *tdate = [chineseCalendar dateFromComponents:components];
    return (CLDate){tdate.year, tdate.month, tdate.day};
}



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

+ (NSString *)chineseMonth:(NSDate *)date{
    NSString *m = nil;
    switch (date.month_zh) {
        case 1:
            m = @"一";
            break;
        case 2:
            m = @"二";
            break;
        case 3:
            m = @"三";
            break;
        case 4:
            m = @"四";
            break;
        case 5:
            m = @"五";
            break;
        case 6:
            m = @"六";
            break;
        case 7:
            m = @"七";
            break;
        case 8:
            m = @"八";
            break;
        case 9:
            m = @"九";
            break;
        case 10:
            m = @"十";
            break;
        case 11:
            m = @"十一";
            break;
        case 12:
            m = @"十二";
            break;
        default:
            break;
    }
    return [m stringByAppendingString:@"月"];
}


+ (NSString *)chineseDay:(NSDate *)date{
    if (date.day_zh == 1){
        return [self chineseMonth:date];
    }
    NSString *prefix = nil;
    NSUInteger day = date.day_zh;
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
