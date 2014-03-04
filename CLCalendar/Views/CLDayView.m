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

@interface CLDayView ()

@property (nonatomic, strong) UILabel *chineseLabel;

@end

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

- (void)setShowChinese:(BOOL)showChinese{
    if (showChinese){
        if (!self.chineseLabel){
            self.chineseLabel = [[UILabel alloc] initWithFrame:(CGRect){{0, self.frame.size.height / 3 * 2},{self.frame.size.width, self.frame.size.height / 3}}];
            [self addSubview:_chineseLabel];
            [_chineseLabel setText:[CLDateManager chineseDay:self.date.day_zh]];
            [_chineseLabel setFont:[UIFont systemFontOfSize:12]];
            [_chineseLabel setTextAlignment:NSTextAlignmentCenter];
            [_chineseLabel setBackgroundColor:[UIColor clearColor]];
        }else{
            [self.chineseLabel setHidden:NO];
        }
    }else{
        if (self.chineseLabel){
            [self.chineseLabel setHidden:YES];
        }
    }
    [super setShowChinese:showChinese];
}


@end
