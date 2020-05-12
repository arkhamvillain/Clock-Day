//
//  VoidClock.m
//  Clock Day
//
//  Created by Yoseph Winata on 22/04/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "VoidClock.h"

@implementation VoidClock

- (id)initWithParams: (BOOL)isLongerHandUpInput shortHandArg:(int)shorterHandInput locationParam:(int)locationParam {
    self = [super init];
    
    if (self) {
        self.isLongerHandUp = isLongerHandUpInput;
        self.shorterHand = shorterHandInput;
        type = @"void";
        self.location = locationParam;
    }
    
    return self;
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
