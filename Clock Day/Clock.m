//
//  Clock.m
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "Clock.h"

@implementation Clock
@synthesize isLongerHandUp, shorterHand, type, location;


-(NSString*)getType {
    return type;
}

-(BOOL) getIsLongUp {
    return isLongerHandUp;
}

-(void) moveHandsForward:(int)longerHandSteps :(int)shorterHandSteps
{
    if (isLongerHandUp)
    {
        if (longerHandSteps % 2 == 1)
            isLongerHandUp = NO;
        else
            isLongerHandUp = YES;
    }
    else
    {
        if (longerHandSteps % 2 == 1)
            isLongerHandUp = YES;
        else
            isLongerHandUp = NO;
    }
    
    shorterHand += shorterHandSteps;
    shorterHand %= 12;
    if (shorterHand == 0) shorterHand = 12;
}

-(void) moveHandsBackward:(int)longerHandSteps :(int)shorterHandSteps
{
    if (isLongerHandUp)
    {
        if (longerHandSteps % 2 == 1)
            isLongerHandUp = NO;
        else
            isLongerHandUp = YES;
    }
    else
    {
        if (longerHandSteps % 2 == 1)
            isLongerHandUp = YES;
        else
            isLongerHandUp = NO;
    }
    
    shorterHand = shorterHand - shorterHandSteps;
    if (shorterHand == 0) shorterHand = 12;
}

@end
