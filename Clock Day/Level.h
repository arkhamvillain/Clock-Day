//
//  Level.h
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject {
    int currentLevel, steps, goal;
    //Structure of clocks (MutableArray)
    NSMutableArray* clocks;
    //structure of arrows (MutableSet)
    NSMutableArray* arrows;
    //structure of items (MutableArray) - later stage
}

@property int currentLevel, steps, goal;
@property NSMutableArray* clocks;
@property NSMutableArray* arrows;

- (id)initWithParamsArgLevelNumberArg:(int) levelInput
                            clocksArg:(NSMutableArray*) clocksInput
                            arrowsArg:(NSMutableArray*) arrowsInput
                              goalArg:(int)goalParam;

-(int) getNumberOfClocks;
-(void) add1Step;

@end
