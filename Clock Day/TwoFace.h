//
//  TwoFace.h
//  Clock Day
//
//  Created by Yoseph Winata on 1/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clock.h"

@interface TwoFace : Clock {
    int state; //1=angel 0=demon
    int angel, demon;
}

@property int state;



@end
