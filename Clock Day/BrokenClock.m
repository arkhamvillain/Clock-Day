//
//  BrokenClock.m
//  Clock Day
//
//  Created by Yoseph Winata on 1/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "BrokenClock.h"

@implementation BrokenClock

- (id)initWithParams:(BOOL)isLongerHandUpInput locationParam:(int)locationParam {
    self = [super init];
    
    if (self) {
        self.isLongerHandUp = isLongerHandUpInput;
        self.shorterHand = -1;
        type = @"broken";
        self.location = locationParam;
    }
    
    return self;
}

-(void) makeIt12 {
    isLongerHandUp = YES;
}

-(BOOL) checkTwelve {
    if (isLongerHandUp == YES)
        return YES;
    return NO;
}

-(BOOL) checkTwelveNo2Face {
    if (isLongerHandUp == YES)
        return YES;
    return NO;
}

@end
