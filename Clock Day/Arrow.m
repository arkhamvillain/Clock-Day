//
//  Arrow.m
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow
@synthesize multiplier, origin, destination, type;

- (id)initWithParams:(int)multiplierInput
           originArg:(int)originInput
      destinationArg:(int)destinationInput {
    
    self = [super init];
    
    if (self) {
        self.multiplier = multiplierInput;
        self.origin = originInput;
        self.destination = destinationInput;
        type = @"normal";
    }
    
    return self;
}

@end
