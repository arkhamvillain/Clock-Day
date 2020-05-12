//
//  RegularClock.m
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "RegularClock.h"

@implementation RegularClock


- (id)initWithParams:(BOOL)isLongerHandUpInput shortHandArg:(int)shorterHandInput locationParam:(int)locationParam {
    self = [super init];
    
    if (self) {
        self.isLongerHandUp = isLongerHandUpInput;
        self.shorterHand = shorterHandInput;
        type = @"regular";
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

-(void) passiveForward:(int)longerHandSteps :(int)shorterHandSteps
{
    [super moveHandsForward:longerHandSteps: shorterHandSteps];
}

-(void) passiveBackward:(int)longerHandSteps :(int)shorterHandSteps
{
    [super moveHandsBackward:longerHandSteps: shorterHandSteps];
}

@end
