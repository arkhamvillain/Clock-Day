//
//  SleepyClock.m
//  Clock Day
//
//  Created by Yoseph Winata on 4/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "SleepyClock.h"

@implementation SleepyClock
@synthesize status;

- (id)initWithParams:(BOOL)isLongerHandUpInput shortHandArg:(int)shorterHandInput locationParam:(int)locationParam {
    self = [super init];
    
    if (self) {
        self.isLongerHandUp = isLongerHandUpInput;
        self.shorterHand = shorterHandInput;
        type = @"sleepyclock";
        [self initiateVariables];
        status = asleep;
        self.location = locationParam;
    }
    
    return self;
}

-(void)initiateVariables {
    awake = 1;
    asleep = 0;
}

-(void) makeIt12 {
    isLongerHandUp = YES;
    shorterHand = 12;
}

-(BOOL) checkTwelve {
    if (isLongerHandUp == YES && shorterHand == 12)
        return YES;
    return NO;
}

-(BOOL) checkTwelveNo2Face {
    if (isLongerHandUp == YES && shorterHand == 12)
        return YES;
    return NO;
}

@end
