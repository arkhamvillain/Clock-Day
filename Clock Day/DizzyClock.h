//
//  DizzyClock.h
//  Clock Day
//
//  Created by Yoseph Winata on 6/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clock.h"

@interface DizzyClock : Clock {
    BOOL rotatingRight;
}

@property BOOL rotatingRight;

- (id)initWithParamsArgRotatingRightArg:(BOOL)rotatingRightParam shortHandArg:(int)shorterHandInput locationParam:(int)locationParam;

@end
