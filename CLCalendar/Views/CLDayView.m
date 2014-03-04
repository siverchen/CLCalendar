//
//  CLDayView.m
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLDayView.h"
#import "CLDateManager.h"
#import "NSDate+Extern.h"

@implementation CLDayView

@synthesize date = _date;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithDate:(NSDate *)date andFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        UILabel *label = [[UILabel alloc] initWithFrame:[self bounds]];
        [self addSubview:label];
        [label setText:[NSString stringWithFormat:@"%ld", date.day]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        if ([CLDateManager Date:date isSameDayWithDate:[NSDate date]]){
            [label setTextColor:[UIColor redColor]];
        }
        _date = date;
    }
    return self;
}

- (void)showChinese{
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRect){{0, self.frame.size.height / 3 * 2},{self.frame.size.width, self.frame.size.height / 3}}];
    [self addSubview:label];
    [label setText:[CLDateManager chineseDay:self.date.day_zh]];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:[UIColor clearColor]];
}


@end
