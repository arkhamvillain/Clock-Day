//
//  Clock.h
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Clock : NSObject {
    BOOL isLongerHandUp;
    int shorterHand;
    NSString* type;
    int location;
}

@property BOOL isLongerHandUp;
@property int shorterHand;
@property NSString* type;
@property int location;

//One longerHandSteps = halfway (12->6)
//One shorterHandSteps = one digit increment (12->1)
//- (id)initWithParams: (BOOL)isLongerHandUpInput shortHandArg:(int)shorterHandInput;
- (id)initWithParams:(BOOL)isLongerHandUpInput shortHandArg:(int)shorterHandInput locationParam:(int)locationParam;
-(void) moveHandsForward:(int) longerHandSteps:(int) shorterHandSteps;
-(void) moveHandsBackward:(int) longerHandSteps:(int) shorterHandSteps;
-(BOOL) checkTwelve;
-(void) makeIt12;
-(BOOL) getIsLongUp;
-(NSString*)getType;

-(BOOL) checkTwelveButDemon;
-(BOOL) checkTwelveNo2Face;

@end
