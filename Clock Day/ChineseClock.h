//
//  ChineseClock.h
//  Clock Day
//
//  Created by Yoseph Winata on 4/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clock.h"

@interface ChineseClock : Clock {
    int zodiacAt;
}

@property int zodiacAt;

- (id)initWithParamsArgZodiacAtArg:(int)zodiacAtParam shortHandArg:(int)shorterHandInput locationParam:(int)locationParam;
-(void) moveZodiacForward:(int)steps;
-(void) moveZodiacBackward:(int)steps;

@end
