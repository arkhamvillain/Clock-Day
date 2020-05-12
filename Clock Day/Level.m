//
//  Level.m
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "Level.h"

@implementation Level
@synthesize currentLevel, clocks, arrows, steps, goal;

- (id)initWithParamsArgLevelNumberArg:(int) levelInput
           clocksArg:(NSMutableArray*) clocksInput
           arrowsArg:(NSMutableArray*) arrowsInput
             goalArg:(int)goalParam {
    self = [super init];
    
    if (self) {
        self.currentLevel = levelInput;
        self.clocks = clocksInput;
        self.arrows = arrowsInput;
        self.goal = goalParam;
        self.steps = 0;
    }
    
    return self;
}

-(int) getNumberOfClocks {
    return [clocks count];
}

-(void)add1Step {
    if (steps < 999) {
        steps++;
    }
}

@end
