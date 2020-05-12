//
//  RegularClock.h
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clock.h"

@interface RegularClock : Clock {
}


-(void) passiveForward:(int)longerHandSteps :(int)shorterHandSteps;
-(void) passiveBackward:(int)longerHandSteps :(int)shorterHandSteps;

@end
