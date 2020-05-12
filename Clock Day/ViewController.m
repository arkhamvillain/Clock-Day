//
//  ViewController.m
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "ViewController.h"
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    gameModel = [[Model alloc] init];
    inAppPurchaseManager = [[InAppPurchaseManager alloc] init];
    inAppPurchaseManager.inAppDelegate = self;
    
    [inAppPurchaseManager loadStore];
    
    [self hideIOSStatusBar];
    
    [self optionalSetups];
    
    [self initiateFirstVariables];
    
    [self setVariablesToNil];
  
    [self audioMainPlay];

    [self paintMainMenu];
    
    /////OLD starts////
    //    [self initAudioPlayers];
    //    [self loadLogoPage];
    //    [self startAudioTimer];
    //    [self startTimer];
    /////OLD ends/////
}

/////ONE PACKAGE - starts/////
-(void) hideIOSStatusBar {
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
/////ONE PACKAGE - ends/////

-(void) optionalSetups {
    //UNCOMMENT THIS LINE TO RESET ALL USER'S DATA - Starts
    [self resetProgress];
    //UNCOMMENT THIS LINE TO RESET ALL USER'S DATA - Ends
    
    //UNCOMMENT THIS LINE TO UNLOCK ALL LEVELS - Starts
    [self unlockAll120Levels];
    //UNCOMMENT THIS LINE TO UNLOCK ALL LEVELS - Ends
    
    //UNCOMMENT THIS LINE TO UNLOCK 15 LEVELS - Starts
    //[self unlock16Levels];
    //UNCOMMENT THIS LINE TO UNLOCK 15 LEVELS - Ends
    
    //UNCOMMENT THIS LINE TO SET TOTAL STARS - Starts
    [self setTotalStars:240];
    //UNCOMMENT THIS LINE TO SET TOTAL STARS - Ends
    
//test
//    [gameModel.prefs setInteger:90 forKey:@"latestUnlockedLevel"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initiateFirstVariables {
    
    //achievement rate becomes true - starts
    if ([gameModel.prefs boolForKey:@"achReversed"] == FALSE) {
        [gameModel.prefs setBool:TRUE forKey:@"achReversed"];
        [self addStickerBy1];
    }
    //ends
    
    tempAnimArray = [[NSMutableArray alloc] initWithCapacity:2];
    tempShortFullAnim = [[NSMutableArray alloc] initWithCapacity:24];
    
    leftside = 1;
    rightside = 2;
    
    totalCapsules20 = 20;
    totalCapsules50 = 50;
    totalCapsules500 = 500;
    
    eatingAnimDuration = 0.35;
    
    lastLevelBeforeLockdown = 15;
    tutorialPageCounter = 1;
    
    firstStatus = YES;
    firstBackground1 = YES;
    first2Clocks = YES;
    defaultMultiplier = 1;
    angelState = 1;
    demonState = 0;
    awakeState = 1;
    sleepingState = 0;
    forwardDirection = 1;
    backwardDirection = 0;
    prefixNumStatusBar = @"NUMBER_statusbar_";
    prefixTextStatusBar = @"TEXT_";
    prefixNumWin = @"NUMBER_win_";
    prefixTextPurchase = @"NUMBER_purchaseitem_";
    
    if ([gameModel.prefs integerForKey:@"latestUnlockedLevel"] == 0) {
        printf("latest unlocked set to 1\n");
        [gameModel.prefs setInteger:1 forKey:@"latestUnlockedLevel"];
    }
    
    if ([gameModel.prefs boolForKey:@"notfirsttime"] == NO) {
        [gameModel.prefs setInteger:2 forKey:@"purchase1"];
        [gameModel.prefs setBool:YES forKey:@"notfirsttime"];
    }
}

-(void)loadLogoPage {
    NSString* logoPath = [[NSBundle mainBundle] pathForResource:@"Logo" ofType:@"png"];
    logoPage = [[UIImageView alloc] initWithImage:[[UIImage alloc]initWithContentsOfFile:logoPath]];
    [logoPage setFrame:gameModel.backgroundRect];
    [self.view addSubview:logoPage];
}

-(void) dePaintLogoPage {
    [logoPage removeFromSuperview];
    logoPage = nil;
}

-(void)setVariablesToNil {
    currentLevel = nil;
    tempClock = nil;
    tempClock2Bottom = nil;
    tempArrow1 = nil;
    tempArrow2 = nil;
}

-(void) resetProgress {
    gameModel.appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:gameModel.appDomain];
}

-(void) unlockAll120Levels {
    [gameModel.prefs setInteger:120 forKey:@"latestUnlockedLevel"];
}

-(void) unlock15Levels {
    [gameModel.prefs setInteger:15 forKey:@"latestUnlockedLevel"];
}

-(void) unlock16Levels {
    [gameModel.prefs setInteger:16 forKey:@"latestUnlockedLevel"];
}

-(void) setAnimationArrays {
//    [self prepareAnimation]; //preload
    
    
    [self prepareArrowFlashes]; //not nullified
    [self prepareFlashingAnimations]; //preload
    [self prepareClockFlashes];
    [self prepareEatingAnimations];
    
    [self prepareYellowArray];
    
    [self prepareNotifArray];
}

-(void) prepareSpecificArrayOrdinary {
//    [self prepareShortOrdinaryForward];
    [self prepareLongOrdinaryForward];
//    [self prepareLongOrdinaryBackward];
}

-(void) prepareSpecificArrayReversed {
//    [self prepareShortReversedForward];
    [self prepareLongReversedForward];
//    [self prepareLongReversedBackward];
}


-(void) prepareSpecificArraySleepy {
//    [self prepareShortSleepyForward];
    [self prepareLongSleepyForward];
//    [self prepareLongSleepyBackward];
}


-(void) prepareSpecificArrayDizzy {
//    [self prepareShortDizzyForward];
    //long is ignored
}


-(void) prepareSpecificArrayFlower {
//    [self prepareShortFlowerForward];
    [self prepareLongFlowerForward];
//    [self prepareLongFlowerBackward];
//    [self prepareLongArrowAnimationLazyForward];
//    [self prepareLongArrowAnimationLazyBackward];
}


-(void) prepareSpecificArrayRoman {
//    [self prepareShortRomanForward];
    [self prepareLongRomanForward];
//    [self prepareLongRomanBackward];
}


-(void) prepareSpecificArrayNinja {
//    [self prepareShortNinjaForward];
    [self prepareLongNinjaForward];
//    [self prepareLongNinjaBackward];
}


-(void) prepareSpecificArrayIcy {
//    [self prepareShortIcyForward];
    [self prepareLongIcyForward];
//    [self prepareLongIcyBackward];
}


-(void) prepareSpecificArrayTwoface {
//    [self prepareShortDevilForward];
//    [self prepareShortAngelForward];
    [self prepareLongDevilForward];
//    [self prepareLongDevilBackward];
    [self prepareLongAngelForward];
//    [self prepareLongAngelBackward];
}


-(void) prepareSpecificArrayChinese {
//    [self prepareShortChineseForward];
}


-(void) prepareSpecificArrayBroken {
//    [self prepareLongArrowAnimationForwardFromDown];
//    [self prepareLongArrowAnimationBackwardFromDown];
//    [self prepareLongArrowAnimationRightToDown];
//    [self prepareLongArrowAnimationLeftToUp];
//    [self prepareLongArrowAnimationLeftToDown];
//    [self prepareLongArrowAnimationRightToUp];
}

-(void) prepareNotifArray {
    [self prepareIcyNotif]; //not nullified
    [self prepareSleepyNotif]; //not nullified
    [self prepareTwoFaceNotif]; //not nullified
    [self prepareCapsuleNotif]; //not nullified
}

-(void) nullifyAnimArraysAfterWin {
    [ordinaryGenWin removeFromSuperview];
    ordinaryGenWin = nil;
    [reversedGenWin removeFromSuperview];
    reversedGenWin = nil;
    [sleepyGenWin removeFromSuperview];
    sleepyGenWin = nil;
    [dizzyGenWin removeFromSuperview];
    dizzyGenWin = nil;
    [flowerGenWin removeFromSuperview];
    flowerGenWin = nil;
    [romanGenWin removeFromSuperview];
    romanGenWin = nil;
    [ninjaGenWin removeFromSuperview];
    ninjaGenWin = nil;
    [icyGenWin removeFromSuperview];
    icyGenWin = nil;
    [angelGenWin removeFromSuperview];
    angelGenWin = nil;
    [chineseGenWin removeFromSuperview];
    chineseGenWin = nil;
    [brokenGenWin removeFromSuperview];
    brokenGenWin = nil;
    
    animOrdinaryWin = nil;
    animReversedWin = nil;
    animSleepyWin = nil;
    animDizzyWin = nil;
    animFlowerWin = nil;
    animRomanWin = nil;
    animNinjaWin = nil;
    animIcyWin = nil;
    animAngelWin = nil;
    animChineseWin = nil;
    animBrokenWin = nil;
    
    animFlashToBlack = nil;
    animFlashFromBlack = nil;
    animFlashToWhite = nil;
    animFlashFromWhite = nil;
}

-(void) nullifyAnimArraysBeforeWin {
    
    [fullScreenFlashGen removeFromSuperview];
    fullScreenFlashGen = nil;
    
    [ordinaryGenA removeFromSuperview];
    ordinaryGenA = nil;
    [ordinaryGenB removeFromSuperview];
    ordinaryGenB = nil;
    
    [reversedGenA removeFromSuperview];
    reversedGenA = nil;
    [reversedGenB removeFromSuperview];
    reversedGenB = nil;
    
    [sleepyGenA removeFromSuperview];
    sleepyGenA = nil;
    [sleepyGenB removeFromSuperview];
    sleepyGenB = nil;
    [sleepyGenSleeping removeFromSuperview];
    sleepyGenSleeping = nil;
    
    [sleepyGenStoA removeFromSuperview];
    sleepyGenStoA = nil;
    [sleepyGenAtoS removeFromSuperview];
    sleepyGenAtoS = nil;
    
    [dizzyGenA removeFromSuperview];
    dizzyGenA = nil;
    [dizzyGenB removeFromSuperview];
    dizzyGenB = nil;
    
    [flowerGenA removeFromSuperview];
    flowerGenA = nil;
    [flowerGenB removeFromSuperview];
    flowerGenB = nil;
    
    [romanGenA removeFromSuperview];
    romanGenA = nil;
    [romanGenB removeFromSuperview];
    romanGenB = nil;
    
    [ninjaGenA removeFromSuperview];
    ninjaGenA = nil;
    [ninjaGenB removeFromSuperview];
    ninjaGenB = nil;
    
    [icyGenA removeFromSuperview];
    icyGenA = nil;
    [icyGenB removeFromSuperview];
    icyGenB = nil;
    
    [angelGenA removeFromSuperview];
    angelGenA = nil;
    [devilGenA removeFromSuperview];
    devilGenA = nil;
    
    [angelToDevilGen removeFromSuperview];
    angelToDevilGen = nil;
    [devilToAngelGen removeFromSuperview];
    devilToAngelGen = nil;
    [chineseGenA removeFromSuperview];
    chineseGenA = nil;
    [chineseGenB removeFromSuperview];
    chineseGenB = nil;
    
    [brokenGenA removeFromSuperview];
    brokenGenA = nil;
    [brokenGenB removeFromSuperview];
    brokenGenB = nil;
    
    [ordinaryShortGen removeFromSuperview];
    ordinaryShortGen = nil;
    [ordinaryLongGen removeFromSuperview];
    ordinaryLongGen = nil;
    [ordinaryLongBackwardsGen removeFromSuperview];
    ordinaryLongBackwardsGen = nil;
    [reversedShortGen removeFromSuperview];
    reversedShortGen = nil;
    [reversedLongGen removeFromSuperview];
    reversedLongGen = nil;
    [reversedLongBackwardsGen removeFromSuperview];
    reversedLongBackwardsGen = nil;
    [sleepyShortGen removeFromSuperview];
    sleepyShortGen = nil;
    [sleepyLongGen removeFromSuperview];
    sleepyLongGen = nil;
    [sleepyLongBackwardsGen removeFromSuperview];
    sleepyLongBackwardsGen = nil;
    [dizzyShortGen removeFromSuperview];
    dizzyShortGen = nil;
//    [dizzyLongGen removeFromSuperview];
//    dizzyLongGen = nil;
    [flowerShortGen removeFromSuperview];
    flowerShortGen = nil;
    [flowerLongGen removeFromSuperview];
    flowerLongGen = nil;
    [flowerLongBackwardsGen removeFromSuperview];
    flowerLongBackwardsGen = nil;
    [flowerLongGen2 removeFromSuperview];
    flowerLongGen2 = nil;
    [flowerLongBackwardsGen2 removeFromSuperview];
    flowerLongBackwardsGen2 = nil;
    [romanShortGen removeFromSuperview];
    romanShortGen = nil;
    [romanLongGen removeFromSuperview];
    romanLongGen = nil;
    [romanLongBackwardsGen removeFromSuperview];
    romanLongBackwardsGen = nil;
    [ninjaShortGen removeFromSuperview];
    ninjaShortGen = nil;
    [ninjaLongGen removeFromSuperview];
    ninjaLongGen = nil;
    [ninjaLongBackwardsGen removeFromSuperview];
    ninjaLongBackwardsGen = nil;
    [icyShortGen removeFromSuperview];
    icyShortGen = nil;
    [icyLongGen removeFromSuperview];
    icyLongGen = nil;
    [icyLongBackwardsGen removeFromSuperview];
    icyLongBackwardsGen = nil;
    [angelShortGen removeFromSuperview];
    angelShortGen = nil;
    [angelLongGen removeFromSuperview];
    angelLongGen = nil;
    [angelLongBackwardsGen removeFromSuperview];
    angelLongBackwardsGen = nil;
    [devilShortGen removeFromSuperview];
    devilShortGen = nil;
    [devilLongGen removeFromSuperview];
    devilLongGen = nil;
    [devilLongBackwardsGen removeFromSuperview];
    devilLongBackwardsGen = nil;
    [chineseShortGen removeFromSuperview];
    chineseShortGen = nil;
    [brokenLongGen removeFromSuperview];
    brokenLongGen = nil;

    
    arrowFlash3BfrTL = nil;
    arrowFlash3BfrTR = nil;
    arrowFlash3toTL = nil;
    arrowFlash3toTR = nil;
    arrowFlash4toBL = nil;
    arrowFlash4toBR = nil;
    arrowFlash4toTL = nil;
    arrowFlash4toTR = nil;
    arrowFlashToLeft = nil;
    arrowFlashToRight = nil;
    arrowFlashToDown = nil;
    arrowFlashToUp = nil;
    
    regularAnimationStandard1 = nil;
    animOrdinaryB = nil;
    animReversedA = nil;
    animReversedB = nil;
    animSleepyA = nil;
    animSleepyB = nil;
    animSleepySleeping = nil;
    animSleepToAwake = nil;
    animAwakeToSleep = nil;
    animDizzyA = nil;
    animDizzyB = nil;
    animFlowerA = nil;
    animFlowerB = nil;
    animRomanA = nil;
    animRomanB = nil;
    animNinjaA = nil;
    animNinjaB = nil;
    animIcyA = nil;
    animIcyB = nil;
    animAngelA = nil;
    animDevilA = nil;
    animAngeltoDevil = nil;
    animDevilToAngel = nil;
    animChineseA = nil;
    animChineseB = nil;
    animBrokenA = nil;
    animBrokenB = nil;
    
    sleepyFlashFull = nil;
    dizzyFlashFull = nil;
    ninjaFlashFull = nil;
    icyFlashFull = nil;
    ordinaryFlashLeft = nil;
    ordinaryFlashRight = nil;
    reversedFlashLeft = nil;
    reversedFlashRight = nil;
    flowerFlashLeft = nil;
    flowerFlashRight = nil;
    romanFlashLeft = nil;
    romanFlashRight = nil;
    devilFlashLeft = nil;
    devilFlashRight = nil;
    chineseFlashLeft = nil;
    chineseFlashRight = nil;
    brokenFlashLeft = nil;
    brokenFlashRight = nil;
    
    ordinaryEatingAnim = nil;
    reversedEatingAnim = nil;
    sleepyEatingAnim = nil;
    dizzyEatingAnim = nil;
    flowerEatingAnim = nil;
    romanEatingAnim = nil;
    ninjaEatingAnim = nil;
    icyEatingAnim = nil;
    angelEatingAnim = nil;
    chineseEatingAnim = nil;
    brokenEatingAnim = nil;
    
    longArrowLazyForward = nil;
    longArrowLazyBackward = nil;
    
    longArrowFullLoopAnimationFromDown = nil;
    longArrowFullLoopAnimationFromDownReversed = nil;
    longArrowRightToDownAnimation = nil;
    longArrowLeftToUpAnimation = nil;
    longArrowLeftToDownAnimation = nil;
    longArrowRightToUpAnimation = nil;
    
    shortOrdinaryForwardAnim = nil;
    shortReversedForwardAnim = nil;
    shortSleepyForwardAnim = nil;
    shortDizzyForwardAnim = nil;
    shortFlowerForwardAnim = nil;
    shortRomanForwardAnim = nil;
    shortNinjaForwardAnim = nil;
    shortIcyForwardAnim = nil;
    shortDevilForwardAnim = nil;
    shortAngelForwardAnim = nil;
    shortChineseForwardAnim = nil;
    
    longOrdinaryForwardAnim = nil;
    longOrdinaryBackwardAnim = nil;
    longReversedForwardAnim = nil;
    longReversedBackwardAnim = nil;
    longSleepyForwardAnim = nil;
    longSleepyBackwardAnim = nil;
    longDizzyForwardAnim = nil;
    longDizzyBackwardAnim = nil;
    longDizzyYellowForwardAnim = nil;
    longDizzyYellowBackwardAnim = nil;
    longFlowerForwardAnim = nil;
    longFlowerBackwardAnim = nil;
    longRomanForwardAnim = nil;
    longRomanBackwardAnim = nil;
    longNinjaForwardAnim = nil;
    longNinjaBackwardAnim = nil;
    longIcyForwardAnim = nil;
    longIcyBackwardAnim = nil;
    longDevilForwardAnim = nil;
    longDevilBackwardAnim = nil;
    longAngelForwardAnim = nil;
    longAngelBackwardAnim = nil;
    
    sleepToAwake = nil;
    awakeToSleep = nil;
    
    icyNotif = nil;
    sleepyNotif = nil;
    twoFaceNotif = nil;
    capsuleNotif = nil;
    
    yellowArray = nil;
}

-(void)prepareYellowArray {
    //Index references
    //0 = regular
    //1 = reversed
    //etc
    
    NSString *yellowFile;
    yellowArray = [[NSMutableArray alloc] initWithCapacity:9];
    
    //0
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //1
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Reversed_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //2
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Sleepy_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //3
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //4
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Roman_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //5
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Ninja_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //6
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //7
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Chinese_Short_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
    
    //8
    yellowFile = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Long_999"] ofType:@"png"];
    [yellowArray addObject:[[UIImage alloc] initWithContentsOfFile:yellowFile]];
}

-(void)prepareFlashingAnimations {
//    NSString *fileToBlack;
//    animFlashToBlack = [[NSMutableArray alloc] initWithCapacity:5];
//    for(int j = 1; j<=5; j++) {
//        fileToBlack = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"BlackOpacity-%i", j] ofType:@"png"];
//        [animFlashToBlack addObject:[[UIImage alloc] initWithContentsOfFile:fileToBlack]];
//    }
//    
//    NSString *fileFromBlack;
//    animFlashFromBlack = [[NSMutableArray alloc] initWithCapacity:5];
//    for(int j = 5; j>=1; j--) {
//        fileFromBlack = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"BlackOpacity-%i", j] ofType:@"png"];
//        [animFlashFromBlack addObject:[[UIImage alloc] initWithContentsOfFile:fileFromBlack]];
//    }
    
    NSString *fileToWhite;
    animFlashToWhite = [[NSMutableArray alloc] initWithCapacity:4];
    for(int j = 1; j<=4; j++) {
        fileToWhite = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"WhiteOpacityy-%i", j] ofType:@"png"];
        [animFlashToWhite addObject:[[UIImage alloc] initWithContentsOfFile:fileToWhite]];
    }
    
//    NSString *fileFromWhite;
//    animFlashFromWhite = [[NSMutableArray alloc] initWithCapacity:6];
//    for(int j = 6; j>=1; j--) {
//        fileFromWhite = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"WhiteOpacity-%i", j] ofType:@"png"];
//        [animFlashFromWhite addObject:[[UIImage alloc] initWithContentsOfFile:fileFromWhite]];
//    }
}

-(void)prepareClockFlashes {

    //FULL
    NSString *sleepyFull;
    sleepyFlashFull = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        sleepyFull = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_FLASH-F-%i", j] ofType:@"png"];
        [sleepyFlashFull addObject:[[UIImage alloc] initWithContentsOfFile:sleepyFull]];
    }
    
    NSString *dizzyFull;
    dizzyFlashFull = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        dizzyFull = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DIZZY_262px_FLASH-F-%i", j] ofType:@"png"];
        [dizzyFlashFull addObject:[[UIImage alloc] initWithContentsOfFile:dizzyFull]];
    }
    
    NSString *ninjaFull;
    ninjaFlashFull = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        ninjaFull = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-NINJA_262px_FLASH-F-%i", j] ofType:@"png"];
        [ninjaFlashFull addObject:[[UIImage alloc] initWithContentsOfFile:ninjaFull]];
    }
    
    NSString *icyFull;
    icyFlashFull = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        icyFull = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ICY_262px_FLASH-F-%i", j] ofType:@"png"];
        [icyFlashFull addObject:[[UIImage alloc] initWithContentsOfFile:icyFull]];
    }
    
    //LEFT & RIGHT
    NSString *ordinaryLeft;
    ordinaryFlashLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        ordinaryLeft = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ORDINARY_262px_FLASH-L-%i", j] ofType:@"png"];
        [ordinaryFlashLeft addObject:[[UIImage alloc] initWithContentsOfFile:ordinaryLeft]];
    }
    
    NSString *ordinaryRight;
    ordinaryFlashRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        ordinaryRight = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ORDINARY_262px_FLASH-R-%i", j] ofType:@"png"];
        [ordinaryFlashRight addObject:[[UIImage alloc] initWithContentsOfFile:ordinaryRight]];
    }
    
    NSString *reversedLeft;
    reversedFlashLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        reversedLeft = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-REVERSE_262px_FLASH-L-%i", j] ofType:@"png"];
        [reversedFlashLeft addObject:[[UIImage alloc] initWithContentsOfFile:reversedLeft]];
    }
    
    NSString *reversedRight;
    reversedFlashRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        reversedRight = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-REVERSE_262px_FLASH-R-%i", j] ofType:@"png"];
        [reversedFlashRight addObject:[[UIImage alloc] initWithContentsOfFile:reversedRight]];
    }
    
    NSString *flowerLeft;
    flowerFlashLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flowerLeft = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-PINK FLOWER_262px_FLASH-L-%i", j] ofType:@"png"];
        [flowerFlashLeft addObject:[[UIImage alloc] initWithContentsOfFile:flowerLeft]];
    }
    
    NSString *flowerRight;
    flowerFlashRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flowerRight = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-PINK FLOWER_262px_FLASH-R-%i", j] ofType:@"png"];
        [flowerFlashRight addObject:[[UIImage alloc] initWithContentsOfFile:flowerRight]];
    }
    
    NSString *romanLeft;
    romanFlashLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        romanLeft = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ROMAN_262px_FLASH-L-%i", j] ofType:@"png"];
        [romanFlashLeft addObject:[[UIImage alloc] initWithContentsOfFile:romanLeft]];
    }
    
    NSString *romanRight;
    romanFlashRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        romanRight = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ROMAN_262px_FLASH-R-%i", j] ofType:@"png"];
        [romanFlashRight addObject:[[UIImage alloc] initWithContentsOfFile:romanRight]];
    }
    
    NSString *devilLeft;
    devilFlashLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        devilLeft = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DEVIL_262px_FLASH-L-%i", j] ofType:@"png"];
        [devilFlashLeft addObject:[[UIImage alloc] initWithContentsOfFile:devilLeft]];
    }
    
    NSString *devilRight;
    devilFlashRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        devilRight = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DEVIL_262px_FLASH-R-%i", j] ofType:@"png"];
        [devilFlashRight addObject:[[UIImage alloc] initWithContentsOfFile:devilRight]];
    }
    
    NSString *chineseLeft;
    chineseFlashLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        chineseLeft = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-CHINESE_262px_FLASH-L-%i", j] ofType:@"png"];
        [chineseFlashLeft addObject:[[UIImage alloc] initWithContentsOfFile:chineseLeft]];
    }
    
    NSString *chineseRight;
    chineseFlashRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        chineseRight = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-CHINESE_262px_FLASH-R-%i", j] ofType:@"png"];
        [chineseFlashRight addObject:[[UIImage alloc] initWithContentsOfFile:chineseRight]];
    }
    
    NSString *brokenLeft;
    brokenFlashLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        brokenLeft = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-BROKEN_262px_FLASH-L-%i", j] ofType:@"png"];
        [brokenFlashLeft addObject:[[UIImage alloc] initWithContentsOfFile:brokenLeft]];
    }
    
    NSString *brokenRight;
    brokenFlashRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        brokenRight = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-BROKEN_262px_FLASH-R-%i", j] ofType:@"png"];
        [brokenFlashRight addObject:[[UIImage alloc] initWithContentsOfFile:brokenRight]];
    }
}

-(void)prepareEatingAnimations {
    
    NSString *ordinaryEating;
    ordinaryEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        ordinaryEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ORDINARY_262px_CAPSULE-%i", j] ofType:@"png"];
        [ordinaryEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:ordinaryEating]];
    }
    
    NSString *reversedEating;
    reversedEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        reversedEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-REVERSE_262px_CAPSULE-%i", j] ofType:@"png"];
        [reversedEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:reversedEating]];
    }
    
    NSString *sleepyEating;
    sleepyEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        sleepyEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_CAPSULE-%i", j] ofType:@"png"];
        [sleepyEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:sleepyEating]];
    }
    
    NSString *dizzyEating;
    dizzyEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        dizzyEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DIZZY_262px_CAPSULE-%i", j] ofType:@"png"];
        [dizzyEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:dizzyEating]];
    }
    
    NSString *flowerEating;
    flowerEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        flowerEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-PINK FLOWER_262px_CAPSULE-%i", j] ofType:@"png"];
        [flowerEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:flowerEating]];
    }
    
    NSString *romanEating;
    romanEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        romanEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ROMAN_262px_CAPSULE-%i", j] ofType:@"png"];
        [romanEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:romanEating]];
    }
    
    NSString *ninjaEating;
    ninjaEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        ninjaEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-NINJA_262px_CAPSULE-%i", j] ofType:@"png"];
        [ninjaEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:ninjaEating]];
    }
    
    NSString *icyEating;
    icyEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        icyEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ICY_262px_CAPSULE-%i", j] ofType:@"png"];
        [icyEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:icyEating]];
    }
    
    NSString *angelEating;
    angelEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        angelEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ANGEL_262px_CAPSULE-%i", j] ofType:@"png"];
        [angelEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:angelEating]];
    }
    
    NSString *chineseEating;
    chineseEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        chineseEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-CHINESE_262px_CAPSULE-%i", j] ofType:@"png"];
        [chineseEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:chineseEating]];
    }
    
    NSString *brokenEating;
    brokenEatingAnim = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        brokenEating = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-BROKEN_262px_CAPSULE-%i", j] ofType:@"png"];
        [brokenEatingAnim addObject:[[UIImage alloc] initWithContentsOfFile:brokenEating]];
    }
}

-(void)prepareArrowFlashes {
    NSString *flash1;
    arrowFlash3BfrTL = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowBottomInThreeFromTopLeft-%i", j] ofType:@"png"];
        [arrowFlash3BfrTL addObject:[[UIImage alloc] initWithContentsOfFile:flash1]];
    }
    
    NSString *flash2;
    arrowFlash3BfrTR = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowBottomInThreeFromTopRight-%i", j] ofType:@"png"];
        [arrowFlash3BfrTR addObject:[[UIImage alloc] initWithContentsOfFile:flash2]];
    }
    
    NSString *flash3;
    arrowFlash3toTL = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowTopLeftInThree-%i", j] ofType:@"png"];
        [arrowFlash3toTL addObject:[[UIImage alloc] initWithContentsOfFile:flash3]];
    }
    
    NSString *flash4;
    arrowFlash3toTR = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash4 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowTopRightInThree-%i", j] ofType:@"png"];
        [arrowFlash3toTR addObject:[[UIImage alloc] initWithContentsOfFile:flash4]];
    }
    
    NSString *flash5;
    arrowFlash4toBL = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash5 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowBottomLeft-%i", j] ofType:@"png"];
        [arrowFlash4toBL addObject:[[UIImage alloc] initWithContentsOfFile:flash5]];
    }
    
    NSString *flash6;
    arrowFlash4toBR = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash6 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowBottomRight-%i", j] ofType:@"png"];
        [arrowFlash4toBR addObject:[[UIImage alloc] initWithContentsOfFile:flash6]];
    }
    
    NSString *flash7;
    arrowFlash4toTL = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash7 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowTopLeft-%i", j] ofType:@"png"];
        [arrowFlash4toTL addObject:[[UIImage alloc] initWithContentsOfFile:flash7]];
    }
    
    NSString *flash8;
    arrowFlash4toTR = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash8 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowTopRight-%i", j] ofType:@"png"];
        [arrowFlash4toTR addObject:[[UIImage alloc] initWithContentsOfFile:flash8]];
    }
    
    NSString *flash9;
    arrowFlashToLeft = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash9 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowLeft-%i", j] ofType:@"png"];
        [arrowFlashToLeft addObject:[[UIImage alloc] initWithContentsOfFile:flash9]];
    }
    
    NSString *flash10;
    arrowFlashToRight = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash10 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowRight-%i", j] ofType:@"png"];
        [arrowFlashToRight addObject:[[UIImage alloc] initWithContentsOfFile:flash10]];
    }
    
    NSString *flash11;
    arrowFlashToDown = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash11 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowDown-%i", j] ofType:@"png"];
        [arrowFlashToDown addObject:[[UIImage alloc] initWithContentsOfFile:flash11]];
    }
    
    NSString *flash12;
    arrowFlashToUp = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        flash12 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"LinkingArrowUp-%i", j] ofType:@"png"];
        [arrowFlashToUp addObject:[[UIImage alloc] initWithContentsOfFile:flash12]];
    }
}

-(void)prepareAnimation {
    
    
    
}

-(void)prepareOrdinaryWinAnim {
    NSString *fileOrdinary3;
    animOrdinaryWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileOrdinary3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ORDINARY_262px_WIN-%i", j] ofType:@"png"];
        [animOrdinaryWin addObject:[[UIImage alloc] initWithContentsOfFile:fileOrdinary3]];
    }
}

-(void)prepareReversedWinAnim {
    NSString *fileReversed3;
    animReversedWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileReversed3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-REVERSE_262px_WIN-%i", j] ofType:@"png"];
        [animReversedWin addObject:[[UIImage alloc] initWithContentsOfFile:fileReversed3]];
    }
}

-(void)prepareSleepyWinAnim {
    NSString *fileSleepy6;
    animSleepyWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileSleepy6 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_WIN-%i", j] ofType:@"png"];
        [animSleepyWin addObject:[[UIImage alloc] initWithContentsOfFile:fileSleepy6]];
    }
}

-(void)prepareDizzyWinAnim {
    NSString *fileDizzy3;
    animDizzyWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileDizzy3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DIZZY_262px_WIN-%i", j] ofType:@"png"];
        [animDizzyWin addObject:[[UIImage alloc] initWithContentsOfFile:fileDizzy3]];
    }
}

-(void)prepareFlowerWinAnim {
    NSString *fileFlower3;
    animFlowerWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileFlower3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-PINK FLOWER_262px_WIN-%i", j] ofType:@"png"];
        [animFlowerWin addObject:[[UIImage alloc] initWithContentsOfFile:fileFlower3]];
    }
}

-(void)prepareRomanWinAnim {
    NSString *fileRoman3;
    animRomanWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileRoman3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ROMAN_262px_WIN-%i", j] ofType:@"png"];
        [animRomanWin addObject:[[UIImage alloc] initWithContentsOfFile:fileRoman3]];
    }
}

-(void)prepareNinjaWinAnim {
    NSString *fileNinja3;
    animNinjaWin = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        fileNinja3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-NINJA_262px_WIN-%i", j] ofType:@"png"];
        [animNinjaWin addObject:[[UIImage alloc] initWithContentsOfFile:fileNinja3]];
    }
}

-(void)prepareIcyWinAnim {
    NSString *fileIcy3;
    animIcyWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileIcy3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ICY_262px_WIN-%i", j] ofType:@"png"];
        [animIcyWin addObject:[[UIImage alloc] initWithContentsOfFile:fileIcy3]];
    }
}

-(void)prepareTwofaceWinAnim {
    NSString *fileAngel3;
    animAngelWin = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        fileAngel3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ANGEL_262px_WIN-%i", j] ofType:@"png"];
        [animAngelWin addObject:[[UIImage alloc] initWithContentsOfFile:fileAngel3]];
    }
}

-(void)prepareChineseWinAnim {
    NSString *fileChinese3;
    animChineseWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileChinese3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-CHINESE_262px_WIN-%i", j] ofType:@"png"];
        [animChineseWin addObject:[[UIImage alloc] initWithContentsOfFile:fileChinese3]];
    }
}

-(void)prepareBrokenWinAnim {
    NSString *fileBroken3;
    animBrokenWin = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileBroken3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-BROKEN_262px_WIN-%i", j] ofType:@"png"];
        [animBrokenWin addObject:[[UIImage alloc] initWithContentsOfFile:fileBroken3]];
    }
}

-(void)prepareOrdinaryAnimNotWin {
    NSString *fileOrdinary1;
    regularAnimationStandard1 = [[NSMutableArray alloc] initWithCapacity:10];
    for(int i = 1; i<=10; i++) {
        fileOrdinary1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ORDINARY_262px_BLINK-%i", i] ofType:@"png"];
        [regularAnimationStandard1 addObject:[[UIImage alloc] initWithContentsOfFile:fileOrdinary1]];
    }
    
    NSString *fileOrdinary2;
    animOrdinaryB = [[NSMutableArray alloc] initWithCapacity:11];
    for(int j = 1; j<=11; j++) {
        fileOrdinary2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ORDINARY_262px_WINK-%i", j] ofType:@"png"];
        [animOrdinaryB addObject:[[UIImage alloc] initWithContentsOfFile:fileOrdinary2]];
    }
}

-(void)prepareReversedAnimNotWin {
    NSString *fileReversed1;
    animReversedA = [[NSMutableArray alloc] initWithCapacity:17];
    for(int j = 1; j<=17; j++) {
        fileReversed1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-REVERSE_262px_BLINK-%i", j] ofType:@"png"];
        [animReversedA addObject:[[UIImage alloc] initWithContentsOfFile:fileReversed1]];
    }
    
    NSString *fileReversed2;
    animReversedB = [[NSMutableArray alloc] initWithCapacity:10];
    for(int j = 1; j<=10; j++) {
        fileReversed2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-REVERSE_262px_SPIN-%i", j] ofType:@"png"];
        [animReversedB addObject:[[UIImage alloc] initWithContentsOfFile:fileReversed2]];
    }
}

-(void)prepareSleepyAnimNotWin {
    [self prepareSleepToAwake]; //preload
    [self prepareAwakeToSleep]; //preload
    
    NSString *fileSleepy1;
    animSleepyA = [[NSMutableArray alloc] initWithCapacity:8];
    for(int j = 1; j<=8; j++) {
        fileSleepy1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_BLINK-%i", j] ofType:@"png"];
        [animSleepyA addObject:[[UIImage alloc] initWithContentsOfFile:fileSleepy1]];
    }
    
    NSString *fileSleepy2;
    animSleepyB = [[NSMutableArray alloc] initWithCapacity:17];
    for(int j = 1; j<=17; j++) {
        fileSleepy2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_YAWN-%i", j] ofType:@"png"];
        [animSleepyB addObject:[[UIImage alloc] initWithContentsOfFile:fileSleepy2]];
    }
    
    NSString *fileSleepy3;
    animSleepySleeping = [[NSMutableArray alloc] initWithCapacity:16];
    for(int j = 1; j<=16; j++) {
        fileSleepy3 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_SLEEP-%i", j] ofType:@"png"];
        [animSleepySleeping addObject:[[UIImage alloc] initWithContentsOfFile:fileSleepy3]];
    }
    
    NSString *fileSleepy4;
    animSleepToAwake = [[NSMutableArray alloc] initWithCapacity:4];
    for(int j = 1; j<=4; j++) {
        fileSleepy4 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_TRANSITION-%i", j] ofType:@"png"];
        [animSleepToAwake addObject:[[UIImage alloc] initWithContentsOfFile:fileSleepy4]];
    }
    
    NSString *fileSleepy5;
    animAwakeToSleep = [[NSMutableArray alloc] initWithCapacity:4];
    for(int j = 1; j<=4; j++) {
        fileSleepy5 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_TRANSITION-a%i", j] ofType:@"png"];
        [animAwakeToSleep addObject:[[UIImage alloc] initWithContentsOfFile:fileSleepy5]];
    }
}

-(void)prepareDizzyAnimNotWin {
    NSString *fileDizzy1;
    animDizzyA = [[NSMutableArray alloc] initWithCapacity:6];
    for(int j = 1; j<=6; j++) {
        fileDizzy1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DIZZY_262px_BLINK-%i", j] ofType:@"png"];
        [animDizzyA addObject:[[UIImage alloc] initWithContentsOfFile:fileDizzy1]];
    }
    
    NSString *fileDizzy2;
    animDizzyB = [[NSMutableArray alloc] initWithCapacity:18];
    for(int j = 1; j<=18; j++) {
        fileDizzy2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DIZZY_262px_CONFUSE-%i", j] ofType:@"png"];
        [animDizzyB addObject:[[UIImage alloc] initWithContentsOfFile:fileDizzy2]];
    }
}

-(void)prepareFlowerAnimNotWin {
    NSString *fileFlower1;
    animFlowerA = [[NSMutableArray alloc] initWithCapacity:6];
    for(int j = 1; j<=6; j++) {
        fileFlower1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-PINK FLOWER_262px_BLINK-%i", j] ofType:@"png"];
        [animFlowerA addObject:[[UIImage alloc] initWithContentsOfFile:fileFlower1]];
    }
    
    NSString *fileFlower2;
    animFlowerB = [[NSMutableArray alloc] initWithCapacity:20];
    for(int j = 1; j<=20; j++) {
        fileFlower2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-PINK FLOWER_262px_NAUGHTY-%i", j] ofType:@"png"];
        [animFlowerB addObject:[[UIImage alloc] initWithContentsOfFile:fileFlower2]];
    }
}

-(void)prepareRomanAnimNotWin {
    NSString *fileRoman1;
    animRomanA = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        fileRoman1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ROMAN_262px_BLINK-%i", j] ofType:@"png"];
        [animRomanA addObject:[[UIImage alloc] initWithContentsOfFile:fileRoman1]];
    }
    
    NSString *fileRoman2;
    animRomanB = [[NSMutableArray alloc] initWithCapacity:23];
    for(int j = 1; j<=23; j++) {
        fileRoman2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ROMAN_262px_ANGRY-%i", j] ofType:@"png"];
        [animRomanB addObject:[[UIImage alloc] initWithContentsOfFile:fileRoman2]];
    }
}

-(void)prepareNinjaAnimNotWin {
    NSString *fileNinja1;
    animNinjaA = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        fileNinja1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-NINJA_262px_BLINK-%i", j] ofType:@"png"];
        [animNinjaA addObject:[[UIImage alloc] initWithContentsOfFile:fileNinja1]];
    }
    
    NSString *fileNinja2;
    animNinjaB = [[NSMutableArray alloc] initWithCapacity:24];
    for(int j = 1; j<=24; j++) {
        fileNinja2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-NINJA_262px_FOCUS-%i", j] ofType:@"png"];
        [animNinjaB addObject:[[UIImage alloc] initWithContentsOfFile:fileNinja2]];
    }
}

-(void)prepareIcyAnimNotWin {
    NSString *fileIcy1;
    animIcyA = [[NSMutableArray alloc] initWithCapacity:16];
    for(int j = 1; j<=16; j++) {
        fileIcy1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ICY_262px_BLINK-%i", j] ofType:@"png"];
        [animIcyA addObject:[[UIImage alloc] initWithContentsOfFile:fileIcy1]];
    }
    
    NSString *fileIcy2;
    animIcyB = [[NSMutableArray alloc] initWithCapacity:15];
    for(int j = 1; j<=15; j++) {
        fileIcy2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ICY_262px_ROLL EYES-%i", j] ofType:@"png"];
        [animIcyB addObject:[[UIImage alloc] initWithContentsOfFile:fileIcy2]];
    }
}

-(void)prepareTwofaceAnimNotWin {
    NSString *fileAngel1;
    animAngelA = [[NSMutableArray alloc] initWithCapacity:6];
    for(int j = 1; j<=6; j++) {
        fileAngel1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-ANGEL_262px_BLINK-%i", j] ofType:@"png"];
        [animAngelA addObject:[[UIImage alloc] initWithContentsOfFile:fileAngel1]];
    }
    
    NSString *fileDevil1;
    animDevilA = [[NSMutableArray alloc] initWithCapacity:5];
    for(int j = 1; j<=5; j++) {
        fileDevil1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-DEVIL_262px_BLINK-%i", j] ofType:@"png"];
        [animDevilA addObject:[[UIImage alloc] initWithContentsOfFile:fileDevil1]];
    }
    
    NSString *fileAtoD;
    animAngeltoDevil = [[NSMutableArray alloc] initWithCapacity:7];
    for(int j = 1; j<=7; j++) {
        fileAtoD = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-TWO FACE_262px_TRANSITION-%i", j] ofType:@"png"];
        [animAngeltoDevil addObject:[[UIImage alloc] initWithContentsOfFile:fileAtoD]];
    }
    
    NSString *fileDtoA;
    animDevilToAngel = [[NSMutableArray alloc] initWithCapacity:7];
    for(int j = 1; j<=7; j++) {
        fileDtoA = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-TWO FACE_262px_TRANSITION-a%i", j] ofType:@"png"];
        [animDevilToAngel addObject:[[UIImage alloc] initWithContentsOfFile:fileDtoA]];
    }
}

-(void)prepareChineseAnimNotWin {
    NSString *fileChinese1;
    animChineseA = [[NSMutableArray alloc] initWithCapacity:18];
    for(int j = 1; j<=18; j++) {
        fileChinese1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-CHINESE_262px_SHOCK-%i", j] ofType:@"png"];
        [animChineseA addObject:[[UIImage alloc] initWithContentsOfFile:fileChinese1]];
    }
    
    NSString *fileChinese2;
    animChineseB = [[NSMutableArray alloc] initWithCapacity:12];
    for(int j = 1; j<=12; j++) {
        fileChinese2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-CHINESE_262px_SNEEZE-%i", j] ofType:@"png"];
        [animChineseB addObject:[[UIImage alloc] initWithContentsOfFile:fileChinese2]];
    }
}

-(void)prepareBrokenAnimNotWin {
    NSString *fileBroken1;
    animBrokenA = [[NSMutableArray alloc] initWithCapacity:13];
    for(int j = 1; j<=13; j++) {
        fileBroken1 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-BROKEN_262px_RAISE EYEBROW-%i", j] ofType:@"png"];
        [animBrokenA addObject:[[UIImage alloc] initWithContentsOfFile:fileBroken1]];
    }
    
    NSString *fileBroken2;
    animBrokenB = [[NSMutableArray alloc] initWithCapacity:17];
    for(int j = 1; j<=17; j++) {
        fileBroken2 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-BROKEN_262px_CRY-%i", j] ofType:@"png"];
        [animBrokenB addObject:[[UIImage alloc] initWithContentsOfFile:fileBroken2]];
    }
}

//-(void)prepareLongBrokenForward {
//    NSString *fileName;
//    longIcyForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
//    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Long_1"] ofType:@"png"];
//    [longIcyForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//}

-(void)prepareLongArrowAnimationForwardFromDown {
    NSString *fileName;
    longArrowFullLoopAnimationFromDown = [[NSMutableArray alloc] initWithCapacity:60];
    for(int i = 13; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowFullLoopAnimationFromDown addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
    for(int i = 1; i<=13; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowFullLoopAnimationFromDown addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareLongArrowAnimationLazyForward {
    NSString *fileName;
    longArrowLazyForward = [[NSMutableArray alloc] initWithCapacity:20];
    for(int i = 2; i<=6; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_%i", i] ofType:@"png"];
        [longArrowLazyForward addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
    for(int i = 5; i>=1; i--) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_%i", i] ofType:@"png"];
        [longArrowLazyForward addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareLongArrowAnimationBackwardFromDown {
    NSString *fileName;
    longArrowFullLoopAnimationFromDownReversed = [[NSMutableArray alloc] initWithCapacity:60];
    for(int i = 12; i>=1; i--) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowFullLoopAnimationFromDownReversed addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
    for(int i = 24; i>=13; i--) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowFullLoopAnimationFromDownReversed addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareLongArrowAnimationLazyBackward {
    NSString *fileName;
    longArrowLazyBackward = [[NSMutableArray alloc] initWithCapacity:20];
    for(int i = 24; i>=20; i--) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_%i", i] ofType:@"png"];
        [longArrowLazyBackward addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
    for(int i = 20; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_%i", i] ofType:@"png"];
        [longArrowLazyBackward addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

//broken clock long arrow animations
-(void)prepareLongArrowAnimationRightToDown {
    NSString *fileName;
    longArrowRightToDownAnimation = [[NSMutableArray alloc] initWithCapacity:13];
    for(int i = 2; i<=13; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowRightToDownAnimation addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareLongArrowAnimationLeftToUp {
    NSString *fileName;
    longArrowLeftToUpAnimation = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 14; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowLeftToUpAnimation addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_1"] ofType:@"png"];
    [longArrowLeftToUpAnimation addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

-(void)prepareLongArrowAnimationLeftToDown {
    NSString *fileName;
    longArrowLeftToDownAnimation = [[NSMutableArray alloc] initWithCapacity:30];
    for(int i = 24; i>=13; i--) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowLeftToDownAnimation addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareLongArrowAnimationRightToUp {
    NSString *fileName;
    longArrowRightToUpAnimation = [[NSMutableArray alloc] initWithCapacity:30];
    for(int i = 12; i>=1; i--) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", i] ofType:@"png"];
        [longArrowRightToUpAnimation addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

////////////SHORT FORWARD STARTS/////////////

///SHORT - starts///
-(void)prepareShortOrdinaryForward {
    NSString *fileName;
    shortOrdinaryForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Short_%i", i] ofType:@"png"];
        [shortOrdinaryForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortReversedForward {
    NSString *fileName;
    shortReversedForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Reversed_Short_%i", i] ofType:@"png"];
        [shortReversedForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortSleepyForward {
    NSString *fileName;
    shortSleepyForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Sleepy_Short_%i", i] ofType:@"png"];
        [shortSleepyForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortDizzyForward {
    NSString *fileName;
    shortDizzyForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Short_%i", i] ofType:@"png"];
        [shortDizzyForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortFlowerForward {
    NSString *fileName;
    shortFlowerForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Short_%i", i] ofType:@"png"];
        [shortFlowerForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortRomanForward {
    NSString *fileName;
    shortRomanForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Roman_Short_%i", i] ofType:@"png"];
        [shortRomanForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortNinjaForward {
    NSString *fileName;
    shortNinjaForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Ninja_Short_%i", i] ofType:@"png"];
        [shortNinjaForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortIcyForward {
    NSString *fileName;
    shortIcyForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Short_%i", i] ofType:@"png"];
        [shortIcyForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortDevilForward {
    NSString *fileName;
    shortDevilForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Devil_Short_%i", i] ofType:@"png"];
        [shortDevilForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortAngelForward {
    NSString *fileName;
    shortAngelForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_%i", i] ofType:@"png"];
        [shortAngelForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareShortChineseForward {
    NSString *fileName;
    shortChineseForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i = 1; i<=24; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Chinese_Short_%i", i] ofType:@"png"];
        [shortChineseForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}
///SHORT - ends///

///LONG - starts///
-(void)prepareLongOrdinaryForward {
    NSString *fileName;
    longOrdinaryForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Long_1"] ofType:@"png"];
    [longOrdinaryForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongOrdinaryForward {
//    NSString *fileName;
//    longOrdinaryForwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 1; i<=24; i++) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Long_%i", i] ofType:@"png"];
//        [longOrdinaryForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}
//
//-(void)prepareLongOrdinaryBackward {
//    NSString *fileName;
//    longOrdinaryBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Long_%i", i] ofType:@"png"];
//        [longOrdinaryBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongReversedForward {
    NSString *fileName;
    longReversedForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Reversed_Long_1"] ofType:@"png"];
    [longReversedForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongReversedBackward {
//    NSString *fileName;
//    longReversedBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Reversed_Long_%i", i] ofType:@"png"];
//        [longReversedBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongSleepyForward {
    NSString *fileName;
    longSleepyForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Sleepy_Long_1"] ofType:@"png"];
    [longSleepyForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongSleepyBackward {
//    NSString *fileName;
//    longSleepyBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Sleepy_Long_%i", i] ofType:@"png"];
//        [longSleepyBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongDizzyForward {
    NSString *fileName;
    longDizzyForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Long_1"] ofType:@"png"];
    [longDizzyForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongDizzyBackward {
//    NSString *fileName;
//    longDizzyBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Long_%i", i] ofType:@"png"];
//        [longDizzyBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongDizzyYellowForward {
    NSString *fileName;
    longDizzyYellowForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Long_Yellow_1"] ofType:@"png"];
    [longDizzyYellowForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongDizzyYellowBackward {
//    NSString *fileName;
//    longDizzyYellowBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Long_Yellow_%i", i] ofType:@"png"];
//        [longDizzyYellowBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongFlowerForward {
    NSString *fileName;
    longFlowerForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_1"] ofType:@"png"];
    [longFlowerForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongFlowerBackward {
//    NSString *fileName;
//    longFlowerBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_%i", i] ofType:@"png"];
//        [longFlowerBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongRomanForward {
    NSString *fileName;
    longRomanForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Roman_Long_1"] ofType:@"png"];
    [longRomanForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongRomanBackward {
//    NSString *fileName;
//    longRomanBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Roman_Long_%i", i] ofType:@"png"];
//        [longRomanBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongNinjaForward {
    NSString *fileName;
    longNinjaForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Ninja_Long_1"] ofType:@"png"];
    [longNinjaForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongNinjaBackward {
//    NSString *fileName;
//    longNinjaBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Ninja_Long_%i", i] ofType:@"png"];
//        [longNinjaBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongIcyForward {
    NSString *fileName;
    longIcyForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Long_1"] ofType:@"png"];
    [longIcyForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongIcyBackward {
//    NSString *fileName;
//    longIcyBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Long_%i", i] ofType:@"png"];
//        [longIcyBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongDevilForward {
    NSString *fileName;
    longDevilForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Devil_Long_1"] ofType:@"png"];
    [longDevilForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongDevilBackward {
//    NSString *fileName;
//    longDevilBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Devil_Long_%i", i] ofType:@"png"];
//        [longDevilBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}

-(void)prepareLongAngelForward {
    NSString *fileName;
    longAngelForwardAnim = [[NSMutableArray alloc] initWithCapacity:1];
    fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Long_1"] ofType:@"png"];
    [longAngelForwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
}

//-(void)prepareLongAngelBackward {
//    NSString *fileName;
//    longAngelBackwardAnim = [[NSMutableArray alloc] initWithCapacity:24];
//    for(int i = 24; i>=1; i--) {
//        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Long_%i", i] ofType:@"png"];
//        [longAngelBackwardAnim addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
//    }
//}
///LONG -  ends///


- (void) startTimer {
    [NSTimer scheduledTimerWithTimeInterval:1.5
                                     target:self
                                   selector:@selector(tick:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) startAudioTimer {
    [NSTimer scheduledTimerWithTimeInterval:0.6
                                     target:self
                                   selector:@selector(firstAudio:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void) tick:(NSTimer *) timer {
    [self paintMainMenu];
    [self dePaintLogoPage];
}

- (void) firstAudio:(NSTimer *) timer {
    [self audioMainPlay];
}

-(void) paintMainMenu {
    
    NSString* mainPath;
    if (IS_WIDESCREEN) {
        mainPath = [[NSBundle mainBundle] pathForResource:@"Background2" ofType:@"png"];
    } else {
        mainPath = [[NSBundle mainBundle] pathForResource:@"Background2_3.5inches" ofType:@"png"];
    }
    imageMainMenu = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:mainPath]];
    [imageMainMenu setFrame:gameModel.backgroundRect];
    [self.view addSubview:imageMainMenu];
    
    NSString* titlePath = [[NSBundle mainBundle] pathForResource:@"MainMenu_Title" ofType:@"png"];
    titleImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:titlePath]];
    [titleImage setFrame:gameModel.titleRect];
    titleImage.userInteractionEnabled = NO;
    [self.view addSubview:titleImage];
    
    NSString* playPath = [[NSBundle mainBundle] pathForResource:@"PlayButton" ofType:@"png"];
    playButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:playPath]];
    [playButton setFrame:gameModel.playButtonRect];
    playButton.userInteractionEnabled = YES;
    [self.view addSubview:playButton];
    
    NSString* optionsPath = [[NSBundle mainBundle] pathForResource:@"OptionsButton" ofType:@"png"];
    optionsButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:optionsPath]];
    [optionsButton setFrame:gameModel.optionsButtonRect];
    optionsButton.userInteractionEnabled = YES;
    [self.view addSubview:optionsButton];
    
    NSString* facebookPath = [[NSBundle mainBundle] pathForResource:@"FacebookButton" ofType:@"png"];
    facebookButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:facebookPath]];
    [facebookButton setFrame:gameModel.facebook_mainPageRect];
    facebookButton.userInteractionEnabled = YES;
    [self.view addSubview:facebookButton];
    
    NSString* collectionsPath = [[NSBundle mainBundle] pathForResource:@"Collections_Button" ofType:@"png"];
    collectionsButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:collectionsPath]];
    [collectionsButton setFrame:gameModel.collections_mainPageRect];
    collectionsButton.userInteractionEnabled = YES;
    [self.view addSubview:collectionsButton];
}

-(void) dePaintMainMenu {
    [titleImage removeFromSuperview];
    titleImage = nil;
    
    [playButton removeFromSuperview];
    playButton = nil;
    [collectionsButton removeFromSuperview];
    collectionsButton = nil;
    [optionsButton removeFromSuperview];
    optionsButton = nil;
    [facebookButton removeFromSuperview];
    facebookButton = nil;
    
    [imageMainMenu removeFromSuperview];
    imageMainMenu = nil;
}

-(void) paintPauseMenu {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackAch = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackAch setFrame:gameModel.backgroundRect];
    opacityBlackAch.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackAch];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:@"PauseMenu_Board" ofType:@"png"];
    pauseBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [pauseBoardImage setFrame:gameModel.achBoardRect];
    pauseBoardImage.userInteractionEnabled = YES;
    [opacityBlackAch addSubview:pauseBoardImage];
    
    NSString* resumePath = [[NSBundle mainBundle] pathForResource:@"ResumeButton" ofType:@"png"];
    pauseResumeImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:resumePath]];
    [pauseResumeImage setFrame:gameModel.pauseResumeRect];
    pauseResumeImage.userInteractionEnabled = YES;
    [pauseBoardImage addSubview:pauseResumeImage];
    
    NSString* pauseMainPath = [[NSBundle mainBundle] pathForResource:@"ToMainMenu_Button" ofType:@"png"];
    pauseMainMenuImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:pauseMainPath]];
    [pauseMainMenuImage setFrame:gameModel.pauseMainRect];
    pauseMainMenuImage.userInteractionEnabled = YES;
    [pauseBoardImage addSubview:pauseMainMenuImage];
    
    NSString* pausePurchasePath = [[NSBundle mainBundle] pathForResource:@"PurchaseButton" ofType:@"png"];
    pausePurchaseImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:pausePurchasePath]];
    [pausePurchaseImage setFrame:gameModel.pausePurchaseRect];
    pausePurchaseImage.userInteractionEnabled = YES;
    [pauseBoardImage addSubview:pausePurchaseImage];
}

-(void) dePaintPauseMenu {
    [pausePurchaseImage removeFromSuperview];
    pausePurchaseImage = nil;
    [pauseMainMenuImage removeFromSuperview];
    pauseMainMenuImage = nil;
    [pauseResumeImage removeFromSuperview];
    pauseResumeImage = nil;
    [pauseBoardImage removeFromSuperview];
    pauseBoardImage = nil;
    [opacityBlackAch removeFromSuperview];
    opacityBlackAch = nil;
}

-(void) paintThemeMenu:(BOOL) isFromWinPage {
    NSString* background2Path;
    if (IS_WIDESCREEN) {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2" ofType:@"png"];
    } else {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2_3.5inches" ofType:@"png"];
    }
    imageBackground2 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:background2Path]];
    [imageBackground2 setFrame:gameModel.backgroundRect];
    [self.view addSubview:imageBackground2];
    
    ///////Package to draw theme pages////////
    [self paintScrollView:5];
    [scrollView paintTransparentViews];
    [self drawThemeBoxes:isFromWinPage];
    ///////Package to draw theme pages////////
    
    NSString* backPath = [[NSBundle mainBundle] pathForResource:@"BackButton" ofType:@"png"];
    backButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backPath]];
    [backButton setFrame:gameModel.backButtonRect];
    backButton.userInteractionEnabled = YES;
    [self.view addSubview:backButton];
    
    [self drawCapsuleButtonNotIngame:gameModel.capsuleAtBottomRight];
    
    [self paintTotalStars];
}

-(void) drawThemeBoxes:(BOOL) isFromWinPageParam {
    if ([self getTotalStars] >= 160 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 90) {
        [scrollView paintThemeBoxes:4 isFromWinPageArg:isFromWinPageParam];
    } else if ([self getTotalStars] >= 105 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 60) {
        [scrollView paintThemeBoxes:3 isFromWinPageArg:isFromWinPageParam];
    } else if ([self getTotalStars] >= 50 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 30) {
        [scrollView paintThemeBoxes:2 isFromWinPageArg:isFromWinPageParam];
    } else {
        [scrollView paintThemeBoxes:1 isFromWinPageArg:isFromWinPageParam];
    }
}

-(void) paintScrollView:(int)pages {
    scrollView=[[ScrollViewController alloc] initWithFrame:gameModel.fullScreenRect];
    scrollView.myDelegate = self;
    scrollView.gameModel = gameModel;
    scrollView.contentSize=CGSizeMake(gameModel.screenWidth * pages, scrollView.frame.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
}

-(void) dePaintThemeMenu {
    [imageBackground2 removeFromSuperview];
    imageBackground2 = nil;
    [backButton removeFromSuperview];
    backButton = nil;
    
    [scrollView removeFromSuperview];
    scrollView = nil;
    
    [self depaintCapsuleImage];
    
    [self depaintTotalStars];
}

////////////handle this bug later: when "back" from levelpage1,,, some level buttons not being depainted!!!!!!!/////////////
////////////handle this bug later: when "back" from levelpage1,,, some level buttons not being depainted!!!!!!!/////////////
////////////handle this bug later: when "back" from levelpage1,,, some level buttons not being depainted!!!!!!!/////////////
////////////handle this bug later: when "back" from levelpage1,,, some level buttons not being depainted!!!!!!!/////////////
////////////handle this bug later: when "back" from levelpage1,,, some level buttons not being depainted!!!!!!!/////////////
////////////handle this bug later: when "back" from levelpage1,,, some level buttons not being depainted!!!!!!!/////////////
////////////handle this bug later: when "back" from levelpage1,,, some level buttons not being depainted!!!!!!!/////////////
-(void) paintLevelPage:(int)themeParam
            subPageArg:(int)subPageParam {
    
    NSString* background2Path;
    if (IS_WIDESCREEN) {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2" ofType:@"png"];
    } else {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2_3.5inches" ofType:@"png"];
    }
    imageBackground2 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:background2Path]];
    [imageBackground2 setFrame:gameModel.backgroundRect];
    [self.view addSubview:imageBackground2];

    [self paintScrollView:2];
    [scrollView paintTransparentViewsLevels];
    [scrollView paintLevelButtons:themeParam subPageArg:subPageParam];
    
    NSString* backPath = [[NSBundle mainBundle] pathForResource:@"BackButton" ofType:@"png"];
    backButton4dot1 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backPath]];
    [backButton4dot1 setFrame:gameModel.backButtonRect];
    backButton4dot1.userInteractionEnabled = YES;
    [self.view addSubview:backButton4dot1];
    
    [self drawCapsuleButtonNotIngame:gameModel.capsuleAtBottomRight];
    
    [self paintTotalStars];
}

//prepare sleep or awake transition - starts
-(void)prepareSleepToAwake {
    NSString *fileName;
    sleepToAwake = [[NSMutableArray alloc] initWithCapacity:5];
    for(int i = 0; i<5; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_BLINK-1"] ofType:@"png"];
        [sleepToAwake addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareAwakeToSleep {
    NSString *fileName;
    awakeToSleep = [[NSMutableArray alloc] initWithCapacity:5];
    for(int i = 0; i<5; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"C-SLEEPY PLANT_262px_SLEEP-1"] ofType:@"png"];
        [awakeToSleep addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}
//prepare sleep or awake transition - ends

//prepare notif animations - starts
-(void)prepareIcyNotif {
    NSString *fileName;
    icyNotif = [[NSMutableArray alloc] initWithCapacity:1];
    for(int i = 0; i<1; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"NotifBar_Icy_0"] ofType:@"png"];
        [icyNotif addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareSleepyNotif {
    NSString *fileName;
    sleepyNotif = [[NSMutableArray alloc] initWithCapacity:1];
    for(int i = 0; i<1; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"NotifBar_Sleepy_0"] ofType:@"png"];
        [sleepyNotif addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareTwoFaceNotif {
    NSString *fileName;
    twoFaceNotif = [[NSMutableArray alloc] initWithCapacity:1];
    for(int i = 0; i<1; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"NotifBar_TwoFace_0"] ofType:@"png"];
        [twoFaceNotif addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}

-(void)prepareCapsuleNotif {
    NSString *fileName;
    capsuleNotif = [[NSMutableArray alloc] initWithCapacity:1];
    for(int i = 0; i<1; i++) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"NotifBar_Capsule_0"] ofType:@"png"];
        [capsuleNotif addObject:[[UIImage alloc] initWithContentsOfFile:fileName]];
    }
}
//prepare notif animations - ends

//WARNING:IT'S NOT REMOVING THE imageBackground2!!
-(void) dePaintLevelPage1 {
    //WARNING:IT'S NOT REMOVING THE imageBackground2!!
    
    [backButton4dot1 removeFromSuperview];
    backButton4dot1 = nil;
    
    [scrollView removeFromSuperview];
    scrollView = nil;
    
    [self depaintCapsuleImage];
    
    [self depaintTotalStars];
    
    [imageBackground2 removeFromSuperview];
    imageBackground2 = nil;
}

-(void) paintLevel:(int)number {
    
    [self resetAhaCounter];
    
    [self resetAnimationCounter];
    [gameModel populateLevel:number];
    currentLevel = [gameModel getLevel:1];
    
    
    ////This is the arrays
    [self allocateArraysToLevel];
    [self loadAnimationsInLevel];
    
    
    [self drawLevelBackground];
    
    [self drawStatusBar];
    
    [self drawBottomBar];
    
    [self drawClocks];
    
    [self executeTutorials];
    
    [self depaintLoadingImage];
}

-(void) paintLevelNoArray:(int)number {
    
    [self resetAhaCounter];
    
    [self resetAnimationCounter];
    [gameModel populateLevel:number];
    currentLevel = [gameModel getLevel:1];
    
    [self drawLevelBackground];
    
    [self drawStatusBar];
    
    [self drawBottomBar];
    
    [self drawClocks];
    
    [self executeTutorials];
    
    [self depaintLoadingImage];
}

-(void) displayCertainHelpTutorialPage:(int)boardNumber {
    
    switch (boardNumber) {
        case 1:
            [self paintTutorialBoardInHelp:@"Tutorial1_Yellow"];
            break;
        case 2:
            [self paintTutorialBoardInHelp:@"Tutorial2_Tap"];
            break;
        case 3:
            [self paintTutorialBoardInHelp:@"Tutorial3_Linking"];
            break;
        case 4:
            [self paintTutorialBoardInHelp:@"Tutorial4_Linking2"];
            break;
        case 5:
            [self paintTutorialBoardInHelp:@"Tutorial5_Antipole1"];
            break;
        case 6:
            [self paintTutorialBoardInHelp:@"Tutorial5_Antipole2"];
            break;
        case 7:
            [self paintTutorialBoardInHelp:@"Tutorial7_Sleepy"];
            break;
        case 8:
            [self paintTutorialBoardInHelp:@"Tutorial8_Dizzy1"];
            break;
        case 9:
            [self paintTutorialBoardInHelp:@"Tutorial9_Dizzy2"];
            break;
        case 10:
            [self paintTutorialBoardInHelp:@"Tutorial10_Flower"];
            break;
        case 11:
            [self paintTutorialBoardInHelp:@"Tutorial11_Caesar"];
            break;
        case 12:
            [self paintTutorialBoardInHelp:@"Tutorial12_Ninja"];
            break;
        case 13:
            [self paintTutorialBoardInHelp:@"Tutorial13_Icy"];
            break;
        case 14:
            [self paintTutorialBoardInHelp:@"Tutorial14_Multiface"];
            break;
        case 15:
            [self paintTutorialBoardInHelp:@"Tutorial15_Wang1"];
            break;
        case 16:
            [self paintTutorialBoardInHelp:@"Tutorial16_Wang2"];
            break;
        case 17:
            [self paintTutorialBoardInHelp:@"Tutorial17_Broken"];
            break;
            
        default:
            NSLog(@"Logic error - invalid boardNumber in displayCertainHelpTutorialPage\n");
            break;
    }
}

-(void) displayCertainHelpShadowPage:(int)boardNumber {
    
    switch (boardNumber) {
        case 3:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Antipole"];
            break;
        case 4:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Sleepy"];
            break;
        case 5:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Dizzy"];
            break;
        case 6:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Lazy"];
            break;
        case 7:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Caesar"];
            break;
        case 8:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Tora"];
            break;
        case 9:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Icy"];
            break;
        case 10:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Multiface"];
            break;
        case 11:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Wang"];
            break;
        case 12:
            [self paintTutorialBoardInHelpForShadow:@"HelpLocked_Broken"];
            break;
            
        default:
            NSLog(@"Logic error - invalid boardNumber in displayCertainHelpShadowPage\n");
            break;
    }
    
}

-(void) executeTutorials {
    
    [self depaintTutorialBoard];
    
    if (currentLevel.currentLevel == 1)
    {
        [self paintTutorialBoardIn:@"Tutorial1_Yellow"];
        tutorialPageCounter++;
    }
    else if (currentLevel.currentLevel == 2)
    {
        [self paintTutorialBoardIn:@"Tutorial3_Linking"];
    }
    else if (currentLevel.currentLevel == 4)
    {
        [self paintTutorialBoardIn:@"Tutorial4_Linking2"];
    }
    else if (currentLevel.currentLevel == 7)
    {
        [self paintTutorialBoardIn:@"Tutorial5_Antipole1"];
    }
    else if (currentLevel.currentLevel == 11)
    {
        [self paintTutorialBoardIn:@"Tutorial5_Antipole2"];
    }
    else if (currentLevel.currentLevel == 14)
    {
        [self paintTutorialBoardIn:@"Tutorial7_Sleepy"];
    }
    else if (currentLevel.currentLevel == 21)
    {
        [self paintTutorialBoardIn:@"Tutorial8_Dizzy1"];
        tutorialPageCounter++;
    }
    else if (currentLevel.currentLevel == 31)
    {
        [self paintTutorialBoardIn:@"Tutorial10_Flower"];
    }
    else if (currentLevel.currentLevel == 41)
    {
        [self paintTutorialBoardIn:@"Tutorial11_Caesar"];
    }
    else if (currentLevel.currentLevel == 51)
    {
        [self paintTutorialBoardIn:@"Tutorial12_Ninja"];
    }
    else if (currentLevel.currentLevel == 61)
    {
        [self paintTutorialBoardIn:@"Tutorial13_Icy"];
    }
    else if (currentLevel.currentLevel == 76)
    {
        [self paintTutorialBoardIn:@"Tutorial14_Multiface"];
    }
    else if (currentLevel.currentLevel == 91)
    {
        [self paintTutorialBoardIn:@"Tutorial15_Wang1"];
        tutorialPageCounter++;
    }
    else if (currentLevel.currentLevel == 106)
    {
        [self paintTutorialBoardIn:@"Tutorial17_Broken"];
    }
}

-(void) handleNextInTutorial {
    if (currentLevel.currentLevel == 1)
    {
        if (tutorialPageCounter == 2) {
            [self paintTutorialBoardIn:@"Tutorial2_Tap"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 3) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
            [self sfxGoodLuck];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
    else if (currentLevel.currentLevel == 21)
    {
        if (tutorialPageCounter == 2) {
            [self paintTutorialBoardIn:@"Tutorial9_Dizzy2"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 3) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
    else if (currentLevel.currentLevel == 91)
    {
        if (tutorialPageCounter == 2) {
            [self paintTutorialBoardIn:@"Tutorial16_Wang2"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 3) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
}

-(void) handleNextInTutorial:(int)currentBoard {
    if (currentBoard == 1)
    {
        if (tutorialPageCounter == 1) {
            [self paintTutorialBoardInHelp:@"Tutorial2_Tap"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 2) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
    else if (currentBoard == 2)
    {
        if (tutorialPageCounter == 1) {
            [self paintTutorialBoardInHelp:@"Tutorial4_Linking2"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 2) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
    else if (currentBoard == 3)
    {
        if (tutorialPageCounter == 1) {
            [self paintTutorialBoardInHelp:@"Tutorial5_Antipole2"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 2) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
    else if (currentBoard == 5)
    {
        if (tutorialPageCounter == 1) {
            [self paintTutorialBoardInHelp:@"Tutorial9_Dizzy2"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 2) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
    else if (currentBoard == 11)
    {
        if (tutorialPageCounter == 1) {
            [self paintTutorialBoardInHelp:@"Tutorial16_Wang2"];
            tutorialPageCounter++;
        } else if (tutorialPageCounter == 2) {
            tutorialPageCounter = 1;
            [self depaintTutorialBoard];
        } else {
            NSLog(@"Logic error - Invalid variable:tutorialPageCounter at function:executeTutorials at class:handleNextInTutorial");
        }
    }
}

-(void) paintTutorialBoardInHelp:(NSString*) fileName {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackAch = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackAch setFrame:gameModel.backgroundRect];
    opacityBlackAch.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackAch];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    tutorialBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [tutorialBoardImage setFrame:gameModel.tutorialBoard];
    tutorialBoardImage.userInteractionEnabled = YES;
    [opacityBlackAch addSubview:tutorialBoardImage];
    
    NSString* achBackPath = [[NSBundle mainBundle] pathForResource:@"NextButtonRect" ofType:@"png"];
    tutorialNextHelpImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achBackPath]];
    [tutorialNextHelpImage setFrame:gameModel.backTutorialRect];
    tutorialNextHelpImage.userInteractionEnabled = YES;
    [tutorialBoardImage addSubview:tutorialNextHelpImage];
}

-(void) paintTutorialBoardInHelpForShadow:(NSString*) fileName {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackAch = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackAch setFrame:gameModel.backgroundRect];
    opacityBlackAch.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackAch];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    tutorialBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [tutorialBoardImage setFrame:gameModel.tutorialBoard];
    tutorialBoardImage.userInteractionEnabled = YES;
    [opacityBlackAch addSubview:tutorialBoardImage];
    
    NSString* achBackPath = [[NSBundle mainBundle] pathForResource:@"NextButtonRect" ofType:@"png"];
    tutorialNextHelpForShadowImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achBackPath]];
    [tutorialNextHelpForShadowImage setFrame:gameModel.backTutorialRect];
    tutorialNextHelpForShadowImage.userInteractionEnabled = YES;
    [tutorialBoardImage addSubview:tutorialNextHelpForShadowImage];
}

-(void) paintTutorialBoardIn:(NSString*) fileName {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackAch = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackAch setFrame:gameModel.backgroundRect];
    opacityBlackAch.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackAch];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    tutorialBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [tutorialBoardImage setFrame:gameModel.tutorialBoard];
    tutorialBoardImage.userInteractionEnabled = YES;
    [opacityBlackAch addSubview:tutorialBoardImage];
    
    NSString* achBackPath = [[NSBundle mainBundle] pathForResource:@"NextButtonRect" ofType:@"png"];
    tutorialNextImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achBackPath]];
    [tutorialNextImage setFrame:gameModel.backTutorialRect];
    tutorialNextImage.userInteractionEnabled = YES;
    [tutorialBoardImage addSubview:tutorialNextImage];
}

-(void) depaintTutorialBoard {
    [tutorialNextImage removeFromSuperview];
    [tutorialNextHelpImage removeFromSuperview];
    [tutorialBoardImage removeFromSuperview];
    [opacityBlackAch removeFromSuperview];
    
    tutorialNextImage = nil;
    tutorialNextHelpImage = nil;
    tutorialBoardImage = nil;
    opacityBlackAch = nil;
}

-(void) resetAhaCounter {
    isPre12Top2Clocks = NO;
    isPre12Bottom2Clocks = NO;
    
    isPre12TopLeft3Clocks = NO;
    isPre12TopRight3Clocks = NO;
    isPre12Bottom3Clocks = NO;
    
    isPre12TopLeft4Clocks = NO;
    isPre12TopRight4Clocks = NO;
    isPre12BottomRight4Clocks = NO;
    isPre12BottomLeft4Clocks = NO;
}

-(void) initiateAhaCounter2Clocks {
    if ([tempClock checkTwelve]) {
        isPre12Top2Clocks = YES;
    }
    
    if ([tempClock2Bottom checkTwelve]) {
        isPre12Bottom2Clocks = YES;
    }
}

-(void) initiateAhaCounter3Clocks {
    if ([tempClock3TopLeft checkTwelve]) {
        isPre12TopLeft3Clocks = YES;
    }
    
    if ([tempClock3TopRight checkTwelve]) {
        isPre12TopRight3Clocks = YES;
    }
    
    if ([tempClock3Bottom checkTwelve]) {
        isPre12Bottom3Clocks = YES;
    }
}

-(void) initiateAhaCounter4Clocks {
    if ([tempClock4TopLeft checkTwelve]) {
        isPre12TopLeft4Clocks = YES;
    }
    
    if ([tempClock4TopRight checkTwelve]) {
        isPre12TopRight4Clocks = YES;
    }
    
    if ([tempClock4BottomRight checkTwelve]) {
        isPre12BottomRight4Clocks = YES;
    }
    
    if ([tempClock4BottomLeft checkTwelve]) {
        isPre12BottomLeft4Clocks = YES;
    }
}

-(void) drawBottomBar {
//    [self drawNotif];
    
    NSString* helpPath = [[NSBundle mainBundle] pathForResource:@"Help_RoundButton" ofType:@"png"];
    gameplayHelp = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:helpPath]];
    [gameplayHelp setFrame:gameModel.gameplayHelpRect];
    gameplayHelp.userInteractionEnabled = YES;
    [self.view addSubview:gameplayHelp];
    
    [self drawCapsuleButton:gameModel.gameplayPurchaseRect];
}

-(void) drawCapsuleButton:(CGRect) rectParam {
    NSString* purchasePath = [[NSBundle mainBundle] pathForResource:@"Purchase_Button" ofType:@"png"];
    gameplayPurchase = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchasePath]];
    [gameplayPurchase setFrame:rectParam];
    gameplayPurchase.userInteractionEnabled = YES;
    [self.view addSubview:gameplayPurchase];
    
    NSString* purchaseD100Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_2" ofType:@"png"];
    purchaseNumber100 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchaseD100Path]];
    [purchaseNumber100 setFrame:gameModel.purchaseDigitHundredRect];
    [gameplayPurchase addSubview:purchaseNumber100];
    
    NSString* purchaseD10Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_8" ofType:@"png"];
    purchaseNumber10 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchaseD10Path]];
    [purchaseNumber10 setFrame:gameModel.purchaseDigitTenRect];
    [gameplayPurchase addSubview:purchaseNumber10];
    
    NSString* purchaseD0Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_9" ofType:@"png"];
    purchaseNumber0 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchaseD0Path]];
    [purchaseNumber0 setFrame:gameModel.purchaseDigitOneRect];
    [gameplayPurchase addSubview:purchaseNumber0];
    
    [self updatePurchasedItems];
}

-(void) drawCapsuleButtonNotIngame:(CGRect) rectParam {
    NSString* purchasePath = [[NSBundle mainBundle] pathForResource:@"Purchase_Button" ofType:@"png"];
    notGameplayPurchase = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchasePath]];
    [notGameplayPurchase setFrame:rectParam];
    notGameplayPurchase.userInteractionEnabled = YES;
    [self.view addSubview:notGameplayPurchase];
    
    NSString* purchaseD100Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_2" ofType:@"png"];
    purchaseNumber100 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchaseD100Path]];
    [purchaseNumber100 setFrame:gameModel.purchaseDigitHundredRect];
    [notGameplayPurchase addSubview:purchaseNumber100];
    
    NSString* purchaseD10Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_8" ofType:@"png"];
    purchaseNumber10 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchaseD10Path]];
    [purchaseNumber10 setFrame:gameModel.purchaseDigitTenRect];
    [notGameplayPurchase addSubview:purchaseNumber10];
    
    NSString* purchaseD0Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_9" ofType:@"png"];
    purchaseNumber0 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:purchaseD0Path]];
    [purchaseNumber0 setFrame:gameModel.purchaseDigitOneRect];
    [notGameplayPurchase addSubview:purchaseNumber0];
    
    [self updatePurchasedItems];
}

-(void) depaintCapsuleImage {
    
    [purchaseNumber0 removeFromSuperview];
    purchaseNumber0 = nil;
    
    [purchaseNumber10 removeFromSuperview];
    purchaseNumber10 = nil;
    
    [purchaseNumber100 removeFromSuperview];
    purchaseNumber100 = nil;
    
    [notGameplayPurchase removeFromSuperview];
    notGameplayPurchase = nil;
    
    [gameplayPurchase removeFromSuperview];
    gameplayPurchase = nil;
}

-(void) updatePurchasedItems {
    [self intToLabelArgIntArg:[gameModel.prefs integerForKey:@"purchase1"] digitHundredArg:purchaseNumber100 digitTenArg:purchaseNumber10 digitOneArg:purchaseNumber0 prefixArg:prefixTextPurchase];
}

-(void) drawLevelBackground {
    NSString *imageString;
    
    if (IS_WIDESCREEN) {
        if (currentLevel.currentLevel <=30) {
            imageString = @"Theme1Background";
        }
        else if (currentLevel.currentLevel >30 && currentLevel.currentLevel <= 60)
            imageString = @"Theme2Background"; //replace!!
        else if (currentLevel.currentLevel >60 && currentLevel.currentLevel <= 90)
            imageString = @"Theme3Background"; //replace!!
        else if (currentLevel.currentLevel >90 && currentLevel.currentLevel <= 120)
            imageString = @"Theme4Background"; //replace!!
        else
            NSLog(@"Off limit! - 4");
    } else {
        if (currentLevel.currentLevel <=30) {
            imageString = @"Theme1Background_3.5inches";
        }
        else if (currentLevel.currentLevel >30 && currentLevel.currentLevel <= 60)
            imageString = @"Theme2Background_3.5inches"; //replace!!
        else if (currentLevel.currentLevel >60 && currentLevel.currentLevel <= 90)
            imageString = @"Theme3Background_3.5inches"; //replace!!
        else if (currentLevel.currentLevel >90 && currentLevel.currentLevel <= 120)
            imageString = @"Theme4Background_3.5inches"; //replace!!
        else
            NSLog(@"Off limit! - 3.5");
    }
    
    
    
    NSString* backgroundPath = [[NSBundle mainBundle] pathForResource:imageString ofType:@"png"];
    inGameTheme1Background = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [inGameTheme1Background setFrame:gameModel.fullScreenRect];
    [self.view addSubview:inGameTheme1Background];
    firstBackground1 = NO;
}

-(void) hideLevelBackground {
    [inGameTheme1Background removeFromSuperview];
    inGameTheme1Background = nil;
}

//If no UIImageView, pass a nil
-(void)intToLabelArgIntArg:(int)intParam
           digitHundredArg:(UIImageView*)digitHundredParam
               digitTenArg:(UIImageView*)digitTenParam
               digitOneArg:(UIImageView*)digitOneParam
                 prefixArg:(NSString*)prefixParam {
    
    int hundredDigit = -1, tenDigit = -1, oneDigit = -1;
    
    [self separateIntHTO:intParam hundredResultArg:&hundredDigit tenResultArg:&tenDigit oneResultArg:&oneDigit];
    
    if (hundredDigit == -1 && tenDigit == -1) {
        [digitHundredParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, oneDigit]] waitUntilDone:YES];
        
        [digitTenParam performSelectorOnMainThread:@selector(setImage:) withObject:nil waitUntilDone:YES];
        
        [digitOneParam performSelectorOnMainThread:@selector(setImage:) withObject:nil waitUntilDone:YES];
    } else if (hundredDigit == -1) {
        [digitHundredParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, tenDigit]] waitUntilDone:YES];
        
        [digitTenParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, oneDigit]] waitUntilDone:YES];
        
        [digitOneParam performSelectorOnMainThread:@selector(setImage:) withObject:nil waitUntilDone:YES];
    } else { //get rid of imageNamed //get rid of imageNamed //get rid of imageNamed //get rid of imageNamed
        [digitHundredParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, hundredDigit]] waitUntilDone:YES];
        
        [digitTenParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, tenDigit]] waitUntilDone:YES];
        
        [digitOneParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, oneDigit]] waitUntilDone:YES];
    }
}

-(void)intToLabelReversedArgIntArg:(int)intParam
           digitHundredArg:(UIImageView*)digitHundredParam
               digitTenArg:(UIImageView*)digitTenParam
               digitOneArg:(UIImageView*)digitOneParam
                 prefixArg:(NSString*)prefixParam {
    
    int hundredDigit = -1, tenDigit = -1, oneDigit = -1;
    
    [self separateIntHTO:intParam hundredResultArg:&hundredDigit tenResultArg:&tenDigit oneResultArg:&oneDigit];
    
    if (hundredDigit == -1 && tenDigit == -1) {
        [digitHundredParam performSelectorOnMainThread:@selector(setImage:) withObject:nil waitUntilDone:YES];
        
        [digitTenParam performSelectorOnMainThread:@selector(setImage:) withObject:nil waitUntilDone:YES];
        
        [digitOneParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, oneDigit]] waitUntilDone:YES];
    } else if (hundredDigit == -1) {
        [digitHundredParam performSelectorOnMainThread:@selector(setImage:) withObject:nil waitUntilDone:YES];
        
        [digitTenParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, tenDigit]] waitUntilDone:YES];
        
        [digitOneParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, oneDigit]] waitUntilDone:YES];
    } else { //get rid of imageNamed //get rid of imageNamed //get rid of imageNamed //get rid of imageNamed
        [digitHundredParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, hundredDigit]] waitUntilDone:YES];
        
        [digitTenParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, tenDigit]] waitUntilDone:YES];
        
        [digitOneParam performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:[NSString stringWithFormat: @"%@%i", prefixParam, oneDigit]] waitUntilDone:YES];
    }
}

-(void)separateIntHTO:(int)integerInput
     hundredResultArg:(int*)hundredResultParam
         tenResultArg:(int*)tenResultParam
         oneResultArg:(int*)oneResultParam {
    
    int remainder = integerInput;
    
    while (remainder > 0) {
        if (remainder > 999) {
            NSLog(@"Logic error - can't be greater than 999");
            break;
        } else if (remainder > 99) {
            *hundredResultParam = remainder / 100;
            remainder %= 100;
        } else if (remainder > 9) {
            *tenResultParam = remainder / 10;
            remainder %= 10;
        } else {
            *oneResultParam = remainder;
            remainder = 0;
        }
    }

    if (integerInput >= 100 && integerInput%100 == 0) {
        *tenResultParam = 0;
    }
    if (integerInput >= 100 && integerInput%100 < 10 && integerInput%100 > 0) {
        *tenResultParam = 0;
    }
    if (integerInput >= 10 && integerInput%10 == 0) {
        *oneResultParam = 0;
    }
    if (integerInput == 0) {
        *oneResultParam = 0;
    }
}

-(void) drawStatusBar {
    if(firstStatus == NO) {
        [self.view addSubview:statusBar];
    }
    else {
        NSString* statusPath = [[NSBundle mainBundle] pathForResource:@"StatusBar" ofType:@"png"];
        statusBar = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:statusPath]];
        //                 [UIImage imageNamed:@"StatusBar.png"]];
        [statusBar setFrame:gameModel.statusBarRect];
        statusBar.userInteractionEnabled = YES;
        [self.view addSubview:statusBar];
        
        NSString* pausePath = [[NSBundle mainBundle] pathForResource:@"PauseButton" ofType:@"png"];
        pauseButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:pausePath]];
        [pauseButton setFrame:gameModel.pauseButtonRect];
        pauseButton.userInteractionEnabled = YES;
        [statusBar addSubview:pauseButton];
        
        NSString* resetPath = [[NSBundle mainBundle] pathForResource:@"ResetButton" ofType:@"png"];
        resetButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:resetPath]];
        [resetButton setFrame:gameModel.resetButtonRect];
        resetButton.userInteractionEnabled = YES;
        [statusBar addSubview:resetButton];
        
        NSString* goalTextPath = [[NSBundle mainBundle] pathForResource:@"TEXT_goal" ofType:@"png"];
        goalText = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:goalTextPath]];
        [goalText setFrame:gameModel.textGoalRect];
        [statusBar addSubview:goalText];
        
        NSString* levelTextPath = [[NSBundle mainBundle] pathForResource:@"TEXT_level" ofType:@"png"];
        levelText = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:levelTextPath]];
        [levelText setFrame:gameModel.textLevelRect];
        [statusBar addSubview:levelText];
        
        NSString* stepsTextPath = [[NSBundle mainBundle] pathForResource:@"TEXT_steps" ofType:@"png"];
        stepsText = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:stepsTextPath]];
        [stepsText setFrame:gameModel.textStepsRect];
        [statusBar addSubview:stepsText];
        
        NSString* number100GoalPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_1" ofType:@"png"];
        goalNumber100 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number100GoalPath]];
        [goalNumber100 setFrame:gameModel.numberGoal100Rect];
        [statusBar addSubview:goalNumber100];
        
        NSString* number10GoalPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_1" ofType:@"png"];
        goalNumber10 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number10GoalPath]];
        [goalNumber10 setFrame:gameModel.numberGoal10Rect];
        [statusBar addSubview:goalNumber10];
        
        NSString* number0GoalPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_2" ofType:@"png"];
        goalNumber0 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number0GoalPath]];
        [goalNumber0 setFrame:gameModel.numberGoal0Rect];
        [statusBar addSubview:goalNumber0];
        
        NSString* number100LevelPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_1" ofType:@"png"];
        levelNumber100 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number100LevelPath]];
        [levelNumber100 setFrame:gameModel.numberLevel100Rect];
        [statusBar addSubview:levelNumber100];
        
        NSString* number10LevelPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_3" ofType:@"png"];
        levelNumber10 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number10LevelPath]];
        [levelNumber10 setFrame:gameModel.numberLevel10Rect];
        [statusBar addSubview:levelNumber10];
        
        NSString* number0LevelPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_5" ofType:@"png"];
        levelNumber0 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number0LevelPath]];
        [levelNumber0 setFrame:gameModel.numberLevel0Rect];
        [statusBar addSubview:levelNumber0];
        
        NSString* number100StepsPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_5" ofType:@"png"];
        stepsNumber100 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number100StepsPath]];
        [stepsNumber100 setFrame:gameModel.numberSteps100Rect];
        [statusBar addSubview:stepsNumber100];
        
        NSString* number10StepsPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_5" ofType:@"png"];
        stepsNumber10 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number10StepsPath]];
        [stepsNumber10 setFrame:gameModel.numberSteps10Rect];
        [statusBar addSubview:stepsNumber10];
        
        NSString* number0StepsPath = [[NSBundle mainBundle] pathForResource:@"NUMBER_statusbar_5" ofType:@"png"];
        stepsNumber0 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:number0StepsPath]];
        [stepsNumber0 setFrame:gameModel.numberSteps0Rect];
        [statusBar addSubview:stepsNumber0];
        
        firstStatus = NO;
    }
    [self updateStatusBar];
}

-(void) updateStatusBar {
    [self intToLabelArgIntArg:currentLevel.goal digitHundredArg:goalNumber100 digitTenArg:goalNumber10 digitOneArg:goalNumber0 prefixArg:prefixNumStatusBar];
    [self intToLabelArgIntArg:currentLevel.currentLevel digitHundredArg:levelNumber100 digitTenArg:levelNumber10 digitOneArg:levelNumber0 prefixArg:prefixNumStatusBar];
    [self intToLabelArgIntArg:currentLevel.steps digitHundredArg:stepsNumber100 digitTenArg:stepsNumber10 digitOneArg:stepsNumber0 prefixArg:prefixNumStatusBar];
}

-(void)addStep {
    [currentLevel add1Step];
    [self intToLabelArgIntArg:currentLevel.steps digitHundredArg:stepsNumber100 digitTenArg:stepsNumber10 digitOneArg:stepsNumber0 prefixArg:prefixNumStatusBar];
}

-(void) hideStatusBar {
    [statusBar removeFromSuperview];
}

-(void) drawClocks {
    if (currentLevel.getNumberOfClocks == 2) {
        [self draw2Clocks];
        
        [self checkSleepyIn2];
    }
    else if (currentLevel.getNumberOfClocks == 3) {
        [self draw3Clocks];
    
        [self checkSleepyIn3];
    }
    else if (currentLevel.getNumberOfClocks == 4) {
        [self draw4Clocks];
        
        [self checkSleepyIn4];
    }
}

-(void) checkSleepyIn2 {
    if ([[self getClockTypePureString:1] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:21];
    } else {
        [self timerAnimate2ClocksTop];
    }
    
    if ([[self getClockTypePureString:2] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:22];
    } else {
        [self timerAnimate2ClocksBottom];
    }
}

-(void) checkSleepyIn3 {
    if ([[self getClockTypePureString:1] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:31];
    } else {
        [self timerAnimate3ClocksTopLeft];
    }
    
    if ([[self getClockTypePureString:2] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:32];
    } else {
        [self timerAnimate3ClocksTopRight];
    }
    
    if ([[self getClockTypePureString:3] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:33];
    } else {
        [self timerAnimate3ClocksBottom];
    }
}

-(void) checkSleepyIn4 {
    if ([[self getClockTypePureString:1] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:41];
    } else {
        [self timerAnimate4ClocksTopLeft];
    }
    
    if ([[self getClockTypePureString:2] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:42];
    } else {
        [self timerAnimate4ClocksTopRight];
    }
    
    if ([[self getClockTypePureString:3] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:43];
    } else {
        [self timerAnimate4ClocksBottomRight];
    }
    
    if ([[self getClockTypePureString:4] isEqual: @"sleepyclock"]) {
        [self animatingSleepingNoTimer:44];
    } else {
        [self timerAnimate4ClocksBottomLeft];
    }
}

-(void) draw2Clocks {
    
    gameModel.win = FALSE;
    currentLevel.steps = 0;
    
    [self refillTempClocks];
    [self draw2ClocksSetup];
    
    [self.view addSubview:twoClocksFrame];
    
    [self draw2Shadow];
    
    [twoClocksFrame addSubview:top2ClocksImage];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:UP_2CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:top2ClocksImage chineseClockArg:tempClock];
    }
    //draw chinese - ends
    
    //Twoface handlers
    if ([[self getClockTypePureString:UP_2CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngelT = [self getLongName:1 clockLocationArg:UP_2CLOCKS];
        longAngel2T = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngelT]];
        [self setRectToHands:longAngel2T clockPositionArg:UP_2CLOCKS];
        longAngel2T.userInteractionEnabled = NO;
        longAngel2T.hidden = YES;
        [top2ClocksImage addSubview:longAngel2T];
        
        NSString* shortAngelT = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel2T = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngelT]];
        [self setRectToHands:shortAngel2T clockPositionArg:UP_2CLOCKS];
        shortAngel2T.userInteractionEnabled = NO;
        shortAngel2T.hidden = YES;
        [top2ClocksImage addSubview:shortAngel2T];
    }
    
    //yellow top
    NSString* longYellowT = [self getLongName:999 clockLocationArg:UP_2CLOCKS];
    longYellow2T = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowT]];
    [self setRectToHands:longYellow2T clockPositionArg:UP_2CLOCKS];
    longYellow2T.userInteractionEnabled = NO;
    longYellow2T.hidden = YES;
    [top2ClocksImage addSubview:longYellow2T];
    
    NSString* shortYellowT = [self getShortName:12 clockLocationArg:UP_2CLOCKS];
    shortYellow2T = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowT]];
    [self setRectToHands:shortYellow2T clockPositionArg:UP_2CLOCKS];
    shortYellow2T.userInteractionEnabled = NO;
    shortYellow2T.hidden = YES;
    [top2ClocksImage addSubview:shortYellow2T];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:UP_2CLOCKS] isEqualToString:@"chinese"]) {
        [top2ClocksImage addSubview:longArrow2TopImage];
    }
    
    if (![[self getClockTypePureString:UP_2CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [top2ClocksImage addSubview:shortArrow2TopImage];
    }
    
    [twoClocksFrame addSubview:bottom2ClocksImage];
    
    //set shorthand position
    [self initialiseHandPosition:tempClock shortImage:shortArrow2TopImage shortAngel:shortAngel2T];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock longImage:longArrow2TopImage];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:bottom2ClocksImage chineseClockArg:tempClock2Bottom];
    }
    //draw chinese - ends
    
    //Twoface handlers
    if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngelB = [self getLongName:1 clockLocationArg:BOTTOM_2CLOCKS];
        longAngel2B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngelB]];
        [self setRectToHands:longAngel2B clockPositionArg:BOTTOM_2CLOCKS];
        longAngel2B.userInteractionEnabled = NO;
        longAngel2B.hidden = YES;
        [bottom2ClocksImage addSubview:longAngel2B];
        
        NSString* shortAngelB = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel2B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngelB]];
        [self setRectToHands:shortAngel2B clockPositionArg:BOTTOM_2CLOCKS];
        shortAngel2B.userInteractionEnabled = NO;
        shortAngel2B.hidden = YES;
        [bottom2ClocksImage addSubview:shortAngel2B];
    }
    
    //yellow bottom
    NSString* longYellowB = [self getLongName:999 clockLocationArg:BOTTOM_2CLOCKS];
    longYellow2B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowB]];
    [self setRectToHands:longYellow2B clockPositionArg:BOTTOM_2CLOCKS];
    longYellow2B.userInteractionEnabled = NO;
    longYellow2B.hidden = YES;
    [bottom2ClocksImage addSubview:longYellow2B];
    
    NSString* shortYellowB = [self getShortName:12 clockLocationArg:BOTTOM_2CLOCKS];
    shortYellow2B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowB]];
    [self setRectToHands:shortYellow2B clockPositionArg:BOTTOM_2CLOCKS];
    shortYellow2B.userInteractionEnabled = NO;
    shortYellow2B.hidden = YES;
    [bottom2ClocksImage addSubview:shortYellow2B];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:BOTTOM_2CLOCKS] isEqualToString:@"chinese"]) {
        [bottom2ClocksImage addSubview:longArrow2BottomImage];
    }

    if (![[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [bottom2ClocksImage addSubview:shortArrow2BottomImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock2Bottom shortImage:shortArrow2BottomImage shortAngel:shortAngel2B];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock2Bottom longImage:longArrow2BottomImage];
    
    ////////Draw 1st arrow (if any)
    if ([currentLevel.arrows count] > 0)
    {
        tempArrow1 = [currentLevel.arrows objectAtIndex:0];
        linkingArrowUp2ClocksImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self get2LinkingArrows:tempArrow1]]];
        if (tempArrow1.origin == 1) {
            [linkingArrowUp2ClocksImage setFrame:gameModel.linkingArrowDown2ClocksRect];
        } else {
            [linkingArrowUp2ClocksImage setFrame:gameModel.linkingArrowUp2ClocksRect];
        }
        [twoClocksFrame addSubview:linkingArrowUp2ClocksImage];
    }
    
    //////////Draw 2nd arrow (if any)
    if ([currentLevel.arrows count] > 1)
    {
        tempArrow2 = [currentLevel.arrows objectAtIndex:1];
        linkingArrowDown2ClocksImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self get2LinkingArrows:tempArrow2]]];
        if (tempArrow2.origin == 1) {
            [linkingArrowDown2ClocksImage setFrame:gameModel.linkingArrowDown2ClocksRect];
        } else {
            [linkingArrowDown2ClocksImage setFrame:gameModel.linkingArrowUp2ClocksRect];
        }
        [twoClocksFrame addSubview:linkingArrowDown2ClocksImage];
    }
    
    //animate dizzy - starts
    if ([[self getClockTypePureString:UP_2CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:UP_2CLOCKS longImageArg:longArrow2TopImage longYellow:longYellow2T];
    }
    if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:BOTTOM_2CLOCKS longImageArg:longArrow2BottomImage longYellow:longYellow2B];
    }
    //animate dizzy - ends
    
    [self draw2Flashes];
    
    [self initiateAhaCounter2Clocks];
    
    [self draw2VirtualArrows];
}

-(void) animateArrowFlash:(UIImageView*)imageParam
             animArrayArg:(NSMutableArray*)animArrayParam {
    
    imageParam.animationImages = animArrayParam;
    imageParam.animationDuration = 0.25;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
}

-(void) draw2VirtualArrows {
    NSString* vir1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA2ClocksToTop = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir1]];
    [VA2ClocksToTop setFrame:gameModel.linkingArrowUp2ClocksRect];
    VA2ClocksToTop.userInteractionEnabled = YES;
    [twoClocksFrame addSubview:VA2ClocksToTop];
    
    NSString* vir2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA2ClocksToBottom = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir2]];
    [VA2ClocksToBottom setFrame:gameModel.linkingArrowDown2ClocksRect];
    VA2ClocksToBottom.userInteractionEnabled = YES;
    [twoClocksFrame addSubview:VA2ClocksToBottom];
}

-(void) draw3VirtualArrows {
    NSString* vir1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA3ClocksLtoR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir1]];
    [VA3ClocksLtoR setFrame:gameModel.linkingArrowRight3ClocksSideTopRect];
    VA3ClocksLtoR.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:VA3ClocksLtoR];
    
    NSString* vir2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA3ClocksRtoL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir2]];
    [VA3ClocksRtoL setFrame:gameModel.linkingArrowLeft3ClocksSideTopRect];
    VA3ClocksRtoL.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:VA3ClocksRtoL];
    
    NSString* vir3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA3ClocksBtoTL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir3]];
    [VA3ClocksBtoTL setFrame:gameModel.linkingArrow3ClocksToTopLeftRect];
    VA3ClocksBtoTL.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:VA3ClocksBtoTL];
    
    NSString* vir4 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA3ClocksTLtoB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir4]];
    [VA3ClocksTLtoB setFrame:gameModel.linkingArrow3ClocksToBottomFromTopLeftRect];
    VA3ClocksTLtoB.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:VA3ClocksTLtoB];
    
    NSString* vir5 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA3ClocksBtoTR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir5]];
    [VA3ClocksBtoTR setFrame:gameModel.linkingArrow3ClocksToTopRightRect];
    VA3ClocksBtoTR.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:VA3ClocksBtoTR];
    
    NSString* vir6 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA3ClocksTRtoB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir6]];
    [VA3ClocksTRtoB setFrame:gameModel.linkingArrow3ClocksToBottomFromTopRightRect];
    VA3ClocksTRtoB.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:VA3ClocksTRtoB];
}

-(void) draw4VirtualArrows {
    NSString* vir1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksTLtoTR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir1]];
    [VA4ClocksTLtoTR setFrame:gameModel.linkingArrowRight4ClocksSideTopRect];
    VA4ClocksTLtoTR.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksTLtoTR];
    
    NSString* vir2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksTRtoTL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir2]];
    [VA4ClocksTRtoTL setFrame:gameModel.linkingArrowLeft4ClocksSideTopRect];
    VA4ClocksTRtoTL.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksTRtoTL];
    
    NSString* vir3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksBLtoBR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir3]];
    [VA4ClocksBLtoBR setFrame:gameModel.linkingArrowRight4ClocksSideBottomRect];
    VA4ClocksBLtoBR.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksBLtoBR];
    
    NSString* vir4 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksBRtoBL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir4]];
    [VA4ClocksBRtoBL setFrame:gameModel.linkingArrowLeft4ClocksSideBottomRect];
    VA4ClocksBRtoBL.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksBRtoBL];
    
    NSString* vir5 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksTLtoBL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir5]];
    [VA4ClocksTLtoBL setFrame:gameModel.linkingArrowDown4ClocksSideLeftRect];
    VA4ClocksTLtoBL.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksTLtoBL];
    
    NSString* vir6 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksBLtoTL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir6]];
    [VA4ClocksBLtoTL setFrame:gameModel.linkingArrowUp4ClocksSideLeftRect];
    VA4ClocksBLtoTL.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksBLtoTL];
    
    NSString* vir7 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksTRtoBR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir7]];
    [VA4ClocksTRtoBR setFrame:gameModel.linkingArrowDown4ClocksSideRightRect];
    VA4ClocksTRtoBR.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksTRtoBR];
    
    NSString* vir8 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksBRtoTR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir8]];
    [VA4ClocksBRtoTR setFrame:gameModel.linkingArrowUp4ClocksSideRightRect];
    VA4ClocksBRtoTR.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksBRtoTR];
    
    NSString* vir9 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksTLtoBR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir9]];
    [VA4ClocksTLtoBR setFrame:gameModel.linkingArrow4ClocksToBottomRightRect];
    VA4ClocksTLtoBR.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksTLtoBR];
    
    NSString* vir10 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksBRtoTL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir10]];
    [VA4ClocksBRtoTL setFrame:gameModel.linkingArrow4ClocksToTopLeftRect];
    VA4ClocksBRtoTL.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksBRtoTL];
    
    NSString* vir11 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksTRtoBL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir11]];
    [VA4ClocksTRtoBL setFrame:gameModel.linkingArrow4ClocksToBottomLeftRect];
    VA4ClocksTRtoBL.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksTRtoBL];
    
    NSString* vir12 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    VA4ClocksBLtoTR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:vir12]];
    [VA4ClocksBLtoTR setFrame:gameModel.linkingArrow4ClocksToTopRightRect];
    VA4ClocksBLtoTR.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:VA4ClocksBLtoTR];
}

-(void) DepaintVirtualArrows {
    [VA2ClocksToTop removeFromSuperview];
    [VA2ClocksToBottom removeFromSuperview];
    
    [VA3ClocksLtoR removeFromSuperview];
    [VA3ClocksRtoL removeFromSuperview];
    [VA3ClocksBtoTL removeFromSuperview];
    [VA3ClocksTLtoB removeFromSuperview];
    [VA3ClocksBtoTR removeFromSuperview];
    [VA3ClocksTRtoB removeFromSuperview];
    
    [VA4ClocksTLtoTR removeFromSuperview];
    [VA4ClocksTRtoTL removeFromSuperview];
    [VA4ClocksBLtoBR removeFromSuperview];
    [VA4ClocksBRtoBL removeFromSuperview];
    [VA4ClocksTLtoBL removeFromSuperview];
    [VA4ClocksBLtoTL removeFromSuperview];
    [VA4ClocksTRtoBR removeFromSuperview];
    [VA4ClocksBRtoTR removeFromSuperview];
    [VA4ClocksTLtoBR removeFromSuperview];
    [VA4ClocksBRtoTL removeFromSuperview];
    [VA4ClocksTRtoBL removeFromSuperview];
    [VA4ClocksBLtoTR removeFromSuperview];
    
    VA2ClocksToTop = nil;
    VA2ClocksToBottom = nil;
    
    VA3ClocksLtoR = nil;
    VA3ClocksRtoL = nil;
    VA3ClocksBtoTL = nil;
    VA3ClocksTLtoB = nil;
    VA3ClocksBtoTR = nil;
    VA3ClocksTRtoB = nil;
    
    VA4ClocksTLtoTR = nil;
    VA4ClocksTRtoTL = nil;
    VA4ClocksBLtoBR = nil;
    VA4ClocksBRtoBL = nil;
    VA4ClocksTLtoBL = nil;
    VA4ClocksBLtoTL = nil;
    VA4ClocksTRtoBR = nil;
    VA4ClocksBRtoTR = nil;
    VA4ClocksTLtoBR = nil;
    VA4ClocksBRtoTL = nil;
    VA4ClocksTRtoBL = nil;
    VA4ClocksBLtoTR = nil;
}

-(void) draw2Shadow {
    NSString* shadow1Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:UP_2CLOCKS] ofType:@"png"];
    shadow2TopImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow1Path]];
    [shadow2TopImage setFrame:gameModel.clockShadow2T];
    shadow2TopImage.userInteractionEnabled = YES;
    [twoClocksFrame addSubview:shadow2TopImage];
    
    NSString* shadow2Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:BOTTOM_2CLOCKS] ofType:@"png"];
    shadow2BottomImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow2Path]];
    [shadow2BottomImage setFrame:gameModel.clockShadow2B];
    shadow2BottomImage.userInteractionEnabled = YES;
    [twoClocksFrame addSubview:shadow2BottomImage];
}

-(void) draw2Flashes {
    NSString* flash1Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash2TopImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash1Path]];
    [self setRectToFlash:flash2TopImage clockPositionArg:UP_2CLOCKS];
    flash2TopImage.userInteractionEnabled = NO;
    [top2ClocksImage addSubview:flash2TopImage];
    
    NSString* flash2Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash2BottomImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash2Path]];
    [self setRectToFlash:flash2BottomImage clockPositionArg:BOTTOM_2CLOCKS];
    flash2BottomImage.userInteractionEnabled = NO;
    [bottom2ClocksImage addSubview:flash2BottomImage];
}

-(void) draw3Shadow {
    NSString* shadow1Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:TOPLEFT_3CLOCKS] ofType:@"png"];
    shadow3TopLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow1Path]];
    [shadow3TopLeftImage setFrame:gameModel.clockShadow3TL];
    shadow3TopLeftImage.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:shadow3TopLeftImage];
    
    NSString* shadow2Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:TOPRIGHT_3CLOCKS] ofType:@"png"];
    shadow3TopRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow2Path]];
    [shadow3TopRightImage setFrame:gameModel.clockShadow3TR];
    shadow3TopRightImage.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:shadow3TopRightImage];
    
    NSString* shadow3Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:BOTTOM_3CLOCKS] ofType:@"png"];
    shadow3BottomImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow3Path]];
    [shadow3BottomImage setFrame:gameModel.clockShadow3B];
    shadow3BottomImage.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:shadow3BottomImage];
}

-(void) draw3Flashes {
    NSString* flash1Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash3TLImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash1Path]];
    [self setRectToFlash:flash3TLImage clockPositionArg:TOPLEFT_3CLOCKS];
    flash3TLImage.userInteractionEnabled = NO;
    [topLeft3Image addSubview:flash3TLImage];
    
    NSString* flash2Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash3TRImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash2Path]];
    [self setRectToFlash:flash3TRImage clockPositionArg:TOPRIGHT_3CLOCKS];
    flash3TRImage.userInteractionEnabled = NO;
    [topRight3Image addSubview:flash3TRImage];
    
    NSString* flash3Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash3BImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash3Path]];
    [self setRectToFlash:flash3BImage clockPositionArg:BOTTOM_3CLOCKS];
    flash3BImage.userInteractionEnabled = NO;
    [bottom3Image addSubview:flash3BImage];
}

-(void) draw4Shadow {
    NSString* shadow1Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:TOPLEFT_4CLOCKS] ofType:@"png"];
    shadow4TopLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow1Path]];
    [shadow4TopLeftImage setFrame:gameModel.clockShadow4TL];
    shadow4TopLeftImage.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:shadow4TopLeftImage];
    
    NSString* shadow2Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:TOPRIGHT_4CLOCKS] ofType:@"png"];
    shadow4TopRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow2Path]];
    [shadow4TopRightImage setFrame:gameModel.clockShadow4TR];
    shadow4TopRightImage.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:shadow4TopRightImage];
    
    NSString* shadow3Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:BOTTOMRIGHT_4CLOCKS] ofType:@"png"];
    shadow4BottomRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow3Path]];
    [shadow4BottomRightImage setFrame:gameModel.clockShadow4BR];
    shadow4BottomRightImage.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:shadow4BottomRightImage];
    
    NSString* shadow4Path = [[NSBundle mainBundle] pathForResource:[self getShadowName:BOTTOMLEFT_4CLOCKS] ofType:@"png"];
    shadow4BottomLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shadow4Path]];
    [shadow4BottomLeftImage setFrame:gameModel.clockShadow4BL];
    shadow4BottomLeftImage.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:shadow4BottomLeftImage];
}

-(void) draw4Flashes {
    NSString* flash1Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash4TLImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash1Path]];
    [self setRectToFlash:flash4TLImage clockPositionArg:TOPLEFT_4CLOCKS];
    flash4TLImage.userInteractionEnabled = NO;
    [topLeft4Image addSubview:flash4TLImage];
    
    NSString* flash2Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash4TRImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash2Path]];
    [self setRectToFlash:flash4TRImage clockPositionArg:TOPRIGHT_4CLOCKS];
    flash4TRImage.userInteractionEnabled = NO;
    [topRight4Image addSubview:flash4TRImage];
    
    NSString* flash3Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash4BRImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash3Path]];
    [self setRectToFlash:flash4BRImage clockPositionArg:BOTTOMRIGHT_4CLOCKS];
    flash4BRImage.userInteractionEnabled = NO;
    [bottomRight4Image addSubview:flash4BRImage];
    
    NSString* flash4Path = [[NSBundle mainBundle] pathForResource:@"ClockFlash_Full_0" ofType:@"png"];
    flash4BLImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flash4Path]];
    [self setRectToFlash:flash4BLImage clockPositionArg:BOTTOMLEFT_4CLOCKS];
    flash4BLImage.userInteractionEnabled = NO;
    [bottomLeft4Image addSubview:flash4BLImage];
}

-(void)animateDizzyArgClockIndexArg:(int)clockPosition
                       longImageArg:(UIImageView*)longImageParam
                         longYellow:(UIImageView*)longYellow {
    
    if ([[currentLevel.clocks objectAtIndex:clockPosition-1] rotatingRight] == YES) {
        if ([[currentLevel.clocks objectAtIndex:clockPosition-1] checkTwelve] == YES) {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longYellow arrayArg:longDizzyYellowForwardAnim isForward:YES];
        } else {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longImageParam arrayArg:longDizzyForwardAnim isForward:YES];
        }
    }
    else {
        if ([[currentLevel.clocks objectAtIndex:clockPosition-1] checkTwelve] == YES) {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longYellow arrayArg:longDizzyYellowBackwardAnim isForward:NO];
        } else {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longImageParam arrayArg:longDizzyBackwardAnim isForward:NO];
        }
    }
}

-(void)animateDizzyClockPositionArg:(int)clockPosition
                    longImageArg:(UIImageView*)longImageParam
                   multiplierArg:(int)multiplierParam
                         timeArg:(int)timeParam
                    isForwardArg:(BOOL)isForwardParam
                      longYellow:(UIImageView*)longYellow {
    
    if (multiplierParam == 2) {
        if (timeParam == 11 && isForwardParam == YES) {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longYellow arrayArg:longDizzyYellowForwardAnim isForward:YES];
        }
        else if (timeParam == 1 && isForwardParam == NO) {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longYellow arrayArg:longDizzyYellowBackwardAnim isForward:NO];
        }
        else if (timeParam == 12 && isForwardParam == YES) {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longImageParam arrayArg:longDizzyForwardAnim isForward:YES];
        }
        else if (timeParam == 12 && isForwardParam == NO) {
            [self animatingLongArrowInfinite:defaultMultiplier imageArg:longImageParam arrayArg:longDizzyBackwardAnim isForward:NO];
        }
    }
}

//Clocks position
//1
//2
//Clocks position
-(NSString*) get2LinkingArrows:(Arrow*)temp {
    NSString *l, *arrowName;
    if (temp.origin == 1 &&  temp.destination == 2)
        l = @"Down";
    else if (temp.origin == 2 &&  temp.destination == 1)
        l = @"Up";
    else
        NSLog(@"Logic Error: Overlapping Arrows! (2clocks)");
    
    arrowName = [self arrowCondition:temp lArg:l];
    
    NSString* linkingPath = [[NSBundle mainBundle] pathForResource:arrowName ofType:@"png"];
    return linkingPath;
}

-(NSString*) get3LinkingArrows:(Arrow*)temp {
    //Clocks position
    //1     2
    //   3
    //Clocks position
    NSString *l, *arrowName;
    if (temp.origin == 1 &&  temp.destination == 2)
        l = @"Right";
    else if (temp.origin == 2 &&  temp.destination == 1)
        l = @"Left";
    else if (temp.origin == 1 &&  temp.destination == 3)
        l = @"BottomInThreeFromTopLeft";
    else if (temp.origin == 3 &&  temp.destination == 1)
        l = @"TopLeftInThree";
    else if (temp.origin == 2 &&  temp.destination == 3)
        l = @"BottomInThreeFromTopRight";
    else if (temp.origin == 3 &&  temp.destination == 2)
        l = @"TopRightInThree";
    else
        NSLog(@"Logic Error: Overlapping Arrows! (3clocks)");
    
    arrowName = [self arrowCondition:temp lArg:l];
    
    NSString* linkingPath = [[NSBundle mainBundle] pathForResource:arrowName ofType:@"png"];
    return linkingPath;
}

-(NSString*)arrowCondition:(Arrow*)temp
                      lArg:(NSString*)l {
    
    if ([temp.type isEqualToString:@"normal"]) {
        return [NSString stringWithFormat: @"LinkingArrow%@No%i", l, temp.multiplier];
    } else if ([temp.type isEqualToString:@"explosive"]) {
        return [NSString stringWithFormat: @"LinkingArrow%@No%iEX", l, temp.multiplier];
    } else {
        NSLog(@"Logic error - invalid arrow type");
        return @"0";
    }
//    if ([temp.type isEqualToString:@"normal"]) {
//        arrowNameParam = [NSString stringWithFormat: @"LinkingArrow%@No%i", l, temp.multiplier];
//    } else if ([temp.type isEqualToString:@"explosive"]) {
//        arrowNameParam = [NSString stringWithFormat: @"LinkingArrow%@No%iEX", l, temp.multiplier];
//    } else {
//        NSLog(@"Logic error - invalid arrow type");
//    }
}

-(NSString*) get4LinkingArrows:(Arrow*)temp {
//Clocks position
//1    2
//4    3
//Clocks position
    NSString *l, *arrowName;
    if ((temp.origin == 1 &&  temp.destination == 2)||(temp.origin == 4 && temp.destination == 3))
        l = @"Right";
    else if ((temp.origin == 2 &&  temp.destination == 1)||(temp.origin == 3 && temp.destination == 4))
        l = @"Left";
    else if ((temp.origin == 2 &&  temp.destination == 3)||(temp.origin == 1 && temp.destination == 4))
        l = @"Down";
    else if ((temp.origin == 4 &&  temp.destination == 1)||(temp.origin == 3 && temp.destination == 2))
        l = @"Up";
    else if (temp.origin == 4 &&  temp.destination == 2)
        l = @"TopRight";
    else if (temp.origin == 2 &&  temp.destination == 4)
        l = @"BottomLeft";
    else if (temp.origin == 1 &&  temp.destination == 3)
        l = @"BottomRight";
    else if (temp.origin == 3 &&  temp.destination == 1)
        l = @"TopLeft";
    else
        NSLog(@"Logic Error: Overlapping Arrows! (4clocks)");
    
    arrowName = [self arrowCondition:temp lArg:l];
    
    NSString* linkingPath = [[NSBundle mainBundle] pathForResource:arrowName ofType:@"png"];
    return linkingPath;
}

-(void) refillTempClocks {
    tempClock = [currentLevel.clocks objectAtIndex:0];
    tempClock2Bottom = [currentLevel.clocks objectAtIndex:1];
}

-(void) draw2ClocksSetup {
    @autoreleasepool {
        twoClocksFrame = [[UIImageView alloc] init];
        [twoClocksFrame setFrame:gameModel.twoClocksRect];
        twoClocksFrame.userInteractionEnabled = YES;

        NSString* topClockPath = [self getClockType:UP_2CLOCKS];
        top2ClocksImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topClockPath]];
        [top2ClocksImage setFrame:gameModel.top2ClocksRect];
        top2ClocksImage.userInteractionEnabled = YES;
        
        
        
        longArrow2TopImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:UP_2CLOCKS]]];

        
        [self setRectToHands:longArrow2TopImage clockPositionArg:UP_2CLOCKS];
        if ([[self getClockTypePureString:UP_2CLOCKS] isEqualToString:@"broken"]) {
            longArrow2TopImage.userInteractionEnabled = NO;
        }
        
        tempClock = [currentLevel.clocks objectAtIndex:0];
//        shortArrow2TopImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock.shorterHand clockLocationArg:UP_2CLOCKS]]];
        shortArrow2TopImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock.shorterHand clockLocationArg:UP_2CLOCKS]]];
        [self setRectToHands:shortArrow2TopImage clockPositionArg:UP_2CLOCKS];
        
        NSString* bottomClockPath = [self getClockType:BOTTOM_2CLOCKS];
        bottom2ClocksImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottomClockPath]];
        [bottom2ClocksImage setFrame:gameModel.bottom2ClocksRect];
        bottom2ClocksImage.userInteractionEnabled = YES;
        
        
        longArrow2BottomImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:BOTTOM_2CLOCKS]]];
        
        
        [self setRectToHands:longArrow2BottomImage clockPositionArg:BOTTOM_2CLOCKS];
        if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqualToString:@"broken"]) {
            longArrow2BottomImage.userInteractionEnabled = NO;
        }
        
        tempClock2Bottom = [currentLevel.clocks objectAtIndex:1];
//        shortArrow2BottomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock2Bottom.shorterHand clockLocationArg:BOTTOM_2CLOCKS]]];
        shortArrow2BottomImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock2Bottom.shorterHand clockLocationArg:BOTTOM_2CLOCKS]]];
        [self setRectToHands:shortArrow2BottomImage clockPositionArg:BOTTOM_2CLOCKS];
    }
}

-(NSString*)getShadowName:(int)clockLocationParam {
    
    NSString *fileName;
    
    if ([[self getClockTypePureString:clockLocationParam] isEqual: @"regular"]) {
        fileName = [NSString stringWithFormat: @"C-ORDINARY_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"reversed"]) {
        fileName = [NSString stringWithFormat: @"C-REVERSE_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"sleepyclock"]) {
        fileName = [NSString stringWithFormat: @"C-SLEEPY PLANT_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"dizzy"]) {
        fileName = [NSString stringWithFormat: @"C-DIZZY_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"lazyflower"]) {
        fileName = [NSString stringWithFormat: @"C-PINK FLOWER_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"roman"]) {
        fileName = [NSString stringWithFormat: @"C-ROMAN_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"ninja"]) {
        fileName = [NSString stringWithFormat: @"C-NINJA_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"void"]) {
        fileName = [NSString stringWithFormat: @"C-ICY_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"twoface"]) {
        fileName = [NSString stringWithFormat: @"abc3e23he38"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"chinese"]) {
        fileName = [NSString stringWithFormat: @"C-CHINESE_262px_SHADOW"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"broken"]) {
        fileName = [NSString stringWithFormat: @"C-BROKEN_262px_SHADOW"];
    } else {
        NSLog(@"Logic error - BYRH#*RH&*GDU");
    }
    
    return fileName;
}

-(NSString*)getClockType:(int)location {
    NSString *tempString;
    Clock *tempC = [currentLevel.clocks objectAtIndex:location-1];
    
    if ([tempC.type isEqual: @"regular"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-ORDINARY_262px_BLINK-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"reversed"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-REVERSE_262px_BLINK-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"roman"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-ROMAN_262px_BLINK-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"void"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-ICY_262px_BLINK-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"twoface"]) {
        TwoFace *temp2Face = tempC;
        if (temp2Face.state == angelState) {
            tempString = [[NSBundle mainBundle] pathForResource:@"C-ANGEL_262px_BLINK-1" ofType:@"png"];
        } else if (temp2Face.state == demonState) {
            tempString = [[NSBundle mainBundle] pathForResource:@"C-DEVIL_262px_BLINK-1" ofType:@"png"];
        }
    } else if ([tempC.type isEqual: @"ninja"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-NINJA_262px_BLINK-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"broken"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-BROKEN_262px_RAISE EYEBROW-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"lazyflower"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-PINK FLOWER_262px_BLINK-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"sleepyclock"]) {
        SleepyClock *tempSleepy = tempC;
        if (tempSleepy.status == sleepingState) {
            tempString = [[NSBundle mainBundle] pathForResource:@"C-SLEEPY PLANT_262px_SLEEP-1" ofType:@"png"];
        } else if (tempSleepy.status == awakeState) {
            tempString = [[NSBundle mainBundle] pathForResource:@"C-SLEEPY PLANT_262px_BLINK-1" ofType:@"png"];
        }
    } else if ([tempC.type isEqual: @"chinese"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-CHINESE_262px_SHOCK-1" ofType:@"png"];
    } else if ([tempC.type isEqual: @"dizzy"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-DIZZY_262px_BLINK-1" ofType:@"png"];
    } else {
        NSLog(@"Logic Error - 002");
    }
    
    return tempString;
}

-(int)getAngelOrDemon:(TwoFace*)temp {
    if (temp.state == angelState) return 1;
    else if (temp.state == demonState) return 0;
    return -1;
}

-(NSString*)getClockTypeFromString:(NSString*)clockTypeString {
    NSString *tempString;
    
    if ([clockTypeString isEqual: @"regular"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-ORDINARY_262px_BLINK-1" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"reversed"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"ReversedClock" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"roman"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-ROMAN_262px_BLINK-1" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"void"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-ICY_262px_BLINK-1" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"twoface"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"TwoFace" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"ninja"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-NINJA_262px_BLINK-1" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"broken"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-BROKEN_262px_RAISE EYEBROW-1" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"lazyflower"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-PINK FLOWER_262px_BLINK-1" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"sleepyclock"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"SleepyClock" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"chinese"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-CHINESE_262px_SHOCK-1" ofType:@"png"];
    } else if ([clockTypeString isEqual: @"dizzy"]) {
        tempString = [[NSBundle mainBundle] pathForResource:@"C-DIZZY_262px_BLINK-1" ofType:@"png"];
    } else {
        NSLog(@"Logic Error - Invalid clockTypeString!");
    }
    
    return tempString;
}

-(NSString*)getClockTypePureString:(int)location {
    Clock *tempC = [currentLevel.clocks objectAtIndex:location-1];
    
    if ([tempC.type isEqual: @"regular"]) {
        return @"regular";
    } else if ([tempC.type isEqual: @"reversed"]) {
        return @"reversed";
    } else if ([tempC.type isEqual: @"roman"]) {
        return @"roman";
    } else if ([tempC.type isEqual: @"void"]) {
        return @"void";
    } else if ([tempC.type isEqual: @"twoface"]) {
        return @"twoface";
    } else if ([tempC.type isEqual: @"ninja"]) {
        return @"ninja";
    } else if ([tempC.type isEqual: @"broken"]) {
        return @"broken";
    } else if ([tempC.type isEqual: @"lazyflower"]) {
        return @"lazyflower";
    } else if ([tempC.type isEqual: @"sleepyclock"]) {
        return @"sleepyclock";
    } else if ([tempC.type isEqual: @"chinese"]) {
        return @"chinese";
    } else if ([tempC.type isEqual: @"dizzy"]) {
        return @"dizzy";
    } else {
        NSLog(@"Logic Error - 001");
    }
    
    return @"0";
}

-(void)drawZodiacsArgLocationArg:(UIImageView*)imageParam
                 chineseClockArg:(ChineseClock*)chineseClockParam {
    
    NSString *fileName, *zodiac;
    int counter = chineseClockParam.zodiacAt;
    
    fileName = [NSString stringWithFormat: @"C-CHINESE_262px_KANJI-%i", counter];
    zodiac = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    zodiacsImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:zodiac]];
    [zodiacsImage setFrame:gameModel.zodiacsRect];
    [imageParam addSubview:zodiacsImage];
}

-(void)modifyZodiacsArgLocationArg:(UIImageView*)imageParam
                 chineseClockArg:(ChineseClock*)chineseClockParam {
    
    NSString *fileName, *zodiac;
    int counter = chineseClockParam.zodiacAt;
    
    fileName = [NSString stringWithFormat: @"C-CHINESE_262px_KANJI-%i", counter];
    zodiac = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    [[imageParam.subviews objectAtIndex:0] performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:fileName] waitUntilDone:YES];
}

-(void) draw3Clocks {
    
    gameModel.win = FALSE;
    currentLevel.steps = 0;
    
    threeClocksFrame = [[UIImageView alloc] init];
    [threeClocksFrame setFrame:gameModel.threeClocksRect];
    threeClocksFrame.userInteractionEnabled = YES;
    [self.view addSubview:threeClocksFrame];
    
    [self draw3Shadow];
    
    //clock1
    NSString *topLeftPath = [self getClockType:TOPLEFT_3CLOCKS];
    topLeft3Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topLeftPath]];
    [topLeft3Image setFrame:gameModel.topLeft3Rect];
    topLeft3Image.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:topLeft3Image];
    
    //game logic
    tempClock3TopLeft = [currentLevel.clocks objectAtIndex:0];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:topLeft3Image chineseClockArg:tempClock3TopLeft];
    }
    //draw chinese - ends


    
    longArrow3TopLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:TOPLEFT_3CLOCKS]]];

    
    [self setRectToHands:longArrow3TopLeftImage clockPositionArg:TOPLEFT_3CLOCKS];
    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqualToString:@"broken"]) {
        longArrow3TopLeftImage.userInteractionEnabled = NO;
    }
    
    //Twoface handlers
    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngel = [self getLongName:1 clockLocationArg:TOPLEFT_3CLOCKS];
        longAngel3TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngel]];
        [self setRectToHands:longAngel3TL clockPositionArg:TOPLEFT_3CLOCKS];
        longAngel3TL.userInteractionEnabled = NO;
        longAngel3TL.hidden = YES;
        [topLeft3Image addSubview:longAngel3TL];
        
        NSString* shortAngel = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel3TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngel]];
        [self setRectToHands:shortAngel3TL clockPositionArg:TOPLEFT_3CLOCKS];
        shortAngel3TL.userInteractionEnabled = NO;
        shortAngel3TL.hidden = YES;
        [topLeft3Image addSubview:shortAngel3TL];
    }
    
    //yellow
    NSString* longYellowTL = [self getLongName:999 clockLocationArg:TOPLEFT_3CLOCKS];
    longYellow3TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowTL]];
    [self setRectToHands:longYellow3TL clockPositionArg:TOPLEFT_3CLOCKS];
    longYellow3TL.userInteractionEnabled = NO;
    longYellow3TL.hidden = YES;
    [topLeft3Image addSubview:longYellow3TL];
    
    NSString* shortYellowTL = [self getShortName:12 clockLocationArg:TOPLEFT_3CLOCKS];
    shortYellow3TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowTL]];
    [self setRectToHands:shortYellow3TL clockPositionArg:TOPLEFT_3CLOCKS];
    shortYellow3TL.userInteractionEnabled = NO;
    shortYellow3TL.hidden = YES;
    [topLeft3Image addSubview:shortYellow3TL];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqualToString:@"chinese"]) {
        [topLeft3Image addSubview:longArrow3TopLeftImage];
    }
    
//    shortArrow3TopLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock3TopLeft.shorterHand clockLocationArg:TOPLEFT_3CLOCKS]]];
    shortArrow3TopLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock3TopLeft.shorterHand clockLocationArg:TOPLEFT_3CLOCKS]]];
    [self setRectToHands:shortArrow3TopLeftImage clockPositionArg:TOPLEFT_3CLOCKS];
    
    if (![[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [topLeft3Image addSubview:shortArrow3TopLeftImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock3TopLeft shortImage:shortArrow3TopLeftImage shortAngel:shortAngel3TL];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock3TopLeft longImage:longArrow3TopLeftImage];
    
    //clock2
    NSString* topRightPath = [self getClockType:TOPRIGHT_3CLOCKS];
    topRight3Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topRightPath]];
    [topRight3Image setFrame:gameModel.topRight3Rect];
    topRight3Image.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:topRight3Image];
    
    //game logic
    tempClock3TopRight = [currentLevel.clocks objectAtIndex:1];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:topRight3Image chineseClockArg:tempClock3TopRight];
    }
    //draw chinese - ends
    
    
    
    longArrow3TopRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:TOPRIGHT_3CLOCKS]]];

        
    [self setRectToHands:longArrow3TopRightImage clockPositionArg:TOPRIGHT_3CLOCKS];
    if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqualToString:@"broken"]) {
        longArrow3TopRightImage.userInteractionEnabled = NO;
    }
    
    //Twoface handlers
    if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngel = [self getLongName:1 clockLocationArg:TOPRIGHT_3CLOCKS];
        longAngel3TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngel]];
        [self setRectToHands:longAngel3TR clockPositionArg:TOPRIGHT_3CLOCKS];
        longAngel3TR.userInteractionEnabled = NO;
        longAngel3TR.hidden = YES;
        [topRight3Image addSubview:longAngel3TR];
        
        NSString* shortAngel = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel3TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngel]];
        [self setRectToHands:shortAngel3TR clockPositionArg:TOPRIGHT_3CLOCKS];
        shortAngel3TR.userInteractionEnabled = NO;
        shortAngel3TR.hidden = YES;
        [topRight3Image addSubview:shortAngel3TR];
    }
    
    //yellow
    NSString* longYellowTR = [self getLongName:999 clockLocationArg:TOPRIGHT_3CLOCKS];
    longYellow3TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowTR]];
    [self setRectToHands:longYellow3TR clockPositionArg:TOPRIGHT_3CLOCKS];
    longYellow3TR.userInteractionEnabled = NO;
    longYellow3TR.hidden = YES;
    [topRight3Image addSubview:longYellow3TR];
    
    NSString* shortYellowTR = [self getShortName:12 clockLocationArg:TOPRIGHT_3CLOCKS];
    shortYellow3TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowTR]];
    [self setRectToHands:shortYellow3TR clockPositionArg:TOPRIGHT_3CLOCKS];
    shortYellow3TR.userInteractionEnabled = NO;
    shortYellow3TR.hidden = YES;
    [topRight3Image addSubview:shortYellow3TR];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqualToString:@"chinese"]) {
        [topRight3Image addSubview:longArrow3TopRightImage];
    }
    
//    shortArrow3TopRightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock3TopRight.shorterHand clockLocationArg:TOPRIGHT_3CLOCKS]]];
    shortArrow3TopRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock3TopRight.shorterHand clockLocationArg:TOPRIGHT_3CLOCKS]]];
    [self setRectToHands:shortArrow3TopRightImage clockPositionArg:TOPRIGHT_3CLOCKS];
    
    if (![[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [topRight3Image addSubview:shortArrow3TopRightImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock3TopRight shortImage:shortArrow3TopRightImage shortAngel:shortAngel3TR];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock3TopRight longImage:longArrow3TopRightImage];
    
    //clock3
    NSString* bottomPath = [self getClockType:BOTTOM_3CLOCKS];
    bottom3Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottomPath]];
    [bottom3Image setFrame:gameModel.bottom3Rect];
    bottom3Image.userInteractionEnabled = YES;
    [threeClocksFrame addSubview:bottom3Image];
    
    //game logic
    tempClock3Bottom = [currentLevel.clocks objectAtIndex:2];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:bottom3Image chineseClockArg:tempClock3Bottom];
    }
    //draw chinese - ends
    
    
    
    longArrow3BottomImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:BOTTOM_3CLOCKS]]];
    
    
    [self setRectToHands:longArrow3BottomImage clockPositionArg:BOTTOM_3CLOCKS];
    if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqualToString:@"broken"]) {
        longArrow3BottomImage.userInteractionEnabled = NO;
    }
    
    //Twoface handlers
    if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngel = [self getLongName:1 clockLocationArg:BOTTOM_3CLOCKS];
        longAngel3B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngel]];
        [self setRectToHands:longAngel3B clockPositionArg:BOTTOM_3CLOCKS];
        longAngel3B.userInteractionEnabled = NO;
        longAngel3B.hidden = YES;
        [bottom3Image addSubview:longAngel3B];
        
        NSString* shortAngel = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel3B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngel]];
        [self setRectToHands:shortAngel3B clockPositionArg:BOTTOM_3CLOCKS];
        shortAngel3B.userInteractionEnabled = NO;
        shortAngel3B.hidden = YES;
        [bottom3Image addSubview:shortAngel3B];
    }
    
    //yellow
    NSString* longYellowB = [self getLongName:999 clockLocationArg:BOTTOM_3CLOCKS];
    longYellow3B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowB]];
    [self setRectToHands:longYellow3B clockPositionArg:BOTTOM_3CLOCKS];
    longYellow3B.userInteractionEnabled = NO;
    longYellow3B.hidden = YES;
    [bottom3Image addSubview:longYellow3B];
    
    NSString* shortYellowB = [self getShortName:12 clockLocationArg:BOTTOM_3CLOCKS];
    shortYellow3B = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowB]];
    [self setRectToHands:shortYellow3B clockPositionArg:BOTTOM_3CLOCKS];
    shortYellow3B.userInteractionEnabled = NO;
    shortYellow3B.hidden = YES;
    [bottom3Image addSubview:shortYellow3B];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:BOTTOM_3CLOCKS] isEqualToString:@"chinese"]) {
        [bottom3Image addSubview:longArrow3BottomImage];
    }
    
//    shortArrow3BottomImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock3Bottom.shorterHand clockLocationArg:BOTTOM_3CLOCKS]]];
    shortArrow3BottomImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock3Bottom.shorterHand clockLocationArg:BOTTOM_3CLOCKS]]];
    [self setRectToHands:shortArrow3BottomImage clockPositionArg:BOTTOM_3CLOCKS];
    
    if (![[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [bottom3Image addSubview:shortArrow3BottomImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock3Bottom shortImage:shortArrow3BottomImage shortAngel:shortAngel3B];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock3Bottom longImage:longArrow3BottomImage];
    
    //Linking Arrows
    for (int index=0;index<[currentLevel.arrows count];index++)
    {
        tempArrow1 = [currentLevel.arrows objectAtIndex:index];
        linkingArrow3Clocks = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self get3LinkingArrows:tempArrow1]]];
        
        if(tempArrow1.origin == 1 && tempArrow1.destination == 2) {
            [linkingArrow3Clocks setFrame:gameModel.linkingArrowRight3ClocksSideTopRect];
        }
        else if(tempArrow1.origin == 2 && tempArrow1.destination == 1) {
            [linkingArrow3Clocks setFrame:gameModel.linkingArrowLeft3ClocksSideTopRect];
        }
        else if(tempArrow1.origin == 3 && tempArrow1.destination == 2) {
            [linkingArrow3Clocks setFrame:gameModel.linkingArrow3ClocksToTopRightRect];
        }
        else if(tempArrow1.origin == 2 && tempArrow1.destination == 3) {
            [linkingArrow3Clocks setFrame:gameModel.linkingArrow3ClocksToBottomFromTopRightRect];
        }
        else if(tempArrow1.origin == 3 && tempArrow1.destination == 1) {
            [linkingArrow3Clocks setFrame:gameModel.linkingArrow3ClocksToTopLeftRect];
        }
        else if(tempArrow1.origin == 1 && tempArrow1.destination == 3) {
            [linkingArrow3Clocks setFrame:gameModel.linkingArrow3ClocksToBottomFromTopLeftRect];
        }
        
        [threeClocksFrame addSubview:linkingArrow3Clocks];
    }
    
    //animate dizzy - starts
    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage longYellow:longYellow3TL];
    }
    if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage longYellow:longYellow3TR];
    }
    if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage longYellow:longYellow3B];
    }
    //animate dizzy - ends
    
    [self draw3Flashes];
    
    [self initiateAhaCounter3Clocks];
    
    [self draw3VirtualArrows];
}

-(void) draw4Clocks {
    gameModel.win = FALSE;
    currentLevel.steps = 0;
    
    fourClocksFrame = [[UIImageView alloc] init];
    [fourClocksFrame setFrame:gameModel.fourClocksRect];
    fourClocksFrame.userInteractionEnabled = YES;
    [self.view addSubview:fourClocksFrame];
    
    [self draw4Shadow];
    
    //clock1
    NSString* topLeftPath = [self getClockType:TOPLEFT_4CLOCKS];
    topLeft4Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topLeftPath]];
    [topLeft4Image setFrame:gameModel.topLeft4Rect];
    topLeft4Image.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:topLeft4Image];
    
    //game logic
    tempClock4TopLeft = [currentLevel.clocks objectAtIndex:0];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:topLeft4Image chineseClockArg:tempClock4TopLeft];
    }
    //draw chinese - ends
    

    
    
    longArrow4TopLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:TOPLEFT_4CLOCKS]]];
    
    
    [self setRectToHands:longArrow4TopLeftImage clockPositionArg:TOPLEFT_4CLOCKS];
    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqualToString:@"broken"]) {
        longArrow4TopLeftImage.userInteractionEnabled = NO;
    }
    
    //Twoface handlers
    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngel = [self getLongName:1 clockLocationArg:TOPLEFT_4CLOCKS];
        longAngel4TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngel]];
        [self setRectToHands:longAngel4TL clockPositionArg:TOPLEFT_4CLOCKS];
        longAngel4TL.userInteractionEnabled = NO;
        longAngel4TL.hidden = YES;
        [topLeft4Image addSubview:longAngel4TL];
        
        NSString* shortAngel = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel4TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngel]];
        [self setRectToHands:shortAngel4TL clockPositionArg:TOPLEFT_4CLOCKS];
        shortAngel4TL.userInteractionEnabled = NO;
        shortAngel4TL.hidden = YES;
        [topLeft4Image addSubview:shortAngel4TL];
    }
    
    //yellow
    NSString* longYellowTL = [self getLongName:999 clockLocationArg:TOPLEFT_4CLOCKS];
    longYellow4TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowTL]];
    [self setRectToHands:longYellow4TL clockPositionArg:TOPLEFT_4CLOCKS];
    longYellow4TL.userInteractionEnabled = NO;
    longYellow4TL.hidden = YES;
    [topLeft4Image addSubview:longYellow4TL];
    
    NSString* shortYellowTL = [self getShortName:12 clockLocationArg:TOPLEFT_4CLOCKS];
    shortYellow4TL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowTL]];
    [self setRectToHands:shortYellow4TL clockPositionArg:TOPLEFT_4CLOCKS];
    shortYellow4TL.userInteractionEnabled = NO;
    shortYellow4TL.hidden = YES;
    [topLeft4Image addSubview:shortYellow4TL];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqualToString:@"chinese"]) {
        [topLeft4Image addSubview:longArrow4TopLeftImage];
    }
    
//    shortArrow4TopLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock4TopLeft.shorterHand clockLocationArg:TOPLEFT_4CLOCKS]]];
    shortArrow4TopLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock4TopLeft.shorterHand clockLocationArg:TOPLEFT_4CLOCKS]]];
    [self setRectToHands:shortArrow4TopLeftImage clockPositionArg:TOPLEFT_4CLOCKS];
    
    if (![[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [topLeft4Image addSubview:shortArrow4TopLeftImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock4TopLeft shortImage:shortArrow4TopLeftImage shortAngel:shortAngel4TL];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock4TopLeft longImage:longArrow4TopLeftImage];
    
    //clock2
    NSString* topRightPath = [self getClockType:TOPRIGHT_4CLOCKS];
    topRight4Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topRightPath]];
    [topRight4Image setFrame:gameModel.topRight4Rect];
    topRight4Image.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:topRight4Image];
    
    //game logic
    tempClock4TopRight = [currentLevel.clocks objectAtIndex:1];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:topRight4Image chineseClockArg:tempClock4TopRight];
    }
    //draw chinese - ends
    

    
    
    longArrow4TopRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:TOPRIGHT_4CLOCKS]]];
    
    
    [self setRectToHands:longArrow4TopRightImage clockPositionArg:TOPRIGHT_4CLOCKS];
    if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqualToString:@"broken"]) {
        longArrow4TopRightImage.userInteractionEnabled = NO;
    }
    
    //Twoface handlers
    if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngel = [self getLongName:1 clockLocationArg:TOPRIGHT_4CLOCKS];
        longAngel4TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngel]];
        [self setRectToHands:longAngel4TR clockPositionArg:TOPRIGHT_4CLOCKS];
        longAngel4TR.userInteractionEnabled = NO;
        longAngel4TR.hidden = YES;
        [topRight4Image addSubview:longAngel4TR];
        
        NSString* shortAngel = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel4TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngel]];
        [self setRectToHands:shortAngel4TR clockPositionArg:TOPRIGHT_4CLOCKS];
        shortAngel4TR.userInteractionEnabled = NO;
        shortAngel4TR.hidden = YES;
        [topRight4Image addSubview:shortAngel4TR];
    }
    
    //yellow
    NSString* longYellowTR = [self getLongName:999 clockLocationArg:TOPRIGHT_4CLOCKS];
    longYellow4TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowTR]];
    [self setRectToHands:longYellow4TR clockPositionArg:TOPRIGHT_4CLOCKS];
    longYellow4TR.userInteractionEnabled = NO;
    longYellow4TR.hidden = YES;
    [topRight4Image addSubview:longYellow4TR];
    
    NSString* shortYellowTR = [self getShortName:12 clockLocationArg:TOPRIGHT_4CLOCKS];
    shortYellow4TR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowTR]];
    [self setRectToHands:shortYellow4TR clockPositionArg:TOPRIGHT_4CLOCKS];
    shortYellow4TR.userInteractionEnabled = NO;
    shortYellow4TR.hidden = YES;
    [topRight4Image addSubview:shortYellow4TR];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqualToString:@"chinese"]) {
        [topRight4Image addSubview:longArrow4TopRightImage];
    }
    
//    shortArrow4TopRightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock4TopRight.shorterHand clockLocationArg:TOPRIGHT_4CLOCKS]]];
    shortArrow4TopRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock4TopRight.shorterHand clockLocationArg:TOPRIGHT_4CLOCKS]]];
    [self setRectToHands:shortArrow4TopRightImage clockPositionArg:TOPRIGHT_4CLOCKS];
    
    if (![[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [topRight4Image addSubview:shortArrow4TopRightImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock4TopRight shortImage:shortArrow4TopRightImage shortAngel:shortAngel4TR];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock4TopRight longImage:longArrow4TopRightImage];
    
    //clock3
    NSString* bottomRightPath = [self getClockType:BOTTOMRIGHT_4CLOCKS];
    bottomRight4Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottomRightPath]];
    [bottomRight4Image setFrame:gameModel.bottomRight4Rect];
    bottomRight4Image.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:bottomRight4Image];
    
    //game logic
    tempClock4BottomRight = [currentLevel.clocks objectAtIndex:2];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:bottomRight4Image chineseClockArg:tempClock4BottomRight];
    }
    //draw chinese - ends
    

    
    longArrow4BottomRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:BOTTOMRIGHT_4CLOCKS]]];
    
    
    [self setRectToHands:longArrow4BottomRightImage clockPositionArg:BOTTOMRIGHT_4CLOCKS];
    if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqualToString:@"broken"]) {
        longArrow4BottomRightImage.userInteractionEnabled = NO;
    }
    
    //Twoface handlers
    if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngel = [self getLongName:1 clockLocationArg:BOTTOMRIGHT_4CLOCKS];
        longAngel4BR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngel]];
        [self setRectToHands:longAngel4BR clockPositionArg:BOTTOMRIGHT_4CLOCKS];
        longAngel4BR.userInteractionEnabled = NO;
        longAngel4BR.hidden = YES;
        [bottomRight4Image addSubview:longAngel4BR];
        
        NSString* shortAngel = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel4BR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngel]];
        [self setRectToHands:shortAngel4BR clockPositionArg:BOTTOMRIGHT_4CLOCKS];
        shortAngel4BR.userInteractionEnabled = NO;
        shortAngel4BR.hidden = YES;
        [bottomRight4Image addSubview:shortAngel4BR];
    }
    
    //yellow
    NSString* longYellowBR = [self getLongName:999 clockLocationArg:BOTTOMRIGHT_4CLOCKS];
    longYellow4BR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowBR]];
    [self setRectToHands:longYellow4BR clockPositionArg:BOTTOMRIGHT_4CLOCKS];
    longYellow4BR.userInteractionEnabled = NO;
    longYellow4BR.hidden = YES;
    [bottomRight4Image addSubview:longYellow4BR];
    
    NSString* shortYellowBR = [self getShortName:12 clockLocationArg:BOTTOMRIGHT_4CLOCKS];
    shortYellow4BR = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowBR]];
    [self setRectToHands:shortYellow4BR clockPositionArg:BOTTOMRIGHT_4CLOCKS];
    shortYellow4BR.userInteractionEnabled = NO;
    shortYellow4BR.hidden = YES;
    [bottomRight4Image addSubview:shortYellow4BR];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqualToString:@"chinese"]) {
        [bottomRight4Image addSubview:longArrow4BottomRightImage];
    }
    
//    shortArrow4BottomRightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock4BottomRight.shorterHand clockLocationArg:BOTTOMRIGHT_4CLOCKS]]];
    shortArrow4BottomRightImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock4BottomRight.shorterHand clockLocationArg:BOTTOMRIGHT_4CLOCKS]]];
    [self setRectToHands:shortArrow4BottomRightImage clockPositionArg:BOTTOMRIGHT_4CLOCKS];
    
    if (![[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [bottomRight4Image addSubview:shortArrow4BottomRightImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock4BottomRight shortImage:shortArrow4BottomRightImage shortAngel:shortAngel4BR];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock4BottomRight longImage:longArrow4BottomRightImage];
    
    //clock4
    NSString* bottomLeftPath = [self getClockType:BOTTOMLEFT_4CLOCKS];
    bottomLeft4Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottomLeftPath]];
    [bottomLeft4Image setFrame:gameModel.bottomLeft4Rect];
    bottomLeft4Image.userInteractionEnabled = YES;
    [fourClocksFrame addSubview:bottomLeft4Image];
    
    //game logic
    tempClock4BottomLeft = [currentLevel.clocks objectAtIndex:3];
    
    //draw chinese - starts
    if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqualToString:@"chinese"]) {
        [self drawZodiacsArgLocationArg:bottomLeft4Image chineseClockArg:tempClock4BottomLeft];
    }
    //draw chinese - ends
    

    
    longArrow4BottomLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getLongHandName:1 clockLocationArg:BOTTOMLEFT_4CLOCKS]]];
    
    
    [self setRectToHands:longArrow4BottomLeftImage clockPositionArg:BOTTOMLEFT_4CLOCKS];
    if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqualToString:@"broken"]) {
        longArrow4BottomLeftImage.userInteractionEnabled = NO;
    }
    
    //Twoface handlers
    if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqualToString:@"twoface"]) {
        NSString* longAngel = [self getLongName:1 clockLocationArg:BOTTOMLEFT_4CLOCKS];
        longAngel4BL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longAngel]];
        [self setRectToHands:longAngel4BL clockPositionArg:BOTTOMLEFT_4CLOCKS];
        longAngel4BL.userInteractionEnabled = NO;
        longAngel4BL.hidden = YES;
        [bottomLeft4Image addSubview:longAngel4BL];
        
        NSString* shortAngel = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_1"] ofType:@"png"];
        shortAngel4BL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortAngel]];
        [self setRectToHands:shortAngel4BL clockPositionArg:BOTTOMLEFT_4CLOCKS];
        shortAngel4BL.userInteractionEnabled = NO;
        shortAngel4BL.hidden = YES;
        [bottomLeft4Image addSubview:shortAngel4BL];
    }
    
    //yellow
    NSString* longYellowBL = [self getLongName:999 clockLocationArg:BOTTOMLEFT_4CLOCKS];
    longYellow4BL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:longYellowBL]];
    [self setRectToHands:longYellow4BL clockPositionArg:BOTTOMLEFT_4CLOCKS];
    longYellow4BL.userInteractionEnabled = NO;
    longYellow4BL.hidden = YES;
    [bottomLeft4Image addSubview:longYellow4BL];
    
    NSString* shortYellowBL = [self getShortName:12 clockLocationArg:BOTTOMLEFT_4CLOCKS];
    shortYellow4BL = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:shortYellowBL]];
    [self setRectToHands:shortYellow4BL clockPositionArg:BOTTOMLEFT_4CLOCKS];
    shortYellow4BL.userInteractionEnabled = NO;
    shortYellow4BL.hidden = YES;
    [bottomLeft4Image addSubview:shortYellow4BL];
    
    //when default is 12, long = yellow
    [self handsToYellow];
    
    if (![[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqualToString:@"chinese"]) {
        [bottomLeft4Image addSubview:longArrow4BottomLeftImage];
    }
    
//    shortArrow4BottomLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self getShortHandName:tempClock4BottomLeft.shorterHand clockLocationArg:BOTTOMLEFT_4CLOCKS]]];
    shortArrow4BottomLeftImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self getShortHandName:tempClock4BottomLeft.shorterHand clockLocationArg:BOTTOMLEFT_4CLOCKS]]];
    [self setRectToHands:shortArrow4BottomLeftImage clockPositionArg:BOTTOMLEFT_4CLOCKS];
    
    if (![[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"broken"]) {
        //when default is 12, chinese shorter hand = yellow
//        [self chineseShorterHandToYellow];
        
        [bottomLeft4Image addSubview:shortArrow4BottomLeftImage];
    }
    
    //set shorthand position
    [self initialiseHandPosition:tempClock4BottomLeft shortImage:shortArrow4BottomLeftImage shortAngel:shortAngel4BL];
    //set longbroken position
    [self initialiseLongBrokenPosition:tempClock4BottomLeft longImage:longArrow4BottomLeftImage];
    
    //Linking Arrows
    for (int index=0;index<[currentLevel.arrows count];index++)
    {
        tempArrow1 = [currentLevel.arrows objectAtIndex:index];
        linkingArrow4Clocks = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[self get4LinkingArrows:tempArrow1]]];
        
        if(tempArrow1.origin == 4 && tempArrow1.destination == 1) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowUp4ClocksSideLeftRect];
        }
        else if(tempArrow1.origin == 1 && tempArrow1.destination == 4) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowDown4ClocksSideLeftRect];
        }
        else if(tempArrow1.origin == 3 && tempArrow1.destination == 2) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowUp4ClocksSideRightRect];
        }
        else if(tempArrow1.origin == 2 && tempArrow1.destination == 3) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowDown4ClocksSideRightRect];
        }
        else if(tempArrow1.origin == 1 && tempArrow1.destination == 2) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowRight4ClocksSideTopRect];
        }
        else if(tempArrow1.origin == 2 && tempArrow1.destination == 1) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowLeft4ClocksSideTopRect];
        }
        else if(tempArrow1.origin == 4 && tempArrow1.destination == 3) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowRight4ClocksSideBottomRect];
        }
        else if(tempArrow1.origin == 3 && tempArrow1.destination == 4) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrowLeft4ClocksSideBottomRect];
        }
        else if(tempArrow1.origin == 4 && tempArrow1.destination == 2) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrow4ClocksToTopRightRect];
        }
        else if(tempArrow1.origin == 2 && tempArrow1.destination == 4) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrow4ClocksToBottomLeftRect];
        }
        else if(tempArrow1.origin == 3 && tempArrow1.destination == 1) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrow4ClocksToTopLeftRect];
        }
        else if(tempArrow1.origin == 1 && tempArrow1.destination == 3) {
            [linkingArrow4Clocks setFrame:gameModel.linkingArrow4ClocksToBottomRightRect];
        }
        [fourClocksFrame addSubview:linkingArrow4Clocks];
    }
    
    //animate dizzy - starts
    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage longYellow:longYellow4TL];
    }
    if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage longYellow:longYellow4TR];
    }
    if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage longYellow:longYellow4BL];
    }
    if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqualToString:@"dizzy"]) {
        [self animateDizzyArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage longYellow:longYellow4BR];
    }
    //animate dizzy - ends
    
    [self draw4Flashes];
    
    [self initiateAhaCounter4Clocks];
    
    [self draw4VirtualArrows];
}

//ANIMATION THINGS - STARTS

- (void) timerAnimate2ClocksTop {
    timer2ClocksTop = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(animatingTop2Clocks:)
                                                     userInfo:nil
                                    repeats:NO];
}

- (void) timerAnimate2ClocksBottom {
    timer2ClocksBottom = [NSTimer scheduledTimerWithTimeInterval:0
                                                       target:self
                                                     selector:@selector(animatingBottom2Clocks:)
                                                     userInfo:nil
                                                      repeats:NO];
}

- (void) timerAnimate3ClocksTopLeft {
    timer3ClocksTopLeft = [NSTimer scheduledTimerWithTimeInterval:2
                                                          target:self
                                                        selector:@selector(animatingTL3Clocks:)
                                                        userInfo:nil
                                                         repeats:NO];
}

- (void) timerAnimate3ClocksTopRight {
    timer3ClocksTopRight = [NSTimer scheduledTimerWithTimeInterval:0.8
                                                          target:self
                                                        selector:@selector(animatingTR3Clocks:)
                                                        userInfo:nil
                                                         repeats:NO];
}

- (void) timerAnimate3ClocksBottom {
    timer3ClocksBottom = [NSTimer scheduledTimerWithTimeInterval:0
                                                          target:self
                                                        selector:@selector(animatingBottom3Clocks:)
                                                        userInfo:nil
                                                         repeats:NO];
}

- (void) timerAnimate4ClocksTopLeft {
    timer4ClocksTopLeft = [NSTimer scheduledTimerWithTimeInterval:2
                                                          target:self
                                                        selector:@selector(animatingTL4Clocks:)
                                                        userInfo:nil
                                                         repeats:NO];
}

- (void) timerAnimate4ClocksTopRight {
    timer4ClocksTopRight = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                           target:self
                                                         selector:@selector(animatingTR4Clocks:)
                                                         userInfo:nil
                                                          repeats:NO];
}

- (void) timerAnimate4ClocksBottomRight {
    timer4ClocksBottomRight = [NSTimer scheduledTimerWithTimeInterval:1
                                                           target:self
                                                         selector:@selector(animatingBR4Clocks:)
                                                         userInfo:nil
                                                          repeats:NO];
}

- (void) timerAnimate4ClocksBottomLeft {
    timer4ClocksBottomLeft = [NSTimer scheduledTimerWithTimeInterval:0
                                                           target:self
                                                         selector:@selector(animatingBL4Clocks:)
                                                         userInfo:nil
                                                          repeats:NO];
}

-(void)animatingTop2Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_2CLOCKS_TOP];
}

-(void)animatingBottom2Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_2CLOCKS_BOTTOM];
}

-(void)animatingTL3Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_3CLOCKS_TOPLEFT];
}

-(void)animatingTR3Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_3CLOCKS_TOPRIGHT];
}

-(void)animatingBottom3Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_3CLOCKS_BOTTOM];
}

-(void)animatingTL4Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_4CLOCKS_TOPLEFT];
}

-(void)animatingTR4Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_4CLOCKS_TOPRIGHT];
}

-(void)animatingBR4Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_4CLOCKS_BOTTOMRIGHT];
}

-(void)animatingBL4Clocks:(NSTimer *) timer {
    [self callWhichAnimation:NEWVAR_4CLOCKS_BOTTOMLEFT];
}

-(void)callSleepingAnimation:(int)clockPosition {
    if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"sleepyclock"]) {
        if (ordinaryIndex % 4 == 0) {
            [self timerAnimateOrdinary1:clockPosition];
        } else if (ordinaryIndex % 4 == 1) {
            [self timerAnimateOrdinary2:clockPosition];
        } else if (ordinaryIndex % 4 == 2) {
            [self timerAnimateOrdinary3:clockPosition];
        } else if (ordinaryIndex % 4 == 3) {
            [self timerAnimateOrdinary4:clockPosition];
        }
    } else {
        NSLog(@"Logic error - 78325b65b65n\n");
    }
}

-(void)callWhichAnimation:(int)clockPosition {
    if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"regular"]) {
        if (ordinaryIndex % 4 == 0) {
            [self timerAnimateOrdinary1:clockPosition];
        } else if (ordinaryIndex % 4 == 1) {
            [self timerAnimateOrdinary2:clockPosition];
        } else if (ordinaryIndex % 4 == 2) {
            [self timerAnimateOrdinary3:clockPosition];
        } else if (ordinaryIndex % 4 == 3) {
            [self timerAnimateOrdinary4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"reversed"]) {
        if (reversedIndex % 4 == 0) {
            [self timerAnimateReversed1:clockPosition];
        } else if (reversedIndex % 4 == 1) {
            [self timerAnimateReversed2:clockPosition];
        } else if (reversedIndex % 4 == 2) {
            [self timerAnimateReversed3:clockPosition];
        } else if (reversedIndex % 4 == 3) {
            [self timerAnimateReversed4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"sleepyclock"]) {
        if ([self convertToOld:clockPosition] % 4 == 1) {
            [self timerAnimateSleepy1:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 2) {
            [self timerAnimateSleepy2:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 3) {
            [self timerAnimateSleepy3:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 4) {
            [self timerAnimateSleepy4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"dizzy"]) {
        if (dizzyIndex % 4 == 0) {
            [self timerAnimateDizzy1:clockPosition];
        } else if (dizzyIndex % 4 == 1) {
            [self timerAnimateDizzy2:clockPosition];
        } else if (dizzyIndex % 4 == 2) {
            [self timerAnimateDizzy3:clockPosition];
        } else if (dizzyIndex % 4 == 3) {
            [self timerAnimateDizzy4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"lazyflower"]) {
        if (flowerIndex % 4 == 0) {
            [self timerAnimateFlower1:clockPosition];
        } else if (flowerIndex % 4 == 1) {
            [self timerAnimateFlower2:clockPosition];
        } else if (flowerIndex % 4 == 2) {
            [self timerAnimateFlower3:clockPosition];
        } else if (flowerIndex % 4 == 3) {
            [self timerAnimateDizzy4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"roman"]) {
        if (romanIndex % 4 == 0) {
            [self timerAnimateRoman1:clockPosition];
        } else if (romanIndex % 4 == 1) {
            [self timerAnimateRoman2:clockPosition];
        } else if (romanIndex % 4 == 2) {
            [self timerAnimateRoman3:clockPosition];
        } else if (romanIndex % 4 == 3) {
            [self timerAnimateRoman4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"ninja"]) {
        if (ninjaIndex % 4 == 0) {
            [self timerAnimateNinja1:clockPosition];
        } else if (ninjaIndex % 4 == 1) {
            [self timerAnimateNinja2:clockPosition];
        } else if (ninjaIndex % 4 == 2) {
            [self timerAnimateNinja3:clockPosition];
        } else if (ninjaIndex % 4 == 3) {
            [self timerAnimateNinja4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"void"]) {
        if (icyIndex % 4 == 0) {
            [self timerAnimateIcy1:clockPosition];
        } else if (icyIndex % 4 == 1) {
            [self timerAnimateIcy2:clockPosition];
        } else if (icyIndex % 4 == 2) {
            [self timerAnimateIcy3:clockPosition];
        } else if (icyIndex % 4 == 3) {
            [self timerAnimateIcy4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"twoface"]) {
        [self timerAnimate2face:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"chinese"]) {
        if (chineseIndex % 4 == 0) {
            [self timerAnimateChinese1:clockPosition];
        } else if (chineseIndex % 4 == 1) {
            [self timerAnimateChinese2:clockPosition];
        } else if (chineseIndex % 4 == 2) {
            [self timerAnimateChinese3:clockPosition];
        } else if (chineseIndex % 4 == 3) {
            [self timerAnimateChinese4:clockPosition];
        }
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"broken"]) {
        if (brokenIndex % 4 == 0) {
            [self timerAnimateBroken1:clockPosition];
        } else if (brokenIndex % 4 == 1) {
            [self timerAnimateBroken2:clockPosition];
        } else if (brokenIndex % 4 == 2) {
            [self timerAnimateBroken3:clockPosition];
        } else if (brokenIndex % 4 == 3) {
            [self timerAnimateBroken4:clockPosition];
        }
    } else {
        NSLog(@"Logic error - ygfr4enn88e8\n");
    }
}

-(void)callWhichAnimationWin:(int)clockPosition {
    [self invalidateAllAnimTimers];
    
    if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"regular"]) {
        [self animatingWinOrdinary:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"reversed"]) {
        [self animatingWinReversed:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"sleepyclock"]) {
        [self animatingWinSleepy:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"dizzy"]) {
        [self animatingWinDizzy:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"lazyflower"]) {
        [self animatingWinFlower:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"roman"]) {
        [self animatingWinRoman:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"ninja"]) {
        [self animatingWinNinja:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"void"]) {
        [self animatingWinIcy:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"twoface"]) {
        [self animatingWinAngel:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"chinese"]) {
        [self animatingWinChinese:clockPosition];
    } else if ([[self getClockTypePureString:[self convertToOld:clockPosition]] isEqual: @"broken"]) {
        [self animatingWinBroken:clockPosition];
    } else {
        NSLog(@"Logic error - ygfr49hr8e8\n");
    }
}

-(void) beforeCallWhichWin {
    if (currentLevel.getNumberOfClocks == 2) {
        [self callWhichAnimationWin:21];
        [self callWhichAnimationWin:22];
    }
    else if (currentLevel.getNumberOfClocks == 3) {
        [self callWhichAnimationWin:31];
        [self callWhichAnimationWin:32];
        [self callWhichAnimationWin:33];
    }
    else if (currentLevel.getNumberOfClocks == 4) {
        [self callWhichAnimationWin:41];
        [self callWhichAnimationWin:42];
        [self callWhichAnimationWin:43];
        [self callWhichAnimationWin:44];
    }
}

-(void) timerAnimate2face:(int)clockPosition {
    if (clockPosition % 10 == 1) {
        [tempTimerDevil1 invalidate];
        tempTimerDevil1 = nil;
        [tempTimerAngel1 invalidate];
        tempTimerAngel1 = nil;
    } else if (clockPosition % 10 == 2) {
        [tempTimerDevil2 invalidate];
        tempTimerDevil2 = nil;
        [tempTimerAngel2 invalidate];
        tempTimerAngel2 = nil;
    } else if (clockPosition % 10 == 3) {
        [tempTimerDevil3 invalidate];
        tempTimerDevil3 = nil;
        [tempTimerAngel3 invalidate];
        tempTimerAngel3 = nil;
    } else if (clockPosition % 10 == 4) {
        [tempTimerDevil4 invalidate];
        tempTimerDevil4 = nil;
        [tempTimerAngel4 invalidate];
        tempTimerAngel4 = nil;
    } else NSLog(@"Logic error - b3kdui4u");
    
    TwoFace *temp2Face = [currentLevel.clocks objectAtIndex:[self convertToOld:clockPosition]-1];
    if (temp2Face.state == angelState) {
        if ([self convertToOld:clockPosition] % 4 == 1) {
            [self timerAnimateAngel1:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 2) {
            [self timerAnimateAngel2:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 3) {
            [self timerAnimateAngel3:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 4) {
            [self timerAnimateAngel4:clockPosition];
        }
    } else {
        if ([self convertToOld:clockPosition] % 4 == 1) {
            [self timerAnimateDevil1:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 2) {
            [self timerAnimateDevil2:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 3) {
            [self timerAnimateDevil3:clockPosition];
        } else if ([self convertToOld:clockPosition] % 4 == 4) {
            [self timerAnimateDevil4:clockPosition];
        }
    }
    temp2Face = nil;
}

-(int)convertToOld:(int)newValue {
    switch (newValue) {
        case 21:
            return 1;
            break;
        case 22:
            return 2;
            break;
            
        case 31:
            return 1;
            break;
        case 32:
            return 2;
            break;
        case 33:
            return 3;
            break;
            
        case 41:
            return 1;
            break;
        case 42:
            return 2;
            break;
        case 43:
            return 3;
            break;
        case 44:
            return 4;
            break;
            
        default:
            NSLog(@"Logic error - Invalid value for conversion &*S#H78NB");
            break;
    }
}

-(int) convertToNew:(int)origin
  numberOfClocksArg:(int)numberOfClocksParam {
    
    if (numberOfClocksParam == 2) {
        if (origin == 1) return 21;
        else if (origin == 2) return 22;
        else NSLog(@"error 22635386");
    } else if (numberOfClocksParam == 3) {
        if (origin == 1) return 31;
        else if (origin == 2) return 32;
        else if (origin == 3) return 33;
        else NSLog(@"error 22635387");
    } else if (numberOfClocksParam == 4) {
        if (origin == 1) return 41;
        else if (origin == 2) return 42;
        else if (origin == 3) return 43;
        else if (origin == 4) return 44;
        else NSLog(@"error 22635388");
    } else {
        NSLog(@"Logic error 227452946\n");
    }
}

-(void) resetAnimIndex {
    ordinaryIndex = 0;
    reversedIndex = 0;
    sleepyIndex = 0;
    dizzyIndex = 0;
    flowerIndex = 0;
    romanIndex = 0;
    ninjaIndex = 0;
    icyIndex = 0;
    twofaceIndex = 0;
    chineseIndex = 0;
    brokenIndex = 0;
}

-(void) timerAnimateOrdinary1:(int) clockPosition {
    ordinaryIndex++;
    tempTimerOrdinary1 = [NSTimer scheduledTimerWithTimeInterval:8
                                                  target:self
                                                selector:@selector(animatingOrdinary:)
                                                userInfo:[NSNumber numberWithInt:clockPosition]
                                                                  repeats:YES];
}

-(void) timerAnimateOrdinary2:(int) clockPosition {
    ordinaryIndex++;
    tempTimerOrdinary2 = [NSTimer scheduledTimerWithTimeInterval:8
                                                         target:self
                                                       selector:@selector(animatingOrdinary:)
                                                       userInfo:[NSNumber numberWithInt:clockPosition]
                                                        repeats:YES];
}

-(void) timerAnimateOrdinary3:(int) clockPosition {
    ordinaryIndex++;
    tempTimerOrdinary3 = [NSTimer scheduledTimerWithTimeInterval:8
                                                         target:self
                                                       selector:@selector(animatingOrdinary:)
                                                       userInfo:[NSNumber numberWithInt:clockPosition]
                                                        repeats:YES];
}

-(void) timerAnimateOrdinary4:(int) clockPosition {
    ordinaryIndex++;
    tempTimerOrdinary4 = [NSTimer scheduledTimerWithTimeInterval:8
                                                         target:self
                                                       selector:@selector(animatingOrdinary:)
                                                       userInfo:[NSNumber numberWithInt:clockPosition]
                                                        repeats:YES];
}

-(void) timerAnimateReversed1:(int) clockPosition {
    reversedIndex++;
    tempTimerReversed1 = [NSTimer scheduledTimerWithTimeInterval:10
                                                 target:self
                                               selector:@selector(animatingReversed:)
                                               userInfo:[NSNumber numberWithInt:clockPosition]
                                                repeats:YES];
}

-(void) timerAnimateReversed2:(int) clockPosition {
    reversedIndex++;
    tempTimerReversed2 = [NSTimer scheduledTimerWithTimeInterval:10
                                                         target:self
                                                       selector:@selector(animatingReversed:)
                                                       userInfo:[NSNumber numberWithInt:clockPosition]
                                                        repeats:YES];
}

-(void) timerAnimateReversed3:(int) clockPosition {
    reversedIndex++;
    tempTimerReversed3 = [NSTimer scheduledTimerWithTimeInterval:10
                                                         target:self
                                                       selector:@selector(animatingReversed:)
                                                       userInfo:[NSNumber numberWithInt:clockPosition]
                                                        repeats:YES];
}

-(void) timerAnimateReversed4:(int) clockPosition {
    reversedIndex++;
    tempTimerReversed4 = [NSTimer scheduledTimerWithTimeInterval:10
                                                         target:self
                                                       selector:@selector(animatingReversed:)
                                                       userInfo:[NSNumber numberWithInt:clockPosition]
                                                        repeats:YES];
}

-(void) timerAnimateSleepy1:(int) clockPosition {
    sleepyIndex++;
    tempTimerSleepy1 = [NSTimer scheduledTimerWithTimeInterval:5
                                                 target:self
                                               selector:@selector(animatingSleepy:)
                                               userInfo:[NSNumber numberWithInt:clockPosition]
                                                repeats:YES];
}

-(void) timerAnimateSleepy2:(int) clockPosition {
    sleepyIndex++;
    tempTimerSleepy2 = [NSTimer scheduledTimerWithTimeInterval:5
                                                       target:self
                                                     selector:@selector(animatingSleepy:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}


-(void) timerAnimateSleepy3:(int) clockPosition {
    sleepyIndex++;
    tempTimerSleepy3 = [NSTimer scheduledTimerWithTimeInterval:5
                                                       target:self
                                                     selector:@selector(animatingSleepy:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}


-(void) timerAnimateSleepy4:(int) clockPosition {
    sleepyIndex++;
    tempTimerSleepy4 = [NSTimer scheduledTimerWithTimeInterval:5
                                                       target:self
                                                     selector:@selector(animatingSleepy:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateSleeping:(int) clockPosition {
    tempTimerSleeping = [NSTimer scheduledTimerWithTimeInterval:0.3
                                                        target:self
                                                      selector:@selector(animatingSleeping:)
                                                      userInfo:[NSNumber numberWithInt:clockPosition]
                                                       repeats:NO];
}

-(void) timerAnimateDizzy1:(int) clockPosition {
    dizzyIndex++;
    tempTimerDizzy1 = [NSTimer scheduledTimerWithTimeInterval:8.5
                                                       target:self
                                                     selector:@selector(animatingDizzy:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateDizzy2:(int) clockPosition {
    dizzyIndex++;
    tempTimerDizzy2 = [NSTimer scheduledTimerWithTimeInterval:8.5
                                                      target:self
                                                    selector:@selector(animatingDizzy:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}


-(void) timerAnimateDizzy3:(int) clockPosition {
    dizzyIndex++;
    tempTimerDizzy3 = [NSTimer scheduledTimerWithTimeInterval:8.5
                                                      target:self
                                                    selector:@selector(animatingDizzy:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}


-(void) timerAnimateDizzy4:(int) clockPosition {
    dizzyIndex++;
    tempTimerDizzy4 = [NSTimer scheduledTimerWithTimeInterval:8.5
                                                      target:self
                                                    selector:@selector(animatingDizzy:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}

-(void) timerAnimateFlower1:(int) clockPosition {
    flowerIndex++;
    tempTimerFlower1 = [NSTimer scheduledTimerWithTimeInterval:7.5
                                                       target:self
                                                     selector:@selector(animatingFlower:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateFlower2:(int) clockPosition {
    flowerIndex++;
    tempTimerFlower2 = [NSTimer scheduledTimerWithTimeInterval:7.5
                                                       target:self
                                                     selector:@selector(animatingFlower:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateFlower3:(int) clockPosition {
    flowerIndex++;
    tempTimerFlower3 = [NSTimer scheduledTimerWithTimeInterval:7.5
                                                       target:self
                                                     selector:@selector(animatingFlower:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateFlower4:(int) clockPosition {
    flowerIndex++;
    tempTimerFlower4 = [NSTimer scheduledTimerWithTimeInterval:7.5
                                                       target:self
                                                     selector:@selector(animatingFlower:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateRoman1:(int) clockPosition {
    romanIndex++;
    tempTimerRoman1 = [NSTimer scheduledTimerWithTimeInterval:10.3
                                                       target:self
                                                     selector:@selector(animatingRoman:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateRoman2:(int) clockPosition {
    romanIndex++;
    tempTimerRoman2 = [NSTimer scheduledTimerWithTimeInterval:10.3
                                                      target:self
                                                    selector:@selector(animatingRoman:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}

-(void) timerAnimateRoman3:(int) clockPosition {
    romanIndex++;
    tempTimerRoman3 = [NSTimer scheduledTimerWithTimeInterval:10.3
                                                      target:self
                                                    selector:@selector(animatingRoman:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}

-(void) timerAnimateRoman4:(int) clockPosition {
    romanIndex++;
    tempTimerRoman4 = [NSTimer scheduledTimerWithTimeInterval:10.3
                                                      target:self
                                                    selector:@selector(animatingRoman:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}

-(void) timerAnimateNinja1:(int) clockPosition {
    ninjaIndex++;
    tempTimerNinja1 = [NSTimer scheduledTimerWithTimeInterval:9.5
                                                       target:self
                                                     selector:@selector(animatingNinja:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateNinja2:(int) clockPosition {
    ninjaIndex++;
    tempTimerNinja2 = [NSTimer scheduledTimerWithTimeInterval:9.5
                                                      target:self
                                                    selector:@selector(animatingNinja:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}

-(void) timerAnimateNinja3:(int) clockPosition {
    ninjaIndex++;
    tempTimerNinja3 = [NSTimer scheduledTimerWithTimeInterval:9.5
                                                      target:self
                                                    selector:@selector(animatingNinja:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}

-(void) timerAnimateNinja4:(int) clockPosition {
    ninjaIndex++;
    tempTimerNinja4 = [NSTimer scheduledTimerWithTimeInterval:9.5
                                                      target:self
                                                    selector:@selector(animatingNinja:)
                                                    userInfo:[NSNumber numberWithInt:clockPosition]
                                                     repeats:YES];
}

-(void) timerAnimateIcy1:(int) clockPosition {
    icyIndex++;
    tempTimerIcy1 = [NSTimer scheduledTimerWithTimeInterval:7.8
                                                       target:self
                                                     selector:@selector(animatingIcy:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateIcy2:(int) clockPosition {
    icyIndex++;
    tempTimerIcy2 = [NSTimer scheduledTimerWithTimeInterval:7.8
                                                    target:self
                                                  selector:@selector(animatingIcy:)
                                                  userInfo:[NSNumber numberWithInt:clockPosition]
                                                   repeats:YES];
}

-(void) timerAnimateIcy3:(int) clockPosition {
    icyIndex++;
    tempTimerIcy3 = [NSTimer scheduledTimerWithTimeInterval:7.8
                                                    target:self
                                                  selector:@selector(animatingIcy:)
                                                  userInfo:[NSNumber numberWithInt:clockPosition]
                                                   repeats:YES];
}

-(void) timerAnimateIcy4:(int) clockPosition {
    icyIndex++;
    tempTimerIcy4 = [NSTimer scheduledTimerWithTimeInterval:7.8
                                                    target:self
                                                  selector:@selector(animatingIcy:)
                                                  userInfo:[NSNumber numberWithInt:clockPosition]
                                                   repeats:YES];
}

-(void) timerAnimateAngel1:(int) clockPosition {
    tempTimerAngel1 = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                     target:self
                                                   selector:@selector(animatingAngel:)
                                                   userInfo:[NSNumber numberWithInt:clockPosition]
                                                    repeats:YES];
}

-(void) timerAnimateAngel2:(int) clockPosition {
    tempTimerAngel2 = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                       target:self
                                                     selector:@selector(animatingAngel:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateAngel3:(int) clockPosition {
    tempTimerAngel3 = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                       target:self
                                                     selector:@selector(animatingAngel:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateAngel4:(int) clockPosition {
    tempTimerAngel4 = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                       target:self
                                                     selector:@selector(animatingAngel:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateDevil1:(int) clockPosition {
    tempTimerDevil1 = [NSTimer scheduledTimerWithTimeInterval:5.5
                                                       target:self
                                                     selector:@selector(animatingDevil:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateDevil2:(int) clockPosition {
    tempTimerDevil2 = [NSTimer scheduledTimerWithTimeInterval:5.5
                                                       target:self
                                                     selector:@selector(animatingDevil:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateDevil3:(int) clockPosition {
    tempTimerDevil3 = [NSTimer scheduledTimerWithTimeInterval:5.5
                                                       target:self
                                                     selector:@selector(animatingDevil:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateDevil4:(int) clockPosition {
    tempTimerDevil4 = [NSTimer scheduledTimerWithTimeInterval:5.5
                                                       target:self
                                                     selector:@selector(animatingDevil:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateChinese1:(int) clockPosition {
    chineseIndex++;
    tempTimerChinese1 = [NSTimer scheduledTimerWithTimeInterval:9.8
                                                     target:self
                                                   selector:@selector(animatingChinese:)
                                                   userInfo:[NSNumber numberWithInt:clockPosition]
                                                    repeats:YES];
}

-(void) timerAnimateChinese2:(int) clockPosition {
    chineseIndex++;
    tempTimerChinese2 = [NSTimer scheduledTimerWithTimeInterval:9.8
                                                     target:self
                                                   selector:@selector(animatingChinese:)
                                                   userInfo:[NSNumber numberWithInt:clockPosition]
                                                    repeats:YES];
}

-(void) timerAnimateChinese3:(int) clockPosition {
    chineseIndex++;
    tempTimerChinese3 = [NSTimer scheduledTimerWithTimeInterval:9.8
                                                     target:self
                                                   selector:@selector(animatingChinese:)
                                                   userInfo:[NSNumber numberWithInt:clockPosition]
                                                    repeats:YES];
}

-(void) timerAnimateChinese4:(int) clockPosition {
    chineseIndex++;
    tempTimerChinese4 = [NSTimer scheduledTimerWithTimeInterval:9.8
                                                     target:self
                                                   selector:@selector(animatingChinese:)
                                                   userInfo:[NSNumber numberWithInt:clockPosition]
                                                    repeats:YES];
}

-(void) timerAnimateBroken1:(int) clockPosition {
    brokenIndex++;
    tempTimerBroken1 = [NSTimer scheduledTimerWithTimeInterval:8.75
                                                       target:self
                                                     selector:@selector(animatingBroken:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateBroken2:(int) clockPosition {
    brokenIndex++;
    tempTimerBroken2 = [NSTimer scheduledTimerWithTimeInterval:8.75
                                                       target:self
                                                     selector:@selector(animatingBroken:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateBroken3:(int) clockPosition {
    brokenIndex++;
    tempTimerBroken3 = [NSTimer scheduledTimerWithTimeInterval:8.75
                                                       target:self
                                                     selector:@selector(animatingBroken:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

-(void) timerAnimateBroken4:(int) clockPosition {
    brokenIndex++;
    tempTimerBroken4 = [NSTimer scheduledTimerWithTimeInterval:8.75
                                                       target:self
                                                     selector:@selector(animatingBroken:)
                                                     userInfo:[NSNumber numberWithInt:clockPosition]
                                                      repeats:YES];
}

//-(void)animatingOrdinary:(NSTimer *) timer {
//    //DELETE
//    testtest.animationImages = nil;
//    testtest = nil;
//    
//    testtest = [self getClockImage:[timer.userInfo intValue]];
//    
//    ordinaryCounter++;
//    if (ordinaryCounter % 5 != 0) {
//        testtest.animationImages = regularAnimationStandard1;
//        testtest.animationDuration = 1.0;
//    } else {
//        testtest.animationImages = animOrdinaryB;
//        testtest.animationDuration = 1.3;
//    }
//    testtest.animationRepeatCount = 1;
//    [testtest startAnimating];
//}

//CheckpointNolan
///////ANIMATIONS PRELOAD - STARTS////////
-(void)loadAnimationsInLevel {
    [self setAnimationArrays];
    
//    [self prepareOrdinaryAnimNotWin];
//    [self prepareReversedAnimNotWin];
//    [self prepareSleepyAnimNotWin];
//    [self prepareDizzyAnimNotWin];
//    [self prepareFlowerAnimNotWin];
//    [self prepareRomanAnimNotWin];
//    [self prepareNinjaAnimNotWin];
//    [self prepareIcyAnimNotWin];
//    [self prepareTwofaceAnimNotWin];
//    [self prepareChineseAnimNotWin];
//    [self prepareBrokenAnimNotWin];
//    
//    [self prepareSpecificArrayOrdinary];
//    [self prepareSpecificArrayReversed];
//    [self prepareSpecificArraySleepy];
//    [self prepareSpecificArrayDizzy];
//    [self prepareSpecificArrayFlower];
//    [self prepareSpecificArrayRoman];
//    [self prepareSpecificArrayNinja];
//    [self prepareSpecificArrayIcy];
//    [self prepareSpecificArrayTwoface];
//    [self prepareSpecificArrayChinese];
//    [self prepareSpecificArrayBroken];
//
//    [self prepareOrdinaryWinAnim];
//    [self prepareReversedWinAnim];
//    [self prepareSleepyWinAnim];
//    [self prepareDizzyWinAnim];
//    [self prepareFlowerWinAnim];
//    [self prepareRomanWinAnim];
//    [self prepareNinjaWinAnim];
//    [self prepareIcyWinAnim];
//    [self prepareTwofaceWinAnim];
//    [self prepareChineseWinAnim];
//    [self prepareBrokenWinAnim];
//    
//    [self preloadOrdinary];
//    [self preloadReversed];
//    [self preloadSleepy];
//    [self preloadDizzy];
//    [self preloadFlower];
//    [self preloadRoman];
//    [self preloadNinja];
//    [self preloadIcy];
//    [self preloadTwoface];
//    [self preloadChinese];
//    [self preloadBroken];
    
    [self preloadFullScreenFlash];
}

-(void) preloadFullScreenFlash {
    NSString* array1Gen = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    fullScreenFlashGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:array1Gen]];
    [fullScreenFlashGen setFrame:gameModel.playButtonRect];
    fullScreenFlashGen.userInteractionEnabled = NO;
    [self.view addSubview:fullScreenFlashGen];
    fullScreenFlashGen.hidden = YES;
    fullScreenFlashGen.animationImages = animFlashToWhite;
    fullScreenFlashGen.animationDuration = 0.1;
    fullScreenFlashGen.animationRepeatCount = 1;
    [fullScreenFlashGen startAnimating];
}

-(void) preloadOrdinary {
    NSString* array1Gen = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    ordinaryGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:array1Gen]];
    [ordinaryGenA setFrame:gameModel.playButtonRect];
    ordinaryGenA.userInteractionEnabled = NO;
    [self.view addSubview:ordinaryGenA];
    ordinaryGenA.hidden = YES;
    ordinaryGenA.animationImages = regularAnimationStandard1;
    ordinaryGenA.animationDuration = 0.1;
    ordinaryGenA.animationRepeatCount = 1;
    [ordinaryGenA startAnimating];
    
    NSString* array2Gen = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    ordinaryGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:array2Gen]];
    [ordinaryGenB setFrame:gameModel.playButtonRect];
    ordinaryGenB.userInteractionEnabled = NO;
    [self.view addSubview:ordinaryGenB];
    ordinaryGenB.hidden = YES;
    ordinaryGenB.animationImages = animOrdinaryB;
    ordinaryGenB.animationDuration = 0.1;
    ordinaryGenB.animationRepeatCount = 1;
    [ordinaryGenB startAnimating];
    
//    NSString* array3Gen = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    ordinaryShortGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:array3Gen]];
//    [ordinaryShortGen setFrame:gameModel.playButtonRect];
//    ordinaryShortGen.userInteractionEnabled = NO;
//    [self.view addSubview:ordinaryShortGen];
//    ordinaryShortGen.hidden = YES;
//    ordinaryShortGen.animationImages = shortOrdinaryForwardAnim;
//    ordinaryShortGen.animationDuration = 0.1;
//    ordinaryShortGen.animationRepeatCount = 1;
//    [ordinaryShortGen startAnimating];
//    
//    NSString* array4Gen = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    ordinaryLongGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:array4Gen]];
//    [ordinaryLongGen setFrame:gameModel.playButtonRect];
//    ordinaryLongGen.userInteractionEnabled = NO;
//    [self.view addSubview:ordinaryLongGen];
//    ordinaryLongGen.hidden = YES;
//    ordinaryLongGen.animationImages = longOrdinaryForwardAnim;
//    ordinaryLongGen.animationDuration = 0.1;
//    ordinaryLongGen.animationRepeatCount = 1;
//    [ordinaryLongGen startAnimating];
//    
//    NSString* array5Gen = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    ordinaryLongBackwardsGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:array5Gen]];
//    [ordinaryLongBackwardsGen setFrame:gameModel.playButtonRect];
//    ordinaryLongBackwardsGen.userInteractionEnabled = NO;
//    [self.view addSubview:ordinaryLongBackwardsGen];
//    ordinaryLongBackwardsGen.hidden = YES;
//    ordinaryLongBackwardsGen.animationImages = longOrdinaryBackwardAnim;
//    ordinaryLongBackwardsGen.animationDuration = 0.1;
//    ordinaryLongBackwardsGen.animationRepeatCount = 1;
//    [ordinaryLongBackwardsGen startAnimating];
    
    NSString* arrayGen6 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    ordinaryGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen6]];
    [ordinaryGenWin setFrame:gameModel.playButtonRect];
    ordinaryGenWin.userInteractionEnabled = NO;
    [self.view addSubview:ordinaryGenWin];
    ordinaryGenWin.hidden = YES;
    ordinaryGenWin.animationImages = animOrdinaryWin;
    ordinaryGenWin.animationDuration = 0.1;
    ordinaryGenWin.animationRepeatCount = 1;
    [ordinaryGenWin startAnimating];
}

-(void) preloadReversed {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    reversedGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [reversedGenA setFrame:gameModel.playButtonRect];
    reversedGenA.userInteractionEnabled = NO;
    [self.view addSubview:reversedGenA];
    reversedGenA.hidden = YES;
    reversedGenA.animationImages = animReversedA;
    reversedGenA.animationDuration = 0.1;
    reversedGenA.animationRepeatCount = 1;
    [reversedGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    reversedGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [reversedGenB setFrame:gameModel.playButtonRect];
    reversedGenB.userInteractionEnabled = NO;
    [self.view addSubview:reversedGenB];
    reversedGenB.hidden = YES;
    reversedGenB.animationImages = animReversedB;
    reversedGenB.animationDuration = 0.1;
    reversedGenB.animationRepeatCount = 1;
    [reversedGenB startAnimating];
    
//    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    reversedShortGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
//    [reversedShortGen setFrame:gameModel.playButtonRect];
//    reversedShortGen.userInteractionEnabled = NO;
//    [self.view addSubview:reversedShortGen];
//    reversedShortGen.hidden = YES;
//    reversedShortGen.animationImages = shortReversedForwardAnim;
//    reversedShortGen.animationDuration = 0.1;
//    reversedShortGen.animationRepeatCount = 1;
//    [reversedShortGen startAnimating];
//    
//    NSString* arrayGen4 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    reversedLongGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen4]];
//    [reversedLongGen setFrame:gameModel.playButtonRect];
//    reversedLongGen.userInteractionEnabled = NO;
//    [self.view addSubview:reversedLongGen];
//    reversedLongGen.hidden = YES;
//    reversedLongGen.animationImages = longReversedForwardAnim;
//    reversedLongGen.animationDuration = 0.1;
//    reversedLongGen.animationRepeatCount = 1;
//    [reversedLongGen startAnimating];
//    
//    NSString* arrayGen5 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    reversedLongBackwardsGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen5]];
//    [reversedLongBackwardsGen setFrame:gameModel.playButtonRect];
//    reversedLongBackwardsGen.userInteractionEnabled = NO;
//    [self.view addSubview:reversedLongBackwardsGen];
//    reversedLongBackwardsGen.hidden = YES;
//    reversedLongBackwardsGen.animationImages = longReversedBackwardAnim;
//    reversedLongBackwardsGen.animationDuration = 0.1;
//    reversedLongBackwardsGen.animationRepeatCount = 1;
//    [reversedLongBackwardsGen startAnimating];
    
    NSString* arrayGen6 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    reversedGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen6]];
    [reversedGenWin setFrame:gameModel.playButtonRect];
    reversedGenWin.userInteractionEnabled = NO;
    [self.view addSubview:reversedGenWin];
    reversedGenWin.hidden = YES;
    reversedGenWin.animationImages = animReversedWin;
    reversedGenWin.animationDuration = 0.1;
    reversedGenWin.animationRepeatCount = 1;
    [reversedGenWin startAnimating];
}

-(void) preloadSleepy {
    NSString* arrayGen = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    sleepyGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen]];
    [sleepyGenA setFrame:gameModel.playButtonRect];
    sleepyGenA.userInteractionEnabled = NO;
    [self.view addSubview:sleepyGenA];
    sleepyGenA.hidden = YES;
    sleepyGenA.animationImages = animSleepyA;
    sleepyGenA.animationDuration = 0.1;
    sleepyGenA.animationRepeatCount = 1;
    [sleepyGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    sleepyGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [sleepyGenB setFrame:gameModel.playButtonRect];
    sleepyGenB.userInteractionEnabled = NO;
    [self.view addSubview:sleepyGenB];
    sleepyGenB.hidden = YES;
    sleepyGenB.animationImages = animSleepyB;
    sleepyGenB.animationDuration = 0.1;
    sleepyGenB.animationRepeatCount = 1;
    [sleepyGenB startAnimating];
    
    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    sleepyGenStoA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
    [sleepyGenStoA setFrame:gameModel.playButtonRect];
    sleepyGenStoA.userInteractionEnabled = NO;
    [self.view addSubview:sleepyGenStoA];
    sleepyGenStoA.hidden = YES;
    sleepyGenStoA.animationImages = animSleepToAwake;
    sleepyGenStoA.animationDuration = 0.1;
    sleepyGenStoA.animationRepeatCount = 1;
    [sleepyGenStoA startAnimating];
    
    NSString* arrayGen4 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    sleepyGenAtoS = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen4]];
    [sleepyGenAtoS setFrame:gameModel.playButtonRect];
    sleepyGenAtoS.userInteractionEnabled = NO;
    [self.view addSubview:sleepyGenAtoS];
    sleepyGenAtoS.hidden = YES;
    sleepyGenAtoS.animationImages = animAwakeToSleep;
    sleepyGenAtoS.animationDuration = 0.1;
    sleepyGenAtoS.animationRepeatCount = 1;
    [sleepyGenAtoS startAnimating];
    
//    NSString* arrayGen5 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    sleepyShortGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen5]];
//    [sleepyShortGen setFrame:gameModel.playButtonRect];
//    sleepyShortGen.userInteractionEnabled = NO;
//    [self.view addSubview:sleepyShortGen];
//    sleepyShortGen.hidden = YES;
//    sleepyShortGen.animationImages = shortSleepyForwardAnim;
//    sleepyShortGen.animationDuration = 0.1;
//    sleepyShortGen.animationRepeatCount = 1;
//    [sleepyShortGen startAnimating];
//    
//    NSString* arrayGen6 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    sleepyLongGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen6]];
//    [sleepyLongGen setFrame:gameModel.playButtonRect];
//    sleepyLongGen.userInteractionEnabled = NO;
//    [self.view addSubview:sleepyLongGen];
//    sleepyLongGen.hidden = YES;
//    sleepyLongGen.animationImages = longSleepyForwardAnim;
//    sleepyLongGen.animationDuration = 0.1;
//    sleepyLongGen.animationRepeatCount = 1;
//    [sleepyLongGen startAnimating];
//    
//    NSString* arrayGen7 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    sleepyLongBackwardsGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen7]];
//    [sleepyLongBackwardsGen setFrame:gameModel.playButtonRect];
//    sleepyLongBackwardsGen.userInteractionEnabled = NO;
//    [self.view addSubview:sleepyLongBackwardsGen];
//    sleepyLongBackwardsGen.hidden = YES;
//    sleepyLongBackwardsGen.animationImages = longSleepyBackwardAnim;
//    sleepyLongBackwardsGen.animationDuration = 0.1;
//    sleepyLongBackwardsGen.animationRepeatCount = 1;
//    [sleepyLongBackwardsGen startAnimating];
    
    NSString* arrayGen8 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    sleepyGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen8]];
    [sleepyGenWin setFrame:gameModel.playButtonRect];
    sleepyGenWin.userInteractionEnabled = NO;
    [self.view addSubview:sleepyGenWin];
    sleepyGenWin.hidden = YES;
    sleepyGenWin.animationImages = animSleepyWin;
    sleepyGenWin.animationDuration = 0.1;
    sleepyGenWin.animationRepeatCount = 1;
    [sleepyGenWin startAnimating];
}

-(void) preloadDizzy {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    dizzyGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [dizzyGenA setFrame:gameModel.playButtonRect];
    dizzyGenA.userInteractionEnabled = NO;
    [self.view addSubview:dizzyGenA];
    dizzyGenA.hidden = YES;
    dizzyGenA.animationImages = animDizzyA;
    dizzyGenA.animationDuration = 0.1;
    dizzyGenA.animationRepeatCount = 1;
    [dizzyGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    dizzyGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [dizzyGenB setFrame:gameModel.playButtonRect];
    dizzyGenB.userInteractionEnabled = NO;
    [self.view addSubview:dizzyGenB];
    dizzyGenB.hidden = YES;
    dizzyGenB.animationImages = animDizzyB;
    dizzyGenB.animationDuration = 0.1;
    dizzyGenB.animationRepeatCount = 1;
    [dizzyGenB startAnimating];
    
//    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    dizzyShortGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
//    [dizzyShortGen setFrame:gameModel.playButtonRect];
//    dizzyShortGen.userInteractionEnabled = NO;
//    [self.view addSubview:dizzyShortGen];
//    dizzyShortGen.hidden = YES;
//    dizzyShortGen.animationImages = shortDizzyForwardAnim;
//    dizzyShortGen.animationDuration = 0.1;
//    dizzyShortGen.animationRepeatCount = 1;
//    [dizzyShortGen startAnimating];
    
    NSString* arrayGen4 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    dizzyGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen4]];
    [dizzyGenWin setFrame:gameModel.playButtonRect];
    dizzyGenWin.userInteractionEnabled = NO;
    [self.view addSubview:dizzyGenWin];
    dizzyGenWin.hidden = YES;
    dizzyGenWin.animationImages = animDizzyWin;
    dizzyGenWin.animationDuration = 0.1;
    dizzyGenWin.animationRepeatCount = 1;
    [dizzyGenWin startAnimating];
}

-(void) preloadFlower {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    flowerGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [flowerGenA setFrame:gameModel.playButtonRect];
    flowerGenA.userInteractionEnabled = NO;
    [self.view addSubview:flowerGenA];
    flowerGenA.hidden = YES;
    flowerGenA.animationImages = animFlowerA;
    flowerGenA.animationDuration = 0.1;
    flowerGenA.animationRepeatCount = 1;
    [flowerGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    flowerGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [flowerGenB setFrame:gameModel.playButtonRect];
    flowerGenB.userInteractionEnabled = NO;
    [self.view addSubview:flowerGenB];
    flowerGenB.hidden = YES;
    flowerGenB.animationImages = animFlowerB;
    flowerGenB.animationDuration = 0.1;
    flowerGenB.animationRepeatCount = 1;
    [flowerGenB startAnimating];
    
//    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    flowerShortGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
//    [flowerShortGen setFrame:gameModel.playButtonRect];
//    flowerShortGen.userInteractionEnabled = NO;
//    [self.view addSubview:flowerShortGen];
//    flowerShortGen.hidden = YES;
//    flowerShortGen.animationImages = shortFlowerForwardAnim;
//    flowerShortGen.animationDuration = 0.1;
//    flowerShortGen.animationRepeatCount = 1;
//    [flowerShortGen startAnimating];
//    
//    NSString* arrayGen4 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    flowerLongGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen4]];
//    [flowerLongGen setFrame:gameModel.playButtonRect];
//    flowerLongGen.userInteractionEnabled = NO;
//    [self.view addSubview:flowerLongGen];
//    flowerLongGen.hidden = YES;
//    flowerLongGen.animationImages = longFlowerForwardAnim;
//    flowerLongGen.animationDuration = 0.1;
//    flowerLongGen.animationRepeatCount = 1;
//    [flowerLongGen startAnimating];
//    
//    NSString* arrayGen5 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    flowerLongBackwardsGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen5]];
//    [flowerLongBackwardsGen setFrame:gameModel.playButtonRect];
//    flowerLongBackwardsGen.userInteractionEnabled = NO;
//    [self.view addSubview:flowerLongBackwardsGen];
//    flowerLongBackwardsGen.hidden = YES;
//    flowerLongBackwardsGen.animationImages = longFlowerBackwardAnim;
//    flowerLongBackwardsGen.animationDuration = 0.1;
//    flowerLongBackwardsGen.animationRepeatCount = 1;
//    [flowerLongBackwardsGen startAnimating];
//    
//    NSString* arrayGen6 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    flowerLongGen2 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen6]];
//    [flowerLongGen2 setFrame:gameModel.playButtonRect];
//    flowerLongGen2.userInteractionEnabled = NO;
//    [self.view addSubview:flowerLongGen2];
//    flowerLongGen2.hidden = YES;
//    flowerLongGen2.animationImages = longArrowLazyForward;
//    flowerLongGen2.animationDuration = 0.1;
//    flowerLongGen2.animationRepeatCount = 1;
//    [flowerLongGen2 startAnimating];
//    
//    NSString* arrayGen7 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
//    flowerLongBackwardsGen2 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen7]];
//    [flowerLongBackwardsGen2 setFrame:gameModel.playButtonRect];
//    flowerLongBackwardsGen2.userInteractionEnabled = NO;
//    [self.view addSubview:flowerLongBackwardsGen2];
//    flowerLongBackwardsGen2.hidden = YES;
//    flowerLongBackwardsGen2.animationImages = longArrowLazyBackward;
//    flowerLongBackwardsGen2.animationDuration = 0.1;
//    flowerLongBackwardsGen2.animationRepeatCount = 1;
//    [flowerLongBackwardsGen2 startAnimating];
    
    NSString* arrayGen8 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    flowerGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen8]];
    [flowerGenWin setFrame:gameModel.playButtonRect];
    flowerGenWin.userInteractionEnabled = NO;
    [self.view addSubview:flowerGenWin];
    flowerGenWin.hidden = YES;
    flowerGenWin.animationImages = animFlowerWin;
    flowerGenWin.animationDuration = 0.1;
    flowerGenWin.animationRepeatCount = 1;
    [flowerGenWin startAnimating];
}

-(void) preloadRoman {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    romanGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [romanGenA setFrame:gameModel.playButtonRect];
    romanGenA.userInteractionEnabled = NO;
    [self.view addSubview:romanGenA];
    romanGenA.hidden = YES;
    romanGenA.animationImages = animRomanA;
    romanGenA.animationDuration = 0.1;
    romanGenA.animationRepeatCount = 1;
    [romanGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    romanGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [romanGenB setFrame:gameModel.playButtonRect];
    romanGenB.userInteractionEnabled = NO;
    [self.view addSubview:romanGenB];
    romanGenB.hidden = YES;
    romanGenB.animationImages = animRomanB;
    romanGenB.animationDuration = 0.1;
    romanGenB.animationRepeatCount = 1;
    [romanGenB startAnimating];
    
    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    romanGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
    [romanGenWin setFrame:gameModel.playButtonRect];
    romanGenWin.userInteractionEnabled = NO;
    [self.view addSubview:romanGenWin];
    romanGenWin.hidden = YES;
    romanGenWin.animationImages = animRomanWin;
    romanGenWin.animationDuration = 0.1;
    romanGenWin.animationRepeatCount = 1;
    [romanGenWin startAnimating];
}

-(void) preloadNinja {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    ninjaGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [ninjaGenA setFrame:gameModel.playButtonRect];
    ninjaGenA.userInteractionEnabled = NO;
    [self.view addSubview:ninjaGenA];
    ninjaGenA.hidden = YES;
    ninjaGenA.animationImages = animNinjaA;
    ninjaGenA.animationDuration = 0.1;
    ninjaGenA.animationRepeatCount = 1;
    [ninjaGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    ninjaGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [ninjaGenB setFrame:gameModel.playButtonRect];
    ninjaGenB.userInteractionEnabled = NO;
    [self.view addSubview:ninjaGenB];
    ninjaGenB.hidden = YES;
    ninjaGenB.animationImages = animNinjaB;
    ninjaGenB.animationDuration = 0.1;
    ninjaGenB.animationRepeatCount = 1;
    [ninjaGenB startAnimating];
    
    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    ninjaGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
    [ninjaGenWin setFrame:gameModel.playButtonRect];
    ninjaGenWin.userInteractionEnabled = NO;
    [self.view addSubview:ninjaGenWin];
    ninjaGenWin.hidden = YES;
    ninjaGenWin.animationImages = animNinjaWin;
    ninjaGenWin.animationDuration = 0.1;
    ninjaGenWin.animationRepeatCount = 1;
    [ninjaGenWin startAnimating];
}

-(void) preloadIcy {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    icyGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [icyGenA setFrame:gameModel.playButtonRect];
    icyGenA.userInteractionEnabled = NO;
    [self.view addSubview:icyGenA];
    icyGenA.hidden = YES;
    icyGenA.animationImages = animIcyA;
    icyGenA.animationDuration = 0.1;
    icyGenA.animationRepeatCount = 1;
    [icyGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    icyGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [icyGenB setFrame:gameModel.playButtonRect];
    icyGenB.userInteractionEnabled = NO;
    [self.view addSubview:icyGenB];
    icyGenB.hidden = YES;
    icyGenB.animationImages = animIcyB;
    icyGenB.animationDuration = 0.1;
    icyGenB.animationRepeatCount = 1;
    [icyGenB startAnimating];
    
    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    icyGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
    [icyGenWin setFrame:gameModel.playButtonRect];
    icyGenWin.userInteractionEnabled = NO;
    [self.view addSubview:icyGenWin];
    icyGenWin.hidden = YES;
    icyGenWin.animationImages = animIcyWin;
    icyGenWin.animationDuration = 0.1;
    icyGenWin.animationRepeatCount = 1;
    [icyGenWin startAnimating];
}

-(void) preloadTwoface {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    angelGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [angelGenA setFrame:gameModel.playButtonRect];
    angelGenA.userInteractionEnabled = NO;
    [self.view addSubview:angelGenA];
    angelGenA.hidden = YES;
    angelGenA.animationImages = animAngelA;
    angelGenA.animationDuration = 0.1;
    angelGenA.animationRepeatCount = 1;
    [angelGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    angelGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [angelGenWin setFrame:gameModel.playButtonRect];
    angelGenWin.userInteractionEnabled = NO;
    [self.view addSubview:angelGenWin];
    angelGenWin.hidden = YES;
    angelGenWin.animationImages = animAngelWin;
    angelGenWin.animationDuration = 0.1;
    angelGenWin.animationRepeatCount = 1;
    [angelGenWin startAnimating];
    
    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    devilGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
    [devilGenA setFrame:gameModel.playButtonRect];
    devilGenA.userInteractionEnabled = NO;
    [self.view addSubview:devilGenA];
    devilGenA.hidden = YES;
    devilGenA.animationImages = animDevilA;
    devilGenA.animationDuration = 0.1;
    devilGenA.animationRepeatCount = 1;
    [devilGenA startAnimating];
    
    NSString* arrayGen4 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    devilToAngelGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen4]];
    [devilToAngelGen setFrame:gameModel.playButtonRect];
    devilToAngelGen.userInteractionEnabled = NO;
    [self.view addSubview:devilToAngelGen];
    devilToAngelGen.hidden = YES;
    devilToAngelGen.animationImages = animDevilToAngel;
    devilToAngelGen.animationDuration = 0.1;
    devilToAngelGen.animationRepeatCount = 1;
    [devilToAngelGen startAnimating];
    
    NSString* arrayGen5 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    angelToDevilGen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen5]];
    [angelToDevilGen setFrame:gameModel.playButtonRect];
    angelToDevilGen.userInteractionEnabled = NO;
    [self.view addSubview:angelToDevilGen];
    angelToDevilGen.hidden = YES;
    angelToDevilGen.animationImages = animAngeltoDevil;
    angelToDevilGen.animationDuration = 0.1;
    angelToDevilGen.animationRepeatCount = 1;
    [angelToDevilGen startAnimating];
}

-(void) preloadChinese {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    chineseGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [chineseGenA setFrame:gameModel.playButtonRect];
    chineseGenA.userInteractionEnabled = NO;
    [self.view addSubview:chineseGenA];
    chineseGenA.hidden = YES;
    chineseGenA.animationImages = animChineseA;
    chineseGenA.animationDuration = 0.1;
    chineseGenA.animationRepeatCount = 1;
    [chineseGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    chineseGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [chineseGenB setFrame:gameModel.playButtonRect];
    chineseGenB.userInteractionEnabled = NO;
    [self.view addSubview:chineseGenB];
    chineseGenB.hidden = YES;
    chineseGenB.animationImages = animChineseB;
    chineseGenB.animationDuration = 0.1;
    chineseGenB.animationRepeatCount = 1;
    [chineseGenB startAnimating];
    
    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    chineseGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
    [chineseGenWin setFrame:gameModel.playButtonRect];
    chineseGenWin.userInteractionEnabled = NO;
    [self.view addSubview:chineseGenWin];
    chineseGenWin.hidden = YES;
    chineseGenWin.animationImages = animChineseWin;
    chineseGenWin.animationDuration = 0.1;
    chineseGenWin.animationRepeatCount = 1;
    [chineseGenWin startAnimating];
}

-(void) preloadBroken {
    NSString* arrayGen1 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    brokenGenA = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen1]];
    [brokenGenA setFrame:gameModel.playButtonRect];
    brokenGenA.userInteractionEnabled = NO;
    [self.view addSubview:brokenGenA];
    brokenGenA.hidden = YES;
    brokenGenA.animationImages = animBrokenA;
    brokenGenA.animationDuration = 0.1;
    brokenGenA.animationRepeatCount = 1;
    [brokenGenA startAnimating];
    
    NSString* arrayGen2 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    brokenGenB = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen2]];
    [brokenGenB setFrame:gameModel.playButtonRect];
    brokenGenB.userInteractionEnabled = NO;
    [self.view addSubview:brokenGenB];
    brokenGenB.hidden = YES;
    brokenGenB.animationImages = animBrokenB;
    brokenGenB.animationDuration = 0.1;
    brokenGenB.animationRepeatCount = 1;
    [brokenGenB startAnimating];
    
    NSString* arrayGen3 = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    brokenGenWin = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrayGen3]];
    [brokenGenWin setFrame:gameModel.playButtonRect];
    brokenGenWin.userInteractionEnabled = NO;
    [self.view addSubview:brokenGenWin];
    brokenGenWin.hidden = YES;
    brokenGenWin.animationImages = animBrokenWin;
    brokenGenWin.animationDuration = 0.1;
    brokenGenWin.animationRepeatCount = 1;
    [brokenGenWin startAnimating];
}

///////ANIMATIONS PRELOAD - ENDS////////

-(void)animatingOrdinary:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    ordinaryCounter++;
    if (ordinaryCounter % 5 != 0) {
        tempImage.animationImages = regularAnimationStandard1;
        tempImage.animationDuration = 1.0;
    } else {
        tempImage.animationImages = animOrdinaryB;
        tempImage.animationDuration = 0.9;
    }
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingReversed:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    reversedCounter++;
    if (reversedCounter % 5 != 0) {
        tempImage.animationImages = animReversedA;
        tempImage.animationDuration = 2.0;
    } else {
        tempImage.animationImages = animReversedB;
        tempImage.animationDuration = 0.8;
    }
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingSleepy:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    [tempImage stopAnimating];
    
    if (sleepyCounter % 3 != 0) {
        tempImage.animationImages = animSleepyA;
        tempImage.animationDuration = 1.1;
    } else {
        tempImage.animationImages = animSleepyB;
        tempImage.animationDuration = 2.0;
    }
    sleepyCounter++;
    
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingSleepToAwake:(UIImageView*) tempImage {
    [tempImage stopAnimating];
    tempImage.animationImages = animSleepToAwake;
    tempImage.animationDuration = 0.3;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingAwakeToSleep:(UIImageView*) tempImage
                 locationArg:(int)clockLocation {
    
    if (clockLocation % 10 == 1) {
        [tempTimerSleepy1 invalidate];
        tempTimerSleepy1 = nil;
    } else if (clockLocation % 10 == 2) {
        [tempTimerSleepy2 invalidate];
        tempTimerSleepy2 = nil;
    } else if (clockLocation % 10 == 3) {
        [tempTimerSleepy3 invalidate];
        tempTimerSleepy3 = nil;
    } else if (clockLocation % 10 == 4) {
        [tempTimerSleepy4 invalidate];
        tempTimerSleepy4 = nil;
    } else NSLog(@"Logic error - b3kd9b4u");
    
    [tempImage stopAnimating];
    tempImage.animationImages = animAwakeToSleep;
    tempImage.animationDuration = 0.3;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingSleeping:(NSTimer *) timer {
    [self enableUIByRemovingLayer];
    
    int clockLocation = [timer.userInfo intValue];
    
    [self animatingSleepingNoTimer:clockLocation];
}

-(void)animatingSleepingNoTimer:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    [tempTimerSleeping invalidate];
    tempTimerSleeping = nil;
    
    [tempImage stopAnimating];
    tempImage.animationImages = animSleepySleeping;
    tempImage.animationDuration = 2.5;
    tempImage.animationRepeatCount = 0;
    [tempImage startAnimating];
}

-(void)animatingDizzy:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    dizzyCounter++;
    if (dizzyCounter % 4 != 0) {
        tempImage.animationImages = animDizzyA;
        tempImage.animationDuration = 0.6;
    } else {
        tempImage.animationImages = animDizzyB;
        tempImage.animationDuration = 2.0;
    }
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingFlower:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    flowerCounter++;
    if (flowerCounter % 4 != 0) {
        tempImage.animationImages = animFlowerA;
        tempImage.animationDuration = 0.5;
    } else {
        tempImage.animationImages = animFlowerB;
        tempImage.animationDuration = 1.0;
    }
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingRoman:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    romanCounter++;
    if (romanCounter % 4 != 0) {
        tempImage.animationImages = animRomanA;
        tempImage.animationDuration = 0.5;
        tempImage.animationRepeatCount = 2;
    } else {
        tempImage.animationImages = animRomanB;
        tempImage.animationDuration = 2.0;
        tempImage.animationRepeatCount = 1;
    }
    [tempImage startAnimating];
}

-(void)animatingNinja:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    ninjaCounter++;
    if (ninjaCounter % 4 != 0) {
        tempImage.animationImages = animNinjaA;
        tempImage.animationDuration = 0.5;
        tempImage.animationRepeatCount = 2;
    } else {
        tempImage.animationImages = animNinjaB;
        tempImage.animationDuration = 1.0;
        tempImage.animationRepeatCount = 1;
    }
    [tempImage startAnimating];
}

-(void)animatingIcy:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    icyCounter++;
    if (icyCounter % 4 != 0) {
        tempImage.animationImages = animIcyA;
        tempImage.animationDuration = 1.0;
    } else {
        tempImage.animationImages = animIcyB;
        tempImage.animationDuration = 0.7;
    }
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingAngel:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    tempImage.animationImages = animAngelA;
    tempImage.animationDuration = 0.5;
    tempImage.animationRepeatCount = 2;
    [tempImage startAnimating];
}

-(void)animatingDevil:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    tempImage.animationImages = animDevilA;
    tempImage.animationDuration = 0.5;
    tempImage.animationRepeatCount = 2;
    [tempImage startAnimating];
}

-(void)animatingChinese:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    chineseCounter++;
    if (chineseCounter % 4 != 0) {
        tempImage.animationImages = animChineseA;
        tempImage.animationDuration = 0.7;
    } else {
        tempImage.animationImages = animChineseB;
        tempImage.animationDuration = 1.0;
    }
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingBroken:(NSTimer *) timer {
    UIImageView *tempImage = [self getClockImage:[timer.userInfo intValue]];
    
    brokenCounter++;
    if (brokenCounter % 4 != 0) {
        tempImage.animationImages = animBrokenA;
        tempImage.animationDuration = 1.0;
    } else {
        tempImage.animationImages = animBrokenB;
        tempImage.animationDuration = 2.0;
    }
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinOrdinary:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animOrdinaryWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinReversed:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animReversedWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinSleepy:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animSleepyWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinDizzy:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animDizzyWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinFlower:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animFlowerWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinRoman:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animRomanWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinNinja:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animNinjaWin;
    tempImage.animationDuration = 1.8;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinIcy:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animIcyWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinAngel:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animAngelWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinChinese:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animChineseWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(void)animatingWinBroken:(int) clockLocation {
    UIImageView *tempImage = [self getClockImage:clockLocation];
    
    tempImage.animationImages = animBrokenWin;
    tempImage.animationDuration = 1.4;
    tempImage.animationRepeatCount = 1;
    [tempImage startAnimating];
}

-(UIImageView*)getClockImage:(int) clockLocation {
    //2clocks - T = 21
    //2clocks - B = 22
    
    //3clocks - TL = 31
    //3clocks - TR = 32
    //3clocks - B = 33
    
    //4clocks - TL = 41
    //4clocks - TR = 42
    //4clocks - BR = 43
    //4clocks - BL = 44
    
    switch (clockLocation) {
        case 21:
            return top2ClocksImage;
            break;
        case 22:
            return bottom2ClocksImage;
            break;
            
        case 31:
            return topLeft3Image;
            break;
        case 32:
            return topRight3Image;
            break;
        case 33:
            return bottom3Image;
            break;
            
        case 41:
            return topLeft4Image;
            break;
        case 42:
            return topRight4Image;
            break;
        case 43:
            return bottomRight4Image;
            break;
        case 44:
            return bottomLeft4Image;
            break;
            
        default:
            NSLog(@"Logic error - Invalid 'clockLocation' - KEJS(F^");
            break;
    }
}

-(void) invalidateAllAnimTimers {
    [timer2ClocksTop invalidate];
    [timer2ClocksBottom invalidate];
    [timer3ClocksTopLeft invalidate];
    [timer3ClocksTopRight invalidate];
    [timer3ClocksBottom invalidate];
    [timer4ClocksTopLeft invalidate];
    [timer4ClocksTopRight invalidate];
    [timer4ClocksBottomLeft invalidate];
    [timer4ClocksTopRight invalidate];
    
    timer2ClocksTop = nil;
    timer2ClocksBottom = nil;
    timer3ClocksTopLeft = nil;
    timer3ClocksTopRight = nil;
    timer3ClocksBottom = nil;
    timer4ClocksTopLeft = nil;
    timer4ClocksTopRight = nil;
    timer4ClocksBottomLeft = nil;
    timer4ClocksTopRight = nil;
    
    
    [tempTimerOrdinary1 invalidate];
    [tempTimerOrdinary2 invalidate];
    [tempTimerOrdinary3 invalidate];
    [tempTimerOrdinary4 invalidate];
    
    [tempTimerReversed1 invalidate];
    [tempTimerReversed2 invalidate];
    [tempTimerReversed3 invalidate];
    [tempTimerReversed4 invalidate];
    
    [tempTimerSleepy1 invalidate];
    [tempTimerSleepy2 invalidate];
    [tempTimerSleepy3 invalidate];
    [tempTimerSleepy4 invalidate];
    
    [tempTimerSleeping invalidate];
    
    [tempTimerDizzy1 invalidate];
    [tempTimerDizzy2 invalidate];
    [tempTimerDizzy3 invalidate];
    [tempTimerDizzy4 invalidate];
    
    [tempTimerFlower1 invalidate];
    [tempTimerFlower2 invalidate];
    [tempTimerFlower3 invalidate];
    [tempTimerFlower4 invalidate];
    
    [tempTimerRoman1 invalidate];
    [tempTimerRoman2 invalidate];
    [tempTimerRoman3 invalidate];
    [tempTimerRoman4 invalidate];
    
    [tempTimerNinja1 invalidate];
    [tempTimerNinja2 invalidate];
    [tempTimerNinja3 invalidate];
    [tempTimerNinja4 invalidate];
    
    [tempTimerIcy1 invalidate];
    [tempTimerIcy2 invalidate];
    [tempTimerIcy3 invalidate];
    [tempTimerIcy4 invalidate];
    
    [tempTimerAngel1 invalidate];
    [tempTimerAngel2 invalidate];
    [tempTimerAngel3 invalidate];
    [tempTimerAngel4 invalidate];
    
    [tempTimerDevil1 invalidate];
    [tempTimerDevil2 invalidate];
    [tempTimerDevil3 invalidate];
    [tempTimerDevil4 invalidate];
    
    [tempTimerChinese1 invalidate];
    [tempTimerChinese2 invalidate];
    [tempTimerChinese3 invalidate];
    [tempTimerChinese4 invalidate];
    
    [tempTimerBroken1 invalidate];
    [tempTimerBroken2 invalidate];
    [tempTimerBroken3 invalidate];
    [tempTimerBroken4 invalidate];
    
    [timerEnableUI invalidate];
    
    
    tempTimerOrdinary1 = nil;
    tempTimerOrdinary2 = nil;
    tempTimerOrdinary3 = nil;
    tempTimerOrdinary4 = nil;
    
    tempTimerReversed1 = nil;
    tempTimerReversed2 = nil;
    tempTimerReversed3 = nil;
    tempTimerReversed4 = nil;
    
    tempTimerSleepy1 = nil;
    tempTimerSleepy2 = nil;
    tempTimerSleepy3 = nil;
    tempTimerSleepy4 = nil;
    
    tempTimerSleeping = nil;
    
    tempTimerDizzy1 = nil;
    tempTimerDizzy2 = nil;
    tempTimerDizzy3 = nil;
    tempTimerDizzy4 = nil;
    
    tempTimerFlower1 = nil;
    tempTimerFlower2 = nil;
    tempTimerFlower3 = nil;
    tempTimerFlower4 = nil;
    
    tempTimerRoman1 = nil;
    tempTimerRoman2 = nil;
    tempTimerRoman3 = nil;
    tempTimerRoman4 = nil;
    
    tempTimerNinja1 = nil;
    tempTimerNinja2 = nil;
    tempTimerNinja3 = nil;
    tempTimerNinja4 = nil;
    
    tempTimerIcy1 = nil;
    tempTimerIcy2 = nil;
    tempTimerIcy3 = nil;
    tempTimerIcy4 = nil;
    
    tempTimerAngel1 = nil;
    tempTimerAngel2 = nil;
    tempTimerAngel3 = nil;
    tempTimerAngel4 = nil;
    
    tempTimerDevil1 = nil;
    tempTimerDevil2 = nil;
    tempTimerDevil3 = nil;
    tempTimerDevil4 = nil;
    
    tempTimerChinese1 = nil;
    tempTimerChinese2 = nil;
    tempTimerChinese3 = nil;
    tempTimerChinese4 = nil;
    
    tempTimerBroken1 = nil;
    tempTimerBroken2 = nil;
    tempTimerBroken3 = nil;
    tempTimerBroken4 = nil;
    
    timerEnableUI = nil;
}

//ANIMATION THINGS - ENDS

//regular long
//delete later on - starts
-(void)animatingLongArrow2TopForward:(int)multiplier  {
    longArrow2TopImage.animationImages = longArrowFullLoopAnimation;
    longArrow2TopImage.animationDuration = 0.35 / multiplier;
    longArrow2TopImage.animationRepeatCount = 1;
    [longArrow2TopImage startAnimating];
}

-(void)animatingLongArrow2TopBackward:(int)multiplier  {
    longArrow2TopImage.animationImages = longArrowFullLoopAnimationReversed;
    longArrow2TopImage.animationDuration = 0.35 / multiplier;
    longArrow2TopImage.animationRepeatCount = 1;
    [longArrow2TopImage startAnimating];
}

-(void)animatingLongArrow2BottomForward:(int)multiplier  {
    longArrow2BottomImage.animationImages = longArrowFullLoopAnimation;
    longArrow2BottomImage.animationDuration = 0.35 / multiplier;
    longArrow2BottomImage.animationRepeatCount = 1;
    [longArrow2BottomImage startAnimating];
}

-(void)animatingLongArrow2BottomBackward:(int)multiplier  {
    longArrow2BottomImage.animationImages = longArrowFullLoopAnimationReversed;
    longArrow2BottomImage.animationDuration = 0.35 / multiplier;
    longArrow2BottomImage.animationRepeatCount = 1;
    [longArrow2BottomImage startAnimating];
}
//delete later on - ends

//reusable long arrow animation
-(void)animatingLongArrow:(int)multiplier imageArg:(UIImageView*)longImage arrayArg:(NSMutableArray*)longArray isForward:(BOOL)isForward type:(NSString*)type isActive:(BOOL)isActive {
    
    if ([type  isEqual: TYPE_FLOWER]) { //getRespectiveYellow
        if (isActive) {
            if (isForward) {
                [self runSpinAnimationOnView:longImage angle:ANGLE_30 * 2.0 duration:0.35/multiplier/2.0 repeat:1.0];
                [NSTimer scheduledTimerWithTimeInterval:0.35/multiplier/2.0
                                                 target:self
                                               selector:@selector(lazyBounceToLeft:)
                                               userInfo:longImage
                                                repeats:NO];
            } else {
                [self runSpinAnimationOnView:longImage angle:-ANGLE_30 * 2.0 duration:0.35/multiplier/2.0 repeat:1.0];
                [NSTimer scheduledTimerWithTimeInterval:0.35/multiplier/2.0
                                                 target:self
                                               selector:@selector(lazyBounceToRight:)
                                               userInfo:longImage
                                                repeats:NO];
            }
        } else {
            if (isForward) {
                [self runSpinAnimationOnView:longImage angle:ANGLE_360 duration:0.35/multiplier repeat:1.0];
            } else {
                [self runSpinAnimationOnView:longImage angle:-ANGLE_360 duration:0.35/multiplier repeat:1.0];
            }
        }
    }
    else if ([type  isEqual: TYPE_BROKEN]) {
        if (isForward) {
            [self runSpinAnimationOnView:longImage angle:ANGLE_360/2.0 duration:0.35/multiplier repeat:1.0];
        } else {
            [self runSpinAnimationOnView:longImage angle:-(ANGLE_360/2.0) duration:0.35/multiplier repeat:1.0];
        }
    }
    else {
        if (isForward) {
            [self runSpinAnimationOnView:longImage angle:ANGLE_360 duration:0.35/multiplier repeat:1.0];
        } else {
            [self runSpinAnimationOnView:longImage angle:-ANGLE_360 duration:0.35/multiplier repeat:1.0];
        }
    }
    
    //    longImage.animationImages = longArray;
    //    longImage.animationDuration = 0.35 / multiplier;
    //    longImage.animationRepeatCount = 1;
    //
    //  [self handsToYellow];
    //
    //    [longImage startAnimating];
}

-(void)animatingYellowFlower:(Clock*)clockObject longYellow:(UIImageView*)longYellow isForward:(BOOL)isForward  {
    int multiplier = 1;
    
    if (isForward) {
        [self runSpinAnimationOnView:longYellow angle:ANGLE_30 * 2.0 duration:0.35/multiplier/2.0 repeat:1.0];
        [NSTimer scheduledTimerWithTimeInterval:0.35/multiplier/2.0
                                         target:self
                                       selector:@selector(lazyBounceToLeft:)
                                       userInfo:longYellow
                                        repeats:NO];
    } else {
        [self runSpinAnimationOnView:longYellow angle:-ANGLE_30 * 2.0 duration:0.35/multiplier/2.0 repeat:1.0];
        [NSTimer scheduledTimerWithTimeInterval:0.35/multiplier/2.0
                                         target:self
                                       selector:@selector(lazyBounceToRight:)
                                       userInfo:longYellow
                                        repeats:NO];
    }
}

-(void)lazyBounceToLeft:(NSTimer *) timer {
    [self runSpinAnimationOnView:[timer userInfo] angle:-ANGLE_30 * 2.0 duration:0.35 repeat:1.0];
}

-(void)lazyBounceToRight:(NSTimer *) timer {
    [self runSpinAnimationOnView:[timer userInfo] angle:ANGLE_30 * 2.0 duration:0.35 repeat:1.0];
}

-(void)animatingLongArrowInfinite:(int)multiplier imageArg:(UIImageView*)longImage arrayArg:(NSMutableArray*)longArray isForward:(BOOL)isForward {
    
    if (isForward == YES) {
        [self runSpinAnimationOnView:longImage angle:ANGLE_360 duration:0.35/multiplier repeat:HUGE_VALF];
    } else {
        [self runSpinAnimationOnView:longImage angle:-ANGLE_360 duration:0.35/multiplier repeat:HUGE_VALF];
    }
}


//reusable long arrow animation by half
-(void)animatingLongArrowByHalf:(int)multiplier imageArg:(UIImageView*)longImage arrayArg:(NSMutableArray*)longArray clockArg:(Clock*)clockParam
                      isForward:(BOOL)isForward {
//    longImage.animationImages = longArray;
//    longImage.animationDuration = 0.35 / multiplier;
//    longImage.animationRepeatCount = 1;
//    
//    if (clockParam.isLongerHandUp == YES) {
//        longImage.image = [longArrowRightToDownAnimation objectAtIndex:longArrowRightToDownAnimation.count-1];
//    } else {
//        longImage.image = [longArrowLeftToUpAnimation objectAtIndex:longArrowLeftToUpAnimation.count-1];
//    }
//    
//    [longImage startAnimating];
    
    if (isForward) {
        [self runSpinAnimationOnView:longImage angle:ANGLE_360/2.0 duration:0.35/multiplier repeat:1.0];
    } else {
        [self runSpinAnimationOnView:longImage angle:-(ANGLE_360/2.0) duration:0.35/multiplier repeat:1.0];
    }
}

///long top (half cycle)
-(void)animatingLongArrow2TopSideRightToDown:(int)multiplier  {
    longArrow2TopImage.animationImages = longArrowRightToDownAnimation;
    longArrow2TopImage.image = [longArrowRightToDownAnimation objectAtIndex:longArrowRightToDownAnimation.count-1];
    longArrow2TopImage.animationDuration = 0.35 / multiplier;
    longArrow2TopImage.animationRepeatCount = multiplier;
    [longArrow2TopImage startAnimating];
}

-(void)animatingLongArrow2TopSideLeftToUp:(int)multiplier  {
    longArrow2TopImage.animationImages = longArrowLeftToUpAnimation;
    longArrow2TopImage.image = [longArrowLeftToUpAnimation objectAtIndex:longArrowLeftToUpAnimation.count-1];
    longArrow2TopImage.animationDuration = 0.35 / multiplier;
    longArrow2TopImage.animationRepeatCount = multiplier;
    [longArrow2TopImage startAnimating];
}

-(void)animatingLongArrow2TopSideLeftToDown:(int)multiplier  {
    longArrow2TopImage.animationImages = longArrowLeftToDownAnimation;
    longArrow2TopImage.image = [longArrowLeftToDownAnimation objectAtIndex:longArrowLeftToDownAnimation.count-1];
    longArrow2TopImage.animationDuration = 0.35 / multiplier;
    longArrow2TopImage.animationRepeatCount = multiplier;
    [longArrow2TopImage startAnimating];
}

-(void)animatingLongArrow2TopSideRightToUp:(int)multiplier  {
    longArrow2TopImage.animationImages = longArrowRightToUpAnimation;
    longArrow2TopImage.image = [longArrowRightToUpAnimation objectAtIndex:longArrowRightToUpAnimation.count-1];
    longArrow2TopImage.animationDuration = 0.35 / multiplier;
    longArrow2TopImage.animationRepeatCount = multiplier;
    [longArrow2TopImage startAnimating];
}

///long bottom (half cycle)
-(void)animatingLongArrow2BottomSideRightToDown:(int)multiplier  {
    longArrow2BottomImage.animationImages = longArrowRightToDownAnimation;
    longArrow2BottomImage.image = [longArrowRightToDownAnimation objectAtIndex:longArrowRightToDownAnimation.count-1];
    longArrow2BottomImage.animationDuration = 0.35 / multiplier;
    longArrow2BottomImage.animationRepeatCount = multiplier;
    [longArrow2BottomImage startAnimating];
}

-(void)animatingLongArrow2BottomSideLeftToUp:(int)multiplier  {
    longArrow2BottomImage.animationImages = longArrowLeftToUpAnimation;
    longArrow2BottomImage.image = [longArrowLeftToUpAnimation objectAtIndex:longArrowLeftToUpAnimation.count-1];
    longArrow2BottomImage.animationDuration = 0.35 / multiplier;
    longArrow2BottomImage.animationRepeatCount = multiplier;
    [longArrow2BottomImage startAnimating];
}

-(void)animatingLongArrow2BottomSideLeftToDown:(int)multiplier  {
    longArrow2BottomImage.animationImages = longArrowLeftToDownAnimation;
    longArrow2BottomImage.image = [longArrowLeftToDownAnimation objectAtIndex:longArrowLeftToDownAnimation.count-1];
    longArrow2BottomImage.animationDuration = 0.35 / multiplier;
    longArrow2BottomImage.animationRepeatCount = multiplier;
    [longArrow2BottomImage startAnimating];
}

-(void)animatingLongArrow2BottomSideRightToUp:(int)multiplier  {
    longArrow2BottomImage.animationImages = longArrowRightToUpAnimation;
    longArrow2BottomImage.image = [longArrowRightToUpAnimation objectAtIndex:longArrowRightToUpAnimation.count-1];
    longArrow2BottomImage.animationDuration = 0.35 / multiplier;
    longArrow2BottomImage.animationRepeatCount = multiplier;
    [longArrow2BottomImage startAnimating];
}


-(void)executeShortForward:(int) multiplier
                  imageArg:(UIImageView*)shortImage
                  clockArg:(Clock*)clockParameter {
    
    //update game logic
    [clockParameter moveHandsForward:2 :1];
    
    //update view
    [self runSpinAnimationOnView:shortImage angle:ANGLE_30 duration:0.35/multiplier repeat:1.0];
    
    //handle twoface angel hands layer
    if ([clockParameter.type isEqualToString:@"twoface"]) {
        [self runSpinAnimationOnView:[self getAngelShort:clockParameter.location] angle:ANGLE_30 duration:0.35/multiplier repeat:1.0];
    }
    
//    [self handsToYellow];
    
//    [self getProperShortAnimation:clockParameter];
//    
//    shortImage.animationImages = nil;
//    shortImage.image = nil;
//    
//    switch (clockParameter.shorterHand) {
//        case 12:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:1];
//            break;
//        case 1:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:2];
//            break;
//        case 2:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:3];
//            break;
//        case 3:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:4];
//            break;
//        case 4:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:5];
//            break;
//        case 5:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:6];
//            break;
//        case 6:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:7];
//            break;
//        case 7:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:8];
//            break;
//        case 8:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:9];
//            break;
//        case 9:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:10];
//            break;
//        case 10:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:11];
//            break;
//        case 11:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:YES toNumberArg:12];
//            break;
//    }
//    
//    shortImage.animationImages = tempAnimArray;
//    shortImage.image = [tempAnimArray objectAtIndex:tempAnimArray.count-1];
//    //game animation
//    
//    shortImage.animationDuration = 0.35/multiplier;
//    shortImage.animationRepeatCount = 1;
//
//    [self chineseShorterHandToYellow];
//    
//    [shortImage startAnimating];
//    
//    //cleanarray
//    for (int i=tempAnimArray.count-1;i>=0;i--) {
//        if([tempAnimArray objectAtIndex:i]) [tempAnimArray removeObjectAtIndex:i];
//    }
}

-(void)executeShortForward:(int) multiplier
                  imageArg:(UIImageView*)shortImage
                  clockArg:(Clock*)clockParameter
                 isDoubled:(BOOL)isDoubled {
    
    //update game logic
    [clockParameter moveHandsForward:2 :2];
    
    //update view
    [self runSpinAnimationOnView:shortImage angle:ANGLE_30 * 2.0 duration:0.35/multiplier repeat:1.0];
    
    //handle twoface angel hands layer
    if ([clockParameter.type isEqualToString:@"twoface"]) {
        [self runSpinAnimationOnView:[self getAngelShort:clockParameter.location] angle:ANGLE_30 * 2.0 duration:0.35/multiplier repeat:1.0];
    }
    
}

-(void)executeShortBackward:(int) multiplier
                   imageArg:(UIImageView*)shortImage
                   clockArg:(Clock*)clockParameter {
    
    //game logic
    [clockParameter moveHandsBackward:2 :1];
    
    //update view
    [self runSpinAnimationOnView:shortImage angle:-ANGLE_30 duration:0.35/multiplier repeat:1.0];
    
    //handle twoface angel hands layer
    if ([clockParameter.type isEqualToString:@"twoface"]) {
        [self runSpinAnimationOnView:[self getAngelShort:clockParameter.location] angle:-ANGLE_30 duration:0.35/multiplier repeat:1.0];
    }
    
//    [self handsToYellow];
    
//    [self getProperShortAnimation:clockParameter];
//    
//    shortImage.animationImages = nil;
//    shortImage.image = nil;
//    
//    switch (clockParameter.shorterHand) {
//        case 2:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:1];
//            break;
//        case 3:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:2];
//            break;
//        case 4:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:3];
//            break;
//        case 5:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:4];
//            break;
//        case 6:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:5];
//            break;
//        case 7:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:6];
//            break;
//        case 8:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:7];
//            break;
//        case 9:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:8];
//            break;
//        case 10:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:9];
//            break;
//        case 11:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:10];
//            break;
//        case 12:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:11];
//            break;
//        case 1:
//            [self getShortAnimationImages:tempShortFullAnim isForwardArg:NO toNumberArg:12];
//            break;
//    }
//    
//    shortImage.animationImages = tempAnimArray;
//    shortImage.image = [tempAnimArray objectAtIndex:tempAnimArray.count-1];
//    //game animation
//    shortImage.animationDuration = 0.35/multiplier;
//    shortImage.animationRepeatCount = 1;
//    
//    
////    if ([clockParameter.type  isEqual: @"chinese"]); {
//        [self chineseShorterHandToYellow];
////    }
//    
//    [shortImage startAnimating];
//    
//    //cleanarray
//    for (int i=tempAnimArray.count-1;i>=0;i--) {
//        if([tempAnimArray objectAtIndex:i]) [tempAnimArray removeObjectAtIndex:i];
//    }
}

-(void)executeShortBackward:(int) multiplier
                   imageArg:(UIImageView*)shortImage
                   clockArg:(Clock*)clockParameter
                  isDoubled:(BOOL)isDoubled {
    
    //game logic
    [clockParameter moveHandsBackward:2 :2];
    
    //update view
    [self runSpinAnimationOnView:shortImage angle:-ANGLE_30 * 2.0 duration:0.35/multiplier repeat:1.0];
    
    //handle twoface angel hands layer
    if ([clockParameter.type isEqualToString:@"twoface"]) {
        [self runSpinAnimationOnView:[self getAngelShort:clockParameter.location] angle:-ANGLE_30 * 2.0 duration:0.35/multiplier repeat:1.0];
    }
    
}

-(void) handleIndirectBrokenArgClockIndexArg:(int)clockIndexParam
                        longImageArg:(UIImageView*)longImageParam
                            clockArg:(Clock*)clockParam
                       multiplierArg:(int)multiplierParam
                        directionArg:(int)directionParam
{
    if (directionParam == forwardDirection) {
        if (multiplierParam == 1) {
            if ([[currentLevel.clocks objectAtIndex:clockIndexParam-1] isLongerHandUp] == YES) {
                [self animatingLongArrowByHalf:defaultMultiplier imageArg:longImageParam arrayArg:longArrowRightToDownAnimation clockArg:clockParam isForward:YES];
                [[currentLevel.clocks objectAtIndex:clockIndexParam-1] moveHandsForward:1 :0];
            } else {
                [self animatingLongArrowByHalf:defaultMultiplier imageArg:longImageParam arrayArg:longArrowLeftToUpAnimation clockArg:clockParam isForward:YES];
                [[currentLevel.clocks objectAtIndex:clockIndexParam-1] moveHandsForward:1 :0];
            }
        } else {
            //multiplier == 2
            if ([[currentLevel.clocks objectAtIndex:clockIndexParam-1] isLongerHandUp] == YES) {
                [self animatingLongArrow:defaultMultiplier imageArg:longImageParam arrayArg:longArrowFullLoopAnimation isForward:YES type:TYPE_BROKEN isActive:NO];
            } else {
                [self animatingLongArrow:defaultMultiplier imageArg:longImageParam arrayArg:longArrowFullLoopAnimationFromDown isForward:YES type:TYPE_BROKEN isActive:NO];
            }
        }
    } else if (directionParam == backwardDirection) {
        if (multiplierParam == 1) {
            if ([[currentLevel.clocks objectAtIndex:clockIndexParam-1] isLongerHandUp] == YES) {
                [self animatingLongArrowByHalf:defaultMultiplier imageArg:longImageParam arrayArg:longArrowLeftToDownAnimation clockArg:clockParam isForward:NO];
                [[currentLevel.clocks objectAtIndex:clockIndexParam-1] moveHandsBackward:1 :0];
            } else {
                [self animatingLongArrowByHalf:defaultMultiplier imageArg:longImageParam arrayArg:longArrowRightToUpAnimation clockArg:clockParam isForward:NO];
                [[currentLevel.clocks objectAtIndex:clockIndexParam-1] moveHandsBackward:1 :0];
            }
        } else {
            //multiplier == 2
            if ([[currentLevel.clocks objectAtIndex:clockIndexParam-1] isLongerHandUp] == YES) {
                [self animatingLongArrow:defaultMultiplier imageArg:longImageParam arrayArg:longArrowFullLoopAnimationReversed isForward:NO type:TYPE_BROKEN isActive:NO];
            } else {
                [self animatingLongArrow:defaultMultiplier imageArg:longImageParam arrayArg:longArrowFullLoopAnimationFromDownReversed isForward:NO type:TYPE_BROKEN isActive:NO];
            }
        }
    } else {
        NSLog(@"Logic Error - Invalid direction - code WFTS7");
    }
}

-(UIImageView*)getLongImageArgIndexArg:(int)index
                     numberOfClocksArg:(int)numberOfClocksParam {
    
    switch (numberOfClocksParam) {
        case 2:
            if (index == 1) return longArrow2TopImage;
            else if (index == 2) return longArrow2BottomImage;
            break;
        case 3:
            if (index == 1) return longArrow3TopLeftImage;
            else if (index == 2) return longArrow3TopRightImage;
            else if (index == 3) return longArrow3BottomImage;
            break;
        case 4:
            if (index == 1) return longArrow4TopLeftImage;
            else if (index == 2) return longArrow4TopRightImage;
            else if (index == 3) return longArrow4BottomRightImage;
            else if (index == 4) return longArrow4BottomLeftImage;
            break;
        default:
            break;
    }
    NSLog(@"Logic error - at function: getLongImageArgIndexArg\n");
}

-(UIImageView*)getLongYellowImageArgIndexArg:(int)index
                     numberOfClocksArg:(int)numberOfClocksParam {
    
    switch (numberOfClocksParam) {
        case 2:
            if (index == 1) return longYellow2T;
            else if (index == 2) return longYellow2B;
            break;
        case 3:
            if (index == 1) return longYellow3TL;
            else if (index == 2) return longYellow3TR;
            else if (index == 3) return longYellow3B;
            break;
        case 4:
            if (index == 1) return longYellow4TL;
            else if (index == 2) return longYellow4TR;
            else if (index == 3) return longYellow4BR;
            else if (index == 4) return longYellow4BL;
            break;
        default:
            break;
    }
    NSLog(@"Logic error - at function: getLongYellowImageArgIndexArg\n");
}

-(void)twoClocksKickOffNeighbours:(NSMutableArray*)arrowsArray directionArg:(int)directionParam originArg:(int)originParam {
    //forwardDirection = 1
    //backwardDirection = 0;
    
    NSString *currentClockType;
    
    int onlyOnceTop = 0, onlyOnceBottom = 0; //if 1, then enough
    int tempMultiplier;
    Arrow *temporaryArrow;
    int direction = directionParam;
    int numberOfClocksLocal = 2;
    
    for(int i=0;i<[arrowsArray count];i++) {
        temporaryArrow = [arrowsArray objectAtIndex:i];
        
        if (temporaryArrow.origin != originParam) continue;
        //if origin doesn't match, continue the loop
        
        tempMultiplier = temporaryArrow.multiplier;
        
        //get clock type for Long Arrow purposes
        currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:temporaryArrow.destination]];
        
        //reversed
        if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"reversed"]) {
            direction = [self getReversedDirection:direction];
        }
        
        //Forward
        if (direction == forwardDirection || [[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"ninja"]) {
            BOOL dirIsForward = YES;
            
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 2))
            {
                
                //handle arrow flash
                [self animateArrowFlash:VA2ClocksToBottom animArrayArg:arrowFlashToDown];
                
                //handle twoface - starts
                if (onlyOnceBottom == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:2];
                    onlyOnceBottom++;
                }
                //handle twoface - ends
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOM_2CLOCKS longImageArg:longArrow2BottomImage clockArg:tempClock2Bottom multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort2BottomForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong2BottomForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
                }
                
                if ([tempClock2Bottom.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel2B arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 1))
            {
                
                //handle arrow flash
                [self animateArrowFlash:VA2ClocksToTop animArrayArg:arrowFlashToUp];
                
                //handle twoface - starts
                if (onlyOnceTop == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:2];
                    onlyOnceTop++;
                }
                //handle twoface - ends
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:UP_2CLOCKS longImageArg:longArrow2TopImage clockArg:tempClock multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow2TopImage clockArg:tempClock];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort2TopForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong2TopForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow2TopImage clockArg:tempClock isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow2TopImage clockArg:tempClock];
                }
                
                if ([tempClock.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel2T arrayArg:[self getProperLongAnimation:tempClock isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            
            //handle dizzy - starts
            if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"]) {
                [[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2] stopAnimating];
                DizzyClock *tempDizzy;
                tempDizzy = [currentLevel.clocks objectAtIndex:temporaryArrow.destination-1];
                tempDizzy.rotatingRight = YES;
                [self animateDizzyArgClockIndexArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2] longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2]];
                
                //execute only when dizzy is affected by multiplier 2, and should be yellow
                [self animateDizzyClockPositionArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2] multiplierArg:tempMultiplier timeArg:[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] shorterHand] isForwardArg:YES longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2]];
            }
            //handle dizzy - ends
            
        } else if (direction == backwardDirection) {
            BOOL dirIsForward = NO;
            
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA2ClocksToBottom animArrayArg:arrowFlashToDown];
                
                //handle twoface - starts
                if (onlyOnceBottom == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:2];
                    onlyOnceBottom++;
                }
                //handle twoface - ends
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOM_2CLOCKS longImageArg:longArrow2BottomImage clockArg:tempClock2Bottom multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort2BottomBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong2BottomBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
                }
                
                if ([tempClock2Bottom.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel2B arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA2ClocksToTop animArrayArg:arrowFlashToUp];
                
                //handle twoface - starts
                if (onlyOnceTop == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:2];
                    onlyOnceTop++;
                }
                //handle twoface - ends
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:UP_2CLOCKS longImageArg:longArrow2TopImage clockArg:tempClock multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow2TopImage clockArg:tempClock];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort2TopBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong2TopBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow2TopImage clockArg:tempClock isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow2TopImage clockArg:tempClock];
                }
                
                if ([tempClock.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel2T arrayArg:[self getProperLongAnimation:tempClock isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            
            //handle dizzy - starts
            if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"]) {
                [[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2] stopAnimating];
                DizzyClock *tempDizzy;
                tempDizzy = [currentLevel.clocks objectAtIndex:temporaryArrow.destination-1];
                tempDizzy.rotatingRight = NO;
                [self animateDizzyArgClockIndexArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2] longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2]];
                
                //execute only when dizzy is affected by multiplier 2, and should be yellow
                [self animateDizzyClockPositionArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2] multiplierArg:tempMultiplier timeArg:[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] shorterHand] isForwardArg:NO longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:2]];
            }
            //handle dizzy - ends
        }
    }
}

-(void)threeClocksKickOffNeighbours:(NSMutableArray*)arrowsArray
                       directionArg:(int)directionParam
                          originArg:(int)originParam
                     whoCalledRoman:(int)whoCalledParam
           beforeRomanMultiplierArg:(int)beforeRomanMultiplierParam {
    //forwardDirection = 1
    //backwardDirection = 0;
    
    NSString *currentClockType;
    
    int tempMultiplier;
    Arrow *temporaryArrow;
    int direction;
    int onlyOnceTopLeft = 0, onlyOnceTopRight = 0, onlyOnceBottom = 0;
    int numberOfClocksLocal = 3;
    
    for(int i=0;i<[arrowsArray count];i++) {
        temporaryArrow = [arrowsArray objectAtIndex:i];
        
        if (temporaryArrow.origin != originParam) continue;
        //if origin doesn't match, continue the loop
        
        //to prevent the romans from countering the effect
        if (whoCalledParam == temporaryArrow.destination) continue;
        
        if (beforeRomanMultiplierParam != 0 && beforeRomanMultiplierParam == 2) {
            tempMultiplier = beforeRomanMultiplierParam;
        } else {
            tempMultiplier = temporaryArrow.multiplier;
        }
        
        //get clock type for Long Arrow purposes
        currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:temporaryArrow.destination]];
        
        //reversed
        direction = directionParam;
        if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"reversed"]) {
            direction = [self getReversedDirection:directionParam];
        }
        
        //Forward
        if (direction == forwardDirection  || [[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"ninja"]) {
            BOOL dirIsForward = YES;
            
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 2))
            {
                
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksLtoR animArrayArg:arrowFlashToRight];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage clockArg:tempClock3TopRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
                }
                
                if ([tempClock3TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TR arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksRtoL animArrayArg:arrowFlashToLeft];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage clockArg:tempClock3TopLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopLeftForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
                }
                
                if ([tempClock3TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TL arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksTLtoB animArrayArg:arrowFlash3BfrTL];
                
                if (onlyOnceBottom == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceBottom++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage clockArg:tempClock3Bottom multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3BottomForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3BottomForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
                }
                
                if ([tempClock3Bottom.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3B arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksBtoTL animArrayArg:arrowFlash3toTL];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage clockArg:tempClock3TopLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopLeftForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
                }
                
                if ([tempClock3TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TL arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksTRtoB animArrayArg:arrowFlash3BfrTR];
                
                if (onlyOnceBottom == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceBottom++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage clockArg:tempClock3Bottom multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3BottomForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3BottomForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
                }
                
                if ([tempClock3Bottom.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3B arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksBtoTR animArrayArg:arrowFlash3toTR];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage clockArg:tempClock3TopRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
                }
                
                if ([tempClock3TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TR arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            
            //handle dizzy - starts
            if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"]) {
                [[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3] stopAnimating];
                DizzyClock *tempDizzy;
                tempDizzy = [currentLevel.clocks objectAtIndex:temporaryArrow.destination-1];
                tempDizzy.rotatingRight = YES;
                [self animateDizzyArgClockIndexArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3] longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3]];
                
                //execute only when dizzy is affected by multiplier 2, and should be yellow
                [self animateDizzyClockPositionArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3] multiplierArg:tempMultiplier timeArg:[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] shorterHand] isForwardArg:YES longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3]];
            }
            //handle dizzy - ends
        } else if (direction == backwardDirection) {
            BOOL dirIsForward = NO;
            
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 2))
            {
                
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksLtoR animArrayArg:arrowFlashToRight];
                
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage clockArg:tempClock3TopRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
                }
                
                if ([tempClock3TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TR arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksRtoL animArrayArg:arrowFlashToLeft];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage clockArg:tempClock3TopLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
                }
                
                if ([tempClock3TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TL arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksTLtoB animArrayArg:arrowFlash3BfrTL];
                
                if (onlyOnceBottom == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceBottom++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage clockArg:tempClock3Bottom multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3BottomBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3BottomBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
                }
                
                if ([tempClock3Bottom.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3B arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksBtoTL animArrayArg:arrowFlash3toTL];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage clockArg:tempClock3TopLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
                }
                
                if ([tempClock3TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TL arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksTRtoB animArrayArg:arrowFlash3BfrTR];
                
                if (onlyOnceBottom == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceBottom++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage clockArg:tempClock3Bottom multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3BottomBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3BottomBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
                }
                
                if ([tempClock3Bottom.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3B arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA3ClocksBtoTR animArrayArg:arrowFlash3toTR];
                
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:3];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage clockArg:tempClock3TopRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort3TopRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong3TopRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
                }
                
                if ([tempClock3TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel3TR arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            
            //handle dizzy - starts
            if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"]) {
                [[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3] stopAnimating];
                DizzyClock *tempDizzy;
                tempDizzy = [currentLevel.clocks objectAtIndex:temporaryArrow.destination-1];
                tempDizzy.rotatingRight = NO;
                [self animateDizzyArgClockIndexArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3] longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3]];
                
                //execute only when dizzy is affected by multiplier 2, and should be yellow
                [self animateDizzyClockPositionArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3] multiplierArg:tempMultiplier timeArg:[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] shorterHand] isForwardArg:NO longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:3]];
            }
            //handle dizzy - ends
        }
        //handle the Romans
        if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"roman"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:temporaryArrow.destination whoCalledRoman:temporaryArrow.origin beforeRomanMultiplierArg:tempMultiplier];
        }
    }
}


-(void)fourClocksKickOffNeighbours:(NSMutableArray*)arrowsArray directionArg:(int)directionParam originArg:(int)originParam whoCalledRoman:(int)whoCalledParam beforeRomanMultiplierArg:(int)beforeRomanMultiplierParam {
    //forwardDirection = 1
    //backwardDirection = 0;
    
    NSString *currentClockType;
    
    int tempMultiplier;
    Arrow *temporaryArrow;
    int direction;
    int onlyOnceTopLeft = 0, onlyOnceTopRight = 0, onlyOnceBottomLeft = 0, onlyOnceBottomRight = 0;
    int numberOfClocksLocal = 4;
    
    for(int i=0;i<[arrowsArray count];i++) {
        temporaryArrow = [arrowsArray objectAtIndex:i];
        
        if (temporaryArrow.origin != originParam) continue;
        //if origin doesn't match, continue the loop
        
        //to prevent the romans from countering the effect
        if (whoCalledParam == temporaryArrow.destination) continue;
        
        if (beforeRomanMultiplierParam != 0 && beforeRomanMultiplierParam == 2) {
            tempMultiplier = beforeRomanMultiplierParam;
        } else {
            tempMultiplier = temporaryArrow.multiplier;
        }
        
        //get clock type for Long Arrow purposes
        currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:temporaryArrow.destination]];
        
        //reversed
        direction = directionParam;
        if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"reversed"]) {
            direction = [self getReversedDirection:directionParam];
        }
    
        //Forward
        if (direction == forwardDirection  || [[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"ninja"]) {
            BOOL dirIsForward = YES;
            
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 2))
            {
                
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTLtoTR animArrayArg:arrowFlashToRight];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage clockArg:tempClock4TopRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                }
                
                if ([tempClock4TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TR arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTLtoBR animArrayArg:arrowFlash4toBR];
                
                //to handle twoface
                if (onlyOnceBottomRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage clockArg:tempClock4BottomRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                }
                
                if ([tempClock4BottomRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BR arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 4))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTLtoBL animArrayArg:arrowFlashToDown];
                
                if (onlyOnceBottomLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage clockArg:tempClock4BottomLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatShort4BottomLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                }
                
                if ([tempClock4BottomLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BL arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTRtoTL animArrayArg:arrowFlashToLeft];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage clockArg:tempClock4TopLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopLeftForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                }
                
                if ([tempClock4TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TL arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 4))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTRtoBL animArrayArg:arrowFlash4toBL];
                
                if (onlyOnceBottomLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage clockArg:tempClock4BottomLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomLeftForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                }
                
                if ([tempClock4BottomLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BL arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTRtoBR animArrayArg:arrowFlashToDown];
                
                if (onlyOnceBottomRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage clockArg:tempClock4BottomRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                }
                
                if ([tempClock4BottomRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BR arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBRtoTR animArrayArg:arrowFlashToUp];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage clockArg:tempClock4TopRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                }
                
                if ([tempClock4TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TR arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBRtoTL animArrayArg:arrowFlash4toTL];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage clockArg:tempClock4TopLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopLeftForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                }
                
                if ([tempClock4TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TL arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 4))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBRtoBL animArrayArg:arrowFlashToLeft];
                
                if (onlyOnceBottomLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage clockArg:tempClock4BottomLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomLeftForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                }
                
                if ([tempClock4BottomLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BL arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 4 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBLtoTL animArrayArg:arrowFlashToUp];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage clockArg:tempClock4TopLeft multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopLeftForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopLeftForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                }
                
                if ([tempClock4TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TL arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            else if ((temporaryArrow.origin == 4 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBLtoTR animArrayArg:arrowFlash4toTR];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage clockArg:tempClock4TopRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                }
                
                if ([tempClock4TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TR arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 4 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBLtoBR animArrayArg:arrowFlashToRight];
                
                if (onlyOnceBottomRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage clockArg:tempClock4BottomRight multiplierArg:tempMultiplier directionArg:forwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacForward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomRightForward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomRightForward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight isDoubled:YES];
                } else {
                    [self executeShortForward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                }
                
                if ([tempClock4BottomRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BR arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //handle dizzy - starts
            if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"]) {
                [[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4] stopAnimating];
                DizzyClock *tempDizzy;
                tempDizzy = [currentLevel.clocks objectAtIndex:temporaryArrow.destination-1];
                tempDizzy.rotatingRight = YES;
                [self animateDizzyArgClockIndexArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4] longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4]];
                
                //execute only when dizzy is affected by multiplier 2, and should be yellow
                [self animateDizzyClockPositionArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4] multiplierArg:tempMultiplier timeArg:[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] shorterHand] isForwardArg:YES longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4]];
            }
            //handle dizzy - ends
            
        //Backward
        } else if (direction == backwardDirection) {
            BOOL dirIsForward = NO;
            
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTLtoTR animArrayArg:arrowFlashToRight];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage clockArg:tempClock4TopRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                }
                
                if ([tempClock4TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TR arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTLtoBR animArrayArg:arrowFlash4toBR];
                
                if (onlyOnceBottomRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage clockArg:tempClock4BottomRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                }
                
                if ([tempClock4BottomRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BR arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 1 && temporaryArrow.destination == 4)) {
                
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTLtoBL animArrayArg:arrowFlashToDown];
                
                if (onlyOnceBottomLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage clockArg:tempClock4BottomLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                }
                
                if ([tempClock4BottomLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BL arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTRtoTL animArrayArg:arrowFlashToLeft];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage clockArg:tempClock4TopLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                }
                
                if ([tempClock4TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TL arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 4))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTRtoBL animArrayArg:arrowFlash4toBL];
                
                if (onlyOnceBottomLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage clockArg:tempClock4BottomLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                }
                
                if ([tempClock4BottomLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BL arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 2 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksTRtoBR animArrayArg:arrowFlashToDown];
                
                if (onlyOnceBottomRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage clockArg:tempClock4BottomRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                }
                
                if ([tempClock4BottomRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BR arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBRtoTR animArrayArg:arrowFlashToUp];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage clockArg:tempClock4TopRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                }
                
                if ([tempClock4TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TR arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBRtoTL animArrayArg:arrowFlash4toTL];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage clockArg:tempClock4TopLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                }
                
                if ([tempClock4TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TL arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 3 && temporaryArrow.destination == 4))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBRtoBL animArrayArg:arrowFlashToLeft];
                
                if (onlyOnceBottomLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage clockArg:tempClock4BottomLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                }
                
                if ([tempClock4BottomLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BL arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 4 && temporaryArrow.destination == 1))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBLtoTL animArrayArg:arrowFlashToUp];
                
                if (onlyOnceTopLeft == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopLeft++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage clockArg:tempClock4TopLeft multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopLeftBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopLeftBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                }
                
                if ([tempClock4TopLeft.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TL arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //diagonal
            else if ((temporaryArrow.origin == 4 && temporaryArrow.destination == 2))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBLtoTR animArrayArg:arrowFlash4toTR];
                
                //to handle twoface
                if (onlyOnceTopRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceTopRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage clockArg:tempClock4TopRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4TopRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4TopRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                }
                
                if ([tempClock4TopRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4TR arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            else if ((temporaryArrow.origin == 4 && temporaryArrow.destination == 3))
            {
                //handle arrow flash
                [self animateArrowFlash:VA4ClocksBLtoBR animArrayArg:arrowFlashToRight];
                
                if (onlyOnceBottomRight == 0 && [[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] getType] isEqual: @"twoface"]) {
                    [self doDemonToAngel:[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] destinationArg:temporaryArrow.destination numberOfClocksArg:4];
                    onlyOnceBottomRight++;
                }
                
                //handle broken - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"broken"]) {
                    [self handleIndirectBrokenArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage clockArg:tempClock4BottomRight multiplierArg:tempMultiplier directionArg:backwardDirection];
                    continue;
                }
                //handle broken - ends
                
                //handle sleepy - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"sleepyclock"]) {
                    if([[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] status] == sleepingState) {
                        continue;
                    }
                }
                //handle sleepy - ends
                
                //handle chinese - starts
                if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"chinese"]) {
                    [[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] moveZodiacBackward:tempMultiplier];
                    [self modifyZodiacsArgLocationArg:[self getClockImage:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal] chineseClockArg:[self getClockObject:temporaryArrow.destination numberOfClocksArg:numberOfClocksLocal]];
                }
                //handle chinese - ends
                
//                [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
//                [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                
                if(tempMultiplier > 1) {
                    
//                    //short arrow
//                    [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                     target:self
//                                                   selector:@selector(repeatShort4BottomRightBackward:)
//                                                   userInfo:nil
//                                                    repeats:NO];
//                    
//                    //long arrow
//                    if (![[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"])
//                        [NSTimer scheduledTimerWithTimeInterval:0.35/tempMultiplier
//                                                         target:self
//                                                       selector:@selector(repeatLong4BottomRightBackward:)
//                                                       userInfo:nil
//                                                        repeats:NO];
                    
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight isDoubled:YES];
                } else {
                    [self executeShortBackward:tempMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                }
                
                if ([tempClock4BottomRight.type  isEqual: @"twoface"]) {
                    [self animatingLongArrow:tempMultiplier imageArg:longAngel4BR arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                } else {
                    [self animatingLongArrow:tempMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:dirIsForward type:currentClockType isActive:NO];
                }
            }
            //handle dizzy - starts
            if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"dizzy"]) {
                [[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4] stopAnimating];
                DizzyClock *tempDizzy;
                tempDizzy = [currentLevel.clocks objectAtIndex:temporaryArrow.destination-1];
                tempDizzy.rotatingRight = NO;
                [self animateDizzyArgClockIndexArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4] longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4]];
                
                //execute only when dizzy is affected by multiplier 2, and should be yellow
                [self animateDizzyClockPositionArg:temporaryArrow.destination longImageArg:[self getLongImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4] multiplierArg:tempMultiplier timeArg:[[currentLevel.clocks objectAtIndex:temporaryArrow.destination-1] shorterHand] isForwardArg:NO longYellow:[self getLongYellowImageArgIndexArg:temporaryArrow.destination numberOfClocksArg:4]];
            }
            //handle dizzy - ends
        }
        else NSLog(@"Warning: Wrong direction!");
        
        //handle the Romans
        if ([[self getClockTypePureString:temporaryArrow.destination] isEqualToString:@"roman"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:temporaryArrow.destination whoCalledRoman:temporaryArrow.origin beforeRomanMultiplierArg:tempMultiplier];
        }
    }
}

-(void)validateMultiplier:(int)multiplier {
    if (multiplier > 2)
        NSLog(@"WARNING: invalid multiplier! Potential unnoticed bugs!");
}

//Repeats (3clocks)
//(Top Right)
-(void)repeatShort3TopRightForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
}

-(void)repeatLong3TopRightForward:(NSTimer *) timer {
    int clockLocation = TOPRIGHT_3CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}

-(void)repeatShort3TopRightBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
}

-(void)repeatLong3TopRightBackward:(NSTimer *) timer {
    int clockLocation = TOPRIGHT_3CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

//(Top Left)
-(void)repeatShort3TopLeftForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
}

-(void)repeatLong3TopLeftForward:(NSTimer *) timer {
    int clockLocation = TOPLEFT_3CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}

-(void)repeatShort3TopLeftBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
}

-(void)repeatLong3TopLeftBackward:(NSTimer *) timer {
    int clockLocation = TOPLEFT_3CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

//(Bottom)
-(void)repeatShort3BottomForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
}

-(void)repeatLong3BottomForward:(NSTimer *) timer {
    int clockLocation = BOTTOM_3CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}

-(void)repeatShort3BottomBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
}

-(void)repeatLong3BottomBackward:(NSTimer *) timer {
    int clockLocation = BOTTOM_3CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

//Repeats (4clocks)
//(Top Right)
-(void)repeatShort4TopRightForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
}

-(void)repeatLong4TopRightForward:(NSTimer *) timer {
    int clockLocation = TOPRIGHT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}

-(void)repeatShort4TopRightBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
}

-(void)repeatLong4TopRightBackward:(NSTimer *) timer {
    int clockLocation = TOPRIGHT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

//(Bottom Left)
-(void)repeatShort4BottomLeftForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
}
    
-(void)repeatLong4BottomLeftForward:(NSTimer *) timer {
    int clockLocation = BOTTOMLEFT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}
    
-(void)repeatShort4BottomLeftBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
}
    
-(void)repeatLong4BottomLeftBackward:(NSTimer *) timer {
    int clockLocation = BOTTOMLEFT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}
    
//(Top Left)
-(void)repeatShort4TopLeftForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
}

-(void)repeatLong4TopLeftForward:(NSTimer *) timer {
    int clockLocation = TOPLEFT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}

-(void)repeatShort4TopLeftBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
}

-(void)repeatLong4TopLeftBackward:(NSTimer *) timer {
    int clockLocation = TOPLEFT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

//(Bottom Right)
-(void)repeatShort4BottomRightForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
}

-(void)repeatLong4BottomRightForward:(NSTimer *) timer {
    int clockLocation = BOTTOMRIGHT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}

-(void)repeatShort4BottomRightBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
}

-(void)repeatLong4BottomRightBackward:(NSTimer *) timer {
    int clockLocation = BOTTOMRIGHT_4CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

//Repeats (2clocks)
-(void)repeatLong2TopForward:(NSTimer *) timer {
    
    //Bug prevention line
//    [tempClock moveHandsForward:2 :1];
    
    //[self animatingLongArrow2TopForward:2];
    int clockLocation = UP_2CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
    
    //Bug prevention line
//    [tempClock moveHandsBackward:2 :1];
}

-(void)repeatLong2TopBackward:(NSTimer *) timer {
    //[self animatingLongArrow2TopBackward:2];
    int clockLocation = UP_2CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

-(void)repeatLong2BottomForward:(NSTimer *) timer {
    //[self animatingLongArrow2BottomForward:2];
    int clockLocation = BOTTOM_2CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:YES] isForward:YES type:currentClockType isActive:NO];
}

-(void)repeatLong2BottomBackward:(NSTimer *) timer {
    //[self animatingLongArrow2BottomBackward:2];
    int clockLocation = BOTTOM_2CLOCKS;
    NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
    
    [self animatingLongArrow:2 imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:NO] isForward:NO type:currentClockType isActive:NO];
}

-(void) repeatShort2TopForward:(NSTimer *) timer {
    //Bug prevention line
//    [tempClock moveHandsBackward:2 :1];
    
    [self executeShortForward:2 imageArg:shortArrow2TopImage clockArg:tempClock];
}

-(void) repeatShort2TopBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow2TopImage clockArg:tempClock];
}

-(void) repeatShort2BottomForward:(NSTimer *) timer {
    [self executeShortForward:2 imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
}

-(void) repeatShort2BottomBackward:(NSTimer *) timer {
    [self executeShortBackward:2 imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
}

-(int)getMultiplier:(int)origin destinationArg:(int)destination {
    if (tempArrow1.origin == origin && tempArrow1.destination == destination)
        return tempArrow1.multiplier;
    else if (tempArrow2.origin == origin && tempArrow2.destination == destination)
        return tempArrow2.multiplier;
    else
        return 0;
}

-(void) checkWin:(int)numberOfClocks {
    
    [self handsToYellow];
    
    switch (numberOfClocks) {
        case 2:
            [self delayWin];
            break;
        case 3:
            [self delayWin3];
            break;
        case 4:
            [self delayWin4];
            break;
        default:
            NSLog(@"Logic Error: Max number of clocks is 4");
            break;
    }
}

-(void) delayWin {
    [NSTimer scheduledTimerWithTimeInterval:0.35
                                     target:self
                                   selector:@selector(callCheckAll12:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) callCheckAll12: (NSTimer *)timer {
//    [self handsToYellow];
    [self checkAll12];
}

-(void) delayWin3 {
    [NSTimer scheduledTimerWithTimeInterval:0.35
                                     target:self
                                   selector:@selector(callCheckAll12in3:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) callCheckAll12in3: (NSTimer *)timer {
//    [self handsToYellow];
    [self checkAll12inThree];
}

-(void) delayWin4 {
    [NSTimer scheduledTimerWithTimeInterval:0.35
                                     target:self
                                   selector:@selector(callCheckAll12in4:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) callCheckAll12in4: (NSTimer *)timer {
    [self checkAll12inFour];
}

-(NSString*) generateKey:(int) levelNumber {
    return [@"starsLevel" stringByAppendingString:[NSString stringWithFormat:@"%d",levelNumber]];
}

-(void) checkAll12 {
    //for debug purposes only//
    printf("up:%d\n", tempClock.shorterHand);
    printf("down:%d\n", tempClock2Bottom.shorterHand);
    //for debug purposes only//
    
    if ([tempClock checkTwelve] && [tempClock2Bottom checkTwelve]) {
        [self callWinTimer];
        gameModel.win = TRUE;
        printf("WIN");
        [self sfxWin];
    }
    
    //check for 2face notif - starts
    if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock checkTwelveButDemon] == YES) {
            if ([tempClock checkTwelveNo2Face] && [tempClock2Bottom checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    } else if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock2Bottom checkTwelveButDemon] == YES) {
            if ([tempClock checkTwelveNo2Face] && [tempClock2Bottom checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    }
    //check for 2face notif - ends
    
    //sound
    if (!([tempClock checkTwelve] && [tempClock2Bottom checkTwelve])) {
        if (isPre12Top2Clocks == NO && [tempClock checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12Top2Clocks = YES;
        } else if (isPre12Bottom2Clocks == NO && [tempClock2Bottom checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12Bottom2Clocks = YES;
        }
        
        if (isPre12Top2Clocks == YES && [tempClock checkTwelve] == NO) {
            isPre12Top2Clocks = NO;
        }
        if (isPre12Bottom2Clocks == YES && [tempClock2Bottom checkTwelve] == NO) {
            isPre12Bottom2Clocks = NO;
        }
    }
    //sound
}

-(void) checkAll12inThree {
    //for debug purposes only//
    printf("3TopLeft:%d\n", tempClock3TopLeft.shorterHand);
    printf("3TopRight:%d\n", tempClock3TopRight.shorterHand);
    printf("Bottom:%d\n", tempClock3Bottom.shorterHand);
    //for debug purposes only//
    
    if ([tempClock3TopLeft checkTwelve] && [tempClock3TopRight checkTwelve] && [tempClock3Bottom checkTwelve]) {
        [self callWinTimer];
        gameModel.win = TRUE;
        printf("WIN");
        [self sfxWin];
    }
    
    //check for 2face notif - starts
    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock3TopLeft checkTwelveButDemon] == YES) {
            if ([tempClock3TopLeft checkTwelveNo2Face] && [tempClock3TopRight checkTwelveNo2Face] && [tempClock3Bottom checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    } else if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock3TopRight checkTwelveButDemon] == YES) {
            if ([tempClock3TopLeft checkTwelveNo2Face] && [tempClock3TopRight checkTwelveNo2Face] && [tempClock3Bottom checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    } else if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock3Bottom checkTwelveButDemon] == YES) {
            if ([tempClock3TopLeft checkTwelveNo2Face] && [tempClock3TopRight checkTwelveNo2Face] && [tempClock3Bottom checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    }
    //check for 2face notif - ends
    
    //sound
    if (!([tempClock3TopLeft checkTwelve] && [tempClock3TopRight checkTwelve] && [tempClock3Bottom checkTwelve])) {
        if (isPre12TopLeft3Clocks == NO && [tempClock3TopLeft checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12TopLeft3Clocks = YES;
        } else if (isPre12TopRight3Clocks == NO && [tempClock3TopRight checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12TopRight3Clocks = YES;
        } else if (isPre12Bottom3Clocks == NO && [tempClock3Bottom checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12Bottom3Clocks = YES;
        }
        
        if (isPre12TopLeft3Clocks == YES && [tempClock3TopLeft checkTwelve] == NO) {
            isPre12TopLeft3Clocks = NO;
        }
        if (isPre12TopRight3Clocks == YES && [tempClock3TopRight checkTwelve] == NO) {
            isPre12TopRight3Clocks = NO;
        }
        if (isPre12Bottom3Clocks == YES && [tempClock3Bottom checkTwelve] == NO) {
            isPre12Bottom3Clocks = NO;
        }
    }
    //sound
}

-(void) checkAll12inFour {
    //for debug purposes only//
    printf("4TopLeft:%d\n", tempClock4TopLeft.shorterHand);
    printf("4TopRight:%d\n", tempClock4TopRight.shorterHand);
    printf("4BottomLeft:%d\n", tempClock4BottomLeft.shorterHand);
    printf("4BottomRight:%d\n", tempClock4BottomRight.shorterHand);
    //for debug purposes only//
    
    if ([tempClock4TopLeft checkTwelve] && [tempClock4TopRight checkTwelve] && [tempClock4BottomLeft checkTwelve] && [tempClock4BottomRight checkTwelve]) {
        [self callWinTimer];
        gameModel.win = TRUE;
        printf("WIN");
        [self sfxWin];
    }
    
    //check for 2face notif - starts
    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock4TopLeft checkTwelveButDemon] == YES) {
            if ([tempClock4TopLeft checkTwelveNo2Face] && [tempClock4TopRight checkTwelveNo2Face] && [tempClock4BottomLeft checkTwelveNo2Face] && [tempClock4BottomRight checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    } else if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock4TopRight checkTwelveButDemon] == YES) {
            if ([tempClock4TopLeft checkTwelveNo2Face] && [tempClock4TopRight checkTwelveNo2Face] && [tempClock4BottomLeft checkTwelveNo2Face] && [tempClock4BottomRight checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    } else if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock4BottomLeft checkTwelveButDemon] == YES) {
            if ([tempClock4TopLeft checkTwelveNo2Face] && [tempClock4TopRight checkTwelveNo2Face] && [tempClock4BottomLeft checkTwelveNo2Face] && [tempClock4BottomRight checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    } else if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"twoface"]) {
        if ([tempClock4BottomRight checkTwelveButDemon] == YES) {
            if ([tempClock4TopLeft checkTwelveNo2Face] && [tempClock4TopRight checkTwelveNo2Face] && [tempClock4BottomLeft checkTwelveNo2Face] && [tempClock4BottomRight checkTwelveNo2Face]) {
                [self executeNotifTwoFaceAnimation];
            }
        }
    }
    //check for 2face notif - ends
    
    //sound
    if (!([tempClock4TopLeft checkTwelve] && [tempClock4TopRight checkTwelve] && [tempClock4BottomLeft checkTwelve] && [tempClock4BottomRight checkTwelve])) {
        if (isPre12TopLeft4Clocks == NO && [tempClock4TopLeft checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12TopLeft4Clocks = YES;
        } else if (isPre12TopRight4Clocks == NO && [tempClock4TopRight checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12TopRight4Clocks = YES;
        } else if (isPre12BottomRight4Clocks == NO && [tempClock4BottomRight checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12BottomRight4Clocks = YES;
        } else if (isPre12BottomLeft4Clocks == NO && [tempClock4BottomLeft checkTwelve] == YES) {
            [self sfxPonting12];
            isPre12BottomLeft4Clocks = YES;
        }
        
        if (isPre12TopLeft4Clocks == YES && [tempClock4TopLeft checkTwelve] == NO) {
            isPre12TopLeft4Clocks = NO;
        }
        if (isPre12TopRight4Clocks == YES && [tempClock4TopRight checkTwelve] == NO) {
            isPre12TopRight4Clocks = NO;
        }
        if (isPre12BottomRight4Clocks == YES && [tempClock4BottomRight checkTwelve] == NO) {
            isPre12BottomRight4Clocks = NO;
        }
        if (isPre12BottomLeft4Clocks == YES && [tempClock4BottomLeft checkTwelve] == NO) {
            isPre12BottomLeft4Clocks = NO;
        }
    }
    //sound
}

-(void) saveProgressArgStarsArg:(int) starsParam
                         keyArg:(NSString*) keyParam {
    
    [gameModel.prefs setInteger:starsParam forKey:keyParam];
}

-(void)callWinTimer {
    [self disableUserInteraction];
    [self nullifyAnimArraysBeforeWin];
    [NSTimer scheduledTimerWithTimeInterval:0.35
                                     target:self
                                   selector:@selector(winTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)winTimer:(NSTimer *) timer {
    [self beforeCallWhichWin];
    
    [self callWinFlashTimer];
    
    [NSTimer scheduledTimerWithTimeInterval:1.4
                                     target:self
                                   selector:@selector(winTimerAfterDelay:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)winTimerAfterDelay:(NSTimer *) timer {
    [self paintWinMenu];
}

-(void) callWinFlashTimer {
    [NSTimer scheduledTimerWithTimeInterval:1.1
                                     target:self
                                   selector:@selector(animateToWhite:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) animateToWhite:(NSTimer *) timer {
    
    [fullScreenImage removeFromSuperview];
    fullScreenImage = nil;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"WhiteOpacityy-4" ofType:@"png"];
    fullScreenImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:path]];
    [fullScreenImage setFrame:gameModel.backgroundRect];
    fullScreenImage.userInteractionEnabled = YES;
    [self.view addSubview:fullScreenImage];
    
    fullScreenImage.animationImages = animFlashToWhite;
    fullScreenImage.animationDuration = 0.35;
    fullScreenImage.animationRepeatCount = 1;
    [fullScreenImage startAnimating];
}

-(void)animateToWhiteNoTimer {
    [fullScreenImage removeFromSuperview];
    fullScreenImage = nil;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"WhiteOpacityy-4" ofType:@"png"];
    fullScreenImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:path]];
    [fullScreenImage setFrame:gameModel.backgroundRect];
    fullScreenImage.userInteractionEnabled = YES;
    [self.view addSubview:fullScreenImage];
    
    fullScreenImage.animationImages = animFlashToWhite;
    fullScreenImage.animationDuration = 0.15;
    fullScreenImage.animationRepeatCount = 1;
    [fullScreenImage startAnimating];
    
    [self delayFlashRemoval];
}

-(void)delayFlashRemoval {
    [NSTimer scheduledTimerWithTimeInterval:0.15
                                     target:self
                                   selector:@selector(removeFlashImage:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)removeFlashImage:(NSTimer *) timer {
    [fullScreenImage removeFromSuperview];
    fullScreenImage = nil;
    
    animFlashToBlack = nil;
    animFlashFromBlack = nil;
    animFlashToWhite = nil;
    animFlashFromWhite = nil;
}

-(void)removeFlashImage {
    [fullScreenImage removeFromSuperview];
    fullScreenImage = nil;
    
    animFlashToBlack = nil;
    animFlashFromBlack = nil;
    animFlashToWhite = nil;
    animFlashFromWhite = nil;
}

//-(void) animateToBlack:(NSTimer *) timer {
//    
//    [fullScreenImage removeFromSuperview];
//    fullScreenImage = nil;
//    
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-3" ofType:@"png"];
//    fullScreenImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:path]];
//    [fullScreenImage setFrame:gameModel.backgroundRect];
//    fullScreenImage.userInteractionEnabled = YES;
//    [self.view addSubview:fullScreenImage];
//    
//    fullScreenImage.animationImages = animFlashToBlack;
//    fullScreenImage.animationDuration = 0.45;
//    fullScreenImage.animationRepeatCount = 1;
//    [fullScreenImage startAnimating];
//}

//-(void) animateFromBlack:(NSTimer *) timer {
//    [fullScreenImage removeFromSuperview];
//    fullScreenImage = nil;
//    
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-5" ofType:@"png"];
//    fullScreenImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:path]];
//    [fullScreenImage setFrame:gameModel.backgroundRect];
//    fullScreenImage.userInteractionEnabled = YES;
//    
//    fullScreenImage.animationImages = animFlashFromBlack;
//    fullScreenImage.animationDuration = 0.2;
//    fullScreenImage.animationRepeatCount = 1;
//    [fullScreenImage startAnimating];
//}

-(void) removeFullScreenImage {
    [fullScreenImage removeFromSuperview];
    fullScreenImage = nil;
}

-(void) paintWinMenu {
    //    @autoreleasepool {
    [self clearNotifBar];
    
    [self hideLevel:YES];
    
    NSString* rightStarPath, *excellentPath, *goodPath;
        
    NSString* mainPath;
    if (IS_WIDESCREEN) {
        mainPath = [[NSBundle mainBundle] pathForResource:@"Background2" ofType:@"png"];
    } else {
        mainPath = [[NSBundle mainBundle] pathForResource:@"Background2_3.5inches" ofType:@"png"];
    }
    imageMainMenu = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:mainPath]];
    [imageMainMenu setFrame:gameModel.backgroundRect];
    imageMainMenu.userInteractionEnabled = YES;
    [self.view addSubview:imageMainMenu];
    
    NSString* winPath = [[NSBundle mainBundle] pathForResource:@"WinPage_Board" ofType:@"png"];
    winPage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:winPath]];
    [winPage setFrame:gameModel.winPageRect];
    winPage.userInteractionEnabled = YES;
    [self.view addSubview:winPage];
    
    NSString* resetPath = [[NSBundle mainBundle] pathForResource:@"ResetButton2" ofType:@"png"];
    winReset = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:resetPath]];
    [winReset setFrame:gameModel.winResetRect];
    winReset.userInteractionEnabled = YES;
    [winPage addSubview:winReset];
    
    if (currentLevel.steps <= currentLevel.goal) {
        excellentPath = [[NSBundle mainBundle] pathForResource:@"TEXT_excellent" ofType:@"png"];
        winExcellent = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:excellentPath]];
        [winExcellent setFrame:gameModel.winExcellentRect];
        [winPage addSubview:winExcellent];
        
        //SFX - SOUND
        [NSTimer scheduledTimerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(sfxExcellentTimer:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        goodPath = [[NSBundle mainBundle] pathForResource:@"TEXT_good" ofType:@"png"];
        winGood = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:goodPath]];
        [winGood setFrame:gameModel.winGoodRect];
        [winPage addSubview:winGood];
    }
    
    NSString* leftStarPath = [[NSBundle mainBundle] pathForResource:@"FullStar" ofType:@"png"];
    winLeftStar = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:leftStarPath]];
    [winLeftStar setFrame:gameModel.winLeftStarRect];
    [winPage addSubview:winLeftStar];
    
    if (currentLevel.steps <= currentLevel.goal) {
        rightStarPath = [[NSBundle mainBundle] pathForResource:@"FullStar" ofType:@"png"];
        
        //test starts
        [self saveProgressArgStarsArg:2 keyArg:[self generateKey:currentLevel.currentLevel]];
        printf("G1/n");
        //test ends
        
    } else {
        rightStarPath = [[NSBundle mainBundle] pathForResource:@"BlankStar" ofType:@"png"];
        
        //test starts
        printf("ALMOST GET IN, int = %i\n", [gameModel.prefs integerForKey:[self generateKey:currentLevel.currentLevel]]);
        if ([gameModel.prefs integerForKey:[self generateKey:currentLevel.currentLevel]] == 0) {
            [self saveProgressArgStarsArg:1 keyArg:[self generateKey:currentLevel.currentLevel]];
            printf("GET IN\n");
        }
        //test ends
        
        //unlock the locked
//        [gameModel.prefs setInteger:starsParam forKey:keyParam];
    }
    //retrieve starts
//    NSInteger myInt = [gameModel.prefs integerForKey:[self generateKey:currentLevel.currentLevel]];
//    printf("stars at this level = %i\n", myInt);
    //retrieve ends
    
    winRightStar = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:rightStarPath]];
    [winRightStar setFrame:gameModel.winRightStarRect];
    [winPage addSubview:winRightStar];
    
    NSString* stepsLabelPath = [[NSBundle mainBundle] pathForResource:@"TEXT_win_yourstep" ofType:@"png"];
    winStepsLabel = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:stepsLabelPath]];
    [winStepsLabel setFrame:gameModel.winStepsLabelRect];
    [winPage addSubview:winStepsLabel];
    
    NSString* stepsD100Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_winpage_2" ofType:@"png"];
    winStepsDigitHundred = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:stepsD100Path]];
    [winStepsDigitHundred setFrame:gameModel.winStepsDigitHundredRect];
    [winPage addSubview:winStepsDigitHundred];
    
    NSString* stepsD10Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_winpage_1" ofType:@"png"];
    winStepsDigitTen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:stepsD10Path]];
    [winStepsDigitTen setFrame:gameModel.winStepsDigitTenRect];
    [winPage addSubview:winStepsDigitTen];
    
    NSString* stepsD0Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_winpage_6" ofType:@"png"];
    winStepsDigitOne = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:stepsD0Path]];
    [winStepsDigitOne setFrame:gameModel.winStepsDigitOneRect];
    [winPage addSubview:winStepsDigitOne];
    
    NSString* goalD100Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_winpage_2" ofType:@"png"];
    winGoalDigitHundred = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:goalD100Path]];
    [winGoalDigitHundred setFrame:gameModel.winGoalDigitHundredRect];
    [winPage addSubview:winGoalDigitHundred];
    
    NSString* goalD10Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_winpage_8" ofType:@"png"];
    winGoalDigitTen = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:goalD10Path]];
    [winGoalDigitTen setFrame:gameModel.winGoalDigitTenRect];
    [winPage addSubview:winGoalDigitTen];
    
    NSString* goalD0Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_winpage_9" ofType:@"png"];
    winGoalDigitOne = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:goalD0Path]];
    [winGoalDigitOne setFrame:gameModel.winGoalDigitOneRect];
    [winPage addSubview:winGoalDigitOne];
    
    NSString* goalLabelPath = [[NSBundle mainBundle] pathForResource:@"TEXT_win_goal" ofType:@"png"];
    winGoalLabel = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:goalLabelPath]];
    [winGoalLabel setFrame:gameModel.winGoalLabelRect];
    [winPage addSubview:winGoalLabel];
    
    NSString* levelsPath = [[NSBundle mainBundle] pathForResource:@"LevelButton" ofType:@"png"];
    winLevels = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:levelsPath]];
    [winLevels setFrame:gameModel.winLevelsRect];
    winLevels.userInteractionEnabled = YES;
    [winPage addSubview:winLevels];
    
    NSString* nextPath = [[NSBundle mainBundle] pathForResource:@"NextButton" ofType:@"png"];
    winNext = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:nextPath]];
    [winNext setFrame:gameModel.winNextRect];
    winNext.userInteractionEnabled = YES;
    [winPage addSubview:winNext];
    
    [self updateWinVariables];
    
    [self checkAndUnlockLevelAtWin];
    
    //Achievements checks - starts
    [self achievementOrdinary];
    [self achievementFlower];
    [self achievementIcy];
    [self achievementAngel];
    [self achievementChinese];
    [self achievementNinja];
    //Achievements checks - ends
    
    //test
    [self checkFacebookReminder];
    
    [self localNotification];
    
    [self updateHelpPageDatabase];
    
    //    }
}

-(void) updateHelpPageDatabase {
    
    if (currentLevel.currentLevel == 6) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedReversed"];
    } else if (currentLevel.currentLevel == 13) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedSleepy"];
    } else if (currentLevel.currentLevel == 20) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedDizzy"];
    } else if (currentLevel.currentLevel == 30) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedFlower"];
    } else if (currentLevel.currentLevel == 40) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedRoman"];
    } else if (currentLevel.currentLevel == 50) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedNinja"];
    } else if (currentLevel.currentLevel == 60) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedIcy"];
    } else if (currentLevel.currentLevel == 75) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedTwoFace"];
    } else if (currentLevel.currentLevel == 90) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedChinese"];
    } else if (currentLevel.currentLevel == 105) {
        [gameModel.prefs setBool:YES forKey:@"helpUnlockedBroken"];
    }
}

-(void)paintHelpPage {
    
    NSString* background2Path;
    if (IS_WIDESCREEN) {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2" ofType:@"png"];
    } else {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2_3.5inches" ofType:@"png"];
    }
    helpBackground = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:background2Path]];
    [helpBackground setFrame:gameModel.fullScreenRect];
    helpBackground.userInteractionEnabled = YES;
    [self.view addSubview:helpBackground];
    
    NSString* ordinaryPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Regular" ofType:@"png"];
    helpOrdinary = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:ordinaryPath]];
    [helpOrdinary setFrame:gameModel.helpOrdinaryRect];
    helpOrdinary.userInteractionEnabled = YES;
    [helpBackground addSubview:helpOrdinary];
    
    NSString* arrowPath = [[NSBundle mainBundle] pathForResource:@"LinkingArrowTopRightNo1" ofType:@"png"];
    helpArrow = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:arrowPath]];
    [helpArrow setFrame:gameModel.helpArrowRect];
    helpArrow.userInteractionEnabled = YES;
    [helpBackground addSubview:helpArrow];
    
    NSString* reversedPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedReversed"] == TRUE) {
        reversedPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Reversed" ofType:@"png"];
    } else {
        reversedPath = [[NSBundle mainBundle] pathForResource:@"Help_Reversed_Shadow" ofType:@"png"];
    }
    helpReversed = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:reversedPath]];
    [helpReversed setFrame:gameModel.helpReversedRect];
    helpReversed.userInteractionEnabled = YES;
    [helpBackground addSubview:helpReversed];
    
    NSString* sleepyPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedSleepy"] == TRUE) {
        sleepyPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Sleepy" ofType:@"png"];
    } else {
        sleepyPath = [[NSBundle mainBundle] pathForResource:@"Help_Sleepy_Shadow" ofType:@"png"];
    }
    helpSleepy = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:sleepyPath]];
    [helpSleepy setFrame:gameModel.helpSleepyRect];
    helpSleepy.userInteractionEnabled = YES;
    [helpBackground addSubview:helpSleepy];
    
    NSString* dizzyPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedDizzy"] == TRUE) {
        dizzyPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Dizzy" ofType:@"png"];
    } else {
        dizzyPath = [[NSBundle mainBundle] pathForResource:@"Dizzy_AchShadow" ofType:@"png"];
    }
    helpDizzy = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:dizzyPath]];
    [helpDizzy setFrame:gameModel.helpDizzyRect];
    helpDizzy.userInteractionEnabled = YES;
    [helpBackground addSubview:helpDizzy];
    
    NSString* flowerPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedFlower"] == TRUE) {
        flowerPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Flower" ofType:@"png"];
    } else {
        flowerPath = [[NSBundle mainBundle] pathForResource:@"Flower_AchShadow" ofType:@"png"];
    }
    helpFlower = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flowerPath]];
    [helpFlower setFrame:gameModel.helpFlowerRect];
    helpFlower.userInteractionEnabled = YES;
    [helpBackground addSubview:helpFlower];
    
    NSString* romanPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedRoman"] == TRUE) {
        romanPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Roman" ofType:@"png"];
    } else {
        romanPath = [[NSBundle mainBundle] pathForResource:@"Roman_AchShadow" ofType:@"png"];
    }
    helpRoman = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:romanPath]];
    [helpRoman setFrame:gameModel.helpRomanRect];
    helpRoman.userInteractionEnabled = YES;
    [helpBackground addSubview:helpRoman];
    
    NSString* ninjaPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedNinja"] == TRUE) {
        ninjaPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Ninja" ofType:@"png"];
    } else {
        ninjaPath = [[NSBundle mainBundle] pathForResource:@"Ninja_AchShadow" ofType:@"png"];
    }
    helpNinja = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:ninjaPath]];
    [helpNinja setFrame:gameModel.helpNinjaRect];
    helpNinja.userInteractionEnabled = YES;
    [helpBackground addSubview:helpNinja];
    
    NSString* icyPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedIcy"] == TRUE) {
        icyPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Icy" ofType:@"png"];
    } else {
        icyPath = [[NSBundle mainBundle] pathForResource:@"Icy_AchShadow" ofType:@"png"];
    }
    helpIcy = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:icyPath]];
    [helpIcy setFrame:gameModel.helpIcyRect];
    helpIcy.userInteractionEnabled = YES;
    [helpBackground addSubview:helpIcy];
    
    NSString* twofacePath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedTwoFace"] == TRUE) {
        twofacePath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Angel" ofType:@"png"];
    } else {
        twofacePath = [[NSBundle mainBundle] pathForResource:@"Angel_AchShadow" ofType:@"png"];
    }
    helpTwoFace = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:twofacePath]];
    [helpTwoFace setFrame:gameModel.helpTwoFaceRect];
    helpTwoFace.userInteractionEnabled = YES;
    [helpBackground addSubview:helpTwoFace];
    
    NSString* chinesePath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedChinese"] == TRUE) {
        chinesePath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Chinese" ofType:@"png"];
    } else {
        chinesePath = [[NSBundle mainBundle] pathForResource:@"Chinese_AchShadow" ofType:@"png"];
    }
    helpChinese = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:chinesePath]];
    [helpChinese setFrame:gameModel.helpChineseRect];
    helpChinese.userInteractionEnabled = YES;
    [helpBackground addSubview:helpChinese];
    
    NSString* brokenPath;
    if ([gameModel.prefs boolForKey:@"helpUnlockedBroken"] == TRUE) {
        brokenPath = [[NSBundle mainBundle] pathForResource:@"Help_NotShadow_Broken" ofType:@"png"];
    } else {
        brokenPath = [[NSBundle mainBundle] pathForResource:@"Broken_AchShadow" ofType:@"png"];
    }
    helpBroken = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:brokenPath]];
    [helpBroken setFrame:gameModel.helpBrokenRect];
    helpBroken.userInteractionEnabled = YES;
    [helpBackground addSubview:helpBroken];
    
    [self drawCapsuleButtonNotIngame:gameModel.capsuleAtBottomRight];
    
    NSString* backPath = [[NSBundle mainBundle] pathForResource:@"BackButton" ofType:@"png"];
    backButtonFromHelp = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backPath]];
    [backButtonFromHelp setFrame:gameModel.backButtonRect];
    backButtonFromHelp.userInteractionEnabled = YES;
    [self.view addSubview:backButtonFromHelp];
}

-(void) depaintHelpPage {
    //tango
    [helpOrdinary removeFromSuperview];
    [helpArrow removeFromSuperview];
    [helpReversed removeFromSuperview];
    [helpSleepy removeFromSuperview];
    [helpDizzy removeFromSuperview];
    [helpFlower removeFromSuperview];
    [helpRoman removeFromSuperview];
    [helpNinja removeFromSuperview];
    [helpIcy removeFromSuperview];
    [helpTwoFace removeFromSuperview];
    [helpChinese removeFromSuperview];
    [helpBroken removeFromSuperview];
    [self depaintCapsuleImage];
    [backButtonFromHelp removeFromSuperview];
    [helpBackground removeFromSuperview];
    
    helpOrdinary = nil;
    helpArrow = nil;
    helpReversed = nil;
    helpSleepy = nil;
    helpDizzy = nil;
    helpFlower = nil;
    helpRoman = nil;
    helpNinja = nil;
    helpIcy = nil;
    helpTwoFace = nil;
    helpChinese = nil;
    helpBroken = nil;
    backButtonFromHelp = nil;
    helpBackground = nil;
}

-(void) checkFacebookReminder {
    if ([gameModel.prefs boolForKey:@"facebookLike"] == NO) {
    
        switch (currentLevel.currentLevel) {
            case 22:
                [self facebookReminder];
                break;
            case 32:
                [self facebookReminder];
                break;
            case 42:
                [self facebookReminder];
                break;
            case 52:
                [self facebookReminder];
                break;
            case 62:
                [self facebookReminder];
                break;
            case 72:
                [self facebookReminder];
                break;
            case 82:
                [self facebookReminder];
                break;
            case 92:
                [self facebookReminder];
                break;
            case 102:
                [self facebookReminder];
                break;
            case 112:
                [self facebookReminder];
                break;
                
            default:
                break;
        }
    }
}

-(void) checkAndUnlockLevelAtWin {
    if ([gameModel.prefs integerForKey:@"latestUnlockedLevel"] <= currentLevel.currentLevel) {
        [gameModel.prefs setInteger:currentLevel.currentLevel+1 forKey:@"latestUnlockedLevel"];
    }
}

-(void) updateWinVariables {
    [self intToLabelArgIntArg:currentLevel.steps digitHundredArg:winStepsDigitHundred digitTenArg:winStepsDigitTen digitOneArg:winStepsDigitOne prefixArg:prefixNumWin];
    [self intToLabelArgIntArg:currentLevel.goal digitHundredArg:winGoalDigitHundred digitTenArg:winGoalDigitTen digitOneArg:winGoalDigitOne prefixArg:prefixNumWin];
}


-(void) dePaintWin {
    [imageMainMenu removeFromSuperview];
    [shadowImage removeFromSuperview];
    [winReset removeFromSuperview];
    [winLevels removeFromSuperview];
    [winNext removeFromSuperview];
    [winPage removeFromSuperview];
    [opacityBlackWin removeFromSuperview];
    
    winReset = nil;
    winLevels = nil;
    winNext = nil;
    winPage = nil;
    opacityBlackWin = nil;
}

-(void) hideLevel:(BOOL)nullifyArray {
    
    if (nullifyArray == YES) {
        [self nullifyAnimArraysBeforeWin];
        [self nullifyAnimArraysAfterWin];
    }
    
    [self invalidateAllAnimTimers];
    
    [self resetAnimIndex];
    
    tempArrow1 = nil;
    tempArrow2 = nil;
    
    [self removeFlashImage];
    
    [inGameTheme1Background removeFromSuperview];
    //    [pauseButton removeFromSuperview];
    //    [resetButton removeFromSuperview];
    [statusBar removeFromSuperview];
    
    //2 clocks hide - starts
    [longYellow2T removeFromSuperview];
    [shortYellow2T removeFromSuperview];
    [longAngel2T removeFromSuperview];
    [shortAngel2T removeFromSuperview];
    
    longYellow2T = nil;
    shortYellow2T = nil;
    longAngel2T = nil;
    shortAngel2T = nil;
    
    [longYellow2B removeFromSuperview];
    [shortYellow2B removeFromSuperview];
    [longAngel2B removeFromSuperview];
    [shortAngel2B removeFromSuperview];
    
    longYellow2B = nil;
    shortYellow2B = nil;
    longAngel2B = nil;
    shortAngel2B = nil;
    
    [longArrow2TopImage removeFromSuperview];
    [longArrow2BottomImage removeFromSuperview];
    [shortArrow2TopImage removeFromSuperview];
    [shortArrow2BottomImage removeFromSuperview];
    [linkingArrowUp2ClocksImage removeFromSuperview];
    [linkingArrowDown2ClocksImage removeFromSuperview];
    [top2ClocksImage removeFromSuperview];
    [bottom2ClocksImage removeFromSuperview];
    [twoClocksFrame removeFromSuperview];
    
    longArrow2TopImage.animationImages = nil;
    longArrow2TopImage.image = nil;
    longArrow2TopImage = nil;
    
    longArrow2BottomImage.animationImages = nil;
    longArrow2BottomImage.image = nil;
    longArrow2BottomImage = nil;
    
    shortArrow2TopImage.animationImages = nil;
    shortArrow2TopImage.image = nil;
    shortArrow2TopImage = nil;
    
    shortArrow2BottomImage.animationImages = nil;
    shortArrow2BottomImage.image = nil;
    shortArrow2BottomImage = nil;
    
    linkingArrowUp2ClocksImage = nil;
    linkingArrowDown2ClocksImage = nil;
    
    tempClock = nil;
    tempClock2Bottom = nil;
    
    top2ClocksImage = nil;
    bottom2ClocksImage = nil;
    
    twoClocksFrame = nil;
    //2 clocks hide - ends
    
    //3 clocks hide - starts
    [longYellow3TL removeFromSuperview];
    [shortYellow3TL removeFromSuperview];
    [longYellow3TR removeFromSuperview];
    [shortYellow3TR removeFromSuperview];
    [longYellow3B removeFromSuperview];
    [shortYellow3B removeFromSuperview];
    
    longYellow3TL = nil;
    shortYellow3TL = nil;
    longYellow3TR = nil;
    shortYellow3TR = nil;
    longYellow3B = nil;
    shortYellow3B = nil;
    
    [longAngel3TL removeFromSuperview];
    [shortAngel3TL removeFromSuperview];
    [longAngel3TR removeFromSuperview];
    [shortAngel3TR removeFromSuperview];
    [longAngel3B removeFromSuperview];
    [shortAngel3B removeFromSuperview];
    
    longAngel3TL = nil;
    shortAngel3TL = nil;
    longAngel3TR = nil;
    shortAngel3TR = nil;
    longAngel3B = nil;
    shortAngel3B = nil;
    
    [longArrow3TopLeftImage removeFromSuperview];
    [longArrow3TopRightImage removeFromSuperview];
    [longArrow3BottomImage removeFromSuperview];
    
    [shortArrow3TopLeftImage removeFromSuperview];
    [shortArrow3TopRightImage removeFromSuperview];
    [shortArrow3BottomImage removeFromSuperview];
    
    [linkingArrow3Clocks removeFromSuperview];
    
    [topLeft3Image removeFromSuperview];
    [topRight3Image removeFromSuperview];
    [bottom3Image removeFromSuperview];
    
    [threeClocksFrame removeFromSuperview];
    
    longArrow3TopLeftImage.animationImages = nil;
    longArrow3TopLeftImage.image = nil;
    longArrow3TopLeftImage = nil;
    
    longArrow3TopRightImage.animationImages = nil;
    longArrow3TopRightImage.image = nil;
    longArrow3TopRightImage = nil;
    
    longArrow3BottomImage.animationImages = nil;
    longArrow3BottomImage.image = nil;
    longArrow3BottomImage = nil;
    
    shortArrow3TopLeftImage.animationImages = nil;
    shortArrow3TopLeftImage.image = nil;
    shortArrow3TopLeftImage = nil;
    
    shortArrow3TopRightImage.animationImages = nil;
    shortArrow3TopRightImage.image = nil;
    shortArrow3TopRightImage = nil;
    
    shortArrow3BottomImage.animationImages = nil;
    shortArrow3BottomImage.image = nil;
    shortArrow3BottomImage = nil;
    
    linkingArrow3Clocks = nil;
    
    tempClock3TopLeft = nil;
    tempClock3TopRight = nil;
    tempClock3Bottom = nil;
    
    topLeft3Image = nil;
    topRight3Image = nil;
    bottom3Image = nil;
    
    threeClocksFrame = nil;
    //3 clocks hide - ends
    
    //4 clocks hide - starts
    [longAngel4TL removeFromSuperview];
    [shortAngel4TL removeFromSuperview];
    [longAngel4TR removeFromSuperview];
    [shortAngel4TR removeFromSuperview];
    [longAngel4BR removeFromSuperview];
    [shortAngel4BR removeFromSuperview];
    [longAngel4BL removeFromSuperview];
    [shortAngel4BL removeFromSuperview];
    
    longAngel4TL = nil;
    shortAngel4TL = nil;
    longAngel4TR = nil;
    shortAngel4TR = nil;
    longAngel4BR = nil;
    shortAngel4BR = nil;
    longAngel4BL = nil;
    shortAngel4BL = nil;
    
    [longYellow4TL removeFromSuperview];
    [longYellow4TR removeFromSuperview];
    [longYellow4BR removeFromSuperview];
    [longYellow4BL removeFromSuperview];
    [shortYellow4TL removeFromSuperview];
    [shortYellow4TR removeFromSuperview];
    [shortYellow4BR removeFromSuperview];
    [shortYellow4BL removeFromSuperview];
    
    longYellow4TL = nil;
    longYellow4TR = nil;
    longYellow4BR = nil;
    longYellow4BL = nil;
    shortYellow4TL = nil;
    shortYellow4TR = nil;
    shortYellow4BR = nil;
    shortYellow4BL = nil;
    
    [longArrow4TopLeftImage removeFromSuperview];
    [longArrow4TopRightImage removeFromSuperview];
    [longArrow4BottomLeftImage removeFromSuperview];
    [longArrow4BottomRightImage removeFromSuperview];
    
    [shortArrow4TopLeftImage removeFromSuperview];
    [shortArrow4TopRightImage removeFromSuperview];
    [shortArrow4BottomLeftImage removeFromSuperview];
    [shortArrow4BottomRightImage removeFromSuperview];
    
    [linkingArrow4Clocks removeFromSuperview];
    
    [topLeft4Image removeFromSuperview];
    [topRight4Image removeFromSuperview];
    [bottomLeft4Image removeFromSuperview];
    [bottomRight4Image removeFromSuperview];
    
    [fourClocksFrame removeFromSuperview];
    
    longArrow4TopLeftImage.animationImages = nil;
    longArrow4TopLeftImage.image = nil;
    longArrow4TopLeftImage = nil;
    
    longArrow4TopRightImage.animationImages = nil;
    longArrow4TopRightImage.image = nil;
    longArrow4TopRightImage = nil;
    
    longArrow4BottomLeftImage.animationImages = nil;
    longArrow4BottomLeftImage.image = nil;
    longArrow4BottomLeftImage = nil;
    
    longArrow4BottomRightImage.animationImages = nil;
    longArrow4BottomRightImage.image = nil;
    longArrow4BottomRightImage = nil;
    
    shortArrow4TopLeftImage.animationImages = nil;
    shortArrow4TopLeftImage.image = nil;
    shortArrow4TopLeftImage = nil;
    
    shortArrow4TopRightImage.animationImages = nil;
    shortArrow4TopRightImage.image = nil;
    shortArrow4TopRightImage = nil;
    
    shortArrow4BottomLeftImage.animationImages = nil;
    shortArrow4BottomLeftImage.image = nil;
    shortArrow4BottomLeftImage = nil;
    
    shortArrow4BottomRightImage.animationImages = nil;
    shortArrow4BottomRightImage.image = nil;
    shortArrow4BottomRightImage = nil;
    
    linkingArrow4Clocks = nil;
    
    tempClock4TopLeft = nil;
    tempClock4TopRight = nil;
    tempClock4BottomLeft = nil;
    tempClock4BottomRight = nil;
    
    topLeft4Image = nil;
    topRight4Image = nil;
    bottomLeft4Image = nil;
    bottomRight4Image = nil;
    
    fourClocksFrame = nil;
    //4 clocks hide - ends
    
    [self depaintCapsuleImage];
    
    
    //hide level BG
    [self hideLevelBackground];
    
    [gameplayHelp removeFromSuperview];
    gameplayHelp = nil;
    
    [shadow2TopImage removeFromSuperview];
    [shadow2BottomImage removeFromSuperview];
    [shadow3TopLeftImage removeFromSuperview];
    [shadow3TopRightImage removeFromSuperview];
    [shadow3BottomImage removeFromSuperview];
    [shadow4TopLeftImage removeFromSuperview];
    [shadow4TopRightImage removeFromSuperview];
    [shadow4BottomRightImage removeFromSuperview];
    [shadow4BottomLeftImage removeFromSuperview];
    
    shadow2TopImage = nil;
    shadow2BottomImage = nil;
    shadow3TopLeftImage = nil;
    shadow3TopRightImage = nil;
    shadow3BottomImage = nil;
    shadow4TopLeftImage = nil;
    shadow4TopRightImage = nil;
    shadow4BottomRightImage = nil;
    shadow4BottomLeftImage = nil;
    
    [flash2TopImage removeFromSuperview];
    [flash2BottomImage removeFromSuperview];
    [flash3TLImage removeFromSuperview];
    [flash3TRImage removeFromSuperview];
    [flash3BImage removeFromSuperview];
    [flash4TLImage removeFromSuperview];
    [flash4TRImage removeFromSuperview];
    [flash4BRImage removeFromSuperview];
    [flash4BLImage removeFromSuperview];
    
    flash2TopImage = nil;
    flash2BottomImage = nil;
    flash3TLImage = nil;
    flash3TRImage = nil;
    flash3BImage = nil;
    flash4TLImage = nil;
    flash4TRImage = nil;
    flash4BRImage = nil;
    flash4BLImage = nil;
    
    [self DepaintVirtualArrows];
}

-(void)automateUI {
    [self disableUserInteraction];
    [self callUserInteractionTimer];
}

-(void)callUserInteractionTimer {
    [NSTimer scheduledTimerWithTimeInterval:0.35
                                     target:self
                                   selector:@selector(userInteractionTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)userInteractionTimer:(NSTimer *) timer {
    //implement some codes for void
    
    ///To solve icy notif issue//
    top2ClocksImage.userInteractionEnabled = YES;
    bottom2ClocksImage.userInteractionEnabled = YES;
    topLeft3Image.userInteractionEnabled = YES;
    topRight3Image.userInteractionEnabled = YES;
    bottom3Image.userInteractionEnabled = YES;
    topLeft4Image.userInteractionEnabled = YES;
    topRight4Image.userInteractionEnabled = YES;
    bottomRight4Image.userInteractionEnabled = YES;
    bottomLeft4Image.userInteractionEnabled = YES;
    
    //2 clocks - start//
    if ([currentLevel.clocks count] == 2) {
        if (![[self getClockTypePureString:UP_2CLOCKS] isEqualToString:@"void"]) {
            top2ClocksImage.userInteractionEnabled = YES;
        }
    
        if (![[self getClockTypePureString:BOTTOM_2CLOCKS] isEqualToString:@"void"]) {
            bottom2ClocksImage.userInteractionEnabled = YES;
        }
    }
    //2clocks - end//
    
    //3 clocks - start//
    if ([currentLevel.clocks count] == 3) {
        if (![[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqualToString:@"void"]) {
            topLeft3Image.userInteractionEnabled = YES;
        }
    
        if (![[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqualToString:@"void"]) {
            topRight3Image.userInteractionEnabled = YES;
        }
    
        if (![[self getClockTypePureString:BOTTOM_3CLOCKS] isEqualToString:@"void"]) {
            bottom3Image.userInteractionEnabled = YES;
        }
    }
    //3 clocks - end//
    
    //4 clocks - start//
    if ([currentLevel.clocks count] == 4) {
        if (![[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqualToString:@"void"]) {
            topLeft4Image.userInteractionEnabled = YES;
        }
    
        if (![[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqualToString:@"void"]) {
            topRight4Image.userInteractionEnabled = YES;
        }
    
        if (![[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqualToString:@"void"]) {
            bottomLeft4Image.userInteractionEnabled = YES;
        }
    
        if (![[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqualToString:@"void"]) {
            bottomRight4Image.userInteractionEnabled = YES;
        }
    }
    //4 clocks - end//
    
    pauseButton.userInteractionEnabled = YES;
    resetButton.userInteractionEnabled = YES;
}

-(void)disableUserInteraction {
    shortArrow2TopImage.userInteractionEnabled = NO;
    shortArrow2BottomImage.userInteractionEnabled = NO;
    
    shortArrow3TopLeftImage.userInteractionEnabled = NO;
    shortArrow3TopRightImage.userInteractionEnabled = NO;
    shortArrow3BottomImage.userInteractionEnabled = NO;
    
    shortArrow4TopLeftImage.userInteractionEnabled = NO;
    shortArrow4TopRightImage.userInteractionEnabled = NO;
    shortArrow4BottomLeftImage.userInteractionEnabled = NO;
    shortArrow4BottomRightImage.userInteractionEnabled = NO;
    
    //for broken clock - starts
    longArrow2TopImage.userInteractionEnabled = NO;
    longArrow2BottomImage.userInteractionEnabled = NO;
    
    longArrow3TopLeftImage.userInteractionEnabled = NO;
    longArrow3TopRightImage.userInteractionEnabled = NO;
    longArrow3BottomImage.userInteractionEnabled = NO;
    
    longArrow4TopLeftImage.userInteractionEnabled = NO;
    longArrow4TopRightImage.userInteractionEnabled = NO;
    longArrow4BottomLeftImage.userInteractionEnabled = NO;
    longArrow4BottomRightImage.userInteractionEnabled = NO;
    //for broken clock - ends
    
    top2ClocksImage.userInteractionEnabled = NO;
    bottom2ClocksImage.userInteractionEnabled = NO;
    topLeft3Image.userInteractionEnabled = NO;
    topRight3Image.userInteractionEnabled = NO;
    bottom3Image.userInteractionEnabled = NO;
    topLeft4Image.userInteractionEnabled = NO;
    topRight4Image.userInteractionEnabled = NO;
    bottomRight4Image.userInteractionEnabled = NO;
    bottomLeft4Image.userInteractionEnabled = NO;
    
    pauseButton.userInteractionEnabled = NO;
    resetButton.userInteractionEnabled = NO;
}

-(void)animateAngelToDemon:(UIImageView*)imageParam {
    imageParam.animationImages = animAngeltoDevil;
    imageParam.image = [animAngeltoDevil objectAtIndex:animAngeltoDevil.count-1];
    imageParam.animationDuration = 0.3;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
}

-(void)animateDemonToAngel:(UIImageView*)imageParam {
    imageParam.animationImages = animDevilToAngel;
    imageParam.image = [animDevilToAngel objectAtIndex:animDevilToAngel.count-1];
    imageParam.animationDuration = 0.3;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
}

-(void)animateSleepToAwake:(UIImageView*)imageParam {
    [self disableUIByAddingLayer];
    
    imageParam.animationImages = sleepToAwake;
    imageParam.image = [sleepToAwake objectAtIndex:sleepToAwake.count-1];
    imageParam.animationDuration = 0.35/2.0;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
}

-(void)animateAwakeToSleep:(UIImageView*)imageParam {
    [self disableUIByAddingLayer];
    
    imageParam.animationImages = awakeToSleep;
    imageParam.image = [awakeToSleep objectAtIndex:awakeToSleep.count-1];
    imageParam.animationDuration = 0.35/2.0;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
}

-(void)animateIcyNotif:(UIImageView*)imageParam {
    imageParam.animationImages = icyNotif;
    imageParam.image = [icyNotif objectAtIndex:icyNotif.count-1];
    imageParam.animationDuration = 0.35/2.0;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
    
    [self sfxIcyNo];
    [self automateUI];
}

-(void)animateSleepyNotif:(UIImageView*)imageParam {
    imageParam.animationImages = sleepyNotif;
    imageParam.image = [sleepyNotif objectAtIndex:sleepyNotif.count-1];
    imageParam.animationDuration = 0.35/2.0;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
    
    [self sfxSleepyNo];
}

-(void)animateTwoFaceNotif:(UIImageView*)imageParam {
    imageParam.animationImages = twoFaceNotif;
    imageParam.image = [twoFaceNotif objectAtIndex:twoFaceNotif.count-1];
    imageParam.animationDuration = 0.35/2.0;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
}

-(void)animateCapsuleNotif:(UIImageView*)imageParam {
    imageParam.animationImages = capsuleNotif;
    imageParam.image = [capsuleNotif objectAtIndex:capsuleNotif.count-1];
    imageParam.animationDuration = 0.35/2.0;
    imageParam.animationRepeatCount = 1;
    [imageParam startAnimating];
}

-(UIImageView*)getClockImage:(int)position
           numberOfClocksArg:(int)numberOfClocksParam {
    
    if (numberOfClocksParam == 2) {
        if (position == UP_2CLOCKS) {
            return top2ClocksImage;
        } else if (position == BOTTOM_2CLOCKS) {
            return bottom2ClocksImage;
        }
    } else if (numberOfClocksParam == 3) {
        if (position == TOPLEFT_3CLOCKS) {
            return topLeft3Image;
        } else if (position == TOPRIGHT_3CLOCKS) {
            return topRight3Image;
        } else if (position == BOTTOM_3CLOCKS) {
            return bottom3Image;
        }
    } else if (numberOfClocksParam == 4) {
        if (position == TOPLEFT_4CLOCKS) {
            return topLeft4Image;
        } else if (position == TOPRIGHT_4CLOCKS) {
            return topRight4Image;
        } else if (position == BOTTOMRIGHT_4CLOCKS) {
            return bottomRight4Image;
        } else if (position == BOTTOMLEFT_4CLOCKS) {
            return bottomLeft4Image;
        }
    } else NSLog(@"Logic Error - Invalid number of clocks inside getGlockImage function!");
}

-(Clock*)getClockObject:(int)position
            numberOfClocksArg:(int)numberOfClocksParam {
    
    if (numberOfClocksParam == 2) {
        if (position == UP_2CLOCKS) {
            return tempClock;
        } else if (position == BOTTOM_2CLOCKS) {
            return tempClock2Bottom;
        }
    } else if (numberOfClocksParam == 3) {
        if (position == TOPLEFT_3CLOCKS) {
            return tempClock3TopLeft;
        } else if (position == TOPRIGHT_3CLOCKS) {
            return tempClock3TopRight;
        } else if (position == BOTTOM_3CLOCKS) {
            return tempClock3Bottom;
        }
    } else if (numberOfClocksParam == 4) {
        if (position == TOPLEFT_4CLOCKS) {
            return tempClock4TopLeft;
        } else if (position == TOPRIGHT_4CLOCKS) {
            return tempClock4TopRight;
        } else if (position == BOTTOMRIGHT_4CLOCKS) {
            return tempClock4BottomRight;
        } else if (position == BOTTOMLEFT_4CLOCKS) {
            return tempClock4BottomLeft;
        }
    } else NSLog(@"Logic Error - Invalid number of clocks inside getGlockObject function!");
}

-(void)doAngelToDemon:(TwoFace*)twoFaceParam
            originArg:(int)originParam
    numberOfClocksArg:(int)numberOfClocksParam {
    
    if (twoFaceParam.state == angelState) {
        twoFaceParam.state = demonState;
        
        [self handsToFromAngel:twoFaceParam.location isFromBlack:NO];
        
        [self animateAngelToDemon:[self getClockImage:originParam numberOfClocksArg:numberOfClocksParam]];
        
        [self timerAnimate2face:[self convertToNew:originParam numberOfClocksArg:numberOfClocksParam]];
    }
}

-(void)doDemonToAngel:(TwoFace*)twoFaceParam
            destinationArg:(int)destinationParam
    numberOfClocksArg:(int)numberOfClocksParam {

    if (twoFaceParam.state == demonState) {
        twoFaceParam.state = angelState;
        
        //hands //test
        [self handsToFromAngel:twoFaceParam.location isFromBlack:YES];
        
        [self animateDemonToAngel:[self getClockImage:destinationParam numberOfClocksArg:numberOfClocksParam]];
        
        [self timerAnimate2face:[self convertToNew:destinationParam numberOfClocksArg:numberOfClocksParam]];
    }
}

- (void) timerToEnableUI {
    timerEnableUI = [NSTimer scheduledTimerWithTimeInterval:0.3
                                                              target:self
                                                            selector:@selector(enableUserInteractionAfterDelay:)
                                                            userInfo:nil
                                                             repeats:NO];
}

-(void)enableUserInteractionAfterDelay:(NSTimer *) timer {
    [self enableUIByRemovingLayer];
}

-(void) disableUIByAddingLayer {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    layerForDisablingUI = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:path]];
    [layerForDisablingUI setFrame:gameModel.backgroundRect];
    layerForDisablingUI.userInteractionEnabled = YES;
    [self.view addSubview:layerForDisablingUI];
}

-(void) enableUIByRemovingLayer {
    [layerForDisablingUI removeFromSuperview];
    layerForDisablingUI = nil;
}

-(void)doSleepOrAwake:(SleepyClock*)sleepyClockParam
            originArg:(int)originParam
    numberOfClocksArg:(int)numberOfClocksParam {
  
    if (sleepyClockParam.status == sleepingState) {
        [self doSleepToAwake:sleepyClockParam originArg:originParam numberOfClocksArg:numberOfClocksParam];
        [self animatingSleepToAwake:[self getClockImage:originParam numberOfClocksArg:numberOfClocksParam]];
        [self callWhichAnimation:[self convertToNew:originParam numberOfClocksArg:numberOfClocksParam]];
        [self timerToEnableUI];
    } else if (sleepyClockParam.status == awakeState) {
        if (![sleepyClockParam checkTwelve]) {
            [self doAwakeToSleep:sleepyClockParam originArg:originParam numberOfClocksArg:numberOfClocksParam];
            [self animatingAwakeToSleep:[self getClockImage:originParam numberOfClocksArg:numberOfClocksParam] locationArg:[self convertToNew:originParam numberOfClocksArg:numberOfClocksParam]];
            [self timerAnimateSleeping:[self convertToNew:originParam numberOfClocksArg:numberOfClocksParam]];
        } else {
            [self executeNotifSleepyAnimation];
            NSLog(@"Cannot sleep at 12! <-- implement animation/notif later\n");
        }
    }
}

-(void)doSleepToAwake:(SleepyClock*)sleepyClockParam
            originArg:(int)originParam
    numberOfClocksArg:(int)numberOfClocksParam {
    
    if (sleepyClockParam.status == sleepingState) {
        sleepyClockParam.status = awakeState;
        
        [self animateSleepToAwake:[self getClockImage:originParam numberOfClocksArg:numberOfClocksParam]];
    }
}

-(void)doAwakeToSleep:(SleepyClock*)sleepyClockParam
            originArg:(int)originParam
    numberOfClocksArg:(int)numberOfClocksParam {
    
    if (sleepyClockParam.status == awakeState) {
        sleepyClockParam.status = sleepingState;
        
        [self animateAwakeToSleep:[self getClockImage:originParam numberOfClocksArg:numberOfClocksParam]];
    }
}



-(void)examineTypes:(UIImageView*)imageParam
           clockArg:(Clock*)clockParam
       directionArg:(int)directionParam
          originArg:(int)originParam
  numberOfClocksArg:(int)numberOfClocksParam {
    
    int forward=1;
    NSString *tempString = [self getClockTypePureString:originParam];
    
    //update variable 'lastHit'
    [self updateLastHit:tempString];
  
    if (numberOfClocksParam == 2) {
        if ([tempString isEqual:@"regular"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
        } else if ([tempString isEqual:@"reversed"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:[self getReversedDirection:directionParam] originArg:originParam];
        } else if ([tempString isEqual:@"twoface"]) {
            [self doAngelToDemon:[currentLevel.clocks objectAtIndex:originParam-1] originArg:originParam numberOfClocksArg:numberOfClocksParam];
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
        } else if ([tempString isEqual:@"ninja"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:forward originArg:originParam];
        } else if ([tempString isEqual:@"broken"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
        } else if ([tempString isEqual:@"lazyflower"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
        } else if ([tempString isEqual:@"sleepyclock"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
        } else if ([tempString isEqual:@"chinese"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
        } else if ([tempString isEqual:@"dizzy"]) {
            [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
        } else NSLog(@"Logic Error - Invalid string for clock type");
    } else if (numberOfClocksParam == 3) {
        if ([tempString isEqual:@"regular"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"reversed"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:[self getReversedDirection:directionParam] originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"roman"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"twoface"]) {
            [self doAngelToDemon:[currentLevel.clocks objectAtIndex:originParam-1] originArg:originParam numberOfClocksArg:numberOfClocksParam];
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"ninja"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:forward originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"broken"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"lazyflower"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"sleepyclock"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"chinese"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"dizzy"]) {
            [self threeClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else NSLog(@"Logic Error - Invalid string for clock type");
    } else if (numberOfClocksParam == 4) {
        if ([tempString isEqual:@"regular"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"reversed"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:[self getReversedDirection:directionParam] originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"roman"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"twoface"]) {
            [self doAngelToDemon:[currentLevel.clocks objectAtIndex:originParam-1] originArg:originParam numberOfClocksArg:numberOfClocksParam];
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"ninja"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:forward originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"broken"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"lazyflower"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"sleepyclock"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"chinese"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else if ([tempString isEqual:@"dizzy"]) {
            [self fourClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam whoCalledRoman:0 beforeRomanMultiplierArg:0];
        } else NSLog(@"Logic Error - Invalid string for clock type");
    } else {
        NSLog(@"Logic Error - Invalid number of clocks!");
    }
}

-(void) updateLastHit:(NSString*) tempString {
    if ([tempString isEqual:@"regular"]) {
        lastHit = @"regular";
    } else if ([tempString isEqual:@"reversed"]) {
        lastHit = @"reversed";
    } else if ([tempString isEqual:@"twoface"]) {
        lastHit = @"twoface";
    } else if ([tempString isEqual:@"ninja"]) {
        lastHit = @"ninja";
    } else if ([tempString isEqual:@"broken"]) {
        lastHit = @"broken";
    } else if ([tempString isEqual:@"lazyflower"]) {
        lastHit = @"lazyflower";
    } else if ([tempString isEqual:@"sleepyclock"]) {
        lastHit = @"sleepyclock";
    } else if ([tempString isEqual:@"chinese"]) {
        lastHit = @"chinese";
    } else if ([tempString isEqual:@"dizzy"]) {
        lastHit = @"dizzy";
    } else NSLog(@"Logic Error - Invalid 6JH9OO9");
}

-(int)getReversedDirection:(int)directionParam {
    if (directionParam == 1) return 0;
    else return 1;
}

//-(void)check1or2Touch:(UIImageView*)imageParam
//             clockArg:(Clock*)clockParam
//       directionArg:(int)directionParam
//            originArg:(int)originParam
//    numberOfClocksArg:(int)numberOfClocksParam {
    
//    NSString *tempString = [self getClockTypePureString:originParam];

//    if (numberOfClocksParam == 2) {
//        if ([tempString isEqual:@"??"]) {
         //   [self twoClocksKickOffNeighbours:currentLevel.arrows directionArg:directionParam originArg:originParam];
//        }
//    }
//}

-(void) executeShortOnDizzy:(int)index
                   imageArg:(UIImageView*)imageParam
                   clockArg:(DizzyClock*)clockParam
          numberOfClocksArg:(int)numberOfClocksParam {
    if ([[currentLevel.clocks objectAtIndex:index-1] rotatingRight] == YES) {
        [self executeShortForward:defaultMultiplier imageArg:imageParam clockArg:clockParam];
        [self examineTypes:imageParam clockArg:clockParam directionArg:forwardDirection originArg:index numberOfClocksArg:numberOfClocksParam];
    } else {
        [self executeShortBackward:defaultMultiplier imageArg:imageParam clockArg:clockParam];
        [self examineTypes:imageParam clockArg:clockParam directionArg:backwardDirection originArg:index numberOfClocksArg:numberOfClocksParam];
    }
}

-(void)checkExplosive {
    //we use timer to let the checkWin outpace this
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(checkDevilsTwinAfterTimer:)
                                       userInfo:nil
                                        repeats:NO];
}

-(void)checkDevilsTwinAfterTimer: (NSTimer *)timer {
    int counter = 0;
    
    if (gameModel.win == FALSE) {
        if (currentLevel.steps == 13) {
            for (Clock *c in currentLevel.clocks) {
                if ([c.type  isEqual: @"twoface"]) {
                    TwoFace *temp2Face = c;
                    if (temp2Face.state == demonState) {
                        if (c.shorterHand == 12) {
                            counter++;
                            if (counter > 1) {
                                [self achievementDevil];
                            }
                        }
                    }
                }
            }
        }
    }
}

//-(void)checkExplosiveAfterTimer: (NSTimer *)timer {
//    if (gameModel.win == FALSE) {
//        for (Arrow *a in currentLevel.arrows) {
//            if ([a.type isEqualToString:@"explosive"]) {
//                if ([[currentLevel.clocks objectAtIndex:a.origin-1] shorterHand] == [[currentLevel.clocks objectAtIndex:a.destination-1] shorterHand]) {
//                    //implement it later: disable user interaction, then some animations, then game over page explaining why
//                    printf("BOOM\n");
//                    
//                    //After implementing animation etc, then check for possible devil achievement
//                    [self achievementDevil];
//                    break;
//                }
//            }
//        }
//    }
//}

-(void) callParticularLevelPage:(int) level {
    if (level <= 15) {
        [self paintLevelPage:1 subPageArg:1];
    } else if (level >= 16 && level <= 30) {
        [self paintLevelPage:1 subPageArg:2];
    } else if (level >= 31 && level <= 45) {
        [self paintLevelPage:2 subPageArg:1];
    } else if (level >= 46 && level <= 60) {
        [self paintLevelPage:2 subPageArg:2];
    } else if (level >= 61 && level <= 75) {
        [self paintLevelPage:3 subPageArg:1];
    } else if (level >= 76 && level <= 90) {
        [self paintLevelPage:3 subPageArg:2];
    } else if (level >= 91 && level <= 105) {
        [self paintLevelPage:4 subPageArg:1];
    } else if (level >= 106 && level <= 120) {
        [self paintLevelPage:4 subPageArg:2];
    } else {
        NSLog(@"Logic error - Invalid vbsk34\n");
    }
}

-(void) drawCongratsPage {
    NSString* congratsPath;
    if (IS_WIDESCREEN) {
        congratsPath = [[NSBundle mainBundle] pathForResource:@"Background2" ofType:@"png"];
    } else {
        congratsPath = [[NSBundle mainBundle] pathForResource:@"Background2_3.5inches" ofType:@"png"];
    }
    
    congratsBackground = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:congratsPath]];
    [congratsBackground setFrame:gameModel.backgroundRect];
    [self.view addSubview:congratsBackground];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:@"Congrats" ofType:@"png"];
    congratsImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [congratsImage setFrame:gameModel.congratsBoardRect];
    congratsImage.userInteractionEnabled = YES;
    [self.view addSubview:congratsImage];
    
    NSString* nextPath = [[NSBundle mainBundle] pathForResource:@"NextButtonRect" ofType:@"png"];
    nextAtCongrats = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:nextPath]];
    [nextAtCongrats setFrame:gameModel.bottomCenterButtonRect];
    nextAtCongrats.userInteractionEnabled = YES;
    [self.view addSubview:nextAtCongrats];
    
    [self sfxEnding];
}

-(void) dePaintCongratsPage {
    [nextAtCongrats removeFromSuperview];
    nextAtCongrats = nil;
    [congratsImage removeFromSuperview];
    congratsImage = nil;
    [congratsBackground removeFromSuperview];
    congratsBackground = nil;
}

-(void) dePaintFinalCredits {
    [backAtFinalCredits removeFromSuperview];
    backAtFinalCredits = nil;
    [creditsBackground removeFromSuperview];
    creditsBackground = nil;
}

-(void)depaintOptionsCredits {
    [backButtonFromOptionsCredits removeFromSuperview];
    backButtonFromOptionsCredits = nil;
    [creditsBackground removeFromSuperview];
    creditsBackground = nil;
}

-(void) setTotalStars:(int)total {
    int counter = 0;
    for (int i=1; i<=total/2; i++) {
        [gameModel.prefs setInteger:2 forKey:[self generateKey:i]];
        counter += 2;
    }
//    printf("Total stars added = %d", counter);
}

-(int) getTotalStars {
    int counter = 0;
    
    for (int level=1; level<=[gameModel.prefs integerForKey:@"latestUnlockedLevel"]; level++) {
        counter += [gameModel.prefs integerForKey:[self generateKey:level]];
    }
//    printf("total stars = %d\n", counter);
    return counter;
}

-(int) getTotalStarsT1 {
    int counter = 0;
    
    for (int level=1; level<=[gameModel.prefs integerForKey:@"latestUnlockedLevel"]; level++) {
        counter += [gameModel.prefs integerForKey:[self generateKey:level]];
        if (level >= 30) break;
    }
        printf("total stars in T1 = %d\n", counter);
    return counter;
}

-(int) getTotalStarsT2 {
    int counter = 0;
    
    for (int level=31; level<=[gameModel.prefs integerForKey:@"latestUnlockedLevel"]; level++) {
        counter += [gameModel.prefs integerForKey:[self generateKey:level]];
        if (level >= 60) break;
    }
    printf("total stars in T2 = %d\n", counter);
    return counter;
}

-(int) getTotalStarsT3 {
    int counter = 0;
    
    for (int level=61; level<=[gameModel.prefs integerForKey:@"latestUnlockedLevel"]; level++) {
        counter += [gameModel.prefs integerForKey:[self generateKey:level]];
        if (level >= 90) break;
    }
    printf("total stars in T3 = %d\n", counter);
    return counter;
}

-(int) getTotalStarsT4 {
    int counter = 0;
    
    for (int level=91; level<=[gameModel.prefs integerForKey:@"latestUnlockedLevel"]; level++) {
        counter += [gameModel.prefs integerForKey:[self generateKey:level]];
        if (level >= 120) break;
    }
    printf("total stars in T4 = %d\n", counter);
    return counter;
}

-(void) clearNotifBar {
    [notifBar removeFromSuperview];
    notifBar = nil;
}

-(void) executeNotifIcyAnimation {
    [self clearNotifBar];
    
    NSString* notifPath = [[NSBundle mainBundle] pathForResource:@"NotifBar_Icy_0" ofType:@"png"];
    notifBar = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:notifPath]];
    [notifBar setFrame:gameModel.notifBarRect];
    [self.view addSubview:notifBar];
    
    [self animateIcyNotif:notifBar];
}

-(void) executeNotifSleepyAnimation {
    [self clearNotifBar];
    
    NSString* notifPath = [[NSBundle mainBundle] pathForResource:@"NotifBar_Sleepy_0" ofType:@"png"];
    notifBar = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:notifPath]];
    [notifBar setFrame:gameModel.notifBarRect];
    [self.view addSubview:notifBar];
    
    [self animateSleepyNotif:notifBar];
}

-(void) executeNotifTwoFaceAnimation {
    [self clearNotifBar];
    
    NSString* notifPath = [[NSBundle mainBundle] pathForResource:@"NotifBar_TwoFace_0" ofType:@"png"];
    notifBar = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:notifPath]];
    [notifBar setFrame:gameModel.notifBarRect];
    [self.view addSubview:notifBar];
    
    [self animateTwoFaceNotif:notifBar];
}

-(void) executeNotifCapsuleAnimation {
    [self clearNotifBar];
    
    NSString* notifPath = [[NSBundle mainBundle] pathForResource:@"NotifBar_Capsule_0" ofType:@"png"];
    notifBar = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:notifPath]];
    [notifBar setFrame:gameModel.notifBarRect];
    [self.view addSubview:notifBar];
    
    [self animateCapsuleNotif:notifBar];
}

-(void) updateDisplay:(CADisplayLink*)sender
{
    // This method is called by the gameTimer each time the display should
    // update
    
    // Update the model
    [gameModel updateNotifWithTime:sender.timestamp];
    
    // Update the display
    [notifBar setFrame:gameModel.notifBarRect];
    
    if (gameModel.notifBarRect.origin.y <= (gameModel.screenHeight*38.0/40.0 - NOTIFBAR_HEIGHT)) {
//        [gameTimer removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [gameTimer invalidate];
    }
}

-(void) facebookReminder {
    facebookAlertView = [[UIAlertView alloc] initWithTitle:@"Enjoying Clock Day?"
                                                    message:@"Please support our Facebook page!\nWe will reward you 2 time capsules and a sticker as our thanks"
                                                   delegate:self
                                          cancelButtonTitle:@"Don't ask again"
                                          otherButtonTitles:@"Yes, like it!", @"Remind me later", nil];
    //random number
    facebookAlertView.tag = 4537;
    
    [facebookAlertView show];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (facebookAlertView.tag == 4537) {
        if (buttonIndex == 0) {
            //"don't ask again" clicked
            [gameModel.prefs setBool:YES forKey:@"facebookLike"];
        } else if (buttonIndex == 1) {
            [self facebookLikeIsClicked];
        } else if (buttonIndex == 2) {
            //"Remind" clicked
        }
    }
}

-(void) facebookRedirection {
    //Open page in native Facebook app
    //fb://profile/<id>
    //Found the ID here - https://graph.facebook.com/clockdaygame?fref=ts
    NSURL *url = [NSURL URLWithString:@"fb://profile/485701774836944"];
    //Open the native app while within the 'if' bracket
    if (![[UIApplication sharedApplication] openURL:url]) {
        //if no Facebook app detected, then use Safari
        NSString *strurl = [NSString stringWithFormat:@"https://www.facebook.com/clockdaygame?fref=ts"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strurl]];
    }
}

-(void) rewardBoxFb {
    UIAlertView *rewardBox = [[UIAlertView alloc] initWithTitle:@"Thank you for your support!"
                                                    message:@"You have obtained 2 time capsules"
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    
    [rewardBox show];
}

-(void) rewardBoxRate {
    UIAlertView *rewardBoxRate = [[UIAlertView alloc] initWithTitle:@"Thank you for your support!!"
                                                        message:@"You have obtained 2 time capsules"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    [rewardBoxRate show];
}

-(void) rewardBoxShare {
    UIAlertView *rewardBoxShare = [[UIAlertView alloc] initWithTitle:@"Thank you for sharing!"
                                                        message:@"You have obtained 2 time capsules"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    [rewardBoxShare show];
}

-(void) facebookLikeIsClicked {
    if ([gameModel.prefs boolForKey:@"facebookLike"] == NO) {
        //update database
        [gameModel.prefs setBool:YES forKey:@"facebookLike"];
        [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+2 forKey:@"purchase1"];
        [self updatePurchasedItems];
        
        //update view
        [self facebookRedirection];
        [self rewardBoxFb];
    } else {
        [self facebookRedirection];
    }

    [self achievementSleepy];
}

-(void) facebookLikeIsClickedNoReward {
    [self facebookRedirection];
}

-(void) rateIsClicked {
//    if ([gameModel.prefs boolForKey:@"rateClicked"] == NO) {
//        //update database
//        [gameModel.prefs setBool:YES forKey:@"rateClicked"];
//        [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+2 forKey:@"purchase1"];
//        [self updatePurchasedItems];
//        
//        //update view
//        [self gotoReviews:self];
//        [self rewardBoxRate];
//    } else {
        [self gotoReviews:self];
//    }
    
//    [self achievementReversed];
}

//-(void) rewardAllStickersCollected {
//    if ([gameModel.prefs integerForKey:@"achOrdinary"] == YES) {
//        if ([gameModel.prefs integerForKey:@"achReversed"] == YES) {
//            if ([gameModel.prefs integerForKey:@"achSleepy"] == YES) {
//                if ([gameModel.prefs integerForKey:@"achFlower"] == YES) {
//                    if ([gameModel.prefs integerForKey:@"achNinja"] == YES) {
//                        if ([gameModel.prefs integerForKey:@"achIcy"] == YES) {
//                            if ([gameModel.prefs integerForKey:@"achDevil"] == YES) {
//                                if ([gameModel.prefs integerForKey:@"achAngel"] == YES) {
//                                    if ([gameModel.prefs integerForKey:@"achChinese"] == YES) {
//                                        [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+6 forKey:@"purchase1"];
//                                        [self updatePurchasedItems];
//                                        [self rewardBoxStickers];
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//-(void) rewardBoxStickers {
//    UIAlertView *rewardBox = [[UIAlertView alloc] initWithTitle:@"Congratulations! You have collected all stickers!"
//                                                        message:@"Rewards: 6 time capsules\nStay tuned for our next updates"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Ok"
//                                              otherButtonTitles:nil];
//    
//    [rewardBox show];
//}

-(void) paintOptionsPage {
    NSString* background2Path;
    if (IS_WIDESCREEN) {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2" ofType:@"png"];
    } else {
        background2Path = [[NSBundle mainBundle] pathForResource:@"Background2_3.5inches" ofType:@"png"];
    }
    imageBackground2 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:background2Path]];
    [imageBackground2 setFrame:gameModel.backgroundRect];
    [self.view addSubview:imageBackground2];
    
    [self drawCapsuleButtonNotIngame:gameModel.capsuleAtBottomRight];
    
    NSString* backPath = [[NSBundle mainBundle] pathForResource:@"BackButton" ofType:@"png"];
    backButtonFromOptions = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backPath]];
    [backButtonFromOptions setFrame:gameModel.backButtonRect];
    backButtonFromOptions.userInteractionEnabled = YES;
    [self.view addSubview:backButtonFromOptions];
    
    NSString* soundPath = [[NSBundle mainBundle] pathForResource:@"SoundOnButton" ofType:@"png"];
    OPSoundButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:soundPath]];
    [OPSoundButton setFrame:gameModel.optionsPageSoundRect];
    OPSoundButton.userInteractionEnabled = YES;
    [self.view addSubview:OPSoundButton];
    
    NSString* ratePath = [[NSBundle mainBundle] pathForResource:@"RateButton" ofType:@"png"];
    OPRateButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:ratePath]];
    [OPRateButton setFrame:gameModel.optionsPageRateRect];
    OPRateButton.userInteractionEnabled = YES;
    [self.view addSubview:OPRateButton];
    
//    NSString* helpPath = [[NSBundle mainBundle] pathForResource:@"HelpButton" ofType:@"png"];
//    OPHelpButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:helpPath]];
//    [OPHelpButton setFrame:gameModel.optionsPageHelpRect];
//    OPHelpButton.userInteractionEnabled = YES;
//    [self.view addSubview:OPHelpButton];
    
    NSString* creditsPath = [[NSBundle mainBundle] pathForResource:@"CreditsButton" ofType:@"png"];
    OPCreditsButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:creditsPath]];
    [OPCreditsButton setFrame:gameModel.optionsPageCreditsRect];
    OPCreditsButton.userInteractionEnabled = YES;
    [self.view addSubview:OPCreditsButton];
    
    NSString* sharePath = [[NSBundle mainBundle] pathForResource:@"ShareButton" ofType:@"png"];
    OPShareButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:sharePath]];
    [OPShareButton setFrame:gameModel.optionsPageShareRect];
    OPShareButton.userInteractionEnabled = YES;
    [self.view addSubview:OPShareButton];
    
    NSString* restorePath = [[NSBundle mainBundle] pathForResource:@"Restore_Button" ofType:@"png"];
    OPRestoreButton = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:restorePath]];
    [OPRestoreButton setFrame:gameModel.optionsPageRestoreRect];
    OPRestoreButton.userInteractionEnabled = YES;
    [self.view addSubview:OPRestoreButton];
}

-(void) dePaintOptionsPage {
    
    [OPSoundButton removeFromSuperview];
    OPSoundButton = nil;
    [OPRateButton removeFromSuperview];
    OPRateButton = nil;
    [OPCreditsButton removeFromSuperview];
    OPCreditsButton = nil;
    [OPShareButton removeFromSuperview];
    OPShareButton = nil;
    [OPRestoreButton removeFromSuperview];
    OPRestoreButton = nil;
    
    [self depaintCapsuleImage];
    
    [backButtonFromOptions removeFromSuperview];
    backButtonFromOptions = nil;
    
    [imageBackground2 removeFromSuperview];
    imageBackground2 = nil;
}

-(void) becomesClicked:(UIImageView*)imageParam
           fileNameArg:(NSString*)fileNameParam
               rectArg:(CGRect)rectParam
{
    NSString* playCPath = [[NSBundle mainBundle] pathForResource:fileNameParam ofType:@"png"];
    imageParam.image = [[UIImage alloc] initWithContentsOfFile:playCPath];
    [imageParam setFrame:[gameModel getClickedButton:rectParam]];
}

-(void) resetClicked:(UIImageView*)imageParam
           fileNameArg:(NSString*)fileNameParam
               rectArg:(CGRect)rectParam
{
    NSString* playCPath = [[NSBundle mainBundle] pathForResource:fileNameParam ofType:@"png"];
    imageParam.image = [[UIImage alloc] initWithContentsOfFile:playCPath];
    [imageParam setFrame:rectParam];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ////////Potential bug: broken clocks having short hand values!!//////////
    ////////Potential bug: broken clocks having short hand values!!//////////
    ////////Potential bug: broken clocks having short hand values!!//////////
    /////also do the while animating for broken/////
    /////also do the while animating for broken/////
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint2Top = [[touches anyObject] locationInView:top2ClocksImage];
    CGPoint touchPoint2Bottom = [[touches anyObject] locationInView:bottom2ClocksImage];
    
    CGPoint touchPoint3TopLeft = [[touches anyObject] locationInView:topLeft3Image];
    CGPoint touchPoint3TopRight = [[touches anyObject] locationInView:topRight3Image];
    CGPoint touchPoint3Bottom = [[touches anyObject] locationInView:bottom3Image];
    
    CGPoint touchPoint4TopLeft = [[touches anyObject] locationInView:topLeft4Image];
    CGPoint touchPoint4TopRight = [[touches anyObject] locationInView:topRight4Image];
    CGPoint touchPoint4BottomLeft = [[touches anyObject] locationInView:bottomLeft4Image];
    CGPoint touchPoint4BottomRight = [[touches anyObject] locationInView:bottomRight4Image];
    
    //handle icy notif - starts
    if ([touch view] == top2ClocksImage)
    {
        if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    } else if ([touch view] == bottom2ClocksImage)
    {
        if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    }
    
    if ([touch view] == topLeft3Image)
    {
        if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    } else if ([touch view] == topRight3Image)
    {
        if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    } else if ([touch view] == bottom3Image)
    {
        if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    }
    
    if ([touch view] == topLeft4Image)
    {
        if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    } else if ([touch view] == topRight4Image)
    {
        if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    } else if ([touch view] == bottomLeft4Image)
    {
        if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    } else if ([touch view] == bottomRight4Image)
    {
        if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"void"]) {
            [self executeNotifIcyAnimation];
        }
    }
    //handle icy notif - ends
    
    //2clocks broken - starts
    if ([touch view] == top2ClocksImage)
    {
        if ([[self getClockTypePureString:UP_2CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = UP_2CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint2Top.x > gameModel.top2ClocksRect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2TopImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock isForward:YES];
                    [[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2TopImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock isForward:YES];
                    [[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow2TopImage clockArg:tempClock directionArg:forwardDirection originArg:UP_2CLOCKS numberOfClocksArg:2];
                [self animateFlash:2 clockPositionArg:UP_2CLOCKS leftIs1RightIs2:rightside];
            } else if (touchPoint2Top.x < gameModel.top2ClocksRect.size.width/2.0) {
                if ([[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2TopImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock isForward:NO];
                    [[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] moveHandsBackward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2TopImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock isForward:NO];
                    [[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] moveHandsBackward:1 :0];
                }
                [self examineTypes:shortArrow2TopImage clockArg:tempClock directionArg:backwardDirection originArg:UP_2CLOCKS numberOfClocksArg:2];
                [self animateFlash:2 clockPositionArg:UP_2CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:2];
            [self checkExplosive];
            [self addStep];
        }
    } else if ([touch view] == bottom2ClocksImage)
    {
        if ([[self getClockTypePureString:BOTTOM_2CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = BOTTOM_2CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint2Top.x > gameModel.bottom2ClocksRect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock2Bottom isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock2Bottom isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow2BottomImage clockArg:tempClock2Bottom directionArg:forwardDirection originArg:BOTTOM_2CLOCKS numberOfClocksArg:2];
                [self animateFlash:2 clockPositionArg:BOTTOM_2CLOCKS leftIs1RightIs2:rightside];
            } else if (touchPoint2Top.x < gameModel.top2ClocksRect.size.width/2.0) {
                if ([[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock2Bottom isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] moveHandsBackward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock2Bottom isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] moveHandsBackward:1 :0];
                }
                [self examineTypes:shortArrow2BottomImage clockArg:tempClock2Bottom directionArg:backwardDirection originArg:BOTTOM_2CLOCKS numberOfClocksArg:2];
                [self animateFlash:2 clockPositionArg:BOTTOM_2CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:2];
            [self checkExplosive];
            [self addStep];
        }
    }
    //2clocks broken - ends
    
    //2clocks - starts
    if ([touch view] == top2ClocksImage)
    {
        if ([[self getClockTypePureString:UP_2CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:UP_2CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = UP_2CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint2Top.x > gameModel.top2ClocksRect.size.width/2.0)
            {
                
                if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:UP_2CLOCKS imageArg:shortArrow2TopImage clockArg:tempClock numberOfClocksArg:2];
                    //test
                    [self animateDizzyArgClockIndexArg:UP_2CLOCKS longImageArg:longArrow2TopImage longYellow:longYellow2T];
                }
                else if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] originArg:UP_2CLOCKS numberOfClocksArg:2];
                } else {
                    
                    //Bug prevention line
//                    [tempClock moveHandsForward:2 :1];
                    [self examineTypes:shortArrow2TopImage clockArg:tempClock directionArg:forwardDirection originArg:UP_2CLOCKS numberOfClocksArg:2];
                    //Bug prevention line
//                    [tempClock moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow2TopImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock longYellow:longYellow2T isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow2TopImage clockArg:tempClock];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                    }
//                    [self examineTypes:shortArrow2TopImage clockArg:tempClock directionArg:forwardDirection originArg:UP_2CLOCKS numberOfClocksArg:2];
//                    nololon
                }
                [self animateFlash:2 clockPositionArg:UP_2CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint2Top.x < gameModel.top2ClocksRect.size.width/2.0)
            {
                if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:UP_2CLOCKS imageArg:shortArrow2TopImage clockArg:tempClock numberOfClocksArg:2];
                    //test
                    [self animateDizzyArgClockIndexArg:UP_2CLOCKS longImageArg:longArrow2TopImage longYellow:longYellow2T];
                }
                else if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] originArg:UP_2CLOCKS numberOfClocksArg:2];
                } else {
                    
                    //Bug prevention line
//                    [tempClock moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow2TopImage clockArg:tempClock directionArg:backwardDirection originArg:UP_2CLOCKS numberOfClocksArg:2];
                    //Bug prevention line
//                    [tempClock moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"ninja"]) {
                        
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow2TopImage clockArg:tempClock];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                    } else {
                        if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow2TopImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock longYellow:longYellow2T isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow2TopImage clockArg:tempClock];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow2TopImage arrayArg:[self getProperLongAnimation:tempClock isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:2 clockPositionArg:UP_2CLOCKS leftIs1RightIs2:leftside];
            }
            
            [self automateUI];
            [self checkWin:2];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:UP_2CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    else if ([touch view] == bottom2ClocksImage)
    {
        if ([[self getClockTypePureString:BOTTOM_2CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:BOTTOM_2CLOCKS]  isEqual: @"broken"])
        {
            
            int clockLocation = BOTTOM_2CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint2Bottom.x > gameModel.bottom2ClocksRect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:BOTTOM_2CLOCKS imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom numberOfClocksArg:2];
                    //test
                    [self animateDizzyArgClockIndexArg:BOTTOM_2CLOCKS longImageArg:longArrow2BottomImage longYellow:longYellow2B];
                }
                else if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] originArg:BOTTOM_2CLOCKS numberOfClocksArg:2];
                } else {
                    
                    //Bug prevention line
//                    [tempClock2Bottom moveHandsForward:2 :1];
                    [self examineTypes:shortArrow2BottomImage clockArg:tempClock2Bottom directionArg:forwardDirection originArg:BOTTOM_2CLOCKS numberOfClocksArg:2];
                    //Bug prevention line
//                    [tempClock2Bottom moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock2Bottom longYellow:longYellow2B isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:2 clockPositionArg:BOTTOM_2CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint2Bottom.x < gameModel.bottom2ClocksRect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:BOTTOM_2CLOCKS imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom numberOfClocksArg:2];
                    //test
                    [self animateDizzyArgClockIndexArg:BOTTOM_2CLOCKS longImageArg:longArrow2BottomImage longYellow:longYellow2B];
                }
                else if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] originArg:BOTTOM_2CLOCKS numberOfClocksArg:2];
                } else {
                    
                    //Bug prevention line
//                    [tempClock2Bottom moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow2BottomImage clockArg:tempClock2Bottom directionArg:backwardDirection originArg:BOTTOM_2CLOCKS numberOfClocksArg:2];
                    //Bug prevention line
//                    [tempClock2Bottom moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock2Bottom longYellow:longYellow2B isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow2BottomImage clockArg:tempClock2Bottom];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow2BottomImage arrayArg:[self getProperLongAnimation:tempClock2Bottom isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:2 clockPositionArg:BOTTOM_2CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:2];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:BOTTOM_2CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    //2clocks - ends
    
    //3clocks broken - starts
    if ([touch view] == topLeft3Image)
    {
        if ([[self getClockTypePureString:TOPLEFT_3CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPLEFT_3CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint3TopLeft.x > gameModel.topLeft3Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock3TopLeft isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock3TopLeft isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow3TopLeftImage clockArg:tempClock3TopLeft directionArg:forwardDirection originArg:TOPLEFT_3CLOCKS numberOfClocksArg:3];
                [self animateFlash:3 clockPositionArg:TOPLEFT_3CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint3TopLeft.x < gameModel.topLeft3Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock3TopLeft isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock3TopLeft isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow3TopLeftImage clockArg:tempClock3TopLeft directionArg:backwardDirection originArg:TOPLEFT_3CLOCKS numberOfClocksArg:3];
                [self animateFlash:3 clockPositionArg:TOPLEFT_3CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:3];
            [self checkExplosive];
            [self addStep];
        }
    }
    else if ([touch view] == topRight3Image)
    {
        if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPRIGHT_3CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint3TopRight.x > gameModel.topRight3Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock3TopRight isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock3TopRight isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow3TopRightImage clockArg:tempClock3TopRight directionArg:forwardDirection originArg:TOPRIGHT_3CLOCKS numberOfClocksArg:3];
                [self animateFlash:3 clockPositionArg:TOPRIGHT_3CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint3TopRight.x < gameModel.topRight3Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock3TopRight isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock3TopRight isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow3TopRightImage clockArg:tempClock3TopRight directionArg:backwardDirection originArg:TOPRIGHT_3CLOCKS numberOfClocksArg:3];
                [self animateFlash:3 clockPositionArg:TOPRIGHT_3CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:3];
            [self checkExplosive];
            [self addStep];
        }
    }
    else if ([touch view] == bottom3Image)
    {
        if ([[self getClockTypePureString:BOTTOM_3CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = BOTTOM_3CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint3Bottom.x > gameModel.bottom3Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock3Bottom isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock3Bottom isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow3BottomImage clockArg:tempClock3Bottom directionArg:forwardDirection originArg:BOTTOM_3CLOCKS numberOfClocksArg:3];
                [self animateFlash:3 clockPositionArg:BOTTOM_3CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint3Bottom.x < gameModel.bottom3Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock3Bottom isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock3Bottom isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow3BottomImage clockArg:tempClock3Bottom directionArg:backwardDirection originArg:BOTTOM_3CLOCKS numberOfClocksArg:3];
                [self animateFlash:3 clockPositionArg:BOTTOM_3CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:3];
            [self checkExplosive];
            [self addStep];
        }
    }
    //3clocks broken - ends
    
    //3clocks - starts
    if ([touch view] == topLeft3Image)
    {
        if ([[self getClockTypePureString:TOPLEFT_3CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:TOPLEFT_3CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPLEFT_3CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint3TopLeft.x > gameModel.topLeft3Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPLEFT_3CLOCKS imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft numberOfClocksArg:3];
                    [self animateDizzyArgClockIndexArg:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage longYellow:longYellow3TL];
                }
                else if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] originArg:TOPLEFT_3CLOCKS numberOfClocksArg:3];
                } else {
                    //Bug prevention line
//                    [tempClock3TopLeft moveHandsForward:2 :1];
                    [self examineTypes:shortArrow3TopLeftImage clockArg:tempClock3TopLeft directionArg:forwardDirection originArg:TOPLEFT_3CLOCKS numberOfClocksArg:3];
                    //Bug prevention line
//                    [tempClock3TopLeft moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock3TopLeft longYellow:longYellow3TL isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:3 clockPositionArg:TOPLEFT_3CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint3TopLeft.x < gameModel.topLeft3Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPLEFT_3CLOCKS imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft numberOfClocksArg:3];
                    [self animateDizzyArgClockIndexArg:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage longYellow:longYellow3TL];
                }
                else if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] originArg:TOPLEFT_3CLOCKS numberOfClocksArg:3];
                } else {
                    //Bug prevention line
//                    [tempClock3TopLeft moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow3TopLeftImage clockArg:tempClock3TopLeft directionArg:backwardDirection originArg:TOPLEFT_3CLOCKS numberOfClocksArg:3];
                    //Bug prevention line
//                    [tempClock3TopLeft moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock3TopLeft longYellow:longYellow3TL isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow3TopLeftImage clockArg:tempClock3TopLeft];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopLeftImage arrayArg:[self getProperLongAnimation:tempClock3TopLeft isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:3 clockPositionArg:TOPLEFT_3CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:3];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:TOPLEFT_3CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    else if ([touch view] == topRight3Image)
    {
        if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:TOPRIGHT_3CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPRIGHT_3CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint3TopRight.x > gameModel.topRight3Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPRIGHT_3CLOCKS imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight numberOfClocksArg:3];
                    [self animateDizzyArgClockIndexArg:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage longYellow:longYellow3TR];
                }
                else if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] originArg:TOPRIGHT_3CLOCKS numberOfClocksArg:3];
                } else {
                    //Bug prevention line
//                    [tempClock3TopRight moveHandsForward:2 :1];
                    [self examineTypes:shortArrow3TopRightImage clockArg:tempClock3TopRight directionArg:forwardDirection originArg:TOPRIGHT_3CLOCKS numberOfClocksArg:3];
                    //Bug prevention line
//                    [tempClock3TopRight moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock3TopRight longYellow:longYellow3TR isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:3 clockPositionArg:TOPRIGHT_3CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint3TopRight.x < gameModel.topRight3Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPRIGHT_3CLOCKS imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight numberOfClocksArg:3];
                    [self animateDizzyArgClockIndexArg:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage longYellow:longYellow3TR];
                }
                else if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] originArg:TOPRIGHT_3CLOCKS numberOfClocksArg:3];
                } else {
                    //Bug prevention line
//                    [tempClock3TopRight moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow3TopRightImage clockArg:tempClock3TopRight directionArg:backwardDirection originArg:TOPRIGHT_3CLOCKS numberOfClocksArg:3];
                    //Bug prevention line
//                    [tempClock3TopRight moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock3TopRight longYellow:longYellow3TR isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow3TopRightImage clockArg:tempClock3TopRight];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow3TopRightImage arrayArg:[self getProperLongAnimation:tempClock3TopRight isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:3 clockPositionArg:TOPRIGHT_3CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:3];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:TOPRIGHT_3CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    else if ([touch view] == bottom3Image)
    {
        if ([[self getClockTypePureString:BOTTOM_3CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:BOTTOM_3CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = BOTTOM_3CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"dizzy"]) {
                [self executeShortOnDizzy:BOTTOM_3CLOCKS imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom numberOfClocksArg:3];
                [self animateDizzyArgClockIndexArg:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage longYellow:longYellow3B];
            }
            else if (touchPoint3Bottom.x > gameModel.bottom3Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] originArg:BOTTOM_3CLOCKS numberOfClocksArg:3];
                } else {
                    //Bug prevention line
//                    [tempClock3Bottom moveHandsForward:2 :1];
                    [self examineTypes:shortArrow3BottomImage clockArg:tempClock3Bottom directionArg:forwardDirection originArg:BOTTOM_3CLOCKS numberOfClocksArg:3];
                    //Bug prevention line
//                    [tempClock3Bottom moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock3Bottom longYellow:longYellow3B isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:3 clockPositionArg:BOTTOM_3CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint3Bottom.x < gameModel.bottom3Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:BOTTOM_3CLOCKS imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom numberOfClocksArg:3];
                    [self animateDizzyArgClockIndexArg:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage longYellow:longYellow3B];
                }
                else if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] originArg:BOTTOM_3CLOCKS numberOfClocksArg:3];
                } else {
                    //Bug prevention line
//                    [tempClock3Bottom moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow3BottomImage clockArg:tempClock3Bottom directionArg:backwardDirection originArg:BOTTOM_3CLOCKS numberOfClocksArg:3];
                    //Bug prevention line
//                    [tempClock3Bottom moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock3Bottom longYellow:longYellow3B isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow3BottomImage clockArg:tempClock3Bottom];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow3BottomImage arrayArg:[self getProperLongAnimation:tempClock3Bottom isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:3 clockPositionArg:BOTTOM_3CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:3];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:BOTTOM_3CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    
    //4clocks - starts
    if ([touch view] == topLeft4Image)
    {
        if ([[self getClockTypePureString:TOPLEFT_4CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:TOPLEFT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPLEFT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4TopLeft.x > gameModel.topLeft4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPLEFT_4CLOCKS imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage longYellow:longYellow4TL];
                }
                else if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] originArg:TOPLEFT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4TopLeft moveHandsForward:2 :1];
                    [self examineTypes:shortArrow4TopLeftImage clockArg:tempClock4TopLeft directionArg:forwardDirection originArg:TOPLEFT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4TopLeft moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock4TopLeft longYellow:longYellow4TL isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:4 clockPositionArg:TOPLEFT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4TopLeft.x < gameModel.topLeft4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPLEFT_4CLOCKS imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage longYellow:longYellow4TL];
                }
                else if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] originArg:TOPLEFT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4TopLeft moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow4TopLeftImage clockArg:tempClock4TopLeft directionArg:backwardDirection originArg:TOPLEFT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4TopLeft moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock4TopLeft longYellow:longYellow4TL isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow4TopLeftImage clockArg:tempClock4TopLeft];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:[self getProperLongAnimation:tempClock4TopLeft isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:4 clockPositionArg:TOPLEFT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    else if ([touch view] == topRight4Image)
    {
        if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:TOPRIGHT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPRIGHT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4TopRight.x > gameModel.topRight4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPRIGHT_4CLOCKS imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage longYellow:longYellow4TR];
                }
                else if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] originArg:TOPRIGHT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4TopRight moveHandsForward:2 :1];
                    [self examineTypes:shortArrow4TopRightImage clockArg:tempClock4TopRight directionArg:forwardDirection originArg:TOPRIGHT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4TopRight moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock4TopRight longYellow:longYellow4TR isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:4 clockPositionArg:TOPRIGHT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4TopRight.x < gameModel.topRight4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:TOPRIGHT_4CLOCKS imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage longYellow:longYellow4TR];
                }
                else if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] originArg:TOPRIGHT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4TopRight moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow4TopRightImage clockArg:tempClock4TopRight directionArg:backwardDirection originArg:TOPRIGHT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4TopRight moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock4TopRight longYellow:longYellow4TR isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow4TopRightImage clockArg:tempClock4TopRight];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:[self getProperLongAnimation:tempClock4TopRight isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:4 clockPositionArg:TOPRIGHT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    else if ([touch view] == bottomLeft4Image)
    {
        if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:BOTTOMLEFT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = BOTTOMLEFT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4BottomLeft.x > gameModel.bottomLeft4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:BOTTOMLEFT_4CLOCKS imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage longYellow:longYellow4BL];
                }
                else if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] originArg:BOTTOMLEFT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4BottomLeft moveHandsForward:2 :1];
                    [self examineTypes:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft directionArg:forwardDirection originArg:BOTTOMLEFT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4BottomLeft moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock4BottomLeft longYellow:longYellow4BL isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:4 clockPositionArg:BOTTOMLEFT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4BottomLeft.x < gameModel.bottomLeft4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:BOTTOMLEFT_4CLOCKS imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage longYellow:longYellow4BL];
                }
                else if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] originArg:BOTTOMLEFT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4BottomLeft moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft directionArg:backwardDirection originArg:BOTTOMLEFT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4BottomLeft moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock4BottomLeft longYellow:longYellow4BL isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:[self getProperLongAnimation:tempClock4BottomLeft isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:4 clockPositionArg:BOTTOMLEFT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    else if ([touch view] == bottomRight4Image)
    {
        if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS]  isEqual: @"void"]) {
            return;
        }
        
        if (![[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = BOTTOMRIGHT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4BottomRight.x > gameModel.bottomRight4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:BOTTOMRIGHT_4CLOCKS imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage longYellow:longYellow4BR];
                }
                else if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] originArg:BOTTOMRIGHT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4BottomRight moveHandsForward:2 :1];
                    [self examineTypes:shortArrow4BottomRightImage clockArg:tempClock4BottomRight directionArg:forwardDirection originArg:BOTTOMRIGHT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4BottomRight moveHandsBackward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"lazyflower"]) {
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:longArrowLazyForward isForward:YES type:currentClockType isActive:YES];
                        
                        //flower yellow bounce back
                        [self animatingYellowFlower:tempClock4BottomRight longYellow:longYellow4BR isForward:YES];
                    } else {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    }
                }
                [self animateFlash:4 clockPositionArg:BOTTOMRIGHT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4BottomRight.x < gameModel.bottomRight4Rect.size.width/2.0)
            {
                if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"dizzy"]) {
                    [self executeShortOnDizzy:BOTTOMRIGHT_4CLOCKS imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight numberOfClocksArg:4];
                    [self animateDizzyArgClockIndexArg:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage longYellow:longYellow4BR];
                }
                else if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"sleepyclock"]) {
                    [self doSleepOrAwake:[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] originArg:BOTTOMRIGHT_4CLOCKS numberOfClocksArg:4];
                } else {
                    //Bug prevention line
//                    [tempClock4BottomRight moveHandsBackward:2 :1];
                    [self examineTypes:shortArrow4BottomRightImage clockArg:tempClock4BottomRight directionArg:backwardDirection originArg:BOTTOMRIGHT_4CLOCKS numberOfClocksArg:4];
                    //Bug prevention line
//                    [tempClock4BottomRight moveHandsForward:2 :1];
                    
                    if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"ninja"]) {
                        [self executeShortForward:defaultMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                        [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:YES] isForward:YES type:currentClockType isActive:YES];
                        
                    } else {
                        if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"lazyflower"]) {
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:longArrowLazyBackward isForward:NO type:currentClockType isActive:YES];
                            
                            //flower yellow bounce back
                            [self animatingYellowFlower:tempClock4BottomRight longYellow:longYellow4BR isForward:NO];
                        } else {
                            [self executeShortBackward:defaultMultiplier imageArg:shortArrow4BottomRightImage clockArg:tempClock4BottomRight];
                            [self animatingLongArrow:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:[self getProperLongAnimation:tempClock4BottomRight isForwardArg:NO] isForward:NO type:currentClockType isActive:YES];
                            
                        }
                    }
                }
                [self animateFlash:4 clockPositionArg:BOTTOMRIGHT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            if (![[[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] getType] isEqualToString:@"void"]) {
                if (!([[[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] getType] isEqualToString:@"sleepyclock"] && [[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] shorterHand] == 12)) {
                    [self addStep];
                }
            }
        }
    }
    //4clocks - ends
    
    //4clocks broken - starts
    if ([touch view] == topLeft4Image)
    {
        if ([[self getClockTypePureString:TOPLEFT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPLEFT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4TopLeft.x > gameModel.topLeft4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock4TopLeft isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock4TopLeft isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4TopLeftImage clockArg:tempClock4TopLeft directionArg:forwardDirection originArg:TOPLEFT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:TOPLEFT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4TopLeft.x < gameModel.topLeft4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock4TopLeft isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopLeftImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock4TopLeft isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4TopLeftImage clockArg:tempClock4TopLeft directionArg:backwardDirection originArg:TOPLEFT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:TOPLEFT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            [self addStep];
        }
    }
    else if ([touch view] == topRight4Image)
    {
        if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = TOPRIGHT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4TopRight.x > gameModel.topRight4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock4TopRight isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock4TopRight isForward:YES];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4TopRightImage clockArg:tempClock4TopRight directionArg:forwardDirection originArg:TOPRIGHT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:TOPRIGHT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4TopRight.x < gameModel.topRight4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock4TopRight isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4TopRightImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock4TopRight isForward:NO];
                    [[currentLevel.clocks objectAtIndex:TOPRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4TopRightImage clockArg:tempClock4TopRight directionArg:backwardDirection originArg:TOPRIGHT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:TOPRIGHT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            [self addStep];
        }
    }
    else if ([touch view] == bottomLeft4Image)
    {
        if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = BOTTOMLEFT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4BottomLeft.x > gameModel.bottomLeft4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock4BottomLeft isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock4BottomLeft isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft directionArg:forwardDirection originArg:BOTTOMLEFT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:BOTTOMLEFT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4BottomLeft.x < gameModel.bottomLeft4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock4BottomLeft isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomLeftImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock4BottomLeft isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOMLEFT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft directionArg:backwardDirection originArg:BOTTOMLEFT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:BOTTOMLEFT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            [self addStep];
        }
    }
    else if ([touch view] == bottomRight4Image)
    {
        if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS]  isEqual: @"broken"])
        {
            int clockLocation = BOTTOMRIGHT_4CLOCKS;
            NSString *currentClockType = [self convertClockTypeOldToNew:[self getClockTypePureString:clockLocation]];
            
            if (touchPoint4BottomRight.x > gameModel.bottomRight4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:longArrowRightToDownAnimation clockArg:tempClock4BottomRight isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:longArrowLeftToUpAnimation clockArg:tempClock4BottomRight isForward:YES];
                    [[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4BottomRightImage clockArg:tempClock4BottomRight directionArg:forwardDirection originArg:BOTTOMRIGHT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:BOTTOMRIGHT_4CLOCKS leftIs1RightIs2:rightside];
            }
            else if (touchPoint4BottomRight.x < gameModel.bottomRight4Rect.size.width/2.0)
            {
                if ([[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] isLongerHandUp] == YES) {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:longArrowLeftToDownAnimation clockArg:tempClock4BottomRight isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                } else {
                    [self animatingLongArrowByHalf:defaultMultiplier imageArg:longArrow4BottomRightImage arrayArg:longArrowRightToUpAnimation clockArg:tempClock4BottomRight isForward:NO];
                    [[currentLevel.clocks objectAtIndex:BOTTOMRIGHT_4CLOCKS-1] moveHandsForward:1 :0];
                }
                [self examineTypes:shortArrow4BottomRightImage clockArg:tempClock4BottomRight directionArg:backwardDirection originArg:BOTTOMRIGHT_4CLOCKS numberOfClocksArg:4];
                [self animateFlash:4 clockPositionArg:BOTTOMRIGHT_4CLOCKS leftIs1RightIs2:leftside];
            }
            [self automateUI];
            [self checkWin:4];
            [self checkExplosive];
            [self addStep];
        }
    }
    //4clocks broken - ends
    
    if ([touch view] == playButton)
    {
        [self becomesClicked:playButton fileNameArg:@"PlayButton_Clicked" rectArg:gameModel.playButtonRect];
        [self sfxButtonClick];
    }
    else if ([touch view] == optionsButton)
    {
        [self becomesClicked:optionsButton fileNameArg:@"OptionsButton_Clicked" rectArg:gameModel.optionsButtonRect];
        [self sfxButtonClick];
    }
    else if ([touch view] == facebookButton)
    {
        [self becomesClicked:facebookButton fileNameArg:@"FacebookButton_Clicked" rectArg:gameModel.facebook_mainPageRect];
        [self sfxButtonClick];
    }
    else if ([touch view] == backButton)
    {
        [self becomesClicked:backButton fileNameArg:@"BackButton_Clicked" rectArg:gameModel.backButtonRect];
        [self sfxButtonClick];
    }
    else if ([touch view] == backButton4dot1)
    {
        [self becomesClicked:backButton4dot1 fileNameArg:@"BackButton_Clicked" rectArg:gameModel.backButtonRect];
        [self sfxButtonClick];
    }
    else if ([touch view] == winNext)
    {
        [self becomesClicked:winNext fileNameArg:@"NextButton_Clicked" rectArg:gameModel.winNextRect];
        [self sfxButtonClick];
        [self removeFullScreenImage];
    }
    else if ([touch view] == winLevels)
    {
        [self becomesClicked:winLevels fileNameArg:@"LevelButton_Clicked" rectArg:gameModel.winLevelsRect];
        [self sfxButtonClick];
        [self removeFullScreenImage];
    }
    else if ([touch view] == winReset)
    {
        [self becomesClicked:winReset fileNameArg:@"ResetButton2_Clicked" rectArg:gameModel.winResetRect];
        [self sfxButtonClick];
        [self removeFullScreenImage];
    }
    else if ([touch view] == resetButton) {
        [self becomesClicked:resetButton fileNameArg:@"ResetButton_Clicked" rectArg:gameModel.resetButtonRect];
        [self sfxButtonClick];
    } else if ([touch view] == pauseButton) {
        [self becomesClicked:pauseButton fileNameArg:@"PauseButton_Clicked" rectArg:gameModel.pauseButtonRect];
        [self sfxButtonClick];
    }
    else if ([touch view] == nextAtCongrats) {
        [self becomesClicked:nextAtCongrats fileNameArg:@"NextButtonRect_Clicked" rectArg:gameModel.bottomCenterButtonRect];
        [self sfxButtonClick];
    } else if ([touch view] == backAtFinalCredits) {
        [self sfxButtonClick];
        
        [self dePaintFinalCredits];
        [scrollView depaintLongCreditsPage];
        [self paintMainMenu];
    } else if ([touch view] == collectionsButton) {
        [self sfxButtonClick];
        [self becomesClicked:collectionsButton fileNameArg:@"Collections_Button_Clicked" rectArg:gameModel.collections_mainPageRect];
    } else if ([touch view] == OPSoundButton) {
        if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
            [self sfxButtonClick];
            [gameModel.prefs setBool:YES forKey:@"isSoundMute"];
            [self becomesClicked:OPSoundButton fileNameArg:@"SoundOnButton_Clicked" rectArg:gameModel.optionsPageSoundRect];
            //kill all sounds
            [self audioMusicOnlyStop];
        } else {
            [gameModel.prefs setBool:NO forKey:@"isSoundMute"];
            [self becomesClicked:OPSoundButton fileNameArg:@"SoundOffButton_Clicked" rectArg:gameModel.optionsPageSoundRect];
            //play main song
            [self audioMainPlay];
        }
    } else if ([touch view] == OPRateButton) {
        [self becomesClicked:OPRateButton fileNameArg:@"RateButton_Clicked" rectArg:gameModel.optionsPageRateRect];
        [self sfxButtonClick];
    } else if ([touch view] == OPHelpButton) {
        [self becomesClicked:OPHelpButton fileNameArg:@"HelpButton_Clicked" rectArg:gameModel.optionsPageHelpRect];
        [self sfxButtonClick];
    } else if ([touch view] == OPCreditsButton) {
        [self becomesClicked:OPCreditsButton fileNameArg:@"CreditsButton_Clicked" rectArg:gameModel.optionsPageCreditsRect];
        [self sfxButtonClick];
    } else if ([touch view] == OPShareButton) {
        [self becomesClicked:OPShareButton fileNameArg:@"ShareButton_Clicked" rectArg:gameModel.optionsPageShareRect];
        [self sfxButtonClick];
    } else if ([touch view] == OPRestoreButton) {
        [self becomesClicked:OPRestoreButton fileNameArg:@"Restore_Button_Clicked" rectArg:gameModel.optionsPageRestoreRect];
        [self sfxButtonClick];
    } else if ([touch view] == shareInStickers) {
        [self becomesClicked:shareInStickers fileNameArg:@"ShareButton_Clicked" rectArg:gameModel.shareInStickersRect];
        [self sfxButtonClick];
    } else if ([touch view] == backButtonFromOptions) {
        [self becomesClicked:backButtonFromOptions fileNameArg:@"BackButton_Clicked" rectArg:gameModel.backButtonRect];
        [self sfxButtonClick];
    } else if ([touch view] == backButtonFromOptionsCredits) {
        [self becomesClicked:backButtonFromOptionsCredits fileNameArg:@"BackButton_Clicked" rectArg:gameModel.backButtonRect];
        [self sfxButtonClick];
    } else if ([touch view] == gameplayHelp) {
        [self becomesClicked:gameplayHelp fileNameArg:@"Help_RoundButton_Clicked" rectArg:gameModel.gameplayHelpRect];
        [self sfxButtonClick];
    } else if ([touch view] == gameplayPurchase) {
        [self becomesClicked:gameplayPurchase fileNameArg:@"Purchase_Button" rectArg:gameModel.gameplayPurchaseRect];
        [self sfxButtonClick];
    } else if ([touch view] == achBackImage) {
        [self becomesClicked:achBackImage fileNameArg:@"AchShadow_BackButton_Clicked" rectArg:gameModel.backAchBoardRect];
        [self sfxButtonClick];
    } else if ([touch view] == achLikeImage) {
        [self becomesClicked:achLikeImage fileNameArg:@"AchShadow_FbButton_Clicked" rectArg:gameModel.rateAndLikeRect];
        [self sfxButtonClick];
    } else if ([touch view] == achRateImage) {
        [self becomesClicked:achRateImage fileNameArg:@"AchShadow_RateButton_Clicked" rectArg:gameModel.rateAndLikeRect];
        [self sfxButtonClick];
    } else if ([touch view] == backButtonFromCollections) {
        [self becomesClicked:backButtonFromCollections fileNameArg:@"BackButton_Clicked" rectArg:gameModel.backButtonRect];
        [self sfxButtonClick];
    } else if ([touch view] == inAppCloseImage) {
        [self becomesClicked:inAppCloseImage fileNameArg:@"InAppPurchases_Close_Clicked" rectArg:gameModel.inAppCloseRect];
        [self sfxButtonClick];
    } else if ([touch view] == freeCloseImage) {
        [self becomesClicked:freeCloseImage fileNameArg:@"InAppPurchases_Close_Clicked" rectArg:gameModel.inAppCloseRect];
        [self sfxButtonClick];
    } else if ([touch view] == pauseResumeImage) {
        [self becomesClicked:pauseResumeImage fileNameArg:@"ResumeButton_Clicked" rectArg:gameModel.pauseResumeRect];
        [self sfxButtonClick];
    } else if ([touch view] == pauseMainMenuImage) {
        [self becomesClicked:pauseMainMenuImage fileNameArg:@"ToMainMenu_Button_Clicked" rectArg:gameModel.pauseMainRect];
        [self sfxButtonClick];
    } else if ([touch view] == pausePurchaseImage) {
        [self becomesClicked:pausePurchaseImage fileNameArg:@"PurchaseButton_Clicked" rectArg:gameModel.pausePurchaseRect];
        [self sfxButtonClick];
    } else if ([touch view] == inAppPrice1Image) {
        [self becomesClicked:inAppPrice1Image fileNameArg:@"InAppPurchases_Price1" rectArg:gameModel.inAppPrice1Rect];
        [self sfxButtonClick];
    } else if ([touch view] == inAppPrice2Image) {
        [self becomesClicked:inAppPrice2Image fileNameArg:@"InAppPurchases_Price2" rectArg:gameModel.inAppPrice2Rect];
        [self sfxButtonClick];
    } else if ([touch view] == inAppPrice3Image) {
        [self becomesClicked:inAppPrice3Image fileNameArg:@"InAppPurchases_Price3" rectArg:gameModel.inAppPrice3Rect];
        [self sfxButtonClick];
    } else if ([touch view] == inAppPrice4Image) {
        [self becomesClicked:inAppPrice4Image fileNameArg:@"InAppPurchases_Price0" rectArg:gameModel.inAppPrice4Rect];
        [self sfxButtonClick];
    } else if ([touch view] == freeFacebookImage) {
        [self becomesClicked:freeFacebookImage fileNameArg:@"InAppPurchases_Facebook" rectArg:gameModel.purchaseFacebookRect];
        [self sfxButtonClick];
    } else if ([touch view] == freeShareImage) {
        [self becomesClicked:freeShareImage fileNameArg:@"InAppPurchases_Share" rectArg:gameModel.purchaseShareRect];
        [self sfxButtonClick];
    } else if ([touch view] == freeRateImage) {
        [self becomesClicked:freeRateImage fileNameArg:@"InAppPurchases_Rate" rectArg:gameModel.purchaseRateRect];
        [self sfxButtonClick];
    } else if ([touch view] == notGameplayPurchase) {
        [self becomesClicked:notGameplayPurchase fileNameArg:@"Purchase_Button" rectArg:gameModel.capsuleAtBottomRight];
        [self sfxButtonClick];
    } else if ([touch view] == tutorialNextImage) {
        [self becomesClicked:tutorialNextImage fileNameArg:@"NextButtonRect_Clicked" rectArg:gameModel.backTutorialRect];
        [self sfxButtonClick];
    } else if ([touch view] == tutorialNextHelpImage) {
        [self becomesClicked:tutorialNextHelpImage fileNameArg:@"NextButtonRect_Clicked" rectArg:gameModel.backTutorialRect];
        [self sfxButtonClick];
    } else if ([touch view] == tutorialNextHelpForShadowImage) {
        [self becomesClicked:tutorialNextHelpForShadowImage fileNameArg:@"NextButtonRect_Clicked" rectArg:gameModel.backTutorialRect];
        [self sfxButtonClick];
    } else if ([touch view] == backButtonFromHelp) {
        [self becomesClicked:backButtonFromHelp fileNameArg:@"BackButton_Clicked" rectArg:gameModel.backButtonRect];
        [self sfxButtonClick];
    }
    else if ([touch view] == top2Virtual) {
        if ([tempClock checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock clockLocationArg:UP_2CLOCKS numberOfClocksArg:2];
            [self capsuleShortTo12:shortArrow2TopImage clockArg:tempClock shortAngel:shortAngel2T];
            [self capsuleLongTo12:longArrow2TopImage clockArg:tempClock];
            [self modifyZodiacsTo12:top2ClocksImage clockArg:tempClock];
            [self doDizzyCapsule:UP_2CLOCKS longImageArg:longArrow2TopImage longYellow:longYellow2T];
            [self animateEating:2 clockPositionArg:UP_2CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:2];
        }
    } else if ([touch view] == bottom2Virtual) {
        if ([tempClock2Bottom checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock2Bottom clockLocationArg:BOTTOM_2CLOCKS numberOfClocksArg:2];
            [self capsuleShortTo12:shortArrow2BottomImage clockArg:tempClock2Bottom shortAngel:shortAngel2B];
            [self capsuleLongTo12:longArrow2BottomImage clockArg:tempClock2Bottom];
            [self modifyZodiacsTo12:bottom2ClocksImage clockArg:tempClock2Bottom];
            [self doDizzyCapsule:BOTTOM_2CLOCKS longImageArg:longArrow2BottomImage longYellow:longYellow2B];
            [self animateEating:2 clockPositionArg:BOTTOM_2CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:2];
        }
    } else if ([touch view] == topLeft3Virtual) {
        if ([tempClock3TopLeft checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock3TopLeft clockLocationArg:TOPLEFT_3CLOCKS numberOfClocksArg:3];
            [self capsuleShortTo12:shortArrow3TopLeftImage clockArg:tempClock3TopLeft shortAngel:shortAngel3TL];
            [self capsuleLongTo12:longArrow3TopLeftImage clockArg:tempClock3TopLeft];
            [self modifyZodiacsTo12:topLeft3Image clockArg:tempClock3TopLeft];
            [self doDizzyCapsule:TOPLEFT_3CLOCKS longImageArg:longArrow3TopLeftImage longYellow:longYellow3TL];
            [self animateEating:3 clockPositionArg:TOPLEFT_3CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:3];
        }
    } else if ([touch view] == topRight3Virtual) {
        if ([tempClock3TopRight checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock3TopRight clockLocationArg:TOPRIGHT_3CLOCKS numberOfClocksArg:3];
            [self capsuleShortTo12:shortArrow3TopRightImage clockArg:tempClock3TopRight shortAngel:shortAngel3TR];
            [self capsuleLongTo12:longArrow3TopRightImage clockArg:tempClock3TopRight];
            [self modifyZodiacsTo12:topRight3Image clockArg:tempClock3TopRight];
            [self doDizzyCapsule:TOPRIGHT_3CLOCKS longImageArg:longArrow3TopRightImage longYellow:longYellow3TR];
            [self animateEating:3 clockPositionArg:TOPRIGHT_3CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:3];
        }
    } else if ([touch view] == bottom3Virtual) {
        if ([tempClock3Bottom checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock3Bottom clockLocationArg:BOTTOM_3CLOCKS numberOfClocksArg:3];
            [self capsuleShortTo12:shortArrow3BottomImage clockArg:tempClock3Bottom shortAngel:shortAngel3B];
            [self capsuleLongTo12:longArrow3BottomImage clockArg:tempClock3Bottom];
            [self modifyZodiacsTo12:bottom3Image clockArg:tempClock3Bottom];
            [self doDizzyCapsule:BOTTOM_3CLOCKS longImageArg:longArrow3BottomImage longYellow:longYellow3B];
            [self animateEating:3 clockPositionArg:BOTTOM_3CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:3];
        }
    } else if ([touch view] == topLeft4Virtual) {
        if ([tempClock4TopLeft checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock4TopLeft clockLocationArg:TOPLEFT_4CLOCKS numberOfClocksArg:4];
            [self capsuleShortTo12:shortArrow4TopLeftImage clockArg:tempClock4TopLeft shortAngel:shortAngel4TL];
            [self capsuleLongTo12:longArrow4TopLeftImage clockArg:tempClock4TopLeft];
            [self modifyZodiacsTo12:topLeft4Image clockArg:tempClock4TopLeft];
            [self doDizzyCapsule:TOPLEFT_4CLOCKS longImageArg:longArrow4TopLeftImage longYellow:longYellow4TL];
            [self animateEating:4 clockPositionArg:TOPLEFT_4CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:4];
        }
    } else if ([touch view] == topRight4Virtual) {
        if ([tempClock4TopRight checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock4TopRight clockLocationArg:TOPRIGHT_4CLOCKS numberOfClocksArg:4];
            [self capsuleShortTo12:shortArrow4TopRightImage clockArg:tempClock4TopRight shortAngel:shortAngel4TR];
            [self capsuleLongTo12:longArrow4TopRightImage clockArg:tempClock4TopRight];
            [self modifyZodiacsTo12:topRight4Image clockArg:tempClock4TopRight];
            [self doDizzyCapsule:TOPRIGHT_4CLOCKS longImageArg:longArrow4TopRightImage longYellow:longYellow4TR];
            [self animateEating:4 clockPositionArg:TOPRIGHT_4CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:4];
        }
    } else if ([touch view] == bottomRight4Virtual) {
        if ([tempClock4BottomRight checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock4BottomRight clockLocationArg:BOTTOMRIGHT_4CLOCKS numberOfClocksArg:4];
            [self capsuleShortTo12:shortArrow4BottomRightImage clockArg:tempClock4BottomRight shortAngel:shortAngel4BR];
            [self capsuleLongTo12:longArrow4BottomRightImage clockArg:tempClock4BottomRight];
            [self modifyZodiacsTo12:bottomRight4Image clockArg:tempClock4BottomRight];
            [self doDizzyCapsule:BOTTOMRIGHT_4CLOCKS longImageArg:longArrow4BottomRightImage longYellow:longYellow4BR];
            [self animateEating:4 clockPositionArg:BOTTOMRIGHT_4CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:4];
        }
    } else if ([touch view] == bottomLeft4Virtual) {
        if ([tempClock4BottomLeft checkTwelve] == NO) {
            [self do2FaceCapsule:tempClock4BottomLeft clockLocationArg:BOTTOMLEFT_4CLOCKS numberOfClocksArg:4];
            [self capsuleShortTo12:shortArrow4BottomLeftImage clockArg:tempClock4BottomLeft shortAngel:shortAngel4BL];
            [self capsuleLongTo12:longArrow4BottomLeftImage clockArg:tempClock4BottomLeft];
            [self modifyZodiacsTo12:bottomLeft4Image clockArg:tempClock4BottomLeft];
            [self doDizzyCapsule:BOTTOMLEFT_4CLOCKS longImageArg:longArrow4BottomLeftImage longYellow:longYellow4BL];
            [self animateEating:4 clockPositionArg:BOTTOMLEFT_4CLOCKS];
            [self callHideAllVirtualTimer];
            [self checkWin:4];
        }
    }
}

-(void)callHideAllVirtualTimer {
    [self disableUserInteractionAtVirtual];
    
    [NSTimer scheduledTimerWithTimeInterval:0.35
                                     target:self
                                   selector:@selector(hideAllVirtual:)
                                   userInfo:nil
                                    repeats:NO];
}

//move following functions to bottom
-(void)capsuleShortTo12:(UIImageView*)imageParam
               clockArg:(Clock*)clockParam
             shortAngel:(UIImageView*)shortAngel {
    
    if ([clockParam.type  isEqual: @"broken"]) {
        return;
    }
    
    [self rotateShortHandTo12:clockParam shortImage:imageParam shortAngel:shortAngel];
    
    [clockParam makeIt12];
    
    [self clearNotifBar];
}

-(void)capsuleLongTo12:(UIImageView*)imageParam
              clockArg:(Clock*)clockParam { //nonasim
    
    if ([clockParam.type  isEqual: @"chinese"]) {
        return;
    }
    
    if ([clockParam.type  isEqual: @"broken"]) {
        [self rotateBrokenHandTo12:clockParam longImage:imageParam];
        [clockParam makeIt12];
    }
    
    [self clearNotifBar];
}

-(void)modifyZodiacsTo12:(UIImageView*)imageParam
                clockArg:(Clock*)clockParam {
    
    if ([clockParam.type  isEqual: @"chinese"]) {
        NSString *fileName, *zodiac;
        int counter = 12;
        
        fileName = [NSString stringWithFormat: @"C-CHINESE_262px_KANJI-%i", counter];
        zodiac = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
        [[imageParam.subviews objectAtIndex:0] performSelectorOnMainThread:@selector(setImage:) withObject: [UIImage imageNamed:fileName] waitUntilDone:YES];
    }
}

-(void)do2FaceCapsule:(Clock*)clockObject
     clockLocationArg:(int)clockLocationParam
    numberOfClocksArg:(int)numberOfClocksParam {
    
    if ([clockObject.type isEqual:@"twoface"]) {
        TwoFace *temp2Face = clockObject;
        if (temp2Face.state == demonState) {
            [self doDemonToAngel:clockObject destinationArg:clockLocationParam numberOfClocksArg:numberOfClocksParam];
        }
    }
}

-(void)doDizzyCapsule:(int)clockPosition
         longImageArg:(UIImageView*)longImageParam
           longYellow:(UIImageView*)longYellow {
    
    if ([[[currentLevel.clocks objectAtIndex:clockPosition-1] getType]  isEqual: @"dizzy"]) {
        [self animateDizzyArgClockIndexArg:clockPosition longImageArg:longImageParam longYellow:longYellow];
    }
}

-(NSString*)getShort12Name:(Clock*)clockObject {
    if ([clockObject.type  isEqual: @"regular"]) {
        return @"Arrow_Regular_Short_1";
    } else if ([clockObject.type  isEqual: @"reversed"]) {
        return @"Arrow_Reversed_Short_1";
    } else if ([clockObject.type  isEqual: @"sleepyclock"]) {
        return @"Arrow_Sleepy_Short_1";
    } else if ([clockObject.type  isEqual: @"dizzy"]) {
        return @"Arrow_Dizzy_Short_1";
    } else if ([clockObject.type  isEqual: @"lazyflower"]) {
        return @"Arrow_Flower_Short_1";
    } else if ([clockObject.type  isEqual: @"roman"]) {
        return @"Arrow_Roman_Short_1";
    } else if ([clockObject.type  isEqual: @"ninja"]) {
        return @"Arrow_Ninja_Short_1";
    } else if ([clockObject.type  isEqual: @"void"]) {
        return @"Arrow_Icy_Short_1";
    } else if ([clockObject.type  isEqual: @"twoface"]) {
        return @"Arrow_Angel_Short_1";
    } else if ([clockObject.type  isEqual: @"chinese"]) {
        return @"Arrow_Chinese_Short_999";
    }
}

-(NSString*)getLong12Name:(Clock*)clockObject {
    if ([clockObject.type  isEqual: @"regular"]) {
        return @"Arrow_Regular_Long_999";
    } else if ([clockObject.type  isEqual: @"reversed"]) {
        return @"Arrow_Reversed_Long_999";
    } else if ([clockObject.type  isEqual: @"sleepyclock"]) {
        return @"Arrow_Sleepy_Long_999";
    } else if ([clockObject.type  isEqual: @"dizzy"]) {
        return @"Arrow_Dizzy_Long_999";
    } else if ([clockObject.type  isEqual: @"lazyflower"]) {
        return @"Arrow_Flower_Long_999";
    } else if ([clockObject.type  isEqual: @"roman"]) {
        return @"Arrow_Roman_Long_999";
    } else if ([clockObject.type  isEqual: @"ninja"]) {
        return @"Arrow_Ninja_Long_999";
    } else if ([clockObject.type  isEqual: @"void"]) {
        return @"Arrow_Icy_Long_999";
    } else if ([clockObject.type  isEqual: @"twoface"]) {
        return @"Arrow_Angel_Long_999";
    } else if ([clockObject.type  isEqual: @"broken"]) {
        return @"Arrow_Broken_Long_1";
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == playButton)
    {
        [self paintThemeMenu:NO];
        [self dePaintMainMenu];
    }
    else if ([touch view] == optionsButton)
    {
        [self dePaintMainMenu];
        [self paintOptionsPage];
    }
    else if ([touch view] == facebookButton)
    {
        [self facebookLikeIsClickedNoReward];
        [self resetClicked:facebookButton fileNameArg:@"FacebookButton" rectArg:gameModel.facebook_mainPageRect];
    }
    else if ([touch view] == collectionsButton) {
        [self dePaintMainMenu];
        [self paintCollectionsPage];
    }
    else if ([touch view] == achBackImage) {
        [self hideAchBoard];
    }
    else if ([touch view] == achLikeImage) {
        [self facebookLikeIsClicked];
        [self depaintCollectionsPage];
        [self paintCollectionsPage];
    }
    else if ([touch view] == achRateImage) {
        [self rateIsClicked];
        [self depaintCollectionsPage];
        [self paintCollectionsPage];
    }
    else if ([touch view] == winLevels)
    {
        [self nullifyAnimArraysAfterWin];
        [self dePaintWin];
        [self hideLevel:YES];
        [self callParticularLevelPage:currentLevel.currentLevel];
        [self enableUserInteractionsInLevel];
        [self audioMainPlay];
    }
    else if ([touch view] == winReset) {
        
        [self paintLoadingScreen];
        
        [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(delayLoadingWinReset:)
                                       userInfo:nil
                                        repeats:NO];
    }
    else if ([touch view] == winNext)
    {
        [self paintLoadingScreen];
        
        [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(delayLoadingWinNext:)
                                       userInfo:nil
                                        repeats:NO];
    }
    else if ([touch view] == inAppCloseImage) {
        [self depaintInAppPurchasesBoard];
    }
    else if ([touch view] == freeCloseImage) {
        [self depaintFreePurchase];
    }
    else if ([touch view] == pauseResumeImage) {
        [self dePaintPauseMenu];
    }
    else if ([touch view] == pauseMainMenuImage) {
        [self dePaintPauseMenu];
        [self hideLevel:YES];
        [self paintMainMenu];
        [self audioMainPlay];
    }
    else if ([touch view] == pausePurchaseImage) {
        [self dePaintPauseMenu];
        [self paintInAppPurchasesBoard];
    }
    else if ([touch view] == backButton)
    {
        [self dePaintThemeMenu];
        [self paintMainMenu];
    }
    else if ([touch view] == backButton4dot1)
    {
        [self dePaintLevelPage1];
        [self paintThemeMenu:NO];
    }
    else if ([touch view] == backButtonFromOptions) {
        [self dePaintOptionsPage];
        [self paintMainMenu];
    }
    else if ([touch view] == backButtonFromOptionsCredits) {
        [self depaintOptionsCredits];
        [scrollView depaintLongCreditsPage];
        [self paintOptionsPage];
    }
    else if ([touch view] == backButtonFromCollections) {
        [self depaintCollectionsPage];
        [self paintMainMenu];
    }
    else if ([touch view] == resetButton)
    {
        [self automateUI];
        [self clearNotifBar];
        [self hideLevel:NO];
        [self paintLevelNoArray:currentLevel.currentLevel];
        [self localNotification];
        [self resetClicked:resetButton fileNameArg:@"ResetButton" rectArg:gameModel.resetButtonRect];
        [self animateToWhiteNoTimer];
    }
    else if ([touch view] == pauseButton) {
        [self clearNotifBar];
        [self paintPauseMenu];
        [self resetClicked:pauseButton fileNameArg:@"PauseButton" rectArg:gameModel.pauseButtonRect];
    }
    else if ([touch view] == OPSoundButton) {
        if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
            [self resetClicked:OPSoundButton fileNameArg:@"SoundOnButton" rectArg:gameModel.optionsPageSoundRect];
        } else {
            [self resetClicked:OPSoundButton fileNameArg:@"SoundOffButton" rectArg:gameModel.optionsPageSoundRect];
        }
    }
    else if ([touch view] == OPRateButton) {
        [self rateIsClicked];
        [self resetClicked:OPRateButton fileNameArg:@"RateButton" rectArg:gameModel.optionsPageRateRect];
    }
    else if ([touch view] == OPHelpButton) {
        [self resetClicked:OPHelpButton fileNameArg:@"HelpButton" rectArg:gameModel.optionsPageHelpRect];
        [self paintHelpPage];
    }
    else if ([touch view] == OPCreditsButton) {
        [self dePaintOptionsPage];
        [self drawOptionsCredits];
        [self resetClicked:OPCreditsButton fileNameArg:@"CreditsButton" rectArg:gameModel.optionsPageCreditsRect];
    }
    else if ([touch view] == OPShareButton) {
        [self shareNonReward];
        [self resetClicked:OPShareButton fileNameArg:@"ShareButton" rectArg:gameModel.optionsPageShareRect];
    }
    else if ([touch view] == OPRestoreButton) {
        [self resetClicked:OPRestoreButton fileNameArg:@"Restore_Button" rectArg:gameModel.optionsPageRestoreRect];
        [inAppPurchaseManager restoreCompletedTransactions];
    }
    else if ([touch view] == shareInStickers) {
        [self shareNonReward];
        [self resetClicked:shareInStickers fileNameArg:@"ShareButton" rectArg:gameModel.shareInStickersRect];
    }
    else if ([touch view] == inAppPrice1Image) {
        if ([self isOver999:totalCapsules20] == FALSE) {
            [self makePurchaseCapsules20];
        } else {
            [self alertViewCapsulesOverLimit];
        }
        [self resetClicked:inAppPrice1Image fileNameArg:@"InAppPurchases_Price1" rectArg:gameModel.inAppPrice1Rect];
    }
    else if ([touch view] == inAppPrice2Image) {
        if ([self isOver999:totalCapsules50] == FALSE) {
            [self makePurchaseCapsules50];
        } else {
            [self alertViewCapsulesOverLimit];
        }
        [self resetClicked:inAppPrice2Image fileNameArg:@"InAppPurchases_Price2" rectArg:gameModel.inAppPrice2Rect];
    }
    else if ([touch view] == inAppPrice3Image) {
        //delta
        if ([self isOver999:totalCapsules500] == FALSE) {
            [self makePurchaseCapsules500];
        } else {
            [self alertViewCapsulesOverLimit];
        }
        [self resetClicked:inAppPrice3Image fileNameArg:@"InAppPurchases_Price3" rectArg:gameModel.inAppPrice3Rect];
    }
    else if ([touch view] == inAppPrice4Image) {
        [self depaintInAppPurchasesBoard];
        [self paintFreePurchase];
    }
    else if ([touch view] == freeFacebookImage)
    {
        [self paintAchBoardInPurchases:@"AchShadow_Sleepyhead"];
    }
    else if ([touch view] == achLikePurchase)
    {
        [self facebookLikeIsClicked];
        [self resetClicked:freeFacebookImage fileNameArg:@"Purchase_Facebook_Disabled" rectArg:gameModel.purchaseFacebookRect];
        freeFacebookImage.userInteractionEnabled = NO;
    }
    else if ([touch view] == freeShareImage)
    {
        [self shareNonReward];
        if ([gameModel.prefs boolForKey:@"firstShareDone"] == NO) {
            [gameModel.prefs setBool:YES forKey:@"firstShareDone"];
            [self resetClicked:freeShareImage fileNameArg:@"InAppPurchases_Share" rectArg:gameModel.purchaseShareRect];
        } else {
            [gameModel.prefs setBool:YES forKey:@"shareWithRewards"];
            [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+2 forKey:@"purchase1"];
            [self rewardBoxShare];
            [self updatePurchasedItems];
            [self resetClicked:freeShareImage fileNameArg:@"Purchase_Share_Disabled" rectArg:gameModel.purchaseShareRect];
            freeShareImage.userInteractionEnabled = NO;
        }
    }
    else if ([touch view] == freeRateImage)
    {
        [self paintAchBoardInPurchases:@"AchShadow_InvertedView"];
    }
    else if ([touch view] == achRatePurchase)
    {
        [self rateIsClicked];
        [self resetClicked:freeRateImage fileNameArg:@"Purchase_Rate_Disabled" rectArg:gameModel.purchaseRateRect];
        freeRateImage.userInteractionEnabled = NO;
    }
    else if ([touch view] == notGameplayPurchase)
    {
        [self paintInAppPurchasesBoard];
        [self resetClicked:notGameplayPurchase fileNameArg:@"Purchase_Button" rectArg:gameModel.capsuleAtBottomRight];
    }
    else if ([touch view] == gameplayPurchase)
    {
        [self clearNotifBar];
        [self gameplayPurchaseClicked];
        [self resetClicked:gameplayPurchase fileNameArg:@"Purchase_Button" rectArg:gameModel.gameplayPurchaseRect];
    }
    else if ([touch view] == gameplayHelp)
    {
        [self clearNotifBar];
        [self resetClicked:gameplayHelp fileNameArg:@"Help_RoundButton" rectArg:gameModel.gameplayHelpRect];
        [self paintHelpPage];
    }
    else if ([touch view] == tutorialNextImage)
    {
        [self depaintTutorialBoard];
        [self handleNextInTutorial];
    }
    else if ([touch view] == tutorialNextHelpImage)
    {
        [self depaintTutorialBoard];
        [self handleNextInTutorial:helpBoardTracker];
    }
    else if ([touch view] == tutorialNextHelpForShadowImage)
    {
        [self depaintTutorialBoard];
    }
    else if ([touch view] == backButtonFromHelp) {
        [self depaintHelpPage];
        [self drawCapsuleButton:gameModel.gameplayPurchaseRect];
    }
    else if ([touch view] == helpOrdinary) {
        helpBoardTracker = 1;
        [self displayCertainHelpTutorialPage:1];
    }
    else if ([touch view] == helpArrow) {
        helpBoardTracker = 2;
        [self displayCertainHelpTutorialPage:3];
    }
    else if ([touch view] == helpReversed) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedReversed"] == TRUE) {
            helpBoardTracker = 3;
            [self displayCertainHelpTutorialPage:5];
        } else {
            [self displayCertainHelpShadowPage:3];
        }
    }
    else if ([touch view] == helpSleepy) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedSleepy"] == TRUE) {
            helpBoardTracker = 4;
            [self displayCertainHelpTutorialPage:7];
        } else {
            [self displayCertainHelpShadowPage:4];
        }
    }
    else if ([touch view] == helpDizzy) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedDizzy"] == TRUE) {
            helpBoardTracker = 5;
            [self displayCertainHelpTutorialPage:8];
        } else {
            [self displayCertainHelpShadowPage:5];
        }
    }
    else if ([touch view] == helpFlower) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedFlower"] == TRUE) {
            helpBoardTracker = 6;
            [self displayCertainHelpTutorialPage:10];
        } else {
            [self displayCertainHelpShadowPage:6];
        }
    }
    else if ([touch view] == helpRoman) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedRoman"] == TRUE) {
            helpBoardTracker = 7;
            [self displayCertainHelpTutorialPage:11];
        } else {
            [self displayCertainHelpShadowPage:7];
        }
    }
    else if ([touch view] == helpNinja) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedNinja"] == TRUE) {
            helpBoardTracker = 8;
            [self displayCertainHelpTutorialPage:12];
        } else {
            [self displayCertainHelpShadowPage:8];
        }
    }
    else if ([touch view] == helpIcy) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedIcy"] == TRUE) {
            helpBoardTracker = 9;
            [self displayCertainHelpTutorialPage:13];
        } else {
            [self displayCertainHelpShadowPage:9];
        }
        
        
    }
    else if ([touch view] == helpTwoFace) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedTwoFace"] == TRUE) {
            helpBoardTracker = 10;
            [self displayCertainHelpTutorialPage:14];
        } else {
            [self displayCertainHelpShadowPage:10];
        }
    }
    else if ([touch view] == helpChinese) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedChinese"] == TRUE) {
            helpBoardTracker = 11;
            [self displayCertainHelpTutorialPage:15];
        } else {
            [self displayCertainHelpShadowPage:11];
        }
    }
    else if ([touch view] == helpBroken) {
        if ([gameModel.prefs boolForKey:@"helpUnlockedBroken"] == TRUE) {
            helpBoardTracker = 12;
            [self displayCertainHelpTutorialPage:17];
        } else {
            [self displayCertainHelpShadowPage:12];
        }
    }
    else if ([touch view] == nextAtCongrats) {
        [self dePaintCongratsPage];
        [self drawFinalCredits];
    }
}

-(void)gameplayPurchaseClicked {
    //checkpointPurchase
    //[gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+2 forKey:@"purchase1"];
    
    if ([gameModel.prefs integerForKey:@"purchase1"] <= 0) {
        [self paintInAppPurchasesBoard];
    } else {
        [self sfxCapsulePressed];
        
        [self executeNotifCapsuleAnimation];
        
        [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]-1 forKey:@"purchase1"];
        [self updatePurchasedItems];
        
        NSString* backgroundPath = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
        backgroundCapsule = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
        [backgroundCapsule setFrame:gameModel.fullScreenRect];
        backgroundCapsule.userInteractionEnabled = YES;
        [self.view addSubview:backgroundCapsule];
        
        if (currentLevel.getNumberOfClocks == 2) {
            [self draw2VirtualClocks];
        } else if (currentLevel.getNumberOfClocks == 3) {
            [self draw3VirtualClocks];
        } else if (currentLevel.getNumberOfClocks == 4) {
            [self draw4VirtualClocks];
        } else {
            NSLog(@"Logic error - invalid number of clocks in gameplayPurchaseClicked - vbvxcvzccz\n");
        }
    }
}

-(void)draw2VirtualClocks {
    NSString* framePath = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    twoVirtualFrame = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:framePath]];
    [twoVirtualFrame setFrame:gameModel.twoClocksRect];
    twoVirtualFrame.userInteractionEnabled = YES;
    [self.view addSubview:twoVirtualFrame];
    
    NSString* topPath = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    top2Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topPath]];
    [top2Virtual setFrame:gameModel.top2ClocksRect];
    top2Virtual.userInteractionEnabled = YES;
    [twoVirtualFrame addSubview:top2Virtual];
    
    NSString* bottomPath = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    bottom2Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottomPath]];
    [bottom2Virtual setFrame:gameModel.bottom2ClocksRect];
    bottom2Virtual.userInteractionEnabled = YES;
    [twoVirtualFrame addSubview:bottom2Virtual];
}

-(void)draw3VirtualClocks {
    NSString* framePath = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    threeVirtualFrame = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:framePath]];
    [threeVirtualFrame setFrame:gameModel.threeClocksRect];
    threeVirtualFrame.userInteractionEnabled = YES;
    [self.view addSubview:threeVirtualFrame];
    
    NSString* topLeft3Path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    topLeft3Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topLeft3Path]];
    [topLeft3Virtual setFrame:gameModel.topLeft3Rect];
    topLeft3Virtual.userInteractionEnabled = YES;
    [threeVirtualFrame addSubview:topLeft3Virtual];
    
    NSString* topRight3Path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    topRight3Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topRight3Path]];
    [topRight3Virtual setFrame:gameModel.topRight3Rect];
    topRight3Virtual.userInteractionEnabled = YES;
    [threeVirtualFrame addSubview:topRight3Virtual];
    
    NSString* bottom3Path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    bottom3Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottom3Path]];
    [bottom3Virtual setFrame:gameModel.bottom3Rect];
    bottom3Virtual.userInteractionEnabled = YES;
    [threeVirtualFrame addSubview:bottom3Virtual];
}

-(void)draw4VirtualClocks {
    NSString* framePath = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    fourVirtualFrame = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:framePath]];
    [fourVirtualFrame setFrame:gameModel.fourClocksRect];
    fourVirtualFrame.userInteractionEnabled = YES;
    [self.view addSubview:fourVirtualFrame];
    
    NSString* topLeft4Path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    topLeft4Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topLeft4Path]];
    [topLeft4Virtual setFrame:gameModel.topLeft4Rect];
    topLeft4Virtual.userInteractionEnabled = YES;
    [fourVirtualFrame addSubview:topLeft4Virtual];
    
    NSString* topRight4Path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    topRight4Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:topRight4Path]];
    [topRight4Virtual setFrame:gameModel.topRight4Rect];
    topRight4Virtual.userInteractionEnabled = YES;
    [fourVirtualFrame addSubview:topRight4Virtual];
    
    NSString* bottomRight4Path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    bottomRight4Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottomRight4Path]];
    [bottomRight4Virtual setFrame:gameModel.bottomRight4Rect];
    bottomRight4Virtual.userInteractionEnabled = YES;
    [fourVirtualFrame addSubview:bottomRight4Virtual];
    
    NSString* bottomLeft4Path = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    bottomLeft4Virtual = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bottomLeft4Path]];
    [bottomLeft4Virtual setFrame:gameModel.bottomLeft4Rect];
    bottomLeft4Virtual.userInteractionEnabled = YES;
    [fourVirtualFrame addSubview:bottomLeft4Virtual];
}

-(void)disableUserInteractionAtVirtual {
    top2Virtual.userInteractionEnabled = NO;
    bottom2Virtual.userInteractionEnabled = NO;
    
    topLeft3Virtual.userInteractionEnabled = NO;
    topRight3Virtual.userInteractionEnabled = NO;
    bottom3Virtual.userInteractionEnabled = NO;
    
    topLeft4Virtual.userInteractionEnabled = NO;
    topRight4Virtual.userInteractionEnabled = NO;
    bottomRight4Virtual.userInteractionEnabled = NO;
    bottomLeft4Virtual.userInteractionEnabled = NO;
}

-(void)hideAllVirtual:(NSTimer *) timer {
    [top2Virtual removeFromSuperview];
    [bottom2Virtual removeFromSuperview];
    [twoVirtualFrame removeFromSuperview];
    
    [topLeft3Virtual removeFromSuperview];
    [topRight3Virtual removeFromSuperview];
    [bottom3Virtual removeFromSuperview];
    [threeVirtualFrame removeFromSuperview];
    
    [topLeft4Virtual removeFromSuperview];
    [topRight4Virtual removeFromSuperview];
    [bottomRight4Virtual removeFromSuperview];
    [bottomLeft4Virtual removeFromSuperview];
    [fourVirtualFrame removeFromSuperview];
    
    [backgroundCapsule removeFromSuperview];
    
    top2Virtual = nil;
    bottom2Virtual = nil;
    twoVirtualFrame = nil;
    
    topLeft3Virtual = nil;
    topRight3Virtual = nil;
    bottom3Virtual = nil;
    threeVirtualFrame = nil;
    
    topLeft4Virtual = nil;
    topRight4Virtual = nil;
    bottomRight4Virtual = nil;
    bottomLeft4Virtual = nil;
    fourVirtualFrame = nil;
    
    backgroundCapsule = nil;
}

-(void) enableUserInteractionsInLevel {
    pauseButton.userInteractionEnabled = YES;
    resetButton.userInteractionEnabled = YES;
    gameplayPurchase.userInteractionEnabled = YES;
    gameplayHelp.userInteractionEnabled = YES;
}

//Delegate methods
-(void)eventHandlerThemeButtonDelegate:(int)page {
    [self dePaintThemeMenu];
    
    if (page == 1 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] <= 15) {
        [self paintLevelPage:page subPageArg:1];
    } else if (page == 1 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 15) {
        [self paintLevelPage:page subPageArg:2];
    } else if (page == 2 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] <= 45) {
        [self paintLevelPage:page subPageArg:1];
    } else if (page == 2 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 45) {
        [self paintLevelPage:page subPageArg:2];
    } else if (page == 3 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] <= 75) {
        [self paintLevelPage:page subPageArg:1];
    } else if (page == 3 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 75) {
        [self paintLevelPage:page subPageArg:2];
    } else if (page == 4 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] <= 105) {
        [self paintLevelPage:page subPageArg:1];
    } else if (page == 4 && [gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 105) {
        [self paintLevelPage:page subPageArg:2];
    } else {
        NSLog(@"Logic error - Invalid LKA-6669219");
    }
}

-(void) paintCollectionsPage {
    [self paintlongScroll];
    [scrollView paintCollectionsPage2];
    
    NSString* backPath = [[NSBundle mainBundle] pathForResource:@"BackButton" ofType:@"png"];
    backButtonFromCollections = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backPath]];
    [backButtonFromCollections setFrame:gameModel.backButtonRect];
    backButtonFromCollections.userInteractionEnabled = YES;
    [self.view addSubview:backButtonFromCollections];
    
    NSString* sharePath = [[NSBundle mainBundle] pathForResource:@"ShareButton" ofType:@"png"];
    shareInStickers = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:sharePath]];
    [shareInStickers setFrame:gameModel.shareInStickersRect];
    shareInStickers.userInteractionEnabled = YES;
    [self.view addSubview:shareInStickers];
    
    [self paintTopAchLabel];
}

-(void) paintTopAchLabel {
    NSString* afterPath = [[NSBundle mainBundle] pathForResource:@"AchLabel_9" ofType:@"png"];
    afterSlash = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:afterPath]];
    [afterSlash setFrame:gameModel.afterSlashRect];
    afterSlash.userInteractionEnabled = NO;
    [self.view addSubview:afterSlash];
    
    NSString* slashNumberPath = [[NSBundle mainBundle] pathForResource:@"AchLabel_Slash" ofType:@"png"];
    slashNumber = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:slashNumberPath]];
    [slashNumber setFrame:gameModel.slashNumberRect];
    slashNumber.userInteractionEnabled = NO;
    [self.view addSubview:slashNumber];
    
    NSString* beforeSlashPath = [[NSBundle mainBundle] pathForResource:@"AchLabel_3" ofType:@"png"];
    beforeSlash = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:beforeSlashPath]];
    [beforeSlash setFrame:gameModel.beforeSlashRect];
    beforeSlash.userInteractionEnabled = NO;
    [self.view addSubview:beforeSlash];
    
    [self intToLabelArgIntArg:[gameModel.prefs integerForKey:@"totalStickers"] digitHundredArg:beforeSlash digitTenArg:nil digitOneArg:nil prefixArg:@"AchLabel_"];
    
    NSString* stickersLabelPath = [[NSBundle mainBundle] pathForResource:@"AchLabel_Stickers" ofType:@"png"];
    stickersLabel = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:stickersLabelPath]];
    [stickersLabel setFrame:gameModel.stickersLabelRect];
    stickersLabel.userInteractionEnabled = NO;
    [self.view addSubview:stickersLabel];
}

-(void) depaintCollectionsPage {
    [backButtonFromCollections removeFromSuperview];
    [stickersLabel removeFromSuperview];
    [afterSlash removeFromSuperview];
    [slashNumber removeFromSuperview];
    [beforeSlash removeFromSuperview];
    [shareInStickers removeFromSuperview];
    
    [scrollView depaintCollectionPage2];
    
    backButtonFromCollections = nil;
    stickersLabel = nil;
    slashNumber = nil;
    afterSlash = nil;
    beforeSlash = nil;
    shareInStickers = nil;
    //to be completed
}

-(void) paintlongScroll {
    scrollView=[[ScrollViewController alloc] initWithFrame:gameModel.collectionsLongRect];
    scrollView.myDelegate = self;
    scrollView.gameModel = gameModel;
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * 1.40);
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = YES;
    [self.view addSubview:scrollView];
}

-(void) addStickerBy1 {
    [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"totalStickers"]+1 forKey:@"totalStickers"];
}

-(void) achievementOrdinary {
    //Condition: Complete Theme 1
    if (currentLevel.currentLevel == 30) {
        if ([gameModel.prefs boolForKey:@"achOrdinary"] == FALSE) {
            [gameModel.prefs setBool:TRUE forKey:@"achOrdinary"];
//            [self rewardAllStickersCollected];
            [self addStickerBy1];
            [self hideAchBoard];
            [self paintAchBoardPopUp:@"AchSticker_BeyondOrdinary"];
            printf("achOrd\n");
            
            [self sfxAchievement];
        }
    }
}

-(void) achievementSleepy {
    //Condition: Like FB
    if ([gameModel.prefs boolForKey:@"achSleepy"] == FALSE) {
        [gameModel.prefs setBool:TRUE forKey:@"achSleepy"];
//        [self rewardAllStickersCollected];
        [self addStickerBy1];
        [self hideAchBoard];
        [self paintAchBoardPopUp:@"AchSticker_Sleepyhead"];
        printf("achSle\n");
    }
}

-(void) achievementFlower {
    //Condition: Obtain all stars in Theme 1
    if ([self getTotalStarsT1] >= 60) {
        if ([gameModel.prefs boolForKey:@"achFlower"] == FALSE) {
            [gameModel.prefs setBool:TRUE forKey:@"achFlower"];
//            [self rewardAllStickersCollected];
            [self addStickerBy1];
            [self hideAchBoard];
            [self paintAchBoardPopUp:@"AchSticker_FloralCharm"];
            printf("achFlo\n");
            
            [self sfxAchievement];
        }
    }
}

//-(void) achievementReversed {
//    //Condition: RATE!
//    if ([gameModel.prefs boolForKey:@"achReversed"] == FALSE) {
//        [gameModel.prefs setBool:TRUE forKey:@"achReversed"];
////        [self rewardAllStickersCollected];
//        [self addStickerBy1];
//        [self hideAchBoard];
//        [self paintAchBoardPopUp:@"AchSticker_InvertedView"];
//        printf("achRev\n");
//    }
//}

-(void) achievementIcy {
    //Condition: Obtain all stars in Theme 2
    if ([self getTotalStarsT2] >= 60) {
        if ([gameModel.prefs boolForKey:@"achIcy"] == FALSE) {
            [gameModel.prefs setBool:TRUE forKey:@"achIcy"];
//            [self rewardAllStickersCollected];
            [self addStickerBy1];
            [self hideAchBoard];
            [self paintAchBoardPopUp:@"AchSticker_ChillySeason"];
            printf("achIcy\n");
            
            [self sfxAchievement];
        }
    }
}

-(void) achievementAngel {
    //Condition: Obtain all stars in Theme 3
    if ([self getTotalStarsT3] >= 60) {
        if ([gameModel.prefs boolForKey:@"achAngel"] == FALSE) {
            [gameModel.prefs setBool:TRUE forKey:@"achAngel"];
//            [self rewardAllStickersCollected];
            [self addStickerBy1];
            [self hideAchBoard];
            [self paintAchBoardPopUp:@"AchSticker_AngelsGift"];
            printf("achAngel\n");
            
            [self sfxAchievement];
        }
    }
}

-(void) achievementChinese {
    //Condition: Obtain all stars in Theme 4
    if ([self getTotalStarsT4] >= 60) {
        if ([gameModel.prefs boolForKey:@"achChinese"] == FALSE) {
            [gameModel.prefs setBool:TRUE forKey:@"achChinese"];
//            [self rewardAllStickersCollected];
            [self addStickerBy1];
            [self hideAchBoard];
            [self paintAchBoardPopUp:@"AchSticker_NewYearsEve"];
            printf("achChinese\n");
            
            [self sfxAchievement];
        }
    }
}

-(void) achievementNinja {
    //Condition: Last hit by ninja on the 11th step (Clue: level 69)
    if (currentLevel.steps == 11 && [lastHit isEqual: @"ninja"]) {
        if ([gameModel.prefs boolForKey:@"achNinja"] == FALSE) {
            [gameModel.prefs setBool:TRUE forKey:@"achNinja"];
//            [self rewardAllStickersCollected];
            [self addStickerBy1];
            [self hideAchBoard];
            [self paintAchBoardPopUp:@"AchSticker_TheArtOfNinja"];
            printf("achNinja\n");
            
            [self sfxAchievement];
        }
    }
}

-(void) achievementDevil {
    //Condition: Explode an arrow when a demon is pointing 12
    //Execute this function while checking for boom (check for boom beforehand)
    //If boom, then this function is called
    
    switch (currentLevel.getNumberOfClocks) {
        case 2:
            //[self handle2FaceInTwo];
            [self checkDevilAch];
            break;
        case 3:
            //[self handle2FaceInThree];
            [self checkDevilAch];
            break;
        case 4:
            //[self handle2FaceInFour];
            [self checkDevilAch];
            break;
        default:
            NSLog(@"Logic Error: Max number of clocks exceeded");
            break;
    }
}

-(void) handle2FaceInTwo {
    
}

//-(void) handle2FaceInTwo {
//    if ([[self getClockTypePureString:UP_2CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    } else if ([[self getClockTypePureString:BOTTOM_2CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock2Bottom checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    }
//}

-(void) checkDevilAch {
    if ([gameModel.prefs boolForKey:@"achDevil"] == FALSE) {
        [gameModel.prefs setBool:TRUE forKey:@"achDevil"];
//        [self rewardAllStickersCollected];
        [self addStickerBy1];
        [self hideAchBoard];
        [self paintAchBoardPopUp:@"AchSticker_DemonsHunter"];
        printf("achDevil\n");
        
        [self sfxAchievement];
    }
}

//-(void) handle2FaceInFour {
//    if ([[self getClockTypePureString:TOPLEFT_4CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock4TopLeft checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    } else if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock4TopRight checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    } else if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock4BottomRight checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    } else if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock4BottomLeft checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    }
//}
//
//-(void) handle2FaceInThree {
//    if ([[self getClockTypePureString:TOPLEFT_3CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock3TopLeft checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    } else if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock3TopRight checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    } else if ([[self getClockTypePureString:BOTTOM_3CLOCKS] isEqual:@"twoface"]) {
//        if ([tempClock3Bottom checkTwelveButDemon] == YES) {
//            [self checkDevilAch];
//        }
//    }
//}

-(void) paintAchBoard:(NSString*) fileName {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackAch = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackAch setFrame:gameModel.backgroundRect];
    opacityBlackAch.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackAch];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    achBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [achBoardImage setFrame:gameModel.achBoardRect];
    achBoardImage.userInteractionEnabled = YES;
    [opacityBlackAch addSubview:achBoardImage];
    
    NSString* achBackPath = [[NSBundle mainBundle] pathForResource:@"AchShadow_BackButton" ofType:@"png"];
    achBackImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achBackPath]];
    [achBackImage setFrame:gameModel.backAchBoardRect];
    achBackImage.userInteractionEnabled = YES;
    [achBoardImage addSubview:achBackImage];
    
    NSString* achLikeRatePath;
    if ([fileName isEqualToString:@"AchShadow_InvertedView"]) {
        achLikeRatePath = [[NSBundle mainBundle] pathForResource:@"AchShadow_RateButton" ofType:@"png"];
        achRateImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achLikeRatePath]];
        [achRateImage setFrame:gameModel.rateAndLikeRect];
        achRateImage.userInteractionEnabled = YES;
        [achBoardImage addSubview:achRateImage];
    } else if ([fileName isEqualToString:@"AchShadow_Sleepyhead"]) {
        achLikeRatePath = [[NSBundle mainBundle] pathForResource:@"AchShadow_FbButton" ofType:@"png"];
        achLikeImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achLikeRatePath]];
        [achLikeImage setFrame:gameModel.rateAndLikeRect];
        achLikeImage.userInteractionEnabled = YES;
        [achBoardImage addSubview:achLikeImage];
    }
}

-(void) paintAchBoardInPurchases:(NSString*) fileName {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackAch = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackAch setFrame:gameModel.backgroundRect];
    opacityBlackAch.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackAch];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    achBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [achBoardImage setFrame:gameModel.achBoardRect];
    achBoardImage.userInteractionEnabled = YES;
    [opacityBlackAch addSubview:achBoardImage];
    
    NSString* achBackPath = [[NSBundle mainBundle] pathForResource:@"AchShadow_BackButton" ofType:@"png"];
    achBackImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achBackPath]];
    [achBackImage setFrame:gameModel.backAchBoardRect];
    achBackImage.userInteractionEnabled = YES;
    [achBoardImage addSubview:achBackImage];
    
    NSString* achLikeRatePath;
    if ([fileName isEqualToString:@"AchShadow_InvertedView"]) {
        achLikeRatePath = [[NSBundle mainBundle] pathForResource:@"AchShadow_RateButton" ofType:@"png"];
        achRatePurchase = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achLikeRatePath]];
        [achRatePurchase setFrame:gameModel.rateAndLikeRect];
        achRatePurchase.userInteractionEnabled = YES;
        [achBoardImage addSubview:achRatePurchase];
    } else if ([fileName isEqualToString:@"AchShadow_Sleepyhead"]) {
        achLikeRatePath = [[NSBundle mainBundle] pathForResource:@"AchShadow_FbButton" ofType:@"png"];
        achLikePurchase = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achLikeRatePath]];
        [achLikePurchase setFrame:gameModel.rateAndLikeRect];
        achLikePurchase.userInteractionEnabled = YES;
        [achBoardImage addSubview:achLikePurchase];
    }
}

-(void) paintAchBoardPopUp:(NSString*) fileName {
    //opacity file might be changed
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackAch = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackAch setFrame:gameModel.backgroundRect];
    opacityBlackAch.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackAch];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    achBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [achBoardImage setFrame:gameModel.achBoardRect];
    achBoardImage.userInteractionEnabled = YES;
    [opacityBlackAch addSubview:achBoardImage];
    
    NSString* bannerPath = [[NSBundle mainBundle] pathForResource:@"Banner_AchUnlocked" ofType:@"png"];
    achBannerImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:bannerPath]];
    [achBannerImage setFrame:gameModel.achBannerRect];
    achBannerImage.userInteractionEnabled = NO;;
    [achBoardImage addSubview:achBannerImage];
    
    NSString* achBackPath = [[NSBundle mainBundle] pathForResource:@"AchShadow_BackButton" ofType:@"png"];
    achBackImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achBackPath]];
    [achBackImage setFrame:gameModel.backAchBoardRect];
    achBackImage.userInteractionEnabled = YES;
    [achBoardImage addSubview:achBackImage];
}

-(void) hideAchBoard {
    [achBackImage removeFromSuperview];
    [achBannerImage removeFromSuperview];
    [achBoardImage removeFromSuperview];
    [opacityBlackAch removeFromSuperview];
    [scrollView achInteractionEnable];
    
    achBackImage = nil;
    achBoardImage = nil;
    opacityBlackAch = nil;
}

//to be tested
- (void)gotoReviews:(id)sender
{
    NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
    str = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", str];
    str = [NSString stringWithFormat:@"%@type=Purple+Software&id=", str];
    
    // Here is the app id from itunesconnect
    str = [NSString stringWithFormat:@"%@764927175", str]; //<--This is real, for later use
    
//    str = [NSString stringWithFormat:@"%@474785950", str]; //<--iRuler Apple ID, TEST ONLY! CHANGE LATER!!
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void) paintInAppPurchasesBoard {
    //opacity file might be changed
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackInApp = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackInApp setFrame:gameModel.backgroundRect];
    opacityBlackInApp.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackInApp];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Board" ofType:@"png"];
    inAppBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [inAppBoardImage setFrame:gameModel.achBoardRect];
    inAppBoardImage.userInteractionEnabled = YES;
    [opacityBlackInApp addSubview:inAppBoardImage];
    
    NSString* price1Path = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Price1" ofType:@"png"];
    inAppPrice1Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:price1Path]];
    [inAppPrice1Image setFrame:gameModel.inAppPrice1Rect];
    inAppPrice1Image.userInteractionEnabled = YES;
    [inAppBoardImage addSubview:inAppPrice1Image];
    
    NSString* price2Path = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Price2" ofType:@"png"];
    inAppPrice2Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:price2Path]];
    [inAppPrice2Image setFrame:gameModel.inAppPrice2Rect];
    inAppPrice2Image.userInteractionEnabled = YES;
    [inAppBoardImage addSubview:inAppPrice2Image];
    
    NSString* price3Path = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Price3" ofType:@"png"];
    inAppPrice3Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:price3Path]];
    [inAppPrice3Image setFrame:gameModel.inAppPrice3Rect];
    inAppPrice3Image.userInteractionEnabled = YES;
    [inAppBoardImage addSubview:inAppPrice3Image];
    
//    if ([gameModel.prefs boolForKey:@"facebookLike"] == YES && [gameModel.prefs boolForKey:@"shareWithRewards"] == YES && [gameModel.prefs boolForKey:@"rateClicked"] == YES) {

    if ([gameModel.prefs boolForKey:@"facebookLike"] == YES && [gameModel.prefs boolForKey:@"shareWithRewards"] == YES) {
        
        NSString* price4Path = [[NSBundle mainBundle] pathForResource:@"Purchase_Free_Disabled" ofType:@"png"];
        inAppPrice4Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:price4Path]];
        [inAppPrice4Image setFrame:gameModel.inAppPrice4Rect];
        inAppPrice4Image.userInteractionEnabled = NO;
        [inAppBoardImage addSubview:inAppPrice4Image];
    } else {
        NSString* price4Path = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Price0" ofType:@"png"];
        inAppPrice4Image = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:price4Path]];
        [inAppPrice4Image setFrame:gameModel.inAppPrice4Rect];
        inAppPrice4Image.userInteractionEnabled = YES;
        [inAppBoardImage addSubview:inAppPrice4Image];
    }
    
    NSString* closePath = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Close" ofType:@"png"];
    inAppCloseImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:closePath]];
    [inAppCloseImage setFrame:gameModel.inAppCloseRect];
    inAppCloseImage.userInteractionEnabled = YES;
    [inAppBoardImage addSubview:inAppCloseImage];
}

-(void) depaintInAppPurchasesBoard {
    [inAppCloseImage removeFromSuperview];
    [inAppPrice1Image removeFromSuperview];
    [inAppPrice2Image removeFromSuperview];
    [inAppPrice3Image removeFromSuperview];
    [inAppPrice4Image removeFromSuperview];
    [inAppBoardImage removeFromSuperview];
    [opacityBlackInApp removeFromSuperview];
    
    inAppCloseImage = nil;
    inAppPrice1Image = nil;
    inAppPrice2Image = nil;
    inAppPrice3Image = nil;
    inAppPrice4Image = nil;
    inAppBoardImage = nil;
    opacityBlackInApp = nil;
}

-(void) paintFreePurchase {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-2" ofType:@"png"];
    opacityBlackInApp = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [opacityBlackInApp setFrame:gameModel.backgroundRect];
    opacityBlackInApp.userInteractionEnabled = YES;
    [self.view addSubview:opacityBlackInApp];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:@"FreePurchases_Board" ofType:@"png"];
    inAppBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [inAppBoardImage setFrame:gameModel.achBoardRect];
    inAppBoardImage.userInteractionEnabled = YES;
    [opacityBlackInApp addSubview:inAppBoardImage];
    
    if ([gameModel.prefs boolForKey:@"facebookLike"] == NO) {
        NSString* facebookPath = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Facebook" ofType:@"png"];
        freeFacebookImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:facebookPath]];
        [freeFacebookImage setFrame:gameModel.purchaseFacebookRect];
        freeFacebookImage.userInteractionEnabled = YES;
        [inAppBoardImage addSubview:freeFacebookImage];
    } else {
        NSString* facebookPath = [[NSBundle mainBundle] pathForResource:@"Purchase_Facebook_Disabled" ofType:@"png"];
        freeFacebookImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:facebookPath]];
        [freeFacebookImage setFrame:gameModel.purchaseFacebookRect];
        freeFacebookImage.userInteractionEnabled = NO;
        [inAppBoardImage addSubview:freeFacebookImage];
    }
    
    if ([gameModel.prefs boolForKey:@"shareWithRewards"] == NO) {
        NSString* sharePath = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Share" ofType:@"png"];
        freeShareImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:sharePath]];
        [freeShareImage setFrame:gameModel.purchaseShareRect];
        freeShareImage.userInteractionEnabled = YES;
        [inAppBoardImage addSubview:freeShareImage];
    } else {
        NSString* sharePath = [[NSBundle mainBundle] pathForResource:@"Purchase_Share_Disabled" ofType:@"png"];
        freeShareImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:sharePath]];
        [freeShareImage setFrame:gameModel.purchaseShareRect];
        freeShareImage.userInteractionEnabled = NO;
        [inAppBoardImage addSubview:freeShareImage];
    }
    
//    if ([gameModel.prefs boolForKey:@"rateClicked"] == NO) {
//        NSString* ratePath = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Rate" ofType:@"png"];
//        freeRateImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:ratePath]];
//        [freeRateImage setFrame:gameModel.purchaseRateRect];
//        freeRateImage.userInteractionEnabled = YES;
//        [inAppBoardImage addSubview:freeRateImage];
//    } else {
//        NSString* ratePath = [[NSBundle mainBundle] pathForResource:@"Purchase_Rate_Disabled" ofType:@"png"];
//        freeRateImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:ratePath]];
//        [freeRateImage setFrame:gameModel.purchaseRateRect];
//        freeRateImage.userInteractionEnabled = NO;
//        [inAppBoardImage addSubview:freeRateImage];
//    }
    
    NSString* closePath = [[NSBundle mainBundle] pathForResource:@"InAppPurchases_Close" ofType:@"png"];
    freeCloseImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:closePath]];
    [freeCloseImage setFrame:gameModel.inAppCloseRect];
    freeCloseImage.userInteractionEnabled = YES;
    [inAppBoardImage addSubview:freeCloseImage];
}

-(void) depaintFreePurchase {
    [freeCloseImage removeFromSuperview];
    [freeRateImage removeFromSuperview];
    [freeShareImage removeFromSuperview];
    [freeFacebookImage removeFromSuperview];
    [inAppBoardImage removeFromSuperview];
    [opacityBlackInApp removeFromSuperview];
    
    freeCloseImage = nil;
    freeRateImage = nil;
    freeShareImage = nil;
    freeFacebookImage = nil;
    inAppBoardImage = nil;
    opacityBlackInApp = nil;
}

-(void) localNotification {
    [self cancelLocalNotification];
    
    localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:259200]; //<-- 259200 secs = 72 hours = 3 days
    localNotification.alertBody = @"Your clocks want to play with you! Go visit them.";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    localNotification2 = [[UILocalNotification alloc] init];
    localNotification2.fireDate = [NSDate dateWithTimeIntervalSinceNow:518401]; //<-- 518400 secs = 144 hours = 6 days
    localNotification2.alertBody = @"Don't leave your clocks alone! Go visit them.";
    localNotification2.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification2];
}

-(void) cancelLocalNotification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    localNotification = nil;
    localNotification2 = nil;
}

-(void) shareNonReward {
    [[FacebookScorer sharedInstance] postToWallWithDialogNewHighscore:0];
}

-(void) paintTotalStars {
    NSString* starPath = [[NSBundle mainBundle] pathForResource:@"FullStar_Small" ofType:@"png"];
    totalStarImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:starPath]];
    [totalStarImage setFrame:gameModel.totalStarImageRect];
    [self.view addSubview:totalStarImage];
    
    NSString* r1Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_0" ofType:@"png"];
    totalAfterSlash1 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:r1Path]];
    [totalAfterSlash1 setFrame:gameModel.totalDigitOneRRect];
    [self.view addSubview:totalAfterSlash1];
    
    NSString* r10Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_4" ofType:@"png"];
    totalAfterSlash10 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:r10Path]];
    [totalAfterSlash10 setFrame:gameModel.totalDigitTenRRect];
    [self.view addSubview:totalAfterSlash10];
    
    NSString* r100Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_2" ofType:@"png"];
    totalAfterSlash100 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:r100Path]];
    [totalAfterSlash100 setFrame:gameModel.totalDigitHundredRRect];
    [self.view addSubview:totalAfterSlash100];
    
    NSString* slashPath = [[NSBundle mainBundle] pathForResource:@"Total_Slash" ofType:@"png"];
    totalSlashImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:slashPath]];
    [totalSlashImage setFrame:gameModel.totalSlashRect];
    [self.view addSubview:totalSlashImage];
    
    NSString* l1Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_0" ofType:@"png"];
    totalBeforeSlash1 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:l1Path]];
    [totalBeforeSlash1 setFrame:gameModel.totalDigitOneLRect];
    [self.view addSubview:totalBeforeSlash1];
    
    NSString* l10Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_0" ofType:@"png"];
    totalBeforeSlash10 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:l10Path]];
    [totalBeforeSlash10 setFrame:gameModel.totalDigitTenLRect];
    [self.view addSubview:totalBeforeSlash10];
    
    NSString* l100Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_purchaseitem_0" ofType:@"png"];
    totalBeforeSlash100 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:l100Path]];
    [totalBeforeSlash100 setFrame:gameModel.totalDigitHundredLRect];
    [self.view addSubview:totalBeforeSlash100];
    
    [self intToLabelReversedArgIntArg:[self getTotalStars] digitHundredArg:totalBeforeSlash100 digitTenArg:totalBeforeSlash10 digitOneArg:totalBeforeSlash1 prefixArg:@"NUMBER_purchaseitem_"];
}

-(void) depaintTotalStars {
    [totalStarImage removeFromSuperview];
    [totalAfterSlash1 removeFromSuperview];
    [totalAfterSlash10 removeFromSuperview];
    [totalAfterSlash100 removeFromSuperview];
    [totalSlashImage removeFromSuperview];
    [totalBeforeSlash1 removeFromSuperview];
    [totalBeforeSlash10 removeFromSuperview];
    [totalBeforeSlash100 removeFromSuperview];
    
    totalStarImage = nil;
    totalAfterSlash1 = nil;
    totalAfterSlash10 = nil;
    totalAfterSlash100 = nil;
    totalSlashImage = nil;
    totalBeforeSlash1 = nil;
    totalBeforeSlash10 = nil;
    totalBeforeSlash100 = nil;
}

-(void) resetAnimationCounter {
    ordinaryCounter = 0;
    reversedCounter = 0;
    sleepyCounter = 0;
    dizzyCounter = 0;
    flowerCounter = 0;
    romanCounter = 0;
    ninjaCounter = 0;
    icyCounter = 0;
    twoFaceCounter = 0;
    chineseCounter = 0;
    brokenCounter = 0;
}

-(void)getShortAnimationImages:(NSMutableArray*)animationParam
                             isForwardArg:(BOOL)isForwardParam
                              toNumberArg:(int)toNumberParam {
    
    if (isForwardParam == YES) {
        switch (toNumberParam) {
            case 1:
                for (int i=2; i<=3; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 2:
                for (int i=4; i<=5; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 3:
                for (int i=6; i<=7; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 4:
                for (int i=8; i<=9; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 5:
                for (int i=10; i<=11; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 6:
                for (int i=12; i<=13; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 7:
                for (int i=14; i<=15; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 8:
                for (int i=16; i<=17; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 9:
                for (int i=18; i<=19; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 10:
                for (int i=20; i<=21; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 11:
                for (int i=22; i<=23; i++) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 12:
                [tempAnimArray addObject:[animationParam objectAtIndex:24-1]];
                [tempAnimArray addObject:[animationParam objectAtIndex:1-1]];
                break;
                
            default:
                NSLog(@"Logic error - invalid toNumberParam h0n237b");
                break;
        }
    } else {
        switch (toNumberParam) {
            case 1:
                for (int i=4; i>=3; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 2:
                for (int i=6; i>=5; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 3:
                for (int i=8; i>=7; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 4:
                for (int i=10; i>=9; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 5:
                for (int i=12; i>=11; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 6:
                for (int i=14; i>=13; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 7:
                for (int i=16; i>=15; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 8:
                for (int i=18; i>=17; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 9:
                for (int i=20; i>=19; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 10:
                for (int i=22; i>=21; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 11:
                for (int i=24; i>=23; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            case 12:
                for (int i=2; i>=1; i--) {
                    [tempAnimArray addObject:[animationParam objectAtIndex:i-1]];
                }
                break;
                
            default:
                NSLog(@"Logic error - invalid toNumberParam 2s342");
                break;
        }
    }
}

-(void) setRectToFlash:(UIImageView*) clockImage
      clockPositionArg:(int)clockPositionParam {
    
    if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"regular"]) {
        [clockImage setFrame:gameModel.ordinaryFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"reversed"]) {
        [clockImage setFrame:gameModel.reversedFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"sleepyclock"]) {
        [clockImage setFrame:gameModel.sleepyFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"dizzy"]) {
        [clockImage setFrame:gameModel.dizzyFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"lazyflower"]) {
        [clockImage setFrame:gameModel.flowerFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"roman"]) {
        [clockImage setFrame:gameModel.romanFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"ninja"]) {
        [clockImage setFrame:gameModel.ninjaFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"void"]) {
        [clockImage setFrame:gameModel.icyFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"twoface"]) {
        [clockImage setFrame:gameModel.twoFaceFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"chinese"]) {
        [clockImage setFrame:gameModel.chineseFlashRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"broken"]) {
        [clockImage setFrame:gameModel.brokenFlashRect];
    }
}

-(void) animateEating:(int)numberOfClocks
     clockPositionArg:(int)clockPositionParam {
    
    if (numberOfClocks == 2) {
        switch (clockPositionParam) {
            case UP_2CLOCKS:
                top2Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                top2Virtual.animationDuration = eatingAnimDuration;
                top2Virtual.animationRepeatCount = 1;
                [top2Virtual startAnimating];
                break;
                
            case BOTTOM_2CLOCKS:
                bottom2Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                bottom2Virtual.animationDuration = eatingAnimDuration;
                bottom2Virtual.animationRepeatCount = 1;
                [bottom2Virtual startAnimating];
                break;
                
            default:
                NSLog(@"Logic error - Invalid switch-case at animateEating - 2");
                break;
        }
    } else if (numberOfClocks == 3) {
        switch (clockPositionParam) {
            case TOPLEFT_3CLOCKS:
                topLeft3Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                topLeft3Virtual.animationDuration = eatingAnimDuration;
                topLeft3Virtual.animationRepeatCount = 1;
                [topLeft3Virtual startAnimating];
                break;
                
            case TOPRIGHT_3CLOCKS:
                topRight3Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                topRight3Virtual.animationDuration = eatingAnimDuration;
                topRight3Virtual.animationRepeatCount = 1;
                [topRight3Virtual startAnimating];
                break;
                
            case BOTTOM_3CLOCKS:
                bottom3Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                bottom3Virtual.animationDuration = eatingAnimDuration;
                bottom3Virtual.animationRepeatCount = 1;
                [bottom3Virtual startAnimating];
                break;
                
            default:
                NSLog(@"Logic error - Invalid switch-case at animateEating - 3");
                break;
        }
    } else if (numberOfClocks == 4) {
        switch (clockPositionParam) {
            case TOPLEFT_4CLOCKS:
                topLeft4Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                topLeft4Virtual.animationDuration = eatingAnimDuration;
                topLeft4Virtual.animationRepeatCount = 1;
                [topLeft4Virtual startAnimating];
                break;
                
            case TOPRIGHT_4CLOCKS:
                topRight4Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                topRight4Virtual.animationDuration = eatingAnimDuration;
                topRight4Virtual.animationRepeatCount = 1;
                [topRight4Virtual startAnimating];
                break;
                
            case BOTTOMRIGHT_4CLOCKS:
                bottomRight4Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                bottomRight4Virtual.animationDuration = eatingAnimDuration;
                bottomRight4Virtual.animationRepeatCount = 1;
                [bottomRight4Virtual startAnimating];
                break;
                
            case BOTTOMLEFT_4CLOCKS:
                bottomLeft4Virtual.animationImages = [self returnEatingAnim:[self getClockTypePureString:clockPositionParam]];
                bottomLeft4Virtual.animationDuration = eatingAnimDuration;
                bottomLeft4Virtual.animationRepeatCount = 1;
                [bottomLeft4Virtual startAnimating];
                break;
                
            default:
                NSLog(@"Logic error - Invalid switch-case at animateEating - 4");
                break;
        }
    }
}

-(void) animateFlash:(int)numberOfClocks
    clockPositionArg:(int)clockPositionParam
     leftIs1RightIs2:(int)leftIs1RightIs2Param {
    
    if (numberOfClocks == 2) {
        switch (clockPositionParam) {
            case UP_2CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash2TopImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        //flash2TopImage.animationImages = clockFlashLeft;
                        flash2TopImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        //flash2TopImage.animationImages = clockFlashRight;
                        flash2TopImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 1");
                    }
                }
                flash2TopImage.animationDuration = 0.1;
                flash2TopImage.animationRepeatCount = 1;
                [flash2TopImage startAnimating];
                break;
                
            case BOTTOM_2CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash2BottomImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash2BottomImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];;
                    } else if (leftIs1RightIs2Param == 2) {
                        flash2BottomImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];;
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 2");
                    }
                }
                flash2BottomImage.animationDuration = 0.1;
                flash2BottomImage.animationRepeatCount = 1;
                [flash2BottomImage startAnimating];
                break;
                
            default:
                NSLog(@"Logic error - Invalid switch-case at animateFlash - 3");
                break;
        }
    } else if (numberOfClocks == 3) {
        switch (clockPositionParam) {
            case TOPLEFT_3CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash3TLImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash3TLImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        flash3TLImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 4");
                    }
                }
                flash3TLImage.animationDuration = 0.1;
                flash3TLImage.animationRepeatCount = 1;
                [flash3TLImage startAnimating];
                break;
                
            case TOPRIGHT_3CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash3TRImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash3TRImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        flash3TRImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 5");
                    }
                }
                flash3TRImage.animationDuration = 0.1;
                flash3TRImage.animationRepeatCount = 1;
                [flash3TRImage startAnimating];
                break;
                
            case BOTTOM_3CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash3BImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash3BImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        flash3BImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 6");
                    }
                }
                flash3BImage.animationDuration = 0.1;
                flash3BImage.animationRepeatCount = 1;
                [flash3BImage startAnimating];
                break;
                
            default:
                NSLog(@"Logic error - Invalid switch-case at animateFlash - 7");
                break;
        }
    } else if (numberOfClocks == 4) {
        switch (clockPositionParam) {
            case TOPLEFT_4CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash4TLImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash4TLImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        flash4TLImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 8");
                    }
                }
                flash4TLImage.animationDuration = 0.1;
                flash4TLImage.animationRepeatCount = 1;
                [flash4TLImage startAnimating];
                break;
                
            case TOPRIGHT_4CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash4TRImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash4TRImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        flash4TRImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 9");
                    }
                }
                flash4TRImage.animationDuration = 0.1;
                flash4TRImage.animationRepeatCount = 1;
                [flash4TRImage startAnimating];
                break;
                
            case BOTTOMRIGHT_4CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash4BRImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash4BRImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        flash4BRImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 10");
                    }
                }
                flash4BRImage.animationDuration = 0.1;
                flash4BRImage.animationRepeatCount = 1;
                [flash4BRImage startAnimating];
                break;
                
            case BOTTOMLEFT_4CLOCKS:
                if ([self isFull:[self getClockTypePureString:clockPositionParam]]) {
                    flash4BLImage.animationImages = [self returnFullFlash:[self getClockTypePureString:clockPositionParam]];
                } else {
                    if (leftIs1RightIs2Param == 1) {
                        flash4BLImage.animationImages = [self returnLeftFlash:[self getClockTypePureString:clockPositionParam]];
                    } else if (leftIs1RightIs2Param == 2) {
                        flash4BLImage.animationImages = [self returnRightFlash:[self getClockTypePureString:clockPositionParam]];
                    } else {
                        NSLog(@"Logic error - Invalid switch-case at animateFlash - 11");
                    }
                }
                flash4BLImage.animationDuration = 0.1;
                flash4BLImage.animationRepeatCount = 1;
                [flash4BLImage startAnimating];
                break;
                
            default:
                NSLog(@"Logic error - Invalid switch-case at animateFlash - 12");
                break;
        }
    } else {
        NSLog(@"Logic error - Invalid numberOfClocks at animateFlash");
    }
}

-(BOOL)isFull:(NSString*)clockType {
    if ([clockType  isEqual: @"sleepyclock"]) {
        return YES;
    } else if ([clockType  isEqual: @"dizzy"]) {
        return YES;
    } else if ([clockType  isEqual: @"ninja"]) {
        return YES;
    } else if ([clockType  isEqual: @"void"]) {
        return YES;
    } else {
        return NO;
    }
}

-(NSMutableArray*)returnFullFlash:(NSString*)clockType {
    if ([clockType  isEqual: @"sleepyclock"]) {
        return sleepyFlashFull;
    } else if ([clockType  isEqual: @"ninja"]) {
        return ninjaFlashFull;
    } else if ([clockType  isEqual: @"dizzy"]) {
        return dizzyFlashFull;
    } else if ([clockType  isEqual: @"void"]) {
        return icyFlashFull;
    }
}

-(NSMutableArray*)returnLeftFlash:(NSString*)clockType {
    if ([clockType  isEqual: @"regular"]) {
        return ordinaryFlashLeft;
    } else if ([clockType  isEqual: @"reversed"]) {
        return reversedFlashLeft;
    } else if ([clockType  isEqual: @"lazyflower"]) {
        return flowerFlashLeft;
    } else if ([clockType  isEqual: @"roman"]) {
        return romanFlashLeft;
    } else if ([clockType  isEqual: @"twoface"]) {
        return devilFlashLeft;
    } else if ([clockType  isEqual: @"chinese"]) {
        return chineseFlashLeft;
    } else if ([clockType  isEqual: @"broken"]) {
        return brokenFlashLeft;
    } else {
        NSLog(@"Logic error - invalid clockType in returnLeftFlash - xgxv53\n");
    }
}

-(NSMutableArray*)returnRightFlash:(NSString*)clockType {
    if ([clockType  isEqual: @"regular"]) {
        return ordinaryFlashRight;
    } else if ([clockType  isEqual: @"reversed"]) {
        return reversedFlashRight;
    } else if ([clockType  isEqual: @"lazyflower"]) {
        return flowerFlashRight;
    } else if ([clockType  isEqual: @"roman"]) {
        return romanFlashRight;
    } else if ([clockType  isEqual: @"twoface"]) {
        return devilFlashRight;
    } else if ([clockType  isEqual: @"chinese"]) {
        return chineseFlashRight;
    } else if ([clockType  isEqual: @"broken"]) {
        return brokenFlashRight;
    } else {
        NSLog(@"Logic error - invalid clockType in returnRightFlash - xg4453\n");
    }
}

-(NSString*)getShortHandName:(int)pointing
            clockLocationArg:(int)clockLocationParam {
    
//    int i;
//    if (pointing == 12) i=1;
//    else i=pointing*2+1;
    NSString *fileName;
    
    if ([[self getClockTypePureString:clockLocationParam] isEqual: @"regular"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Regular_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Regular_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"reversed"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Reversed_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Reversed_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"sleepyclock"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Sleepy_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Sleepy_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"dizzy"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Dizzy_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Dizzy_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"lazyflower"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Flower_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Flower_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"roman"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Roman_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Roman_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"ninja"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Ninja_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Ninja_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"void"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Icy_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Icy_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"twoface"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Devil_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Devil_Short_1" ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"chinese"]) {
        //fileName = [NSString stringWithFormat: @"Arrow_Chinese_Short_1.png"];
        fileName = [[NSBundle mainBundle] pathForResource:@"Arrow_Chinese_Short_1" ofType:@"png"];
    }
    
    return fileName;
}

-(NSString*)getLongHandName:(int)number
           clockLocationArg:(int)clockLocationParam {
    
    //[NSString stringWithFormat: @"C-CHINESE_262px_KANJI-%i", counter];
    
    NSString *fileName;
    
    if ([[self getClockTypePureString:clockLocationParam] isEqual: @"regular"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"reversed"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Reversed_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"sleepyclock"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Sleepy_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"dizzy"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"lazyflower"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"roman"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Roman_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"ninja"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Ninja_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"void"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"twoface"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Devil_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"broken"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"chinese"]) {
        
    } else {
        NSLog(@"Logic error - bsvuycfsdbsvvxu75\n");
    }
    
    return fileName;
}

-(void)getProperShortAnimation:(Clock*)clockParameter {
    //clean up array
    //    for (int i=tempShortFullAnim.count-1;i>=0;i--) {
    //        if([tempShortFullAnim objectAtIndex:i]) [tempShortFullAnim removeObjectAtIndex:i];
    //    }
    
    //to be completed
    if ([clockParameter.type  isEqual: @"regular"]) {
        tempShortFullAnim = shortOrdinaryForwardAnim;
    } else if ([clockParameter.type  isEqual: @"reversed"]) {
        tempShortFullAnim = shortReversedForwardAnim;
    } else if ([clockParameter.type  isEqual: @"sleepyclock"]) {
        tempShortFullAnim = shortSleepyForwardAnim;
    } else if ([clockParameter.type  isEqual: @"dizzy"]) {
        tempShortFullAnim = shortDizzyForwardAnim;
    } else if ([clockParameter.type  isEqual: @"lazyflower"]) {
        tempShortFullAnim = shortFlowerForwardAnim;
    } else if ([clockParameter.type  isEqual: @"roman"]) {
        tempShortFullAnim = shortRomanForwardAnim;
    } else if ([clockParameter.type  isEqual: @"ninja"]) {
        tempShortFullAnim = shortNinjaForwardAnim;
    } else if ([clockParameter.type  isEqual: @"void"]) {
        tempShortFullAnim = shortIcyForwardAnim;
    } else if ([clockParameter.type  isEqual: @"twoface"]) {
        TwoFace *temp2Face = clockParameter;
        if (temp2Face.state == angelState) {
            tempShortFullAnim = shortAngelForwardAnim;
        } else if (temp2Face.state == demonState) {
            tempShortFullAnim = shortDevilForwardAnim;
        }
    } else if ([clockParameter.type  isEqual: @"chinese"]) {
        tempShortFullAnim = shortChineseForwardAnim;
    } else {
        NSLog(@"Logic error - invalid clockParameter for type");
    }
}

-(NSMutableArray*)getProperLongAnimation:(Clock*)clockParameter
                 isForwardArg:(BOOL)isForwardParam {
    
    NSMutableArray *tempLocalAnim;
    
    //to be completed
    if (isForwardParam == YES) {
        if ([clockParameter.type  isEqual: @"regular"]) {
            tempLocalAnim = longOrdinaryForwardAnim;
        } else if ([clockParameter.type  isEqual: @"reversed"]) {
            tempLocalAnim = longReversedForwardAnim;
        } else if ([clockParameter.type  isEqual: @"sleepyclock"]) {
            tempLocalAnim = longSleepyForwardAnim;
        } else if ([clockParameter.type  isEqual: @"dizzy"]) {
            tempLocalAnim = longDizzyForwardAnim;
        } else if ([clockParameter.type  isEqual: @"lazyflower"]) {
            tempLocalAnim = longFlowerForwardAnim;
        } else if ([clockParameter.type  isEqual: @"roman"]) {
            tempLocalAnim = longRomanForwardAnim;
        } else if ([clockParameter.type  isEqual: @"ninja"]) {
            tempLocalAnim = longNinjaForwardAnim;
        } else if ([clockParameter.type  isEqual: @"void"]) {
            tempLocalAnim = longIcyForwardAnim;
        } else if ([clockParameter.type  isEqual: @"twoface"]) {
            TwoFace *temp2Face = clockParameter;
            if (temp2Face.state == angelState) {
                tempLocalAnim = longAngelForwardAnim;
            } else if (temp2Face.state == demonState) {
                tempLocalAnim = longDevilForwardAnim;
            }
        } else {
            NSLog(@"Logic error - invalid clockParameter for type in getProperLongAnimation in forward - 7yey8e");
        }
    } else {
        if ([clockParameter.type  isEqual: @"regular"]) {
            tempLocalAnim = longOrdinaryBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"reversed"]) {
            tempLocalAnim = longReversedBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"sleepyclock"]) {
            tempLocalAnim = longSleepyBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"dizzy"]) {
            tempLocalAnim = longDizzyBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"lazyflower"]) {
            tempLocalAnim = longFlowerBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"roman"]) {
            tempLocalAnim = longRomanBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"ninja"]) {
            tempLocalAnim = longNinjaBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"void"]) {
            tempLocalAnim = longIcyBackwardAnim;
        } else if ([clockParameter.type  isEqual: @"twoface"]) {
            TwoFace *temp2Face = clockParameter;
            if (temp2Face.state == angelState) {
                tempLocalAnim = longAngelBackwardAnim;
            } else if (temp2Face.state == demonState) {
                tempLocalAnim = longDevilBackwardAnim;
            }
        } else {
            NSLog(@"Logic error - invalid clockParameter for type in getProperLongAnimation in backward - 6t84rh");
        }
    }
    
    return tempLocalAnim;
}

-(void) setRectToHands:(UIImageView*) clockImage
      clockPositionArg:(int)clockPositionParam {
    
    if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"regular"]) {
        [clockImage setFrame:gameModel.ordinaryHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"reversed"]) {
        [clockImage setFrame:gameModel.reversedHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"sleepyclock"]) {
        [clockImage setFrame:gameModel.sleepyHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"dizzy"]) {
        [clockImage setFrame:gameModel.dizzyHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"lazyflower"]) {
        [clockImage setFrame:gameModel.flowerHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"roman"]) {
        [clockImage setFrame:gameModel.romanHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"ninja"]) {
        [clockImage setFrame:gameModel.ninjaHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"void"]) {
        [clockImage setFrame:gameModel.icyHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"twoface"]) {
        [clockImage setFrame:gameModel.twofaceHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"chinese"]) {
        [clockImage setFrame:gameModel.chineseHandRect];
    } else if ([[self getClockTypePureString:clockPositionParam]  isEqual: @"broken"]) {
        [clockImage setFrame:gameModel.brokenHandRect];
    }
}

- (void) endingTimer:(NSTimer *) timer {
    [self audioMainPlay];
}

-(void)sfxExcellentTimer:(NSTimer *) timer {
    [self sfxExcellent];
}

-(NSMutableArray*)returnEatingAnim:(NSString*)clockType {
    if ([clockType  isEqual: @"regular"]) {
        return ordinaryEatingAnim;
    } else if ([clockType  isEqual: @"reversed"]) {
        return reversedEatingAnim;
    } else if ([clockType  isEqual: @"sleepyclock"]) {
        return sleepyEatingAnim;
    } else if ([clockType  isEqual: @"dizzy"]) {
        return dizzyEatingAnim;
    } else if ([clockType  isEqual: @"lazyflower"]) {
        return flowerEatingAnim;
    } else if ([clockType  isEqual: @"roman"]) {
        return romanEatingAnim;
    } else if ([clockType  isEqual: @"ninja"]) {
        return ninjaEatingAnim;
    } else if ([clockType  isEqual: @"void"]) {
        return icyEatingAnim;
    } else if ([clockType  isEqual: @"twoface"]) {
        return angelEatingAnim;
    } else if ([clockType  isEqual: @"chinese"]) {
        return chineseEatingAnim;
    } else if ([clockType  isEqual: @"broken"]) {
        return brokenEatingAnim;
    } else {
        NSLog(@"Logic error - invalid clockType in returnEatingAnim - dsaa29\n");
    }
}



////AUDIO FUNCTIONS - START////

//-(void)initAudioPlayers {
//    NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MainSong" ofType:@"m4a"]];
//    
//    audioPlayerMain = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
//    
//    [audioPlayerMain setDelegate:self];
//    
//    [audioPlayerMain prepareToPlay];
//}

-(void)audioMainPlay {
    
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        [self audioMusicOnlyStop];
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"MainSong" ofType:@"m4a"]];
        
        audioPlayerMain = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        audioPlayerMain.numberOfLoops = -1;
        [audioPlayerMain setVolume:1.0];
        
        [audioPlayerMain setDelegate:self];
        
        [audioPlayerMain prepareToPlay];
        
        audioPlayerMain.currentTime = 0;
        [audioPlayerMain play];
    }
}

-(void)audioMainT1 {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        [self audioMusicOnlyStop];
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BGM_Theme1" ofType:@"m4a"]];
        
        audioPlayerT1 = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        audioPlayerT1.numberOfLoops = -1;
        [audioPlayerT1 setVolume:0.35];
        
        [audioPlayerT1 setDelegate:self];
        
        [audioPlayerT1 prepareToPlay];
        
        audioPlayerT1.currentTime = 0;
        [audioPlayerT1 play];
    }
}

-(void)audioMainT2 {
    
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        [self audioMusicOnlyStop];
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BGM_Theme2" ofType:@"m4a"]];
        
        audioPlayerT2 = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        audioPlayerT2.numberOfLoops = -1;
        [audioPlayerT2 setVolume:0.40];
        
        [audioPlayerT2 setDelegate:self];
        
        [audioPlayerT2 prepareToPlay];
        
        audioPlayerT2.currentTime = 0;
        [audioPlayerT2 play];
    }
}

-(void)audioMainT3 {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        [self audioMusicOnlyStop];
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BGM_Theme3" ofType:@"m4a"]];
        
        audioPlayerT3 = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        audioPlayerT3.numberOfLoops = -1;
        [audioPlayerT3 setVolume:0.35];
        
        [audioPlayerT3 setDelegate:self];
        
        [audioPlayerT3 prepareToPlay];
        
        audioPlayerT3.currentTime = 0;
        [audioPlayerT3 play];
    }
}

-(void)audioMainT4 {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        [self audioMusicOnlyStop];
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BGM_Theme4" ofType:@"m4a"]];
        
        audioPlayerT4 = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        audioPlayerT4.numberOfLoops = -1;
        [audioPlayerT4 setVolume:0.45];
        
        [audioPlayerT4 setDelegate:self];
        
        [audioPlayerT4 prepareToPlay];
        
        audioPlayerT4.currentTime = 0;
        [audioPlayerT4 play];
    }
}

-(void)sfxCapsulePressed {
    
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxCapsulePressed = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Capsule_Pressed" ofType:@"m4a"]];
        
        sfxCapsulePressed = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxCapsulePressed.numberOfLoops = 0;
        [sfxCapsulePressed setVolume:0.75];
        
        [sfxCapsulePressed setDelegate:self];
        
        [sfxCapsulePressed prepareToPlay];
        
        sfxCapsulePressed.currentTime = 0;
        [sfxCapsulePressed play];
    }
}

-(void)sfxAchievement {
    
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxAchievement = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Achievement" ofType:@"m4a"]];
        
        sfxAchievement = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxAchievement.numberOfLoops = 0;
        [sfxAchievement setVolume:0.8];
        
        [sfxAchievement setDelegate:self];
        
        [sfxAchievement prepareToPlay];
        
        sfxAchievement.currentTime = 0;
        [sfxAchievement play];
    }
}

-(void)sfxEnding {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxEnding = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Ending" ofType:@"m4a"]];
        
        sfxEnding = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxEnding.numberOfLoops = 0;
        [sfxEnding setVolume:1.0];
        
        [sfxEnding setDelegate:self];
        
        [sfxEnding prepareToPlay];
        
        sfxEnding.currentTime = 0;
        [sfxEnding play];
    }
}

-(void)sfxButtonClick {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxButtonClick = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Button_Click" ofType:@"m4a"]];
        
        sfxButtonClick = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxButtonClick.numberOfLoops = 0;
        [sfxButtonClick setVolume:1.0];
        
        [sfxButtonClick setDelegate:self];
        
        [sfxButtonClick prepareToPlay];
        
        sfxButtonClick.currentTime = 0;
        [sfxButtonClick play];
    }
}

-(void)sfxExcellent {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxExcellent = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Excellent" ofType:@"m4a"]];
        
        sfxExcellent = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxExcellent.numberOfLoops = 0;
        [sfxExcellent setVolume:0.75];
        
        [sfxExcellent setDelegate:self];
        
        [sfxExcellent prepareToPlay];
        
        sfxExcellent.currentTime = 0;
        [sfxExcellent play];
    }
}

-(void)sfxIcyNo {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxIcyNo = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Icy_No" ofType:@"m4a"]];
        
        sfxIcyNo = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxIcyNo.numberOfLoops = 0;
        [sfxIcyNo setVolume:0.75];
        
        [sfxIcyNo setDelegate:self];
        
        [sfxIcyNo prepareToPlay];
        
        sfxIcyNo.currentTime = 0;
        [sfxIcyNo play];
    }
}

-(void)sfxSleepyNo {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxSleepyNo = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Sleepy_No" ofType:@"m4a"]];
        
        sfxSleepyNo = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxSleepyNo.numberOfLoops = 0;
        [sfxSleepyNo setVolume:0.75];
        
        [sfxSleepyNo setDelegate:self];
        
        [sfxSleepyNo prepareToPlay];
        
        sfxSleepyNo.currentTime = 0;
        [sfxSleepyNo play];
    }
}

-(void)sfxPonting12 {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxPonting12 = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Pointing12" ofType:@"m4a"]];
        
        sfxPonting12 = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxPonting12.numberOfLoops = 0;
        [sfxPonting12 setVolume:0.75];
        
        [sfxPonting12 setDelegate:self];
        
        [sfxPonting12 prepareToPlay];
        
        sfxPonting12.currentTime = 0;
        [sfxPonting12 play];
    }
}

-(void)sfxWin {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxWin = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Win" ofType:@"m4a"]];
        
        sfxWin = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxWin.numberOfLoops = 0;
        [sfxWin setVolume:0.8];
        
        [sfxWin setDelegate:self];
        
        [sfxWin prepareToPlay];
        
        sfxWin.currentTime = 0;
        [sfxWin play];
    }
}

-(void)sfxCredits {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxCredits = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_Credits" ofType:@"m4a"]];
        
        sfxCredits = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxCredits.numberOfLoops = 0;
        [sfxCredits setVolume:0.75];
        
        [sfxCredits setDelegate:self];
        
        [sfxCredits prepareToPlay];
        
        sfxCredits.currentTime = 0;
        [sfxCredits play];
    }
}

-(void)sfxGoodLuck {
    if ([gameModel.prefs boolForKey:@"isSoundMute"] == NO) {
        sfxGoodLuck = nil;
        
        NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SFX_GoodLuck" ofType:@"m4a"]];
        
        sfxGoodLuck = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        sfxGoodLuck.numberOfLoops = 0;
        [sfxGoodLuck setVolume:0.75];
        
        [sfxGoodLuck setDelegate:self];
        
        [sfxGoodLuck prepareToPlay];
        
        sfxGoodLuck.currentTime = 0;
        [sfxGoodLuck play];
    }
}

-(void)audioMainStop {
    [audioPlayerMain stop];
    audioPlayerMain = nil;
}

-(void)audioT1Stop {
    [audioPlayerT1 stop];
    audioPlayerT1 = nil;
}

-(void)audioT2Stop {
    [audioPlayerT2 stop];
    audioPlayerT2 = nil;
}

-(void)audioT3Stop {
    [audioPlayerT3 stop];
    audioPlayerT3 = nil;
}

-(void)audioT4Stop {
    [audioPlayerT4 stop];
    audioPlayerT4 = nil;
}

-(void)audioMusicOnlyStop {
    [self audioMainStop];
    [self audioT1Stop];
    [self audioT2Stop];
    [self audioT3Stop];
    [self audioT4Stop];
}
////AUDIO FUNCTIONS - END////


////IN-APP PURCHASE FUNCTIONS - STARTS////
-(BOOL)isOver999:(int)capsulesAddition {
    if (([gameModel.prefs integerForKey:@"purchase1"] + capsulesAddition) > 999) {
        return YES;
    } else {
        return NO;
    }
}

-(void)paintProcessingImage {
    
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-3" ofType:@"png"];
    processingBoard = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [processingBoard setFrame:gameModel.backgroundRect];
    processingBoard.userInteractionEnabled = YES;
    [self.view addSubview:processingBoard];
    
    NSString* textPath = [[NSBundle mainBundle] pathForResource:@"Processing" ofType:@"png"];
    processingText = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:textPath]];
    [processingText setFrame:gameModel.processingRect];
    processingText.userInteractionEnabled = NO;
    [processingBoard addSubview:processingText];
}

-(void) depaintProcessingImage {
    [processingText removeFromSuperview];
    [processingBoard removeFromSuperview];
    
    processingText = nil;
    processingBoard = nil;
}

-(void) depaintProcessingCallTimer {
    [NSTimer scheduledTimerWithTimeInterval:10.0
                                     target:self
                                   selector:@selector(depaintProcessingTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void) depaintProcessingTimer:(NSTimer *) timer {
    [processingText removeFromSuperview];
    [processingBoard removeFromSuperview];
    
    processingText = nil;
    processingBoard = nil;
}

-(void)paintLoadingScreen {
    NSString* opacityPath = [[NSBundle mainBundle] pathForResource:@"BlackOpacity-3" ofType:@"png"];
    loadingBoard = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:opacityPath]];
    [loadingBoard setFrame:gameModel.backgroundRect];
    loadingBoard.userInteractionEnabled = YES;
    [self.view addSubview:loadingBoard];
    
    NSString* textPath = [[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"png"];
    loadingText = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:textPath]];
    [loadingText setFrame:gameModel.loadingRect];
    loadingText.userInteractionEnabled = YES;
    [loadingBoard addSubview:loadingText];
}

-(void) depaintLoadingImage {
    [loadingText removeFromSuperview];
    [loadingBoard removeFromSuperview];
    
    loadingText = nil;
    loadingBoard = nil;
}

-(void)makePremiumPurchase {
    [inAppPurchaseManager checkAndExecutePurchase:kInAppPurchaseProUpgradeProductId];
    NSLog(@"executing function:makePremiumPurchase\n");
}

-(void)makePurchaseCapsules20 {
    [inAppPurchaseManager checkAndExecutePurchase:ProductIDCapsules20];
    NSLog(@"executing makePurchaseCapsules20\n");
}

-(void)makePurchaseCapsules50 {
    [inAppPurchaseManager checkAndExecutePurchase:ProductIDCapsules50];
    NSLog(@"executing makePurchaseCapsules50\n");
}

-(void)makePurchaseCapsules500 {
    [inAppPurchaseManager checkAndExecutePurchase:ProductIDCapsules500];
    NSLog(@"executing makePurchaseCapsules500\n");
}

-(void)providePurchaseUnlockLevels {
    [gameModel.prefs setBool:YES forKey:@"isPremiumPaid"];
    [scrollView depaintPremiumBoard];
    [self depaintProcessingImage];
    
    UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Thank you for upgrading"
                        message:@"We hope you enjoy the game as much as we do!"
                        delegate:self
                        cancelButtonTitle:nil
                        otherButtonTitles:@"Ok", nil];
    [tmp show];
    
    NSLog(@"All levels unlocked!\n");
}

-(void)providePurchaseCapsules20 {
    [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+20 forKey:@"purchase1"];
    
    [self updatePurchasedItems];

    [self depaintProcessingImage];
    
    [self alertViewCapsules];
    
    NSLog(@"Capsules20 purchase: successful!\n");
}

-(void)providePurchaseCapsules50 {
    [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+50 forKey:@"purchase1"];
    
    [self updatePurchasedItems];
    
    [self depaintProcessingImage];
    
    [self alertViewCapsules];
    
    NSLog(@"Capsules50 purchase: successful!\n");
}

-(void)providePurchaseCapsules500 {
    [gameModel.prefs setInteger:[gameModel.prefs integerForKey:@"purchase1"]+500 forKey:@"purchase1"];
    
    [self updatePurchasedItems];
    
    [self depaintProcessingImage];
    
    [self alertViewCapsules];
    
    NSLog(@"Capsules500 purchase: successful!\n");
}

-(void)alertViewCapsules {
    UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Thank you for purchasing"
                        message:@"They are going to be helpful!"
                        delegate:self
                        cancelButtonTitle:nil
                        otherButtonTitles:@"Ok", nil];
    
    [tmp show];
}

-(void)alertViewCapsulesOverLimit {
    UIAlertView *tmp = [[UIAlertView alloc]
                        initWithTitle:@"Purchase Failed"
                        message:@"Exceeding the maximum limit: 999"
                        delegate:self
                        cancelButtonTitle:nil
                        otherButtonTitles:@"Ok", nil];
    
    [tmp show];
}
////IN-APP PURCHASE FUNCTIONS - ENDS////

-(void) paintlongScrollForCredits {
    scrollView=[[ScrollViewController alloc] initWithFrame:gameModel.creditsLongRect];
    scrollView.myDelegate = self;
    scrollView.gameModel = gameModel;
    if (IS_WIDESCREEN) {
        scrollView.contentSize=CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * 1.30);
    } else {
        scrollView.contentSize=CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * 1.40);
    }
    
    scrollView.pagingEnabled = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = YES;
    [self.view addSubview:scrollView];
}

-(void) drawFinalCredits {
    [self drawCreditsBackground];
    
    NSString* backPath = [[NSBundle mainBundle] pathForResource:@"BackButton" ofType:@"png"];
    backAtFinalCredits = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backPath]];
    [backAtFinalCredits setFrame:gameModel.backButtonRect];
    backAtFinalCredits.userInteractionEnabled = YES;
    [self.view addSubview:backAtFinalCredits];
}

-(void) drawOptionsCredits {
    [self drawCreditsBackground];
    
    NSString* backPath = [[NSBundle mainBundle] pathForResource:@"BackButton" ofType:@"png"];
    backButtonFromOptionsCredits = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backPath]];
    [backButtonFromOptionsCredits setFrame:gameModel.backButtonRect];
    backButtonFromOptionsCredits.userInteractionEnabled = YES;
    [self.view addSubview:backButtonFromOptionsCredits];
    
    //sound
    [self sfxCredits];
}

-(void) drawCreditsBackground {
    
    [self paintlongScrollForCredits];
    [scrollView paintLongCreditsPage];
    
}

//- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
//{
//    NSNumber *rotationAtStart = [view.layer valueForKeyPath:@"rotationAnimation"];
//    
//    CABasicAnimation* rotationAnimation;
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
////    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
////    rotationAnimation.fromValue = [NSNumber numberWithFloat: M_PI / 6.0 /* 30 degrees */ * rotations * duration ];
//    rotationAnimation.fromValue = rotationAtStart;
//    rotationAnimation.toValue = [NSNumber numberWithFloat: [rotationAtStart floatValue] + (M_PI / 6.0 /* 30 degrees */ * rotations * duration)];
//    rotationAnimation.duration = duration;
//    rotationAnimation.cumulative = YES;
//    rotationAnimation.repeatCount = repeat;
//    rotationAnimation.fillMode = kCAFillModeForwards;
//    rotationAnimation.removedOnCompletion = NO;
//    
//    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
//}

- (void) runSpinAnimationOnView:(UIView*)view angle:(float)angle duration:(CGFloat)duration repeat:(float)repeat;
{
    CALayer *myLayer = view.layer;
    
    NSNumber *rotationAtStart = [myLayer valueForKeyPath:@"transform.rotation"];
    CATransform3D myRotationTransform = CATransform3DRotate(myLayer.transform, angle, 0.0, 0.0, 1.0);
    myLayer.transform = myRotationTransform;
    CABasicAnimation *myAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    myAnimation.duration = duration;
    myAnimation.repeatCount = repeat;
    myAnimation.fromValue = rotationAtStart;
    myAnimation.toValue = [NSNumber numberWithFloat:([rotationAtStart floatValue] + angle)];
    [myLayer addAnimation:myAnimation forKey:@"transform.rotation"];
}



-(NSString*)convertClockTypeOldToNew:(NSString*)oldType {
    
    if ([oldType isEqual: @"regular"]) {
        return TYPE_REGULAR;
    } else if ([oldType isEqual: @"reversed"]) {
        return TYPE_REVERSED;
    } else if ([oldType isEqual: @"roman"]) {
        return TYPE_ROMAN;
    } else if ([oldType isEqual: @"void"]) {
        return TYPE_ICY;
    } else if ([oldType isEqual: @"twoface"]) {
        return TYPE_TWOFACE;
    } else if ([oldType isEqual: @"ninja"]) {
        return TYPE_NINJA;
    } else if ([oldType isEqual: @"broken"]) {
        return TYPE_BROKEN;
    } else if ([oldType isEqual: @"lazyflower"]) {
        return TYPE_FLOWER;
    } else if ([oldType isEqual: @"sleepyclock"]) {
        return TYPE_SLEEPY;
    } else if ([oldType isEqual: @"chinese"]) {
        return TYPE_CHINESE;
    } else if ([oldType isEqual: @"dizzy"]) {
        return TYPE_DIZZY;
    }
}

//yellow part starts
-(void) handsToYellow {
    
    if ([currentLevel.clocks count] == 2) {
        [self execute2Yellow];
    } else if ([currentLevel.clocks count] == 3) {
        [self execute3Yellow];
    } else if ([currentLevel.clocks count] == 4) {
        [self execute4Yellow];
    } else {
        NSLog(@"Logic error - invalid count at handsToYellow\n");
    }
}

-(void)execute2Yellow {
    //2clocks
    if ([tempClock checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT2Top:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        [self switchHand:UP_2CLOCKS isFromBlack:NO longArrow:longArrow2TopImage shortArrow:shortArrow2TopImage longYellow:longYellow2T shortYellow:shortYellow2T numberOfClocks:2];
    }
    
    if ([tempClock2Bottom checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT2Bottom:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        [self switchHand:BOTTOM_2CLOCKS isFromBlack:NO longArrow:longArrow2BottomImage shortArrow:shortArrow2BottomImage longYellow:longYellow2B shortYellow:shortYellow2B numberOfClocks:2];
    }
}

-(void)execute3Yellow {
    //3clocks
    if ([tempClock3TopLeft checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT3TL:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        
        [self switchHand:TOPLEFT_3CLOCKS isFromBlack:NO longArrow:longArrow3TopLeftImage shortArrow:shortArrow3TopLeftImage longYellow:longYellow3TL shortYellow:shortYellow3TL numberOfClocks:3];
    }
    
    if ([tempClock3TopRight checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT3TR:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        
        [self switchHand:TOPRIGHT_3CLOCKS isFromBlack:NO longArrow:longArrow3TopRightImage shortArrow:shortArrow3TopRightImage longYellow:longYellow3TR shortYellow:shortYellow3TR numberOfClocks:3];
    }
    
    if ([tempClock3Bottom checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT3B:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        
        [self switchHand:BOTTOM_3CLOCKS isFromBlack:NO longArrow:longArrow3BottomImage shortArrow:shortArrow3BottomImage longYellow:longYellow3B shortYellow:shortYellow3B numberOfClocks:3];
    }
}

-(void)execute4Yellow {
    //4clocks
    if ([tempClock4TopLeft checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT4TL:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        [self switchHand:TOPLEFT_4CLOCKS isFromBlack:NO longArrow:longArrow4TopLeftImage shortArrow:shortArrow4TopLeftImage longYellow:longYellow4TL shortYellow:shortYellow4TL numberOfClocks:4];
    }
    
    if ([tempClock4TopRight checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT4TR:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        [self switchHand:TOPRIGHT_4CLOCKS isFromBlack:NO longArrow:longArrow4TopRightImage shortArrow:shortArrow4TopRightImage longYellow:longYellow4TR shortYellow:shortYellow4TR numberOfClocks:4];
    }
    
    if ([tempClock4BottomRight checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT4BR:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        [self switchHand:BOTTOMRIGHT_4CLOCKS isFromBlack:NO longArrow:longArrow4BottomRightImage shortArrow:shortArrow4BottomRightImage longYellow:longYellow4BR shortYellow:shortYellow4BR numberOfClocks:4];
    }
    
    if ([tempClock4BottomLeft checkTwelve]) {
        [NSTimer scheduledTimerWithTimeInterval:0.35
                                         target:self
                                       selector:@selector(YT4BL:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        [self switchHand:BOTTOMLEFT_4CLOCKS isFromBlack:NO longArrow:longArrow4BottomLeftImage shortArrow:shortArrow4BottomLeftImage longYellow:longYellow4BL shortYellow:shortYellow4BL numberOfClocks:4];
    }
}

//YT = yellow timer
- (void) YT2Top:(NSTimer *) timer {
    [self switchHand:UP_2CLOCKS isFromBlack:YES longArrow:longArrow2TopImage shortArrow:shortArrow2TopImage longYellow:longYellow2T shortYellow:shortYellow2T numberOfClocks:2];
}

- (void) YT2Bottom:(NSTimer *) timer {
    [self switchHand:BOTTOM_2CLOCKS isFromBlack:YES longArrow:longArrow2BottomImage shortArrow:shortArrow2BottomImage longYellow:longYellow2B shortYellow:shortYellow2B numberOfClocks:2];
}

- (void) YT3TL:(NSTimer *) timer {
    [self switchHand:TOPLEFT_3CLOCKS isFromBlack:YES longArrow:longArrow3TopLeftImage shortArrow:shortArrow3TopLeftImage longYellow:longYellow3TL shortYellow:shortYellow3TL numberOfClocks:3];
}

- (void) YT3TR:(NSTimer *) timer {
    [self switchHand:TOPRIGHT_3CLOCKS isFromBlack:YES longArrow:longArrow3TopRightImage shortArrow:shortArrow3TopRightImage longYellow:longYellow3TR shortYellow:shortYellow3TR numberOfClocks:3];
}

- (void) YT3B:(NSTimer *) timer {
    [self switchHand:BOTTOM_3CLOCKS isFromBlack:YES longArrow:longArrow3BottomImage shortArrow:shortArrow3BottomImage longYellow:longYellow3B shortYellow:shortYellow3B numberOfClocks:3];
}

- (void) YT4TL:(NSTimer *) timer {
    [self switchHand:TOPLEFT_4CLOCKS isFromBlack:YES longArrow:longArrow4TopLeftImage shortArrow:shortArrow4TopLeftImage longYellow:longYellow4TL shortYellow:shortYellow4TL numberOfClocks:4];
}

- (void) YT4TR:(NSTimer *) timer {
    [self switchHand:TOPRIGHT_4CLOCKS isFromBlack:YES longArrow:longArrow4TopRightImage shortArrow:shortArrow4TopRightImage longYellow:longYellow4TR shortYellow:shortYellow4TR numberOfClocks:4];
}

- (void) YT4BR:(NSTimer *) timer {
    [self switchHand:BOTTOMRIGHT_4CLOCKS isFromBlack:YES longArrow:longArrow4BottomRightImage shortArrow:shortArrow4BottomRightImage longYellow:longYellow4BR shortYellow:shortYellow4BR numberOfClocks:4];
}

- (void) YT4BL:(NSTimer *) timer {
    [self switchHand:BOTTOMLEFT_4CLOCKS isFromBlack:YES longArrow:longArrow4BottomLeftImage shortArrow:shortArrow4BottomLeftImage longYellow:longYellow4BL shortYellow:shortYellow4BL numberOfClocks:4];
}


-(void)longToYellow:(Clock*)clockParam
       longImageArg:(UIImageView*)longImageParam {
    
    if ([clockParam.type  isEqual: @"regular"]) {
        longImageParam.image = [yellowArray objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"reversed"]) {
        longImageParam.image = [yellowArray objectAtIndex:1];
    }
    else if ([clockParam.type  isEqual: @"sleepyclock"]) {
        longImageParam.image = [yellowArray objectAtIndex:2];
    }
    else if ([clockParam.type  isEqual: @"lazyflower"]) {
        longImageParam.image = [yellowArray objectAtIndex:3];
    }
    else if ([clockParam.type  isEqual: @"roman"]) {
        longImageParam.image = [yellowArray objectAtIndex:4];
    }
    else if ([clockParam.type  isEqual: @"ninja"]) {
        longImageParam.image = [yellowArray objectAtIndex:5];
    }
    else if ([clockParam.type  isEqual: @"void"]) {
        longImageParam.image = [yellowArray objectAtIndex:6];
    }
    else if ([clockParam.type  isEqual: @"twoface"]) {
        longImageParam.image = [yellowArray objectAtIndex:8];
    }
    //    else {
    //        NSLog(@"Potential logic error - gh32dn4\n");
    //    }
}

-(void)longToBlack:(Clock*)clockParam
      longImageArg:(UIImageView*)longImageParam {
    
    if ([clockParam.type  isEqual: @"regular"]) {
        longImageParam.image = [longOrdinaryForwardAnim objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"reversed"]) {
        longImageParam.image = [longReversedForwardAnim objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"sleepyclock"]) {
        longImageParam.image = [longSleepyForwardAnim objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"lazyflower"]) {
        longImageParam.image = [longFlowerForwardAnim objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"roman"]) {
        longImageParam.image = [longRomanForwardAnim objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"ninja"]) {
        longImageParam.image = [longNinjaForwardAnim objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"void"]) {
        longImageParam.image = [longIcyForwardAnim objectAtIndex:0];
    }
    else if ([clockParam.type  isEqual: @"twoface"]) {
        TwoFace *temp2Face = clockParam;
        if (temp2Face.state == angelState) {
            longImageParam.image = [longAngelForwardAnim objectAtIndex:0];
        } else if (temp2Face.state == demonState) {
            longImageParam.image = [longDevilForwardAnim objectAtIndex:0];
        }
    }
}

//-(void) chineseShorterHandToYellow {
//    //2clocks
//    if ([tempClock checkTwelve]) {
//        if ([[self getClockTypePureString:UP_2CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock shortImageArg:shortArrow2TopImage];
//        }
//    }
//    
//    //2clocks
//    if ([tempClock2Bottom checkTwelve]) {
//        if ([[self getClockTypePureString:BOTTOM_2CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock2Bottom shortImageArg:shortArrow2BottomImage];
//        }
//    }
//    
//    //3clocks
//    if ([tempClock3TopLeft checkTwelve]) {
//        if ([[self getClockTypePureString:TOPLEFT_3CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock3TopLeft shortImageArg:shortArrow3TopLeftImage];
//        }
//    }
//    
//    //3clocks
//    if ([tempClock3TopRight checkTwelve]) {
//        if ([[self getClockTypePureString:TOPRIGHT_3CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock3TopRight shortImageArg:shortArrow3TopRightImage];
//        }
//    }
//    
//    //3clocks
//    if ([tempClock3Bottom checkTwelve]) {
//        if ([[self getClockTypePureString:BOTTOM_3CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock3Bottom shortImageArg:shortArrow3BottomImage];
//        }
//    }
//    
//    //4clocks
//    if ([tempClock4TopLeft checkTwelve]) {
//        if ([[self getClockTypePureString:TOPLEFT_4CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock4TopLeft shortImageArg:shortArrow4TopLeftImage];
//        }
//    }
//    
//    //4clocks
//    if ([tempClock4TopRight checkTwelve]) {
//        if ([[self getClockTypePureString:TOPRIGHT_4CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock4TopRight shortImageArg:shortArrow4TopRightImage];
//        }
//    }
//    
//    //4clocks
//    if ([tempClock4BottomRight checkTwelve]) {
//        if ([[self getClockTypePureString:BOTTOMRIGHT_4CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock4BottomRight shortImageArg:shortArrow4BottomRightImage];
//        }
//    }
//    
//    //4clocks
//    if ([tempClock4BottomLeft checkTwelve]) {
//        if ([[self getClockTypePureString:BOTTOMLEFT_4CLOCKS]  isEqual: @"chinese"]) {
//            [self chineseShortToYellow:tempClock4BottomLeft shortImageArg:shortArrow4BottomLeftImage];
//        }
//    }
//}


-(void)chineseShortToYellow:(Clock*)clockParam
              shortImageArg:(UIImageView*)shortImageParam {
    
    if ([clockParam.type  isEqual: @"chinese"]) {
        shortImageParam.image = [yellowArray objectAtIndex:7];
    }
}
//yellow part ends

-(void)switchHand:(int)location isFromBlack:(BOOL)isFromBlack longArrow:(UIImageView*)longArrow shortArrow:(UIImageView*)shortArrow
       longYellow:(UIImageView*)longYellow shortYellow:(UIImageView*)shortYellow numberOfClocks:(int)numberOfClocks {
    //if no particular arrow, then pass nil
    
    NSString *type = [self convertClockTypeOldToNew:[self getClockTypePureString:location]];
    
    if (isFromBlack == YES) {
        if ([type isEqual:TYPE_REGULAR] || [type isEqual:TYPE_REVERSED] || [type isEqual:TYPE_SLEEPY] || [type isEqual:TYPE_DIZZY] || [type isEqual:TYPE_FLOWER] || [type isEqual:TYPE_ROMAN] || [type isEqual:TYPE_NINJA] || [type isEqual:TYPE_ICY] || [type isEqual:TYPE_CHINESE]) {
            //hide black
            longArrow.hidden = YES;
            shortArrow.hidden = YES;
            //then unhide yellow
            longYellow.hidden = NO;
            shortYellow.hidden = NO;
        }
    } else {
        if ([type isEqual:TYPE_REGULAR] || [type isEqual:TYPE_REVERSED] || [type isEqual:TYPE_SLEEPY] || [type isEqual:TYPE_DIZZY] || [type isEqual:TYPE_FLOWER] || [type isEqual:TYPE_ROMAN] || [type isEqual:TYPE_NINJA] || [type isEqual:TYPE_ICY] || [type isEqual:TYPE_CHINESE]) {
            //hide yellow
            longYellow.hidden = YES;
            shortYellow.hidden = YES;
            //then unhide black
            longArrow.hidden = NO;
            shortArrow.hidden = NO;
        }
    }
    
    if (isFromBlack == YES) {
        if ([type isEqual:TYPE_BROKEN]) {
            longArrow.hidden = YES;
            longYellow.hidden = NO;
        }
    } else {
        if ([type isEqual:TYPE_BROKEN]) {
            longYellow.hidden = YES;
            longArrow.hidden = NO;
        }
    }
    
    //have to convert from old to new var!
    
    int tempNewVar = [self convertToNew:location numberOfClocksArg:numberOfClocks];
    UIImageView *tempAngelShort, *tempAngelLong;
    tempAngelShort = [self getAngelShort:tempNewVar];
    tempAngelLong = [self getAngelLong:tempNewVar];
    Clock *tempClockObject = [self getClockObjectNewVar:tempNewVar];
    
    if ([type isEqual:TYPE_TWOFACE]) {
        if (isFromBlack == YES) {
            //hide black
            longArrow.hidden = YES;
            shortArrow.hidden = YES;
            //hide angel
            tempAngelLong.hidden = YES;
            tempAngelShort.hidden = YES;
            //then unhide yellow
            longYellow.hidden = NO;
            shortYellow.hidden = NO;
        } else {
            //hide yellow
            longYellow.hidden = YES;
            shortYellow.hidden = YES;
            
            //unhide angel or black
            TwoFace *temp2Face = tempClockObject;
            if (temp2Face.state == angelState) {
                tempAngelLong.hidden = NO;
                tempAngelShort.hidden = NO;
            } else {
                longArrow.hidden = NO;
                shortArrow.hidden = NO;
            }
        }
        
//        TwoFace *temp2Face = tempC;
//        if (temp2Face.state == angelState) {
    }
}

-(NSString*)getShortName:(int)pointing
        clockLocationArg:(int)clockLocationParam {
    
    int i;
    if (pointing == 12) i=1;
    else i=pointing*2+1;
    NSString *fileName;
    
    if ([[self getClockTypePureString:clockLocationParam] isEqual: @"regular"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"reversed"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Reversed_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"sleepyclock"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Sleepy_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"dizzy"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"lazyflower"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"roman"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Roman_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"ninja"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Ninja_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"void"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"twoface"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Short_999"] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"chinese"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Chinese_Short_999"] ofType:@"png"];
    }
    
    return fileName;
}

-(NSString*)getLongName:(int)number
       clockLocationArg:(int)clockLocationParam {
    
    NSString *fileName;
    
    if ([[self getClockTypePureString:clockLocationParam] isEqual: @"regular"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Regular_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"reversed"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Reversed_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"sleepyclock"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Sleepy_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"dizzy"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Dizzy_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"lazyflower"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Flower_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"roman"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Roman_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"ninja"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Ninja_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"void"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Icy_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"twoface"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Angel_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"broken"]) {
        fileName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"Arrow_Broken_Long_%i", number] ofType:@"png"];
    } else if ([[self getClockTypePureString:clockLocationParam] isEqual: @"chinese"]) {
        //
    } else {
        NSLog(@"Logic error - bsvuycfsdbsvvxu75\n");
    }
    
    return fileName;
}

-(UIImageView*)getAngelShort:(int)newvarLocation {
    switch (newvarLocation) {
        case NEWVAR_2CLOCKS_TOP:
            return shortAngel2T;
            break;
        case NEWVAR_2CLOCKS_BOTTOM:
            return shortAngel2B;
            break;
            
        case NEWVAR_3CLOCKS_TOPLEFT:
            return shortAngel3TL;
            break;
        case NEWVAR_3CLOCKS_TOPRIGHT:
            return shortAngel3TR;
            break;
        case NEWVAR_3CLOCKS_BOTTOM:
            return shortAngel3B;
            break;
            
        case NEWVAR_4CLOCKS_TOPLEFT:
            return shortAngel4TL;
            break;
        case NEWVAR_4CLOCKS_TOPRIGHT:
            return shortAngel4TR;
            break;
        case NEWVAR_4CLOCKS_BOTTOMRIGHT:
            return shortAngel4BR;
            break;
        case NEWVAR_4CLOCKS_BOTTOMLEFT:
            return shortAngel4BL;
            break;
            //to complete
            
        default:
            NSLog(@"Logic error - invalid newvarLocation at getAngelShort\n");
            break;
    }
}

-(UIImageView*)getAngelLong:(int)newvarLocation {
    switch (newvarLocation) {
        case NEWVAR_2CLOCKS_TOP:
            return longAngel2T;
            break;
        case NEWVAR_2CLOCKS_BOTTOM:
            return longAngel2B;
            break;
            
        case NEWVAR_3CLOCKS_TOPLEFT:
            return longAngel3TL;
            break;
        case NEWVAR_3CLOCKS_TOPRIGHT:
            return longAngel3TR;
            break;
        case NEWVAR_3CLOCKS_BOTTOM:
            return longAngel3B;
            break;
            
        case NEWVAR_4CLOCKS_TOPLEFT:
            return longAngel4TL;
            break;
        case NEWVAR_4CLOCKS_TOPRIGHT:
            return longAngel4TR;
            break;
        case NEWVAR_4CLOCKS_BOTTOMRIGHT:
            return longAngel4BR;
            break;
        case NEWVAR_4CLOCKS_BOTTOMLEFT:
            return longAngel4BL;
            break;
            
            //to complete
            
        default:
            NSLog(@"Logic error - invalid newvarLocation at getAngelLong\n");
            break;
    }
}

-(void)handsToFromAngel:(int)location
            isFromBlack:(BOOL)isFromBlack {
    
    if (location == NEWVAR_2CLOCKS_TOP) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow2TopImage shortArrow:shortArrow2TopImage longAngel:longAngel2T shortAngel:shortAngel2T];
    } else if (location == NEWVAR_2CLOCKS_BOTTOM) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow2BottomImage shortArrow:shortArrow2BottomImage longAngel:longAngel2B shortAngel:shortAngel2B];
    } else if (location == NEWVAR_3CLOCKS_TOPLEFT) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow3TopLeftImage shortArrow:shortArrow3TopLeftImage longAngel:longAngel3TL shortAngel:shortAngel3TL];
    } else if (location == NEWVAR_3CLOCKS_TOPRIGHT) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow3TopRightImage shortArrow:shortArrow3TopRightImage longAngel:longAngel3TR shortAngel:shortAngel3TR];
    } else if (location == NEWVAR_3CLOCKS_BOTTOM) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow3BottomImage shortArrow:shortArrow3BottomImage longAngel:longAngel3B shortAngel:shortAngel3B];
    } else if (location == NEWVAR_4CLOCKS_TOPLEFT) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow4TopLeftImage shortArrow:shortArrow4TopLeftImage longAngel:longAngel4TL shortAngel:shortAngel4TL];
    } else if (location == NEWVAR_4CLOCKS_TOPRIGHT) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow4TopRightImage shortArrow:shortArrow4TopRightImage longAngel:longAngel4TR shortAngel:shortAngel4TR];
    } else if (location == NEWVAR_4CLOCKS_BOTTOMRIGHT) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow4BottomRightImage shortArrow:shortArrow4BottomRightImage longAngel:longAngel4BR shortAngel:shortAngel4BR];
    } else if (location == NEWVAR_4CLOCKS_BOTTOMLEFT) {
        [self switchHandTwoface:location isFromBlack:isFromBlack longArrow:longArrow4BottomLeftImage shortArrow:shortArrow4BottomLeftImage longAngel:longAngel4BL shortAngel:shortAngel4BL];
    }
}

-(void)switchHandTwoface:(int)location isFromBlack:(BOOL)isFromBlack longArrow:(UIImageView*)longArrow shortArrow:(UIImageView*)shortArrow
       longAngel:(UIImageView*)longAngel shortAngel:(UIImageView*)shortAngel {
    //if no particular arrow, then pass nil
    
    if (isFromBlack == YES) {
            //hide black
            longArrow.hidden = YES;
            shortArrow.hidden = YES;
            //then unhide angel
            longAngel.hidden = NO;
            shortAngel.hidden = NO;
    } else {
            //hide yellow
            longAngel.hidden = YES;
            shortAngel.hidden = YES;
            //then unhide angel
            longArrow.hidden = NO;
            shortArrow.hidden = NO;
    }
}

-(Clock*) getClockObjectNewVar:(int)position {
    switch (position) {
        case NEWVAR_2CLOCKS_TOP:
            return tempClock;
            break;
        case NEWVAR_2CLOCKS_BOTTOM:
            return tempClock2Bottom;
            break;
            
        case NEWVAR_3CLOCKS_TOPLEFT:
            return tempClock3TopLeft;
            break;
        case NEWVAR_3CLOCKS_TOPRIGHT:
            return tempClock3TopRight;
            break;
        case NEWVAR_3CLOCKS_BOTTOM:
            return tempClock3Bottom;
            break;
            
        case NEWVAR_4CLOCKS_TOPLEFT:
            return tempClock4TopLeft;
            break;
        case NEWVAR_4CLOCKS_TOPRIGHT:
            return tempClock4TopRight;
            break;
        case NEWVAR_4CLOCKS_BOTTOMRIGHT:
            return tempClock4BottomRight;
            break;
        case NEWVAR_4CLOCKS_BOTTOMLEFT:
            return tempClock4BottomLeft;
            break;
            
        default:
            NSLog(@"Logic error - invalid position at getClockObjectNewVar\n");
            break;
    }
}

-(void)initialiseHandPosition:(Clock*)clockObject shortImage:(UIImageView*)shortImage shortAngel:(UIImageView*)shortAngel {
    [self runSpinAnimationOnView:shortImage angle:(ANGLE_30 * clockObject.shorterHand) duration:0.01 repeat:1.0];
    
    if ([clockObject.type  isEqual: @"twoface"]) {
        [self runSpinAnimationOnView:shortAngel angle:(ANGLE_30 * clockObject.shorterHand) duration:0.01 repeat:1.0];
    }
}

-(void)rotateShortHandTo12:(Clock*)clockObject shortImage:(UIImageView*)shortImage shortAngel:(UIImageView*)shortAngel {
    
    int rotationValue = 12 - clockObject.shorterHand;
    
    [self runSpinAnimationOnView:shortImage angle:(ANGLE_30 * rotationValue) duration:0.01 repeat:1.0];
    
    if ([clockObject.type  isEqual: @"twoface"]) {
        [self runSpinAnimationOnView:shortAngel angle:(ANGLE_30 * rotationValue) duration:0.01 repeat:1.0];
    }
}

-(void)rotateBrokenHandTo12:(Clock*)clockObject longImage:(UIImageView*)longImage {
    
    if ([clockObject.type  isEqual: @"broken"]) {
        if (clockObject.isLongerHandUp == NO) {
            [self runSpinAnimationOnView:longImage angle:(ANGLE_360/2.0) duration:0.01 repeat:1.0];
        }
    }
}

-(void)initialiseLongBrokenPosition:(Clock*)clockObject longImage:(UIImageView*)longImage {

    if ([clockObject.type  isEqual: @"broken"]) {
        if (clockObject.isLongerHandUp == NO) {
            [self runSpinAnimationOnView:longImage angle:(ANGLE_360/2.0) duration:0.01 repeat:1.0];
        }
    }
}

-(void)allocateArraysToLevel {
    
    int counter = 0;
    
    NSString *type;
    
    BOOL isEqual = NO;

    do {
        
        type = [[currentLevel.clocks objectAtIndex:counter] getType];

        for (int i = 0; i<counter; i++) {
            if ([type isEqual:[[currentLevel.clocks objectAtIndex:i] getType]]) {
                isEqual = YES;
                break;
            } else {
                isEqual = NO;
                continue;
            }
            
        }
        if (!isEqual) {
            [self loadParticularLevelArray:type];
        }
        
        
        counter++;
        
    } while (counter < currentLevel.clocks.count);
    
    printf("\n");
}

-(void)loadParticularLevelArray:(NSString*)type {
    
    if ([type  isEqual: @"regular"]) {
        [self prepareOrdinaryAnimNotWin];
        [self prepareSpecificArrayOrdinary];
        [self prepareOrdinaryWinAnim];
        [self preloadOrdinary];
        printf("Loading array: regular\n");
    }
    else if ([type  isEqual: @"reversed"]) {
        [self prepareReversedAnimNotWin];
        [self prepareSpecificArrayReversed];
        [self prepareReversedWinAnim];
        [self preloadReversed];
        printf("Loading array: reversed\n");
    }
    else if ([type  isEqual: @"sleepyclock"]) {
        [self prepareSleepyAnimNotWin];
        [self prepareSpecificArraySleepy];
        [self prepareSleepyWinAnim];
        [self preloadSleepy];
        printf("Loading array: sleepy\n");
    }
    else if ([type  isEqual: @"dizzy"]) {
        [self prepareDizzyAnimNotWin];
        [self prepareSpecificArrayDizzy];
        [self prepareDizzyWinAnim];
        [self preloadDizzy];
        printf("Loading array: dizzy\n");
    }
    else if ([type  isEqual: @"lazyflower"]) {
        [self prepareFlowerAnimNotWin];
        [self prepareSpecificArrayFlower];
        [self prepareFlowerWinAnim];
        [self preloadFlower];
        printf("Loading array: flower\n");
    }
    else if ([type  isEqual: @"roman"]) {
        [self prepareRomanAnimNotWin];
        [self prepareSpecificArrayRoman];
        [self prepareRomanWinAnim];
        [self preloadRoman];
        printf("Loading array: roman\n");
    }
    else if ([type  isEqual: @"ninja"]) {
        [self prepareNinjaAnimNotWin];
        [self prepareSpecificArrayNinja];
        [self prepareNinjaWinAnim];
        [self preloadNinja];
        printf("Loading array: ninja\n");
    }
    else if ([type  isEqual: @"void"]) {
        [self prepareIcyAnimNotWin];
        [self prepareSpecificArrayIcy];
        [self prepareIcyWinAnim];
        [self preloadIcy];
        printf("Loading array: icy\n");
    }
    else if ([type  isEqual: @"twoface"]) {
        [self prepareTwofaceAnimNotWin];
        [self prepareSpecificArrayTwoface];
        [self prepareTwofaceWinAnim];
        [self preloadTwoface];
        printf("Loading array: twoface\n");
    }
    else if ([type  isEqual: @"chinese"]) {
        [self prepareChineseAnimNotWin];
        [self prepareSpecificArrayChinese];
        [self prepareChineseWinAnim];
        [self preloadChinese];
        printf("Loading array: chinese\n");
    }
    else if ([type  isEqual: @"broken"]) {
        [self prepareBrokenAnimNotWin];
        [self prepareSpecificArrayBroken];
        [self prepareBrokenWinAnim];
        [self preloadBroken];
        printf("Loading array: broken\n");
    }
    else {
        NSLog(@"Logic error - Invalid type at loadParticularLevelArray\n");
    }
}

-(void)delayLoadingWinNext:(NSTimer *) timer {
    [self nullifyAnimArraysAfterWin];
    [self dePaintWin];
    [self hideLevel:YES];
    
    //zebra2
    if (currentLevel.currentLevel == lastLevelBeforeLockdown) {
        if ([gameModel.prefs boolForKey:@"isPremiumPaid"] == NO) {
            [self callParticularLevelPage:lastLevelBeforeLockdown+1];
            [self audioMainPlay];
        } else {
            [self paintLevel:currentLevel.currentLevel+1];
        }
    }
    else if (currentLevel.currentLevel == 30) {
        if ([self getTotalStars] >= 50) {
            //unlock and go to theme 2
            [self paintThemeMenu:YES];
            [self audioMainPlay];
        } else {
            //go to level page
            [self callParticularLevelPage:currentLevel.currentLevel];
        }
    } else if (currentLevel.currentLevel == 60) {
        if ([self getTotalStars] >= 105) {
            //unlock and go to theme 3
            [self paintThemeMenu:YES];
            [self audioMainPlay];
        } else {
            //go to level page
            [self callParticularLevelPage:currentLevel.currentLevel];
        }
    } else if (currentLevel.currentLevel == 90) {
        if ([self getTotalStars] >= 160) {
            //unlock and go to theme 4
            [self paintThemeMenu:YES];
            [self audioMainPlay];
        } else {
            //go to level page
            [self callParticularLevelPage:currentLevel.currentLevel];
        }
    } else if (currentLevel.currentLevel == 120) {
        //draw congratz page
        [self drawCongratsPage];
        [self audioMusicOnlyStop];
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(endingTimer:)
                                       userInfo:nil
                                        repeats:NO];
    } else {
        [self paintLevel:currentLevel.currentLevel+1];
    }
    
    [self enableUserInteractionsInLevel];
}

-(void)delayLoadingWinReset:(NSTimer *) timer {
    [self nullifyAnimArraysAfterWin];
    [self dePaintWin];
    [self hideLevel:NO];
    [self paintLevel:currentLevel.currentLevel];
    [self enableUserInteractionsInLevel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animateDizzyAfterHome:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(void)animateDizzyAfterHome:(NSNotification *)notification {

    for (Clock *c in currentLevel.clocks) {
        if ([[c getType] isEqual:@"dizzy"]) {
            int clockLocation = c.location;
            [self animateDizzyArgClockIndexArg:[self convertToOld:clockLocation]
                                  longImageArg:[self getLongImageFromNew:clockLocation]
                                    longYellow:[self getLongYellowFromNew:clockLocation]];
        }
    }
}

-(UIImageView*)getLongImageFromNew:(int)newVar {
    if (newVar == NEWVAR_2CLOCKS_TOP) {
        return longArrow2TopImage;
    } else if (newVar == NEWVAR_2CLOCKS_BOTTOM) {
        return longArrow2BottomImage;
    } else if (newVar == NEWVAR_3CLOCKS_TOPLEFT) {
        return longArrow3TopLeftImage;
    } else if (newVar == NEWVAR_3CLOCKS_TOPRIGHT) {
        return longArrow3TopRightImage;
    } else if (newVar == NEWVAR_3CLOCKS_BOTTOM) {
        return longArrow3BottomImage;
    } else if (newVar == NEWVAR_4CLOCKS_TOPLEFT) {
        return longArrow4TopLeftImage;
    } else if (newVar == NEWVAR_4CLOCKS_TOPRIGHT) {
        return longArrow4TopRightImage;
    } else if (newVar == NEWVAR_4CLOCKS_BOTTOMRIGHT) {
        return longArrow4BottomRightImage;
    } else if (newVar == NEWVAR_4CLOCKS_BOTTOMLEFT) {
        return longArrow4BottomLeftImage;
    } else {
        NSLog(@"Logic error - invalid newVar at getLongImageFromNew\n");
    }
}

-(UIImageView*)getLongYellowFromNew:(int)newVar {
    if (newVar == NEWVAR_2CLOCKS_TOP) {
        return longYellow2T;
    } else if (newVar == NEWVAR_2CLOCKS_BOTTOM) {
        return longYellow2B;
    } else if (newVar == NEWVAR_3CLOCKS_TOPLEFT) {
        return longYellow3TL;
    } else if (newVar == NEWVAR_3CLOCKS_TOPRIGHT) {
        return longYellow3TR;
    } else if (newVar == NEWVAR_3CLOCKS_BOTTOM) {
        return longYellow3B;
    } else if (newVar == NEWVAR_4CLOCKS_TOPLEFT) {
        return longYellow4TL;
    } else if (newVar == NEWVAR_4CLOCKS_TOPRIGHT) {
        return longYellow4TR;
    } else if (newVar == NEWVAR_4CLOCKS_BOTTOMRIGHT) {
        return longYellow4BR;
    } else if (newVar == NEWVAR_4CLOCKS_BOTTOMLEFT) {
        return longYellow4BL;
    } else {
        NSLog(@"Logic error - invalid newVar at getLongYellowFromNew\n");
    }
}

@end
;