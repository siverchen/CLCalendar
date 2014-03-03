//
//  NSDate+Extern.h
//  CLCalendar
//
//  Created by chenlei on 14-2-28.
//  Copyright (c) 2014年 cc.doplan. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString *NSStringFromCLDate(CLDate date);

@interface NSDate (Extern)


- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)weekDay;

@end
