//
//  CLConveyorView.h
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import "CLCalendarBaseView.h"
#import "CLMonthView.h"

@protocol CLConveyorViewDelegate;

@interface CLConveyorView : CLCalendarBaseView

@property (nonatomic, unsafe_unretained) id <CLConveyorViewDelegate> delegate;

- (void)setCenterDate:(NSDate *)date;

@end

@protocol CLConveyorViewDelegate <NSObject>

- (void)conveyorView:(CLConveyorView *)conveyorView
          SelectMonth:(NSDate *)date;




@end
