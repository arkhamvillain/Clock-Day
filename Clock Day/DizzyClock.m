//
//  DizzyClock.m
//  Clock Day
//
//  Created by Yoseph Winata on 6/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "DizzyClock.h"

@implementation DizzyClock

@synthesize rotatingRight;

- (id)initWithParamsArgRotatingRightArg:(BOOL)rotatingRightParam shortHandArg:(int)shorterHandInput locationParam:(int)locationParam {
    self = [super init];
    
    if (self) {
        self.isLongerHandUp = YES;
        self.rotatingRight = rotatingRightParam;
        self.shorterHand = shorterHandInput;
        type = @"dizzy";
        self.location = locationParam;
    }
    
    return self;
}

-(BOOL) checkTwelve {
    if (isLongerHandUp == YES && shorterHand == 12)
        return YES;
    return NO;
}

-(void) makeIt12 {
    isLongerHandUp = YES;
    shorterHand = 12;
}

-(BOOL) checkTwelveNo2Face {
    if (isLongerHandUp == YES && shorterHand == 12)
        return YES;
    return NO;
}

@end
