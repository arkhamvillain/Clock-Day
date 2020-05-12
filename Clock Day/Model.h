//
//  Model.h
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Clock.h"
#import "RegularClock.h"
#import "ReversedClock.h"
#import "RomanClock.h"
#import "VoidClock.h"
#import "TwoFace.h"
#import "NinjaClock.h"
#import "BrokenClock.h"
#import "LazyFlower.h"
#import "SleepyClock.h"
#import "ChineseClock.h"
#import "DizzyClock.h"
#import "ExplosiveArrow.h"
#import "Level.h"
#import "Arrow.h"

#define ANGLE_30 M_PI/6.0
#define ANGLE_360 M_PI*2.0

#define TYPE_REGULAR @"codeRegular"
#define TYPE_REVERSED @"codeReversed"
#define TYPE_SLEEPY @"codeSleepy"
#define TYPE_DIZZY @"codeDizzy"
#define TYPE_FLOWER @"codeFlower"
#define TYPE_ROMAN @"codeRoman"
#define TYPE_NINJA @"codeNinja"
#define TYPE_ICY @"codeIcy"
#define TYPE_TWOFACE @"codeTwoface"
#define TYPE_CHINESE @"codeChinese"
#define TYPE_BROKEN @"codeBroken"

#define UP_2CLOCKS 1
#define BOTTOM_2CLOCKS 2

#define TOPLEFT_3CLOCKS 1
#define TOPRIGHT_3CLOCKS 2
#define BOTTOM_3CLOCKS 3

#define OPTIONSELEMENT_HEIGHT 40.0
#define OPTIONSELEMENT_WIDTH 160.0
#define SHAREINSTICKERS_HEIGHT 40.0
#define SHAREINSTICKERS_WIDTH 160.0

#define TOPLEFT_4CLOCKS 1
#define TOPRIGHT_4CLOCKS 2
#define BOTTOMRIGHT_4CLOCKS 3
#define BOTTOMLEFT_4CLOCKS 4

#define MAINPAGE_TITLE_WIDTH 280.0
#define MAINPAGE_TITLE_HEIGHT 230.0

#define MAINPAGE_PLAY_LENGTH 140.0
#define MAINPAGE_FACEBOOK_LENGTH 70.0
#define MAINPAGE_COLLECTIONS_LENGTH 70.0
#define MAINPAGE_OPTIONS_LENGTH 70.0

#define DURINGGAMEPLAY_INGAMEPURCHASE 48.0
#define DURINGGAMEPLAY_INGAMEPURCHASE_W 40.0
#define DURINGGAMEPLAY_HELP 48.0
#define NOTIFBAR_HEIGHT 48.0
#define NOTIFBAR_WIDTH 200.0

#define THEMEBUTTON_WIDTH 190.0
#define THEMEBUTTON_HEIGHT 300.0
#define THEMELOCKED_WIDTH 190.0
#define THEMELOCKED_HEIGHT 240.0
#define THEMENOTE_HEIGHT 60.0
#define THEME2NOTE_WIDTH 256.0
#define THEME3NOTE_WIDTH 290.0
#define THEME4NOTE_WIDTH 275.0
#define THEMEXNOTE_WIDTH 150.0
#define THEMEXNOTE_HEIGHT 25.0
#define THEME_FB_WIDTH 160.0
#define THEME_FB_HEIGHT 40.0

#define CAPSULE_TOPLEFT_WIDTH 40.0
#define CAPSULE_TOPLEFT_HEIGHT 48.0

#define BACKBUTTON_LENGTH 60.0
#define ACHIEVEMENTBUTTON_LENGTH 50.0
#define LEVELBUTTON_WIDTH 66.0
#define LEVELBUTTON_HEIGHT 60.0

#define CLOCK_LENGTH 130.0
#define ZODIACS_LENGTH 100.0

#define DIAGONAL4RECT (CLOCK_LENGTH*3.0/4.0)

#define BOTTOMCENTER_WIDTH 120.0
#define BOTTOMCENTER_HEIGHT 40.0

#define WINPAGE_WIDTH 280.0
#define WINPAGE_HEIGHT 370.0
#define WINPAGEBUTTONS_LENGTH 55.0
#define WIN_LABEL_HEIGHT 33.0
#define WIN_GOOD_WIDTH 86.8
#define WIN_EXCELLENT_WIDTH 126.0
#define STAR_LENGTH 80.0
#define STARONLEVEL_LENGTH 20.0

#define WIN_STEPSLABEL_HEIGHT 27.0
#define WIN_GOALLABEL_HEIGHT 21.0
#define WIN_STEPSLABEL_WIDTH 126.0
#define WIN_GOALLABEL_WIDTH 55.5
#define WINNUMBER_HEIGHT 19.0
#define WINNUMBER_WIDTH 13.0

#define PURCHASEDITEM_WIDTH 12.0
#define PURCHASEDITEM_HEIGHT 18.0

#define STATUSBAR_HEIGHT 60.0
#define PAUSEBUTTON_LENGTH 35.0 //before = 31
#define RESETBUTTON_LENGTH 35.0
#define STATUSTEXT_ANY_HEIGHT 12.0
#define STATUSTEXT_GOAL_WIDTH 32.0
#define STATUSTEXT_LEVEL_WIDTH 37.0
#define STATUSTEXT_STEPS_WIDTH 35.0
#define STATUSNUMBER_HEIGHT 10.0
#define STATUSNUMBER_WIDTH 8.0
#define STATUSSTEPS_HEIGHT 14.0

#define LEVELNUMBER_HEIGHT 17.0
#define LEVELNUMBER_WIDTH 12.0

#define ORDINARYACH_LENGTH 120.0
#define SLEEPYACH_LENGTH 100.0
#define FLOWERACH_LENGTH 110.0
#define REVERSED_LENGTH 105.0
#define NINJAACH_LENGTH 130.0
#define ICYACH_LENGTH 105.0
#define DEVILACH_LENGTH 125.0
#define ANGELACH_LENGTH 126.0
#define CHINESE_LENGTH 120.0
#define BROKEN_LENGTH 130.0

#define ACHBOARD_WIDTH 295.0
#define ACHBOARD_HEIGHT 373.0
#define ACHBACK_WIDTH 110.0
#define ACHBACK_HEIGHT 33.0
#define LIKERATE_WIDTH 110.0
#define LIKERATE_HEIGHT 33.0

#define TUTBOARD_WIDTH 350.0 //was 295
#define TUTBOARD_HEIGHT 442.5 //was 373

#define PREMIUM_BOARD_WIDTH 290.0
#define PREMIUM_BOARD_HEIGHT 366.0
#define UNLOCK_WIDTH 110.0
#define UNLOCK_HEIGHT 33.0

#define ACHLABEL_HEIGHT 27.0
#define ACHNUMBER_HEIGHT 24.0
#define STICKERSNUMBER_WIDTH 15.0
#define SLASHNUMBER_WIDTH 16.0
#define AFTERSLASH_WIDTH 15.0
#define STICKERSLABEL_WIDTH 120.0

#define INAPPPRICE_HEIGHT 80.0
#define INAPPPRICE_WIDTH 100.0
#define INAPPCLOSE_LENGTH 50.0

#define BANNER_WIDTH 142.0
#define BANNER_HEIGHT 71.0

#define INSIDEPAUSEBUTTON_WIDTH 120.0
#define INSIDEPAUSEBUTTON_HEIGHT 36.0

#define TOTALSTAR_WIDTH 25.0
#define TOTALSTAR_HEIGHT 25.0
#define TOTALNUMBER_WIDTH 16.0
#define TOTALNUMBER_HEIGHT 23.0
#define TOTALSLASH_WIDTH 14.0
#define TOTALSLASH_HEIGHT 23.0

#define NEWVAR_2CLOCKS_TOP 21
#define NEWVAR_2CLOCKS_BOTTOM 22
#define NEWVAR_3CLOCKS_TOPLEFT 31
#define NEWVAR_3CLOCKS_TOPRIGHT 32
#define NEWVAR_3CLOCKS_BOTTOM 33
#define NEWVAR_4CLOCKS_TOPLEFT 41
#define NEWVAR_4CLOCKS_TOPRIGHT 42
#define NEWVAR_4CLOCKS_BOTTOMRIGHT 43
#define NEWVAR_4CLOCKS_BOTTOMLEFT 44

#define HELP_OBJECT 75.0

#define TUTORIALBACK_WIDTH 125.0
#define TUTORIALBACK_HEIGHT 37.5

#define CONGRATSBOARD_WIDTH 290.0
#define CONGRATSBOARD_HEIGHT 392.0

#define THEMEARROW_WIDTH 35.0
#define THEMEARROW_HEIGHT 57.0

#define PROCESSING_WIDTH 145.0
#define PROCESSING_HEIGHT 30.0

#define LOADING_WIDTH 163.0
#define LOADING_HEIGHT 40.0

#define CREDITS_CONTENT_WIDTH 265.0
#define CREDITS_CONTENT_HEIGHT 1097.5
#define CREDITS_TITLE_LENGTH 105.0


@interface Model : NSObject {
    RegularClock* regularClock;
    ReversedClock* reversedClock;
    RomanClock* romanClock;
    VoidClock* voidClock;
    TwoFace* twoFace;
    NinjaClock* ninjaClock;
    BrokenClock* brokenClock;
    LazyFlower* lazyFlower;
    SleepyClock* sleepyClock;
    ChineseClock* chineseClock;
    DizzyClock* dizzyClock;
    
    Arrow* arrow;
    ExplosiveArrow* explosiveArrow;
    Level* level;
    NSMutableArray* clocks;
    NSMutableArray* levels;
    NSMutableArray* arrows;
    
    NSUserDefaults *prefs;
    NSString *appDomain;
    
    CGFloat screenHeight, screenWidth;
    
    CGRect fullScreenRect, backgroundRect;
    CGRect scrollPage2Rect, scrollPage3Rect, scrollPage4Rect, scrollPage5Rect;
    CGRect titleRect, playButtonRect, optionsButtonRect, facebook_mainPageRect, collections_mainPageRect;
    CGRect playButtonRectC;
    CGRect themeButtonRect, themeLockedRect, lockedNote2Rect, lockedNote3Rect, lockedNote4Rect, backButtonRect, shareInStickersRect, statusBarRect, pauseButtonRect, resetButtonRect, lockedNoteXRect, lockedNoteXFacebookRect;
    CGRect winPageRect, winGoodRect, winExcellentRect, winLeftStarRect, winRightStarRect, winStepsLabelRect, winStepsDigitHundredRect, winStepsDigitTenRect, winStepsDigitOneRect, winGoalDigitHundredRect, purchaseDigitHundredRect, purchaseDigitTenRect, purchaseDigitOneRect, winGoalDigitTenRect, winGoalDigitOneRect, winGoalLabelRect, winResetRect, winLevelsRect, winNextRect;
    NSMutableArray *levelButtonRects;
    CGRect twoClocksRect, top2ClocksRect, bottom2ClocksRect, linkingArrowUp2Clocks, linkingArrowDown2Clocks;
    
    CGRect zodiacsRect;
    
    CGRect level3DigitsLeftRect, level3DigitsCentreRect, level3DigitsRightRect, level2DigitsLeftRect, level2DigitsRightRect, level1DigitRect;
    
    CGRect linkingArrowRight3ClocksSideTopRect,
    linkingArrowLeft3ClocksSideTopRect,
    linkingArrow3ClocksToTopRightRect,
    linkingArrow3ClocksToBottomFromTopRightRect,
    linkingArrow3ClocksToTopLeftRect,
    linkingArrow3ClocksToBottomFromTopLeftRect;
    
    CGRect linkingArrowUp4ClocksSideLeftRect,
    linkingArrowUp4ClocksSideRightRect,
    linkingArrowDown4ClocksSideLeftRect,
    linkingArrowDown4ClocksSideRightRect,
    linkingArrowRight4ClocksSideTopRect,
    linkingArrowRight4ClocksSideBottomRect,
    linkingArrowLeft4ClocksSideTopRect,
    linkingArrowLeft4ClocksSideBottomRect,
    linkingArrow4ClocksToTopRightRect,
    linkingArrow4ClocksToTopLeftRect,
    linkingArrow4ClocksToBottomRightRect,
    linkingArrow4ClocksToBottomLeftRect;
    
    CGRect optionsPageSoundRect, optionsPageRateRect, optionsPageHelpRect, optionsPageCreditsRect, optionsPageShareRect, optionsPageRestoreRect;
    
    CGRect threeClocksRect, topLeft3Rect, topRight3Rect, bottom3Rect;
    
    CGRect fourClocksRect, topLeft4Rect, topRight4Rect, bottomLeft4Rect, bottomRight4Rect;
    
    CGRect leftStarLevelRect, rightStarLevelRect;
    
    CGRect textGoalRect, textLevelRect, textStepsRect;
    CGRect numberGoal100Rect, numberGoal10Rect, numberGoal0Rect, numberLevel100Rect, numberLevel10Rect, numberLevel0Rect, numberSteps100Rect, numberSteps10Rect, numberSteps0Rect;
    
    CGRect bottomCenterButtonRect;
    CGRect notifBarRect, notifBarConstantRect, gameplayHelpRect, gameplayPurchaseRect;
    
    CGRect collectionsLongRect, achievementRect, achBannerRect;
    CGRect creditsLongRect, creditsContentRect, creditsTitleRect;
    CGRect ordinaryAch, reversedAch, sleepyAch, flowerAch, ninjaAch, icyAch, devilAch, angelAch, chineseAch, brokenAch;
    CGRect achBoardRect;
    CGRect backAchBoardRect, rateAndLikeRect;
    CGRect premiumBoardRect, unlockPremiumRect;
    CGRect slashNumberRect, beforeSlashRect, afterSlashRect, stickersLabelRect;
    
    CGRect tutorialBoard;
    
    CGRect inAppPrice1Rect, inAppPrice2Rect, inAppPrice3Rect, inAppPrice4Rect, inAppCloseRect;
    CGRect purchaseFacebookRect, purchaseShareRect, purchaseRateRect;
    
    CGRect pauseResumeRect, pauseMainRect, pausePurchaseRect;
    CGRect capsuleAtTopLeft, capsuleAtBottomRight;
    
    CGRect totalStarImageRect, totalDigitOneRRect, totalDigitTenRRect, totalDigitHundredRRect, totalSlashRect, totalDigitOneLRect, totalDigitTenLRect, totalDigitHundredLRect;
    
    CGRect clockShadow2T, clockShadow2B, clockShadow3TL, clockShadow3TR, clockShadow3B, clockShadow4TL, clockShadow4TR, clockShadow4BR, clockShadow4BL;
    
    CGRect ordinaryFlashRect, reversedFlashRect, sleepyFlashRect, dizzyFlashRect, flowerFlashRect, romanFlashRect, ninjaFlashRect, icyFlashRect, twoFaceFlashRect, chineseFlashRect, brokenFlashRect;
    
    CGRect ordinaryHandRect, reversedHandRect, sleepyHandRect, dizzyHandRect, flowerHandRect, romanHandRect, ninjaHandRect, icyHandRect, twofaceHandRect, chineseHandRect, brokenHandRect;
    
    CGRect helpOrdinaryRect, helpArrowRect, helpReversedRect, helpSleepyRect, helpDizzyRect, helpFlowerRect, helpRomanRect, helpNinjaRect, helpIcyRect, helpTwoFaceRect, helpChineseRect, helpBrokenRect, backButtonFromHelpRect;
    
    CGRect backTutorialRect;
    
    CGRect congratsBoardRect;
    
    CGRect themeLeftRect, themeRightRect;
    
    CGRect processingRect, loadingRect;
    
    double diagonal4RectLength, diagonal3RectLength;
    double diagonal3HorizontalRatio, diagonal3VerticalRatio;
    double arrowOffset;
    
    int currentTheme;
    
    BOOL win;
}

@property Clock* clock;
@property Arrow* arrow;
@property Level* level;

@property (readonly) CGRect fullScreenRect, backgroundRect, scrollPage2Rect, scrollPage3Rect, scrollPage4Rect, scrollPage5Rect;
@property (readonly) CGFloat screenHeight, screenWidth;
@property (readonly) CGRect titleRect, playButtonRect, optionsButtonRect, facebook_mainPageRect, collections_mainPageRect;

@property (readonly) CGRect playButtonRectC;

@property (readonly) CGRect backButtonRect, shareInStickersRect, themeButtonRect, themeLockedRect, lockedNote2Rect, lockedNote3Rect, lockedNote4Rect, statusBarRect, pauseButtonRect, resetButtonRect, lockedNoteXRect, lockedNoteXFacebookRect;
@property (readonly) CGRect zodiacsRect;

@property (readonly) CGRect twoClocksRect, top2ClocksRect, bottom2ClocksRect, linkingArrowUp2ClocksRect, linkingArrowDown2ClocksRect;
@property (readonly) CGRect level3DigitsLeftRect, level3DigitsCentreRect, level3DigitsRightRect, level2DigitsLeftRect, level2DigitsRightRect, level1DigitRect;
@property (readonly) CGRect linkingArrowRight3ClocksSideTopRect,
linkingArrowLeft3ClocksSideTopRect,
linkingArrow3ClocksToTopRightRect,
linkingArrow3ClocksToBottomFromTopRightRect,
linkingArrow3ClocksToTopLeftRect,
linkingArrow3ClocksToBottomFromTopLeftRect;
@property (readonly) CGRect
    linkingArrowUp4ClocksSideLeftRect,
    linkingArrowUp4ClocksSideRightRect,
    linkingArrowDown4ClocksSideLeftRect,
    linkingArrowDown4ClocksSideRightRect,
    linkingArrowRight4ClocksSideTopRect,
    linkingArrowRight4ClocksSideBottomRect,
    linkingArrowLeft4ClocksSideTopRect,
    linkingArrowLeft4ClocksSideBottomRect,
    linkingArrow4ClocksToTopRightRect,
    linkingArrow4ClocksToTopLeftRect,
    linkingArrow4ClocksToBottomRightRect,
    linkingArrow4ClocksToBottomLeftRect;

@property CGRect optionsPageSoundRect, optionsPageRateRect, optionsPageHelpRect, optionsPageCreditsRect, optionsPageShareRect, optionsPageRestoreRect;

@property CGRect textGoalRect, textLevelRect, textStepsRect;
@property CGRect numberGoal100Rect, numberGoal10Rect, numberGoal0Rect, numberLevel100Rect, numberLevel10Rect, numberLevel0Rect, numberSteps100Rect, numberSteps10Rect, numberSteps0Rect;

@property (readonly) CGRect threeClocksRect, topLeft3Rect, topRight3Rect, bottom3Rect;
@property (readonly) CGRect fourClocksRect, topLeft4Rect, topRight4Rect, bottomLeft4Rect, bottomRight4Rect;
@property (readonly) CGRect winPageRect, winGoodRect, winExcellentRect, winLeftStarRect, winRightStarRect, winStepsLabelRect, winStepsDigitHundredRect, winStepsDigitTenRect, winStepsDigitOneRect, winGoalDigitHundredRect, winGoalDigitTenRect, winGoalDigitOneRect, purchaseDigitHundredRect, purchaseDigitTenRect, purchaseDigitOneRect, winGoalLabelRect, winResetRect, winLevelsRect, winNextRect;
@property (readonly) CGRect leftStarLevelRect, rightStarLevelRect;
@property (readonly) CGRect bottomCenterButtonRect;
@property (readonly) CGRect notifBarRect, gameplayHelpRect, gameplayPurchaseRect;

@property (readonly) NSMutableArray *levelButtonRects;
@property BOOL win;
@property int currentTheme;

@property CGRect collectionsLongRect, achievementRect, achBannerRect;
@property CGRect creditsLongRect, creditsContentRect, creditsTitleRect;;
@property CGRect ordinaryAch, reversedAch, sleepyAch, flowerAch, ninjaAch, icyAch, devilAch, angelAch, chineseAch, brokenAch;
@property CGRect achBoardRect, backAchBoardRect, rateAndLikeRect;
@property CGRect slashNumberRect, beforeSlashRect, afterSlashRect, stickersLabelRect;

@property CGRect tutorialBoard;

@property CGRect inAppPrice1Rect, inAppPrice2Rect, inAppPrice3Rect, inAppPrice4Rect, inAppCloseRect;
@property CGRect purchaseFacebookRect, purchaseShareRect, purchaseRateRect;
@property CGRect pauseResumeRect, pauseMainRect, pausePurchaseRect;
@property CGRect capsuleAtTopLeft, capsuleAtBottomRight;

@property CGRect totalStarImageRect, totalDigitOneRRect, totalDigitTenRRect, totalDigitHundredRRect, totalSlashRect, totalDigitOneLRect, totalDigitTenLRect, totalDigitHundredLRect;

@property CGRect clockShadow2T, clockShadow2B, clockShadow3TL, clockShadow3TR, clockShadow3B, clockShadow4TL, clockShadow4TR, clockShadow4BR, clockShadow4BL;

@property CGRect ordinaryFlashRect, reversedFlashRect, sleepyFlashRect, dizzyFlashRect, flowerFlashRect, romanFlashRect, ninjaFlashRect, icyFlashRect, twoFaceFlashRect, chineseFlashRect, brokenFlashRect;

@property CGRect ordinaryHandRect, reversedHandRect, sleepyHandRect, dizzyHandRect, flowerHandRect, romanHandRect, ninjaHandRect, icyHandRect, twofaceHandRect, chineseHandRect, brokenHandRect;

@property CGRect helpOrdinaryRect, helpArrowRect, helpReversedRect, helpSleepyRect, helpDizzyRect, helpFlowerRect, helpRomanRect, helpNinjaRect, helpIcyRect, helpTwoFaceRect, helpChineseRect, helpBrokenRect, backButtonFromHelpRect;

@property CGRect premiumBoardRect, unlockPremiumRect;

@property CGRect backTutorialRect;

@property CGRect congratsBoardRect;

@property CGRect themeLeftRect, themeRightRect;

@property CGRect processingRect, loadingRect;


@property NSUserDefaults *prefs;
@property NSString *appDomain;

-(void) tempAction;
-(void) GenerateLevels;
-(void) populateLevel:(int)number;
-(void) populateLevel1;
-(void) populateLevel2;
-(void) resetNotifBarRect;
-(Level*) getLevel : (int) number;
-(void) updateNotifWithTime:(CFTimeInterval) timestamp;
-(CGRect) getClickedButton:(CGRect) defaultRect;

@end
