//
//  CLCalendarBaseView.h
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLCalendarBaseView : UIControl

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL showChinese;
@property (nonatomic, assign) BOOL showFestival;

- (id)initWithDate:(NSDate *)date andFrame:(CGRect)frame;


@end
