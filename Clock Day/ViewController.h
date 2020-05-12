//
//  ViewController.h
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Model.h"
#import "ScrollViewController.h"
//#import <FacebookSDK/FacebookSDK.h>
#import "FacebookScorer/FacebookScorer.h"
#import <AVFoundation/AVFoundation.h>
#import "InAppPurchaseManager.h"
#import <StoreKit/StoreKit.h>


@interface ViewController : UIViewController <ScrollViewControllerDelegate, InAppPurchaseManagerDelegate> {
    Model *gameModel;
    ScrollViewController *scrollView;
    InAppPurchaseManager *inAppPurchaseManager;
    
//    CABasicAnimation* rotationAnimation;
    
    CADisplayLink* gameTimer;
    
    UILocalNotification* localNotification, *localNotification2;
    
    UIWebView *socialNetworkingWeb;
    
    UIImageView *logoPage, *inGameTheme1Background, *imageMainMenu, *imageBackground2, *congratsBackground, *creditsBackground;
    UIImageView *statusBar, *pauseButton, *resetButton, *goalText, *levelText, *stepsText;
    UIImageView *goalNumber100, *goalNumber10, *goalNumber0, *levelNumber100, *levelNumber10, *levelNumber0, *stepsNumber100, *stepsNumber10, *stepsNumber0, *purchaseNumber100, *purchaseNumber10, *purchaseNumber0;
    UIImageView *shadowImage, *titleImage, *playButton, *optionsButton, *facebookButton, *collectionsButton;
    UIImageView *backButton, *backButton4dot1, *backButtonFromOptions, *backButtonFromOptionsCredits, *backButtonFromCollections, *shareInStickers, *twoClocksFrame, *top2ClocksImage, *shortArrow2TopImage, *longArrow2TopImage, *bottom2ClocksImage, *shortArrow2BottomImage, *longArrow2BottomImage, *linkingArrowUp2ClocksImage, *linkingArrowDown2ClocksImage;
    UIImageView *linkingArrow3Clocks, *linkingArrow4Clocks;
    UIImageView *threeClocksFrame, *topLeft3Image, *topRight3Image, *bottom3Image;
    UIImageView *fourClocksFrame, *topLeft4Image, *topRight4Image, *bottomLeft4Image, *bottomRight4Image;
    UIImageView *longArrow3TopLeftImage, *shortArrow3TopLeftImage, *longArrow3TopRightImage, *shortArrow3TopRightImage, *longArrow3BottomImage, *shortArrow3BottomImage;
    UIImageView *longArrow4TopLeftImage, *shortArrow4TopLeftImage, *longArrow4TopRightImage, *shortArrow4TopRightImage, *longArrow4BottomLeftImage, *shortArrow4BottomLeftImage, *longArrow4BottomRightImage, *shortArrow4BottomRightImage;
    UIImageView *opacityBlackWin, *winPage, *winGood, *winExcellent, *winLeftStar, *winRightStar, *winStepsLabel, *winStepsDigitHundred, *winStepsDigitTen, *winStepsDigitOne, *winGoalDigitHundred, *winGoalDigitTen, *winGoalDigitOne, *winGoalLabel, *winReset, *winLevels, *winNext;
    UIImageView *nextAtCongrats, *congratsImage, *backAtFinalCredits;
    UIImageView *notifBar, *gameplayHelp, *gameplayPurchase, *notGameplayPurchase;
    //OP = Options Page
    UIImageView *OPSoundButton, *OPRateButton, *OPHelpButton, *OPCreditsButton, *OPShareButton, *OPRestoreButton;
    UIImageView *achBoardImage, *achBackImage, *achLikeImage, *achLikePurchase, *achRateImage, *achRatePurchase, *achBannerImage;
    UIImageView *tutorialBoardImage, *tutorialNextImage, *tutorialNextHelpImage, *tutorialNextHelpForShadowImage;
    
    UIImageView *inAppBoardImage, *inAppCloseImage, *inAppPrice1Image, *inAppPrice2Image, *inAppPrice3Image, *inAppPrice4Image;
    UIImageView *freeFacebookImage, *freeShareImage, *freeRateImage, *freeCloseImage;
    
    UIImageView *pauseBoardImage, *pauseResumeImage, *pauseMainMenuImage, *pausePurchaseImage;
    UIImageView *fullScreenImage;
    
    UIImageView *shadow2TopImage, *shadow2BottomImage, *shadow3TopLeftImage, *shadow3TopRightImage, *shadow3BottomImage, *shadow4TopLeftImage, *shadow4TopRightImage, *shadow4BottomRightImage, *shadow4BottomLeftImage;
    
    NSMutableArray *animFlashToBlack, *animFlashFromBlack, *animFlashToWhite, *animFlashFromWhite;;
    NSMutableArray *regularAnimationStandard1, *animOrdinaryB, *animOrdinaryWin;
    NSMutableArray *animReversedA, *animReversedB, *animReversedWin;
    NSMutableArray *animSleepyA, *animSleepyB, *animAwakeToSleep, *animSleepySleeping, *animSleepToAwake, *animSleepyWin;
    NSMutableArray *animDizzyA, *animDizzyB, *animDizzyWin;
    NSMutableArray *animFlowerA, *animFlowerB, *animFlowerWin;
    NSMutableArray *animRomanA, *animRomanB, *animRomanWin;
    NSMutableArray *animNinjaA, *animNinjaB, *animNinjaWin;
    NSMutableArray *animIcyA, *animIcyB, *animIcyWin;
    NSMutableArray *animAngelA, *animAngelB, *animDevilA, *animDevilB, *animAngeltoDevil, *animDevilToAngel, *animAngelWin;
    NSMutableArray *animChineseA, *animChineseB, *animChineseWin;
    NSMutableArray *animBrokenA, *animBrokenB, *animBrokenWin;
    
    NSMutableArray *arrowFlash3BfrTL, *arrowFlash3BfrTR, *arrowFlash3toTL, *arrowFlash3toTR;
    NSMutableArray *arrowFlash4toBL, *arrowFlash4toBR, *arrowFlash4toTL, *arrowFlash4toTR;
    NSMutableArray *arrowFlashToLeft, *arrowFlashToRight;
    NSMutableArray *arrowFlashToDown, *arrowFlashToUp;
    
    //VA = VirtualArrow
    UIImageView *VA2ClocksToTop, *VA2ClocksToBottom;
    UIImageView *VA3ClocksLtoR, *VA3ClocksRtoL, *VA3ClocksBtoTL, *VA3ClocksTLtoB, *VA3ClocksBtoTR, *VA3ClocksTRtoB;
    UIImageView *VA4ClocksTLtoTR, *VA4ClocksTRtoTL, *VA4ClocksBLtoBR, *VA4ClocksBRtoBL, *VA4ClocksTLtoBL, *VA4ClocksBLtoTL, *VA4ClocksTRtoBR, *VA4ClocksBRtoTR, *VA4ClocksTLtoBR, *VA4ClocksBRtoTL, *VA4ClocksTRtoBL, *VA4ClocksBLtoTR;
    
    NSMutableArray *longArrowFullLoopAnimation, *longArrowFullLoopAnimationFromDown, *longArrowLazyForward, * longArrowLazyBackward, *longArrowFullLoopAnimationReversed, *longArrowFullLoopAnimationFromDownReversed;
    NSMutableArray *longArrowRightToDownAnimation, *longArrowLeftToUpAnimation, *longArrowLeftToDownAnimation, *longArrowRightToUpAnimation;
    
    //test//
    NSMutableArray *shortOrdinaryForwardAnim, *shortReversedForwardAnim, *shortSleepyForwardAnim, *shortDizzyForwardAnim, *shortFlowerForwardAnim, *shortRomanForwardAnim, *shortNinjaForwardAnim, *shortIcyForwardAnim, *shortDevilForwardAnim, *shortAngelForwardAnim, *shortChineseForwardAnim;
    
    NSMutableArray *longOrdinaryForwardAnim, *longReversedForwardAnim, *longSleepyForwardAnim, *longDizzyForwardAnim, *longFlowerForwardAnim, *longRomanForwardAnim, *longNinjaForwardAnim, *longIcyForwardAnim, *longDizzyYellowForwardAnim, *longDevilForwardAnim, *longAngelForwardAnim;
    NSMutableArray *longOrdinaryBackwardAnim, *longReversedBackwardAnim, *longSleepyBackwardAnim, *longDizzyBackwardAnim, *longFlowerBackwardAnim, *longRomanBackwardAnim, *longNinjaBackwardAnim, *longIcyBackwardAnim, *longDizzyYellowBackwardAnim, *longDevilBackwardAnim, *longAngelBackwardAnim;
    //test//
    
    NSMutableArray *clockFlashFull, *clockFlashLeft, *clockFlashRight;
    NSMutableArray *sleepyFlashFull, *dizzyFlashFull, *ninjaFlashFull, *icyFlashFull;
    NSMutableArray *ordinaryFlashLeft, *ordinaryFlashRight, *reversedFlashLeft, *reversedFlashRight, *flowerFlashLeft, *flowerFlashRight, *romanFlashLeft, *romanFlashRight, *angelFlashLeft, *angelFlashRight, *devilFlashLeft, *devilFlashRight, *chineseFlashLeft, *chineseFlashRight, *brokenFlashLeft, *brokenFlashRight;
    
    NSMutableArray *ordinaryEatingAnim, *reversedEatingAnim, *sleepyEatingAnim, *dizzyEatingAnim, *flowerEatingAnim, *romanEatingAnim, *ninjaEatingAnim, *icyEatingAnim, *angelEatingAnim, *chineseEatingAnim, *brokenEatingAnim;
    
    UIImageView *flash2TopImage, *flash2BottomImage, *flash3TLImage, *flash3TRImage, *flash3BImage, *flash4TLImage, *flash4TRImage, *flash4BRImage, *flash4BLImage;
    
    UIImageView *eating2TopImage, *eating2BottomImage, *eating3TLImage, *eating3TRImage, *eating3BImage, *eating4TLImage, *eating4TRImage, *eating4BRImage, *eating4BLImage;
    
    NSMutableArray *shortTo1Animation, *shortTo2Animation, *shortTo3Animation, *shortTo4Animation, *shortTo5Animation, *shortTo6Animation, *shortTo7Animation, *shortTo8Animation, *shortTo9Animation, *shortTo10Animation, *shortTo11Animation, *shortTo12Animation;
    NSMutableArray *shortTo1AnimationB, *shortTo2AnimationB, *shortTo3AnimationB, *shortTo4AnimationB, *shortTo5AnimationB, *shortTo6AnimationB, *shortTo7AnimationB, *shortTo8AnimationB, *shortTo9AnimationB, *shortTo10AnimationB, *shortTo11AnimationB, *shortTo12AnimationB;
    NSMutableArray *sleepToAwake, *awakeToSleep;
    NSMutableArray *icyNotif, *twoFaceNotif, *sleepyNotif, *capsuleNotif;
    
    NSMutableArray *yellowArray;
    
    UIImageView *zodiacsImage;
    
    UIImageView *helpOrdinary, *helpArrow, *helpReversed, *helpSleepy, *helpDizzy, *helpFlower, *helpRoman, *helpNinja, *helpIcy, *helpTwoFace, *helpChinese, *helpBroken, *backButtonFromHelp;
    
    //Collections page
    UIImageView *collectionsLongBG, *achievementsButton, *opacityBlackAch, *opacityBlackInApp;
    UIImageView *afterSlash, *slashNumber, *beforeSlash, *stickersLabel;
    
    UIImageView *totalStarImage, *totalAfterSlash1, *totalAfterSlash10, *totalAfterSlash100, *totalSlashImage, *totalBeforeSlash1, *totalBeforeSlash10, *totalBeforeSlash100;
    UIImageView *layerForDisablingUI;
    UIImageView *backgroundCapsule;
    UIImageView *twoVirtualFrame, *top2Virtual, *bottom2Virtual;
    UIImageView *threeVirtualFrame, *topLeft3Virtual, *topRight3Virtual, *bottom3Virtual;
    UIImageView *fourVirtualFrame, *topLeft4Virtual, *topRight4Virtual, *bottomRight4Virtual, *bottomLeft4Virtual;
    UIImageView *helpBackground;
    
    UIImageView *processingBoard, *processingText;
    UIImageView *loadingBoard, *loadingText;
    
    UIImageView *premiumBoardImage, *premiumUnlockImage;
    
    BOOL firstStatus, firstBackground1, first2Clocks;
    int defaultMultiplier, angelState, demonState, sleepingState, awakeState, forwardDirection, backwardDirection;
    NSString *prefixNumStatusBar, *prefixTextStatusBar, *prefixTextPurchase;
    NSString *prefixNumWin;
    NSString *lastHit;
    int ordinaryCounter, reversedCounter, sleepyCounter, dizzyCounter, flowerCounter, romanCounter, ninjaCounter, icyCounter, twoFaceCounter, chineseCounter, brokenCounter;
    
    
    Level *currentLevel;
    
    Clock *tempClock, *tempClock2Bottom;
    Clock *tempClock3TopLeft, *tempClock3TopRight, *tempClock3Bottom;
    Clock *tempClock4TopLeft, *tempClock4TopRight, *tempClock4BottomLeft, *tempClock4BottomRight;
    
    Arrow *tempArrow1, *tempArrow2;
    //to be implemented: After finishing a level, set all variables to nil!
    
    NSTimer *timer2ClocksTop, *timer2ClocksBottom, *timer3ClocksTopLeft, *timer3ClocksTopRight, *timer3ClocksBottom, *timer4ClocksTopLeft, *timer4ClocksTopRight, *timer4ClocksBottomLeft, *timer4ClocksBottomRight;
    NSTimer *tempTimerOrdinary1, *tempTimerOrdinary2, *tempTimerOrdinary3, *tempTimerOrdinary4;
    NSTimer *tempTimerReversed1, *tempTimerReversed2, *tempTimerReversed3, *tempTimerReversed4;
    NSTimer *tempTimerSleepy1, *tempTimerSleepy2, *tempTimerSleepy3, *tempTimerSleepy4;
    NSTimer *tempTimerSleeping;
    NSTimer *tempTimerDizzy1, *tempTimerDizzy2, *tempTimerDizzy3, *tempTimerDizzy4;
    NSTimer *tempTimerFlower1, *tempTimerFlower2, *tempTimerFlower3, *tempTimerFlower4;
    NSTimer *tempTimerRoman1, *tempTimerRoman2, *tempTimerRoman3, *tempTimerRoman4;
    NSTimer *tempTimerNinja1, *tempTimerNinja2, *tempTimerNinja3, *tempTimerNinja4;
    NSTimer *tempTimerIcy1, *tempTimerIcy2, *tempTimerIcy3, *tempTimerIcy4;
    NSTimer *tempTimerAngel1, *tempTimerAngel2, *tempTimerAngel3, *tempTimerAngel4;
    NSTimer *tempTimerDevil1, *tempTimerDevil2, *tempTimerDevil3, *tempTimerDevil4;
    NSTimer *tempTimerChinese1, *tempTimerChinese2, *tempTimerChinese3, *tempTimerChinese4;
    NSTimer *tempTimerBroken1, *tempTimerBroken2, *tempTimerBroken3, *tempTimerBroken4;
    NSTimer *timerEnableUI;
    
    int ordinaryIndex, reversedIndex, sleepyIndex, dizzyIndex, flowerIndex, romanIndex, ninjaIndex, icyIndex, twofaceIndex, chineseIndex, brokenIndex;
    int leftside, rightside;
    int rotationSpeed;
    int eatingAnimDuration;
    BOOL isPre12Top2Clocks, isPre12Bottom2Clocks, isPre12TopLeft3Clocks, isPre12TopRight3Clocks, isPre12Bottom3Clocks, isPre12TopLeft4Clocks, isPre12TopRight4Clocks, isPre12BottomRight4Clocks, isPre12BottomLeft4Clocks;
    int lastLevelBeforeLockdown;
    int tutorialPageCounter;
    int helpBoardTracker;
    int totalCapsules20, totalCapsules50, totalCapsules500;
    
    NSMutableArray *tempAnimArray, *tempShortFullAnim, *tempLongFullAnim;
    
    UIAlertView *facebookAlertView;
    
    AVAudioPlayer *audioPlayerMain, *audioPlayerT1, *audioPlayerT2, *audioPlayerT3, *audioPlayerT4;
    AVAudioPlayer *sfxCapsulePressed, *sfxAchievement, *sfxEnding, *sfxButtonClick, *sfxExcellent, *sfxIcyNo, *sfxSleepyNo, *sfxPonting12, *sfxWin, *sfxCredits, *sfxGoodLuck;
    
    UIImageView *testtest;
//    UIImageView *arrayGenerator1, *arrayGenerator2, *arrayGenerator3, *arrayGenerator4, *arrayGenerator5, *arrayGenerator6, *arrayGenerator7, *arrayGenerator8, *arrayGenerator9, *arrayGenerator10, *arrayGenerator11, *arrayGenerator12, *arrayGenerator13, *arrayGenerator14, *arrayGenerator15, *arrayGenerator16, *arrayGenerator17, *arrayGenerator18;
    
    UIImageView *fullScreenFlashGen;
    UIImageView *ordinaryGenA, *ordinaryGenB, *ordinaryGenWin, *reversedGenA, *reversedGenB, *reversedGenWin, *sleepyGenA, *sleepyGenB, *sleepyGenSleeping, *sleepyGenWin, *sleepyGenStoA, *sleepyGenAtoS, *dizzyGenA, *dizzyGenB, *dizzyGenWin, *flowerGenA, *flowerGenB, *flowerGenWin, *romanGenA, *romanGenB, *romanGenWin, *ninjaGenA, *ninjaGenB, *ninjaGenWin, *icyGenA, *icyGenB, *icyGenWin, *angelGenA, *angelGenWin, *devilGenA, *angelToDevilGen, *devilToAngelGen, *chineseGenA, *chineseGenB, *chineseGenWin, *brokenGenA, *brokenGenB, *brokenGenWin;
    UIImageView *ordinaryShortGen, *ordinaryLongGen, *ordinaryLongBackwardsGen, *reversedShortGen, *reversedLongGen, *reversedLongBackwardsGen, *sleepyShortGen, *sleepyLongGen, *sleepyLongBackwardsGen, *dizzyShortGen, *dizzyLongGen, *flowerShortGen, *flowerLongGen, *flowerLongBackwardsGen, *flowerLongGen2, *flowerLongBackwardsGen2, *romanShortGen, *romanLongGen, *romanLongBackwardsGen, *ninjaShortGen, *ninjaLongGen, *ninjaLongBackwardsGen, *icyShortGen, *icyLongGen, *icyLongBackwardsGen, *angelShortGen, *angelLongGen, *angelLongBackwardsGen, *devilShortGen, *devilLongGen, *devilLongBackwardsGen, *chineseShortGen, *brokenLongGen;
    
    UIImageView *shortYellow2T, *shortYellow2B, *shortYellow3TL, *shortYellow3TR, *shortYellow3B, *shortYellow4TL, *shortYellow4TR, *shortYellow4BR, *shortYellow4BL;
    UIImageView *longYellow2T, *longYellow2B, *longYellow3TL, *longYellow3TR, *longYellow3B, *longYellow4TL, *longYellow4TR, *longYellow4BR, *longYellow4BL;
    
    UIImageView *shortAngel2T, *shortAngel2B, *shortAngel3TL, *shortAngel3TR, *shortAngel3B, *shortAngel4TL, *shortAngel4TR, *shortAngel4BR, *shortAngel4BL;
    UIImageView *longAngel2T, *longAngel2B, *longAngel3TL, *longAngel3TR, *longAngel3B, *longAngel4TL, *longAngel4TR, *longAngel4BR, *longAngel4BL;
}

@end
