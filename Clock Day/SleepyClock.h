//
//  SleepyClock.h
//  Clock Day
//
//  Created by Yoseph Winata on 4/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clock.h"

@interface SleepyClock : Clock {
    int status; //1=awake, 2=asleep
    int awake, asleep;
}

@property int status;

@end
