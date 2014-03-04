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

@interface CLDayView () {
    NSString * _festival;
}

@property (nonatomic, strong) UILabel *detailLabel;

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
        
        self.detailLabel = [[UILabel alloc] initWithFrame:(CGRect){{0, self.frame.size.height / 3 * 2},{self.frame.size.width, self.frame.size.height / 3}}];
        [self addSubview:_detailLabel];
        [_detailLabel setFont:[UIFont systemFontOfSize:12]];
        [_detailLabel setTextAlignment:NSTextAlignmentCenter];
        [_detailLabel setBackgroundColor:[UIColor clearColor]];
        _date = date;
        _festival = [[[CLDateManager manager] festival:self.date] copy];
    }
    return self;
}

- (void)setShowChinese:(BOOL)showChinese{
    if (showChinese && (!self.showFestival || (self.showFestival && !_festival))){
        [self.detailLabel setHidden:NO];
        [_detailLabel setText:[CLDateManager chineseDay:self.date]];
    }else{
        if (self.showFestival && _festival){
            [self setShowFestival:self.showFestival];
        }else{
            [self.detailLabel setHidden:YES];
        }
    }
    [super setShowChinese:showChinese];
}


- (void)setShowFestival:(BOOL)showFestival{
    [super setShowFestival:showFestival];
    if (showFestival && _festival){
        [self.detailLabel setHidden:NO];
        [_detailLabel setText:_festival];
    }else{
        [self setShowChinese:self.showChinese];
    }
}


@end
