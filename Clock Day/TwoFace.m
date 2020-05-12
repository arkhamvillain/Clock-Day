//
//  TwoFace.m
//  Clock Day
//
//  Created by Yoseph Winata on 1/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "TwoFace.h"

@implementation TwoFace
@synthesize state;

//- (id)initWithParams:(BOOL)isLongerHandUpInput shortHandArg:(int)shorterHandInput {
//    self = [super init];
//    
//    if (self) {
//        self.isLongerHandUp = isLongerHandUpInput;
//        self.shorterHand = shorterHandInput;
//        type = @"twoface";
//        [self initiateVariables];
//        state = demon;
//    }
//    
//    return self;
//}

//test
- (id)initWithParams:(BOOL)isLongerHandUpInput shortHandArg:(int)shorterHandInput locationParam:(int)locationParam {
    self = [super init];
    
    if (self) {
        self.isLongerHandUp = isLongerHandUpInput;
        self.shorterHand = shorterHandInput;
        type = @"twoface";
        [self initiateVariables];
        state = demon;
        self.location = locationParam;
    }
    
    return self;
}

-(void)initiateVariables {
    angel = 1;
    demon = 0;
}

-(void) makeIt12 {
    isLongerHandUp = YES;
    shorterHand = 12;
    state = angel;
}

-(BOOL) checkTwelve {
    if (isLongerHandUp == YES && shorterHand == 12 && state == angel)
        return YES;
    return NO;
}

-(BOOL) checkTwelveButDemon {
    if (isLongerHandUp == YES && shorterHand == 12 && state == demon)
        return YES;
    return NO;
}

-(BOOL) checkTwelveNo2Face {
    if (isLongerHandUp == YES && shorterHand == 12)
        return YES;
    return NO;
}

@end
