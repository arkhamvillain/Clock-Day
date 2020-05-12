//
//  ExplosiveArrow.m
//  Clock Day
//
//  Created by Yoseph Winata on 7/05/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "ExplosiveArrow.h"

@implementation ExplosiveArrow
@synthesize isExplosive;

- (id)initWithParams:(int)multiplierInput
           originArg:(int)originInput
      destinationArg:(int)destinationInput {
    
    self = [super init];
    
    if (self) {
        self.multiplier = multiplierInput;
        self.origin = originInput;
        self.destination = destinationInput;
        type = @"explosive";
    }
    
    return self;
}


@end
