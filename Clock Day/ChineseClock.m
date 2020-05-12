//
//  ChineseClock.m
//  Clock Day
//
//  Created by Yoseph Winata on 4/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "ChineseClock.h"

@implementation ChineseClock

@synthesize zodiacAt;

- (id)initWithParamsArgZodiacAtArg:(int)zodiacAtParam shortHandArg:(int)shorterHandInput locationParam:(int)locationParam {
    self = [super init];
    
    if (self) {
        self.isLongerHandUp = YES;
        self.zodiacAt = zodiacAtParam;
        self.shorterHand = shorterHandInput;
        type = @"chinese";
        self.location = locationParam;
    }
    
    return self;
}

-(void) moveZodiacForward:(int)steps
{
    zodiacAt += steps;
    zodiacAt %= 12;
    if (zodiacAt == 0) zodiacAt = 12;
}

-(void) moveZodiacBackward:(int)steps
{
    zodiacAt = zodiacAt - steps;
    if (zodiacAt == 0) zodiacAt = 12;
    else if (zodiacAt == -1) zodiacAt = 11;
}

-(void) makeIt12 {
    isLongerHandUp = YES;
    shorterHand = 12;
    zodiacAt = 12;
}

-(BOOL) checkTwelve {
    if (isLongerHandUp == YES && shorterHand == 12 && zodiacAt == 12)
        return YES;
    return NO;
}

-(BOOL) checkTwelveNo2Face {
    if (isLongerHandUp == YES && shorterHand == 12 && zodiacAt == 12)
        return YES;
    return NO;
}

@end
