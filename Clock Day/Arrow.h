//
//  Arrow.h
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Arrow : NSObject {
    int multiplier;
    int origin;
    int destination;
    NSString *type;
}

@property int multiplier;
@property int origin;
@property int destination;
@property NSString *type;

- (id)initWithParams:(int)multiplierInput
           originArg:(int)originInput
      destinationArg:(int)destinationInput;

@end
