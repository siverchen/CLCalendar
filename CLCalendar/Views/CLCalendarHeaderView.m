//
//  CLCalendarHeaderView.m
//  CLCalendar
//
//  Created by chenlei on 14-3-2.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLCalendarHeaderView.h"

@interface CLCalendarHeaderView ()

@property (nonatomic, strong) UILabel *headerLabel;

@end

@implementation CLCalendarHeaderView

@synthesize date = _date;

- (id)initWithDate:(NSDate *)date andFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.headerLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_headerLabel];
        self.date = date;
    }
    return self;
}

- (void)setDate:(NSDate *)date{
    _date = date;
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM";
    NSString* dateString = [fmt stringFromDate:_date];
    [self.headerLabel setText:dateString];
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
