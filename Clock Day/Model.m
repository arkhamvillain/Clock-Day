//
//  Model.m
//  Clock Day
//
//  Created by Yoseph Winata on 20/03/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "Model.h"

@implementation Model
@synthesize clock, arrow, level;
@synthesize screenHeight, screenWidth;
@synthesize fullScreenRect, backgroundRect, scrollPage2Rect, scrollPage3Rect, scrollPage4Rect, scrollPage5Rect, titleRect, playButtonRect, facebook_mainPageRect, collections_mainPageRect;

@synthesize playButtonRectC;

@synthesize optionsButtonRect, themeButtonRect, themeLockedRect, lockedNote2Rect, lockedNote3Rect, lockedNote4Rect, backButtonRect, shareInStickersRect, statusBarRect, pauseButtonRect, resetButtonRect, lockedNoteXRect, lockedNoteXFacebookRect;
@synthesize winPageRect, winGoodRect, winExcellentRect, winLeftStarRect, winRightStarRect, winStepsLabelRect, winStepsDigitHundredRect, winStepsDigitTenRect, winStepsDigitOneRect, winGoalDigitHundredRect, winGoalDigitTenRect, winGoalDigitOneRect, purchaseDigitHundredRect, purchaseDigitTenRect, purchaseDigitOneRect, winGoalLabelRect, winResetRect, winLevelsRect, winNextRect;
@synthesize twoClocksRect, top2ClocksRect, bottom2ClocksRect, linkingArrowUp2ClocksRect, linkingArrowDown2ClocksRect;
@synthesize level3DigitsLeftRect, level3DigitsCentreRect, level3DigitsRightRect, level2DigitsLeftRect, level2DigitsRightRect, level1DigitRect;

@synthesize zodiacsRect;

@synthesize bottomCenterButtonRect;
@synthesize collectionsLongRect, achievementRect, achBannerRect;

@synthesize creditsLongRect, creditsContentRect, creditsTitleRect;

@synthesize
linkingArrowRight3ClocksSideTopRect,
linkingArrowLeft3ClocksSideTopRect,
linkingArrow3ClocksToTopRightRect,
linkingArrow3ClocksToBottomFromTopRightRect,
linkingArrow3ClocksToTopLeftRect,
linkingArrow3ClocksToBottomFromTopLeftRect;

@synthesize
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

@synthesize optionsPageSoundRect, optionsPageRateRect, optionsPageHelpRect, optionsPageCreditsRect, optionsPageShareRect, optionsPageRestoreRect;

@synthesize textGoalRect, textLevelRect, textStepsRect;
@synthesize numberGoal10Rect, numberGoal0Rect, numberLevel100Rect, numberLevel10Rect, numberLevel0Rect, numberSteps100Rect, numberSteps10Rect, numberSteps0Rect, numberGoal100Rect;

@synthesize threeClocksRect, topLeft3Rect, topRight3Rect, bottom3Rect;
@synthesize fourClocksRect, topLeft4Rect, topRight4Rect, bottomLeft4Rect, bottomRight4Rect;
@synthesize leftStarLevelRect, rightStarLevelRect;
@synthesize win;
@synthesize currentTheme;
@synthesize notifBarRect, gameplayHelpRect, gameplayPurchaseRect;

@synthesize ordinaryAch, reversedAch, sleepyAch, flowerAch, ninjaAch, icyAch, devilAch, angelAch, chineseAch, brokenAch;
@synthesize achBoardRect, backAchBoardRect, rateAndLikeRect;
@synthesize slashNumberRect, beforeSlashRect, afterSlashRect, stickersLabelRect;

@synthesize tutorialBoard;

@synthesize inAppPrice1Rect, inAppPrice2Rect, inAppPrice3Rect, inAppPrice4Rect, inAppCloseRect;
@synthesize purchaseFacebookRect, purchaseShareRect, purchaseRateRect;

@synthesize pauseResumeRect, pauseMainRect, pausePurchaseRect;
@synthesize capsuleAtTopLeft, capsuleAtBottomRight;

@synthesize totalStarImageRect, totalDigitOneRRect, totalDigitTenRRect, totalDigitHundredRRect, totalSlashRect, totalDigitOneLRect, totalDigitTenLRect, totalDigitHundredLRect;

@synthesize clockShadow2T, clockShadow2B, clockShadow3TL, clockShadow3TR, clockShadow3B, clockShadow4TL, clockShadow4TR, clockShadow4BR, clockShadow4BL;

@synthesize ordinaryFlashRect, reversedFlashRect, sleepyFlashRect, dizzyFlashRect, flowerFlashRect, romanFlashRect, ninjaFlashRect, icyFlashRect, twoFaceFlashRect, chineseFlashRect, brokenFlashRect;

@synthesize ordinaryHandRect, reversedHandRect, sleepyHandRect, dizzyHandRect, flowerHandRect, romanHandRect, ninjaHandRect, icyHandRect, twofaceHandRect, chineseHandRect, brokenHandRect;

@synthesize helpOrdinaryRect, helpArrowRect, helpReversedRect, helpSleepyRect, helpDizzyRect, helpFlowerRect, helpRomanRect, helpNinjaRect, helpIcyRect, helpTwoFaceRect, helpChineseRect, helpBrokenRect, backButtonFromHelpRect;

@synthesize premiumBoardRect, unlockPremiumRect;

@synthesize congratsBoardRect;;

@synthesize backTutorialRect;

@synthesize themeLeftRect, themeRightRect;

@synthesize processingRect, loadingRect;

@synthesize prefs;
@synthesize appDomain;

@synthesize levelButtonRects;

- (id)init {
    self = [super init];
    
    if (self) {
        prefs = [NSUserDefaults standardUserDefaults];
        
        win = FALSE;
        currentTheme = 0;
        
        
        
        diagonal4RectLength = CLOCK_LENGTH / 2.0;
//        diagonal3RectLength = diagonal4RectLength * 3.0 / 5.0;
        diagonal3RectLength = CLOCK_LENGTH / 4.0;
        diagonal3HorizontalRatio = 54.0;
        diagonal3VerticalRatio = 69.0;
        arrowOffset = CLOCK_LENGTH/400.0;
        
        fullScreenRect = [[UIScreen mainScreen] applicationFrame];
        
        screenHeight = [[UIScreen mainScreen] bounds].size.height;
        screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        //Options page
        optionsPageSoundRect = CGRectMake(screenWidth/2.0-OPTIONSELEMENT_WIDTH/2.0, screenHeight*0.75/6.0-OPTIONSELEMENT_HEIGHT/2.0, OPTIONSELEMENT_WIDTH, OPTIONSELEMENT_HEIGHT);
        optionsPageRateRect = CGRectMake(screenWidth/2.0-OPTIONSELEMENT_WIDTH/2.0, screenHeight*1.75/6.0-OPTIONSELEMENT_HEIGHT/2.0, OPTIONSELEMENT_WIDTH, OPTIONSELEMENT_HEIGHT);
        optionsPageRestoreRect = CGRectMake(screenWidth/2.0-OPTIONSELEMENT_WIDTH/2.0, screenHeight*2.75/6.0-OPTIONSELEMENT_HEIGHT/2.0, OPTIONSELEMENT_WIDTH, OPTIONSELEMENT_HEIGHT);
        optionsPageShareRect = CGRectMake(screenWidth/2.0-OPTIONSELEMENT_WIDTH/2.0, screenHeight*3.75/6.0-OPTIONSELEMENT_HEIGHT/2.0, OPTIONSELEMENT_WIDTH, OPTIONSELEMENT_HEIGHT);
        optionsPageCreditsRect = CGRectMake(screenWidth/2.0-OPTIONSELEMENT_WIDTH/2.0, screenHeight*4.75/6.0-OPTIONSELEMENT_HEIGHT/2.0, OPTIONSELEMENT_WIDTH, OPTIONSELEMENT_HEIGHT);
        
        scrollPage2Rect = CGRectMake(screenWidth, 0.0, screenWidth, screenHeight);
        scrollPage3Rect = CGRectMake(screenWidth * 2, 0.0, screenWidth, screenHeight);
        scrollPage4Rect = CGRectMake(screenWidth * 3, 0.0, screenWidth, screenHeight);
        scrollPage5Rect = CGRectMake(screenWidth * 4, 0.0, screenWidth, screenHeight);
        
        backgroundRect = CGRectMake(0.0, 0.0, screenWidth, screenHeight);
        titleRect = CGRectMake(screenWidth/2.0 - MAINPAGE_TITLE_WIDTH/2.0, screenHeight/40.0, MAINPAGE_TITLE_WIDTH, MAINPAGE_TITLE_HEIGHT);
        playButtonRect = CGRectMake(screenWidth/2.0-MAINPAGE_PLAY_LENGTH/2.0, screenHeight*6.5/10.0-MAINPAGE_PLAY_LENGTH/2.0, MAINPAGE_PLAY_LENGTH, MAINPAGE_PLAY_LENGTH);
        
        collections_mainPageRect = CGRectMake(screenWidth/2.0-MAINPAGE_COLLECTIONS_LENGTH/2.0, playButtonRect.origin.y + MAINPAGE_PLAY_LENGTH + MAINPAGE_PLAY_LENGTH/13.0, MAINPAGE_COLLECTIONS_LENGTH, MAINPAGE_COLLECTIONS_LENGTH);
        optionsButtonRect = CGRectMake(playButtonRect.origin.x-(MAINPAGE_PLAY_LENGTH/13.0), collections_mainPageRect.origin.y-(MAINPAGE_PLAY_LENGTH/13.0/2.0)-(MAINPAGE_OPTIONS_LENGTH/2.0), MAINPAGE_OPTIONS_LENGTH, MAINPAGE_OPTIONS_LENGTH);
        facebook_mainPageRect = CGRectMake(playButtonRect.origin.x+(MAINPAGE_PLAY_LENGTH/13.0)+(MAINPAGE_PLAY_LENGTH/2.0), optionsButtonRect.origin.y, MAINPAGE_FACEBOOK_LENGTH, MAINPAGE_FACEBOOK_LENGTH);
        
        themeButtonRect = CGRectMake(screenWidth/2.0 - THEMEBUTTON_WIDTH/2.0, screenHeight/2.0 - THEMEBUTTON_HEIGHT*5.4/10.0, THEMEBUTTON_WIDTH, THEMEBUTTON_HEIGHT);
        themeLockedRect = CGRectMake(screenWidth/2.0 - THEMELOCKED_WIDTH/2.0, screenHeight/2.0 - THEMELOCKED_HEIGHT*6.2/10.0, THEMELOCKED_WIDTH, THEMELOCKED_HEIGHT);
        lockedNote2Rect = CGRectMake(screenWidth/2.0-THEME2NOTE_WIDTH/2.0, themeLockedRect.origin.y+THEMELOCKED_HEIGHT*1.05, THEME2NOTE_WIDTH, THEMENOTE_HEIGHT);
        lockedNote3Rect = CGRectMake(screenWidth/2.0-THEME3NOTE_WIDTH/2.0, themeLockedRect.origin.y+THEMELOCKED_HEIGHT*1.05, THEME3NOTE_WIDTH, THEMENOTE_HEIGHT);
        lockedNote4Rect = CGRectMake(screenWidth/2.0-THEME4NOTE_WIDTH/2.0, themeLockedRect.origin.y+THEMELOCKED_HEIGHT*1.05, THEME4NOTE_WIDTH, THEMENOTE_HEIGHT);
        lockedNoteXRect = CGRectMake(screenWidth/2.0 - THEMEXNOTE_WIDTH/2.0, themeLockedRect.origin.y+THEMELOCKED_HEIGHT*1.05, THEMEXNOTE_WIDTH, THEMEXNOTE_HEIGHT);
        lockedNoteXFacebookRect = CGRectMake(screenWidth/2.0 - THEME_FB_WIDTH/2.0, lockedNoteXRect.origin.y + (lockedNoteXRect.size.height * 1.2), THEME_FB_WIDTH, THEME_FB_HEIGHT);
        
        backButtonRect = CGRectMake(screenWidth/25.0, screenHeight*39.0/40.0 - BACKBUTTON_LENGTH, BACKBUTTON_LENGTH, BACKBUTTON_LENGTH);
        shareInStickersRect = CGRectMake((screenWidth/2.0-SHAREINSTICKERS_WIDTH/2.0)+((backButtonRect.origin.x + backButtonRect.size.width)/2.0), backButtonRect.origin.y+(backButtonRect.size.height/2.0)-(SHAREINSTICKERS_HEIGHT/2.0), SHAREINSTICKERS_WIDTH, SHAREINSTICKERS_HEIGHT);
        
        //level buttons - starts
        levelButtonRects = [[NSMutableArray alloc] initWithCapacity:15];
        
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0)-(LEVELBUTTON_HEIGHT*2.4), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/2.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0)-(LEVELBUTTON_HEIGHT*2.4), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth*3.0/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0)-(LEVELBUTTON_HEIGHT*2.4), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0)-(LEVELBUTTON_HEIGHT*1.2) , LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/2.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0)-(LEVELBUTTON_HEIGHT*1.2) , LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth*3.0/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0)-(LEVELBUTTON_HEIGHT*1.2) , LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/2.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth*3.0/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)-(LEVELBUTTON_HEIGHT/2.0), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)+(LEVELBUTTON_HEIGHT/2.0)+(LEVELBUTTON_HEIGHT*0.2), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/2.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)+(LEVELBUTTON_HEIGHT/2.0)+(LEVELBUTTON_HEIGHT*0.2), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth*3.0/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)+(LEVELBUTTON_HEIGHT/2.0)+(LEVELBUTTON_HEIGHT*0.2), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)+(LEVELBUTTON_HEIGHT/2.0)+(LEVELBUTTON_HEIGHT*1.4), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth/2.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)+(LEVELBUTTON_HEIGHT/2.0)+(LEVELBUTTON_HEIGHT*1.4), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        [levelButtonRects addObject:[NSValue valueWithCGRect:CGRectMake(screenWidth*3.0/4.0 - LEVELBUTTON_WIDTH/2.0,(screenHeight*4.8/10.0)+(LEVELBUTTON_HEIGHT/2.0)+(LEVELBUTTON_HEIGHT*1.4), LEVELBUTTON_WIDTH, LEVELBUTTON_HEIGHT)]];
        //level buttons - ends
        
        statusBarRect = CGRectMake(screenWidth*1.0/40.0, STATUSBAR_HEIGHT/10.0, screenWidth*38.0/40.0, STATUSBAR_HEIGHT);
        pauseButtonRect = CGRectMake(statusBarRect.size.width/26.0, STATUSBAR_HEIGHT/2.0-PAUSEBUTTON_LENGTH/2.0, PAUSEBUTTON_LENGTH, PAUSEBUTTON_LENGTH);
        resetButtonRect = CGRectMake((statusBarRect.size.width*25.0/26.0)-RESETBUTTON_LENGTH, STATUSBAR_HEIGHT/2.0-RESETBUTTON_LENGTH/2.0, RESETBUTTON_LENGTH, RESETBUTTON_LENGTH);
        
        textGoalRect = CGRectMake(screenWidth/6.5, STATUSBAR_HEIGHT/2.0-STATUSTEXT_ANY_HEIGHT/2.0, STATUSTEXT_GOAL_WIDTH, STATUSTEXT_ANY_HEIGHT);
        textLevelRect = CGRectMake(screenWidth/2.8, STATUSBAR_HEIGHT/2.0-STATUSTEXT_ANY_HEIGHT/2.0, STATUSTEXT_LEVEL_WIDTH, STATUSTEXT_ANY_HEIGHT);
        textStepsRect = CGRectMake(screenWidth*6.0/10.0, STATUSBAR_HEIGHT/2.0-STATUSTEXT_ANY_HEIGHT/2.0, STATUSTEXT_STEPS_WIDTH, STATUSSTEPS_HEIGHT);
        
        numberGoal100Rect = CGRectMake(textGoalRect.origin.x + textGoalRect.size.width + (STATUSNUMBER_WIDTH/2.0), STATUSBAR_HEIGHT/2.0-(STATUSTEXT_ANY_HEIGHT*4.0/10.0), STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        numberGoal10Rect = CGRectMake(numberGoal100Rect.origin.x + numberGoal100Rect.size.width, numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        numberGoal0Rect = CGRectMake(numberGoal10Rect.origin.x + numberGoal10Rect.size.width, numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        
        numberLevel100Rect = CGRectMake(textLevelRect.origin.x + textLevelRect.size.width + (STATUSNUMBER_WIDTH/2.0), numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        numberLevel10Rect = CGRectMake(numberLevel100Rect.origin.x + numberLevel100Rect.size.width, numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        numberLevel0Rect = CGRectMake(numberLevel10Rect.origin.x + numberLevel10Rect.size.width, numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        
        numberSteps100Rect = CGRectMake(textStepsRect.origin.x + textStepsRect.size.width + (STATUSNUMBER_WIDTH/2.0), numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        numberSteps10Rect = CGRectMake(numberSteps100Rect.origin.x + numberSteps100Rect.size.width, numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);
        numberSteps0Rect = CGRectMake(numberSteps10Rect.origin.x + numberSteps10Rect.size.width, numberGoal100Rect.origin.y, STATUSNUMBER_WIDTH, STATUSNUMBER_HEIGHT);

        twoClocksRect = CGRectMake(screenWidth/2.0-CLOCK_LENGTH/2.0, (screenHeight/2.0) - (screenWidth*38.0/40.0/2.0), CLOCK_LENGTH, screenWidth*38.0/40.0);
        top2ClocksRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        bottom2ClocksRect = CGRectMake(0.0, twoClocksRect.size.height-CLOCK_LENGTH, CLOCK_LENGTH, CLOCK_LENGTH);
                
//        linkingArrowUp2ClocksRect = CGRectMake((CLOCK_LENGTH/2.0)-(CLOCK_LENGTH/4.0)-(arrowOffset), CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-(CLOCK_LENGTH*2));
//        linkingArrowDown2ClocksRect = CGRectMake(CLOCK_LENGTH/2.0+linkingArrowUp2ClocksRect.size.width/4.0, CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-CLOCK_LENGTH*2);

        linkingArrowUp2ClocksRect = CGRectMake((CLOCK_LENGTH/2.0)-(CLOCK_LENGTH/4.0)-(arrowOffset), CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-(CLOCK_LENGTH*2));
        linkingArrowDown2ClocksRect = CGRectMake(CLOCK_LENGTH/2.0+(arrowOffset), CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-CLOCK_LENGTH*2);
        
        fourClocksRect = CGRectMake(screenWidth/40.0, (screenHeight/2.0) - (screenWidth*38.0/40.0/2.0),screenWidth*38.0/40.0, screenWidth*38.0/40.0);
        topLeft4Rect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        topRight4Rect = CGRectMake(fourClocksRect.size.width-CLOCK_LENGTH, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        bottomLeft4Rect = CGRectMake(0.0, fourClocksRect.size.height-CLOCK_LENGTH, CLOCK_LENGTH, CLOCK_LENGTH);
        bottomRight4Rect = CGRectMake(fourClocksRect.size.width-CLOCK_LENGTH, fourClocksRect.size.height-CLOCK_LENGTH, CLOCK_LENGTH, CLOCK_LENGTH);
        
        threeClocksRect = CGRectMake(screenWidth/40.0, (screenHeight/2.0) - (screenWidth*38.0/40.0/2.0),screenWidth*38.0/40.0, screenWidth*38.0/40.0);
        topLeft3Rect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        topRight3Rect = CGRectMake(fourClocksRect.size.width-CLOCK_LENGTH, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        bottom3Rect = CGRectMake(threeClocksRect.size.width/2.0-CLOCK_LENGTH/2.0, threeClocksRect.size.height-CLOCK_LENGTH, CLOCK_LENGTH, CLOCK_LENGTH);
        
        //Arrows in 3-clock environment
        linkingArrowRight3ClocksSideTopRect = CGRectMake(CLOCK_LENGTH, (CLOCK_LENGTH/2.0)-(CLOCK_LENGTH/4.0)-(arrowOffset), twoClocksRect.size.height-(CLOCK_LENGTH*2), CLOCK_LENGTH/4.0);
        linkingArrowLeft3ClocksSideTopRect = CGRectMake(CLOCK_LENGTH, CLOCK_LENGTH/2.0+arrowOffset, twoClocksRect.size.height-(CLOCK_LENGTH*2), CLOCK_LENGTH/4.0);
        
        linkingArrow3ClocksToTopRightRect = CGRectMake(fourClocksRect.size.width-CLOCK_LENGTH+(diagonal3RectLength*3.6/4.0)-diagonal3RectLength, CLOCK_LENGTH-diagonal3RectLength/8.0, diagonal3RectLength, diagonal3VerticalRatio/diagonal3HorizontalRatio*diagonal3RectLength);
        linkingArrow3ClocksToTopLeftRect = CGRectMake(CLOCK_LENGTH-diagonal3RectLength*3.6/4.0, CLOCK_LENGTH-(diagonal3RectLength/9.5), diagonal3RectLength, diagonal3VerticalRatio/diagonal3HorizontalRatio*diagonal3RectLength);
        linkingArrow3ClocksToBottomFromTopLeftRect = CGRectMake(CLOCK_LENGTH*53.0/100.0, CLOCK_LENGTH * 1.02, diagonal3RectLength, diagonal3VerticalRatio/diagonal3HorizontalRatio*diagonal3RectLength);
        linkingArrow3ClocksToBottomFromTopRightRect = CGRectMake(threeClocksRect.size.width-(linkingArrow3ClocksToBottomFromTopLeftRect.origin.x) - diagonal3RectLength, linkingArrow3ClocksToBottomFromTopLeftRect.origin.y, diagonal3RectLength, diagonal3VerticalRatio/diagonal3HorizontalRatio*diagonal3RectLength);
        
        //Arrows in 4-clock environment
        //LEFTs
        linkingArrowUp4ClocksSideLeftRect = CGRectMake((CLOCK_LENGTH/2.0)-(CLOCK_LENGTH/4.0)-(arrowOffset), CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-(CLOCK_LENGTH*2));
        linkingArrowDown4ClocksSideLeftRect = CGRectMake(CLOCK_LENGTH/2.0+arrowOffset, CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-CLOCK_LENGTH*2);
        //RIGHTs
        linkingArrowUp4ClocksSideRightRect = CGRectMake(fourClocksRect.size.width-(CLOCK_LENGTH/2.0)-(CLOCK_LENGTH/4.0)-(arrowOffset), CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-(CLOCK_LENGTH*2));
        linkingArrowDown4ClocksSideRightRect = CGRectMake(fourClocksRect.size.width-(CLOCK_LENGTH/2.0)+(arrowOffset), CLOCK_LENGTH, CLOCK_LENGTH/4.0, twoClocksRect.size.height-(CLOCK_LENGTH*2));
        //TOPs
        linkingArrowRight4ClocksSideTopRect = CGRectMake(CLOCK_LENGTH, (CLOCK_LENGTH/2.0)-(CLOCK_LENGTH/4.0)-(arrowOffset), twoClocksRect.size.height-(CLOCK_LENGTH*2), CLOCK_LENGTH/4.0);
        linkingArrowLeft4ClocksSideTopRect = CGRectMake(CLOCK_LENGTH, CLOCK_LENGTH/2.0+arrowOffset, twoClocksRect.size.height-(CLOCK_LENGTH*2), CLOCK_LENGTH/4.0);
        
        //BOTTOMs
        linkingArrowRight4ClocksSideBottomRect = CGRectMake(CLOCK_LENGTH, fourClocksRect.size.width-(CLOCK_LENGTH/2.0)-(CLOCK_LENGTH/4.0)-(arrowOffset), twoClocksRect.size.height-(CLOCK_LENGTH*2), CLOCK_LENGTH/4.0);
        linkingArrowLeft4ClocksSideBottomRect = CGRectMake(CLOCK_LENGTH, fourClocksRect.size.width-(CLOCK_LENGTH/2.0)+(arrowOffset), twoClocksRect.size.height-(CLOCK_LENGTH*2), CLOCK_LENGTH/4.0);
        
        //Diagonal
        linkingArrow4ClocksToTopRightRect = CGRectMake(fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, diagonal4RectLength, diagonal4RectLength);
        linkingArrow4ClocksToBottomLeftRect = CGRectMake(fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, diagonal4RectLength, diagonal4RectLength);
        linkingArrow4ClocksToTopLeftRect = CGRectMake(fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, diagonal4RectLength, diagonal4RectLength);
        linkingArrow4ClocksToBottomRightRect = CGRectMake(fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, fourClocksRect.size.width/2.0-diagonal4RectLength/2.0, diagonal4RectLength, diagonal4RectLength);
        
        winPageRect = CGRectMake(screenWidth/2.0-WINPAGE_WIDTH/2.0, screenHeight/2.0 - WINPAGE_HEIGHT/2.0, WINPAGE_WIDTH, WINPAGE_HEIGHT);
        winGoodRect = CGRectMake(winPageRect.size.width/2.0 - WIN_GOOD_WIDTH/2.0, winPageRect.size.height/14.0, WIN_GOOD_WIDTH, WIN_LABEL_HEIGHT);
        winExcellentRect = CGRectMake(winPageRect.size.width/2.0 - WIN_EXCELLENT_WIDTH/2.0, winPageRect.size.height/14.0, WIN_EXCELLENT_WIDTH, WIN_LABEL_HEIGHT);
        winLeftStarRect = CGRectMake(winPageRect.size.width/2.0-STAR_LENGTH/6.0-STAR_LENGTH, winPageRect.size.height/5.0, STAR_LENGTH, STAR_LENGTH);
        winRightStarRect = CGRectMake(winPageRect.size.width/2.0+STAR_LENGTH/6.0, winPageRect.size.height/5.0, STAR_LENGTH, STAR_LENGTH);
        
        winStepsLabelRect = CGRectMake(winPageRect.size.width/2.0-WIN_STEPSLABEL_WIDTH/2.0-WINNUMBER_WIDTH/2.0, winPageRect.size.height*5.0/10.0, WIN_STEPSLABEL_WIDTH, WIN_STEPSLABEL_HEIGHT);
        winStepsDigitHundredRect = CGRectMake(winStepsLabelRect.origin.x + winStepsLabelRect.size.width + (WINNUMBER_WIDTH/3.0), winStepsLabelRect.origin.y + (winStepsLabelRect.size.height/6.0), WINNUMBER_WIDTH, WINNUMBER_HEIGHT);
        winStepsDigitTenRect = CGRectMake(winStepsDigitHundredRect.origin.x + winStepsDigitHundredRect.size.width, winStepsDigitHundredRect.origin.y, WINNUMBER_WIDTH, WINNUMBER_HEIGHT);
        winStepsDigitOneRect = CGRectMake(winStepsDigitTenRect.origin.x + winStepsDigitTenRect.size.width, winStepsDigitHundredRect.origin.y, WINNUMBER_WIDTH, WINNUMBER_HEIGHT);
        
        winGoalLabelRect = CGRectMake(winPageRect.size.width/2.0-WIN_GOALLABEL_WIDTH/2.0-WINNUMBER_WIDTH/2.0, winStepsLabelRect.origin.y+winStepsLabelRect.size.height+(WIN_STEPSLABEL_HEIGHT/2.0), WIN_GOALLABEL_WIDTH, WIN_GOALLABEL_HEIGHT);
        winGoalDigitHundredRect = CGRectMake(winGoalLabelRect.origin.x + winGoalLabelRect.size.width + (WINNUMBER_WIDTH/3.0), winGoalLabelRect.origin.y + (WINNUMBER_HEIGHT/10.0), WINNUMBER_WIDTH, WINNUMBER_HEIGHT);
        winGoalDigitTenRect = CGRectMake(winGoalDigitHundredRect.origin.x + winGoalDigitHundredRect.size.width, winGoalDigitHundredRect.origin.y, WINNUMBER_WIDTH, WINNUMBER_HEIGHT);
        winGoalDigitOneRect = CGRectMake(winGoalDigitTenRect.origin.x + winGoalDigitTenRect.size.width, winGoalDigitHundredRect.origin.y, WINNUMBER_WIDTH, WINNUMBER_HEIGHT);
        
        winResetRect = CGRectMake(winPageRect.size.width/4.0-WINPAGEBUTTONS_LENGTH/2.0, winPageRect.size.height*3.0/4.0, WINPAGEBUTTONS_LENGTH, WINPAGEBUTTONS_LENGTH);
        winLevelsRect = CGRectMake(winPageRect.size.width/2.0-WINPAGEBUTTONS_LENGTH/2.0, winPageRect.size.height*3.0/4.0, WINPAGEBUTTONS_LENGTH, WINPAGEBUTTONS_LENGTH);
        winNextRect = CGRectMake(winPageRect.size.width*3.0/4.0-WINPAGEBUTTONS_LENGTH/2.0, winPageRect.size.height*3.0/4.0, WINPAGEBUTTONS_LENGTH, WINPAGEBUTTONS_LENGTH);
        
        purchaseDigitHundredRect = CGRectMake(DURINGGAMEPLAY_INGAMEPURCHASE/2.0-PURCHASEDITEM_WIDTH/2.0-PURCHASEDITEM_WIDTH, DURINGGAMEPLAY_INGAMEPURCHASE - (PURCHASEDITEM_HEIGHT*2.0/3.0), PURCHASEDITEM_WIDTH, PURCHASEDITEM_HEIGHT);
        purchaseDigitTenRect = CGRectMake(DURINGGAMEPLAY_INGAMEPURCHASE/2.0-PURCHASEDITEM_WIDTH/2.0, DURINGGAMEPLAY_INGAMEPURCHASE - (PURCHASEDITEM_HEIGHT*2.0/3.0), PURCHASEDITEM_WIDTH, PURCHASEDITEM_HEIGHT);
        purchaseDigitOneRect = CGRectMake(DURINGGAMEPLAY_INGAMEPURCHASE/2.0+PURCHASEDITEM_WIDTH/2.0, DURINGGAMEPLAY_INGAMEPURCHASE - (PURCHASEDITEM_HEIGHT*2.0/3.0), PURCHASEDITEM_WIDTH, PURCHASEDITEM_HEIGHT);
        
        zodiacsRect = CGRectMake(CLOCK_LENGTH/2.0 - ZODIACS_LENGTH/2.0, CLOCK_LENGTH/2.0 - ZODIACS_LENGTH/2.0, ZODIACS_LENGTH, ZODIACS_LENGTH);
        
        leftStarLevelRect = CGRectMake(LEVELBUTTON_WIDTH-STARONLEVEL_LENGTH-(STARONLEVEL_LENGTH/2.0), LEVELBUTTON_HEIGHT-STARONLEVEL_LENGTH, STARONLEVEL_LENGTH, STARONLEVEL_LENGTH);
        rightStarLevelRect = CGRectMake(LEVELBUTTON_WIDTH-STARONLEVEL_LENGTH, LEVELBUTTON_HEIGHT-STARONLEVEL_LENGTH, STARONLEVEL_LENGTH, STARONLEVEL_LENGTH);
        
        level3DigitsLeftRect = CGRectMake(LEVELBUTTON_WIDTH/2.0-LEVELNUMBER_WIDTH/2.0-LEVELNUMBER_WIDTH, LEVELBUTTON_HEIGHT/2.0 - LEVELNUMBER_HEIGHT/2.0, LEVELNUMBER_WIDTH, LEVELNUMBER_HEIGHT);
        level3DigitsCentreRect = CGRectMake(LEVELBUTTON_WIDTH/2.0-LEVELNUMBER_WIDTH/2.0, LEVELBUTTON_HEIGHT/2.0 - LEVELNUMBER_HEIGHT/2.0, LEVELNUMBER_WIDTH, LEVELNUMBER_HEIGHT);
        level3DigitsRightRect = CGRectMake(LEVELBUTTON_WIDTH/2.0+LEVELNUMBER_WIDTH/2.0, LEVELBUTTON_HEIGHT/2.0 - LEVELNUMBER_HEIGHT/2.0, LEVELNUMBER_WIDTH, LEVELNUMBER_HEIGHT);
        
        level2DigitsLeftRect = CGRectMake(LEVELBUTTON_WIDTH/2.0-LEVELNUMBER_WIDTH, LEVELBUTTON_HEIGHT/2.0 - LEVELNUMBER_HEIGHT/2.0, LEVELNUMBER_WIDTH, LEVELNUMBER_HEIGHT);
        level2DigitsRightRect = CGRectMake(LEVELBUTTON_WIDTH/2.0, LEVELBUTTON_HEIGHT/2.0 - LEVELNUMBER_HEIGHT/2.0, LEVELNUMBER_WIDTH, LEVELNUMBER_HEIGHT);
        
        level1DigitRect = CGRectMake(LEVELBUTTON_WIDTH/2.0-LEVELNUMBER_WIDTH/2.0, LEVELBUTTON_HEIGHT/2.0 - LEVELNUMBER_HEIGHT/2.0, LEVELNUMBER_WIDTH, LEVELNUMBER_HEIGHT);
        
        gameplayPurchaseRect = CGRectMake(screenWidth*39.0/40.0 - DURINGGAMEPLAY_INGAMEPURCHASE_W, screenHeight*39.0/40.0 - DURINGGAMEPLAY_INGAMEPURCHASE, DURINGGAMEPLAY_INGAMEPURCHASE_W, DURINGGAMEPLAY_INGAMEPURCHASE);
        gameplayHelpRect = CGRectMake(screenWidth*38.0/40.0 - DURINGGAMEPLAY_HELP - DURINGGAMEPLAY_INGAMEPURCHASE_W, screenHeight*39.0/40.0 - DURINGGAMEPLAY_HELP, DURINGGAMEPLAY_HELP, DURINGGAMEPLAY_HELP);
        
        notifBarRect = CGRectMake(screenWidth*1.0/40.0, screenHeight*39.0/40.0-NOTIFBAR_HEIGHT, NOTIFBAR_WIDTH, NOTIFBAR_HEIGHT);
        
        collectionsLongRect = CGRectMake(0.0, 0.0 - screenHeight * 0.25, screenWidth, screenHeight * 4.0); //<-- height is questionable
        achievementRect = CGRectMake(screenWidth - screenWidth/20.0 - ACHIEVEMENTBUTTON_LENGTH, screenHeight/40.0, ACHIEVEMENTBUTTON_LENGTH, ACHIEVEMENTBUTTON_LENGTH);
        
        //ordinaryAch, sleepyAch, flowerAch, reversedAch, ninjaAch, icyAch, devilAch, angelAch, chineseAch, brokenAch;
        ordinaryAch = CGRectMake(screenWidth/10.0, collectionsLongRect.size.height*17.0/100.0, ORDINARYACH_LENGTH, ORDINARYACH_LENGTH);
        sleepyAch = CGRectMake(screenWidth*55.0/100.0, collectionsLongRect.size.height*20.0/100.0, SLEEPYACH_LENGTH, SLEEPYACH_LENGTH);
        flowerAch = CGRectMake(screenWidth*58.0/100.0, collectionsLongRect.size.height*26.0/100.0, FLOWERACH_LENGTH, FLOWERACH_LENGTH);
        reversedAch = CGRectMake(screenWidth*11.0/100.0, collectionsLongRect.size.height*28.0/100.0, REVERSED_LENGTH, REVERSED_LENGTH);
        ninjaAch = CGRectMake(screenWidth*30.0/100.0, collectionsLongRect.size.height*34.0/100.0, NINJAACH_LENGTH, NINJAACH_LENGTH);
        icyAch = CGRectMake(screenWidth*40.0/100.0, collectionsLongRect.size.height*43.0/100.0, ICYACH_LENGTH, ICYACH_LENGTH);
        devilAch = CGRectMake(screenWidth*15.0/100.0, collectionsLongRect.size.height*50.0/100.0, DEVILACH_LENGTH, DEVILACH_LENGTH);
        angelAch = CGRectMake(screenWidth*40.0/100.0, collectionsLongRect.size.height*57.0/100.0, ANGELACH_LENGTH, ANGELACH_LENGTH);
        chineseAch = CGRectMake(screenWidth*57.0/100.0, collectionsLongRect.size.height*65.0/100.0, CHINESE_LENGTH, CHINESE_LENGTH);
        brokenAch = CGRectMake(screenWidth*35.0/100.0, collectionsLongRect.size.height*72.0/100.0, BROKEN_LENGTH, BROKEN_LENGTH);
        
        tutorialBoard = CGRectMake(screenWidth/2.0-TUTBOARD_WIDTH/2.0, screenHeight/2.0-TUTBOARD_HEIGHT/2.0, TUTBOARD_WIDTH, TUTBOARD_HEIGHT);
        backTutorialRect = CGRectMake(tutorialBoard.size.width/2.0-TUTORIALBACK_WIDTH/2.0, tutorialBoard.size.height-TUTORIALBACK_HEIGHT-(TUTORIALBACK_HEIGHT*1.3), TUTORIALBACK_WIDTH, TUTORIALBACK_HEIGHT);
        
        achBoardRect = CGRectMake(screenWidth/2.0-ACHBOARD_WIDTH/2.0, screenHeight/2.0-ACHBOARD_HEIGHT/2.0, ACHBOARD_WIDTH, ACHBOARD_HEIGHT);
        backAchBoardRect = CGRectMake(achBoardRect.size.width/2.0-ACHBACK_WIDTH/2.0, achBoardRect.size.height-ACHBACK_HEIGHT-(ACHBACK_HEIGHT*3.0/4.0), ACHBACK_WIDTH, ACHBACK_HEIGHT);
        rateAndLikeRect = CGRectMake(achBoardRect.size.width/2.0-LIKERATE_WIDTH/2.0, backAchBoardRect.origin.y-LIKERATE_HEIGHT-(LIKERATE_HEIGHT/8.0), LIKERATE_WIDTH, LIKERATE_HEIGHT);
        achBannerRect = CGRectMake(0.0, 0.0, BANNER_WIDTH, BANNER_HEIGHT);
        
        premiumBoardRect = CGRectMake(screenWidth/2.0-PREMIUM_BOARD_WIDTH/2.0, screenHeight/2.0-PREMIUM_BOARD_HEIGHT/2.0, PREMIUM_BOARD_WIDTH, PREMIUM_BOARD_HEIGHT);
        unlockPremiumRect = CGRectMake(premiumBoardRect.size.width/2.0-UNLOCK_WIDTH/2.0, premiumBoardRect.size.height-UNLOCK_HEIGHT-(UNLOCK_HEIGHT*3.0/4.0), UNLOCK_WIDTH, UNLOCK_HEIGHT);
        
        
        afterSlashRect = CGRectMake(screenWidth-(screenWidth/20.0)-SLASHNUMBER_WIDTH, screenHeight/40.0+ACHLABEL_HEIGHT-ACHNUMBER_HEIGHT + (ACHNUMBER_HEIGHT/3.0), AFTERSLASH_WIDTH, ACHNUMBER_HEIGHT);
        slashNumberRect = CGRectMake(afterSlashRect.origin.x - SLASHNUMBER_WIDTH, afterSlashRect.origin.y, SLASHNUMBER_WIDTH, ACHNUMBER_HEIGHT);
        beforeSlashRect = CGRectMake(slashNumberRect.origin.x - STICKERSNUMBER_WIDTH, slashNumberRect.origin.y, STICKERSNUMBER_WIDTH, ACHNUMBER_HEIGHT);
        stickersLabelRect = CGRectMake(beforeSlashRect.origin.x - STICKERSLABEL_WIDTH - (STICKERSNUMBER_WIDTH/2.0), screenHeight/40.0 + (ACHNUMBER_HEIGHT/3.0), STICKERSLABEL_WIDTH, ACHLABEL_HEIGHT);
        
        inAppCloseRect = CGRectMake(achBoardRect.size.width-INAPPCLOSE_LENGTH-(INAPPCLOSE_LENGTH/4.0), 0.0, INAPPCLOSE_LENGTH, INAPPCLOSE_LENGTH);
        inAppPrice1Rect = CGRectMake(achBoardRect.size.width/2.0-INAPPPRICE_WIDTH-(INAPPPRICE_WIDTH/15.0), achBoardRect.size.height*4.5/10.0, INAPPPRICE_WIDTH, INAPPPRICE_HEIGHT);
        inAppPrice2Rect = CGRectMake(achBoardRect.size.width/2.0+(INAPPPRICE_WIDTH/15.0), inAppPrice1Rect.origin.y, INAPPPRICE_WIDTH, INAPPPRICE_HEIGHT);
        inAppPrice3Rect = CGRectMake(inAppPrice1Rect.origin.x-(INAPPPRICE_WIDTH*1.0/20.0), inAppPrice1Rect.origin.y+INAPPPRICE_HEIGHT+(INAPPPRICE_HEIGHT/10.0)-(INAPPPRICE_WIDTH*1.0/20.0), INAPPPRICE_WIDTH*10.5/10.0, INAPPPRICE_HEIGHT*10.5/10.0);
        inAppPrice4Rect = CGRectMake(inAppPrice2Rect.origin.x, inAppPrice1Rect.origin.y+INAPPPRICE_HEIGHT+(INAPPPRICE_HEIGHT/10.0), INAPPPRICE_WIDTH, INAPPPRICE_HEIGHT);
        
        //Inside free purchases - starts
        purchaseFacebookRect = CGRectMake(achBoardRect.size.width/2.0-INAPPPRICE_WIDTH/2.0, achBoardRect.size.height*1.3/5.0, INAPPPRICE_WIDTH, INAPPPRICE_HEIGHT);
        purchaseShareRect = CGRectMake(achBoardRect.size.width/2.0-INAPPPRICE_WIDTH/2.0, purchaseFacebookRect.origin.y+INAPPPRICE_HEIGHT + (INAPPPRICE_HEIGHT/3.0), INAPPPRICE_WIDTH, INAPPPRICE_HEIGHT);
//        purchaseRateRect = CGRectMake(achBoardRect.size.width/2.0-INAPPPRICE_WIDTH/2.0, purchaseShareRect.origin.y+INAPPPRICE_HEIGHT + (INAPPPRICE_HEIGHT/6.0), INAPPPRICE_WIDTH, INAPPPRICE_HEIGHT);
        //Insude free purchases - ends
        
        //Inside pause menu - starts
        pauseResumeRect = CGRectMake(achBoardRect.size.width/2.0-INSIDEPAUSEBUTTON_WIDTH/2.0, achBoardRect.size.height*2.6/10.0, INSIDEPAUSEBUTTON_WIDTH, INSIDEPAUSEBUTTON_HEIGHT);
        pauseMainRect = CGRectMake(achBoardRect.size.width/2.0-INSIDEPAUSEBUTTON_WIDTH/2.0, pauseResumeRect.origin.y+INSIDEPAUSEBUTTON_HEIGHT+INSIDEPAUSEBUTTON_HEIGHT, INSIDEPAUSEBUTTON_WIDTH, INSIDEPAUSEBUTTON_HEIGHT);
        pausePurchaseRect = CGRectMake(achBoardRect.size.width/2.0-INSIDEPAUSEBUTTON_WIDTH/2.0, pauseMainRect.origin.y+INSIDEPAUSEBUTTON_HEIGHT+INSIDEPAUSEBUTTON_HEIGHT, INSIDEPAUSEBUTTON_WIDTH, INSIDEPAUSEBUTTON_HEIGHT);
        //Inside pause menu - ends
        
        capsuleAtTopLeft = CGRectMake(screenWidth/25.0, screenHeight*0.5/40.0, CAPSULE_TOPLEFT_WIDTH, CAPSULE_TOPLEFT_HEIGHT);
        capsuleAtBottomRight = CGRectMake(screenWidth*24.0/25.0 - CAPSULE_TOPLEFT_WIDTH, screenHeight*39.0/40.0 - CAPSULE_TOPLEFT_HEIGHT, CAPSULE_TOPLEFT_WIDTH, CAPSULE_TOPLEFT_HEIGHT);
        
        totalStarImageRect = CGRectMake(screenWidth*24.0/25.0 - TOTALSTAR_WIDTH, capsuleAtTopLeft.origin.y + (CAPSULE_TOPLEFT_HEIGHT/2.0) - (TOTALSTAR_HEIGHT/2.0), TOTALSTAR_WIDTH, TOTALSTAR_HEIGHT);
        totalDigitOneRRect = CGRectMake(totalStarImageRect.origin.x - (TOTALNUMBER_WIDTH * 1.3), totalStarImageRect.origin.y, TOTALNUMBER_WIDTH, TOTALNUMBER_HEIGHT);
        totalDigitTenRRect = CGRectMake(totalDigitOneRRect.origin.x - TOTALNUMBER_WIDTH, totalDigitOneRRect.origin.y, TOTALNUMBER_WIDTH, TOTALNUMBER_HEIGHT);
        totalDigitHundredRRect = CGRectMake(totalDigitTenRRect.origin.x - TOTALNUMBER_WIDTH, totalDigitOneRRect.origin.y, TOTALNUMBER_WIDTH, TOTALNUMBER_HEIGHT);
        totalSlashRect = CGRectMake(totalDigitHundredRRect.origin.x - TOTALSLASH_WIDTH, totalDigitOneRRect.origin.y, TOTALSLASH_WIDTH, TOTALSLASH_HEIGHT);
        totalDigitOneLRect = CGRectMake(totalSlashRect.origin.x - TOTALNUMBER_WIDTH, totalDigitOneRRect.origin.y, TOTALNUMBER_WIDTH, TOTALNUMBER_HEIGHT);
        totalDigitTenLRect = CGRectMake(totalDigitOneLRect.origin.x - TOTALNUMBER_WIDTH, totalDigitOneRRect.origin.y, TOTALNUMBER_WIDTH, TOTALNUMBER_HEIGHT);
        totalDigitHundredLRect = CGRectMake(totalDigitTenLRect.origin.x - TOTALNUMBER_WIDTH, totalDigitOneRRect.origin.y, TOTALNUMBER_WIDTH, TOTALNUMBER_HEIGHT);
        
        clockShadow2T = CGRectMake(top2ClocksRect.origin.x + (top2ClocksRect.size.width / 20.0), top2ClocksRect.origin.y + (top2ClocksRect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow2B = CGRectMake(bottom2ClocksRect.origin.x + (bottom2ClocksRect.size.width / 20.0), bottom2ClocksRect.origin.y + (bottom2ClocksRect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow3TL = CGRectMake(topLeft3Rect.origin.x + (topLeft3Rect.size.width / 20.0), topLeft3Rect.origin.y + (topLeft3Rect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow3TR = CGRectMake(topRight3Rect.origin.x + (topRight3Rect.size.width / 20.0), topRight3Rect.origin.y + (topRight3Rect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow3B = CGRectMake(bottom3Rect.origin.x + (bottom3Rect.size.width / 20.0), bottom3Rect.origin.y + (bottom3Rect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow4TL = CGRectMake(topLeft4Rect.origin.x + (topLeft4Rect.size.width / 20.0), topLeft4Rect.origin.y + (topLeft4Rect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow4TR = CGRectMake(topRight4Rect.origin.x + (topRight4Rect.size.width / 20.0), topRight4Rect.origin.y + (topRight4Rect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow4BR = CGRectMake(bottomRight4Rect.origin.x + (bottomRight4Rect.size.width / 20.0), bottomRight4Rect.origin.y + (bottomRight4Rect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        clockShadow4BL = CGRectMake(bottomLeft4Rect.origin.x + (bottomLeft4Rect.size.width / 20.0), bottomLeft4Rect.origin.y + (bottomLeft4Rect.size.height / 20.0), CLOCK_LENGTH, CLOCK_LENGTH);
        
        ordinaryFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        reversedFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        sleepyFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        dizzyFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        flowerFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        romanFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        ninjaFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        icyFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        twoFaceFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        chineseFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        brokenFlashRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        
//        ordinaryHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        reversedHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        sleepyHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        dizzyHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        flowerHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        romanHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        ninjaHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        icyHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        twofaceHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        chineseHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
//        brokenHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        
        ordinaryHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        reversedHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        sleepyHandRect = CGRectMake(0.0, 0.0 - (CLOCK_LENGTH/50.0), CLOCK_LENGTH, CLOCK_LENGTH);
        dizzyHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        flowerHandRect = CGRectMake(0.0, 0.0 + (CLOCK_LENGTH/23.0), CLOCK_LENGTH, CLOCK_LENGTH);
        romanHandRect = CGRectMake(0.0, 0.0 + (CLOCK_LENGTH/50.0), CLOCK_LENGTH, CLOCK_LENGTH);
        ninjaHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        icyHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        twofaceHandRect = CGRectMake(0.0, 0.0  + (CLOCK_LENGTH/23.0), CLOCK_LENGTH, CLOCK_LENGTH);
        chineseHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        brokenHandRect = CGRectMake(0.0, 0.0, CLOCK_LENGTH, CLOCK_LENGTH);
        
        //HELP PAGE - starts
        helpOrdinaryRect = CGRectMake(screenWidth*20.0/100.0 - HELP_OBJECT/2.0, screenHeight*15.0/100.0 - HELP_OBJECT/2.0, HELP_OBJECT, HELP_OBJECT);
        helpArrowRect = CGRectMake(screenWidth*50.0/100.0 - HELP_OBJECT/2.0, helpOrdinaryRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        helpReversedRect = CGRectMake(screenWidth*80.0/100.0 - HELP_OBJECT/2.0, helpOrdinaryRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        
        helpSleepyRect = CGRectMake(helpOrdinaryRect.origin.x, screenHeight*35.0/100.0 - HELP_OBJECT/2.0, HELP_OBJECT, HELP_OBJECT);
        helpDizzyRect = CGRectMake(helpArrowRect.origin.x, helpSleepyRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        helpFlowerRect = CGRectMake(helpReversedRect.origin.x, helpSleepyRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        
        helpRomanRect = CGRectMake(helpOrdinaryRect.origin.x, screenHeight*55.0/100.0 - HELP_OBJECT/2.0, HELP_OBJECT, HELP_OBJECT);
        helpNinjaRect = CGRectMake(helpArrowRect.origin.x, helpRomanRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        helpIcyRect = CGRectMake(helpReversedRect.origin.x, helpRomanRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        
        helpTwoFaceRect = CGRectMake(helpOrdinaryRect.origin.x, screenHeight*75.0/100.0 - HELP_OBJECT/2.0, HELP_OBJECT, HELP_OBJECT);
        helpChineseRect = CGRectMake(helpArrowRect.origin.x, helpTwoFaceRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        helpBrokenRect = CGRectMake(helpReversedRect.origin.x, helpTwoFaceRect.origin.y, HELP_OBJECT, HELP_OBJECT);
        
        backButtonFromHelpRect = CGRectMake(screenWidth/2.0 - (HELP_OBJECT*1.6/2.0), helpChineseRect.origin.y + (HELP_OBJECT*1.2), HELP_OBJECT*1.6, HELP_OBJECT/2.4);
        //HELP PAGE - ends
        
        congratsBoardRect = CGRectMake(screenWidth/2.0 - CONGRATSBOARD_WIDTH/2.0, screenHeight/2.0 - CONGRATSBOARD_HEIGHT*5.5/10.0, CONGRATSBOARD_WIDTH, CONGRATSBOARD_HEIGHT);
        bottomCenterButtonRect = CGRectMake(screenWidth/2.0 - BOTTOMCENTER_WIDTH/2.0, congratsBoardRect.origin.y + congratsBoardRect.size.height + (BOTTOMCENTER_HEIGHT/5.0), BOTTOMCENTER_WIDTH, BOTTOMCENTER_HEIGHT);
        
        themeLeftRect = CGRectMake(themeLockedRect.origin.x - (themeLockedRect.size.width * 0.1) - THEMEARROW_WIDTH, (screenHeight*4.8/10.0) - THEMEARROW_HEIGHT/2.0, THEMEARROW_WIDTH, THEMEARROW_HEIGHT);
        themeRightRect = CGRectMake(themeLockedRect.origin.x + (themeLockedRect.size.width * 1.1), themeLeftRect.origin.y, THEMEARROW_WIDTH, THEMEARROW_HEIGHT);
        
        processingRect = CGRectMake(screenWidth/2.0-PROCESSING_WIDTH/2.0, screenHeight/2.0-PROCESSING_HEIGHT/2.0, PROCESSING_WIDTH, PROCESSING_HEIGHT);
        loadingRect = CGRectMake(screenWidth/2.0 - LOADING_WIDTH/2.0, screenHeight/2.0 - LOADING_HEIGHT/2.0, LOADING_WIDTH, LOADING_HEIGHT);
        
        //CGRect creditsLongRect, creditsContentRect, creditsTitleRect;
        creditsLongRect = CGRectMake(0.0, 0.0 - screenHeight * 0.25, screenWidth, screenHeight * 4.0);
        creditsContentRect = CGRectMake(screenWidth/2.0 - CREDITS_CONTENT_WIDTH/2.0, creditsLongRect.size.height*15.0/100.0, CREDITS_CONTENT_WIDTH, CREDITS_CONTENT_HEIGHT);
        creditsTitleRect = CGRectMake(screenWidth*5.0/100.0, creditsLongRect.size.height*13.0/100.0, CREDITS_TITLE_LENGTH, CREDITS_TITLE_LENGTH);
        
        [self generateLevels];
    }
    
    return self;
}

-(CGRect) getClickedButton:(CGRect) defaultRect {
    return CGRectMake(defaultRect.origin.x + (defaultRect.size.width / 20.0), defaultRect.origin.y + (defaultRect.size.height / 20.0), defaultRect.size.width *18.0 / 20.0, defaultRect.size.height * 18.0 / 20.0);
}

-(void) generateLevels {
    levels = [[NSMutableArray alloc] initWithCapacity:1];
    clocks = [[NSMutableArray alloc] initWithCapacity:4];
    arrows = [[NSMutableArray alloc] initWithCapacity:12];
    
    //create levels when needed, then destroy! Don't populate all levels at once!!
}

//-(void) resetNotifBarRect {
//    notifBarRect = notifBarConstantRect;
//}
//
//-(void) updateNotifWithTime:(CFTimeInterval) timestamp {
//    if (lastTime == 0.0) {
//        lastTime = timestamp;
//    } else {
//        timeDelta = timestamp - lastTime;
//        lastTime = timestamp;
//        
//        notifBarRect.origin.y += notifVelocity.y * timeDelta;
//    }
//}

-(void) populateLevel:(int)number {
    switch (number) {
        case 1:
            currentTheme = 1;
            [self populateLevel1];
            break;
        case 2:
            [self populateLevel2];
            break;
        case 3:
            [self populateLevel3];
            break;
        case 4:
            [self populateLevel4];
            break;
        case 5:
            [self populateLevel5];
            break;
        case 6:
            [self populateLevel6];
            break;
        case 7:
            [self populateLevel7];
            break;
        case 8:
            [self populateLevel8];
            break;
        case 9:
            [self populateLevel9];
            break;
        case 10:
            [self populateLevel10];
            break;
        case 11:
            [self populateLevel11];
            break;
        case 12:
            [self populateLevel12];
            break;
        case 13:
            [self populateLevel13];
            break;
        case 14:
            [self populateLevel14];
            break;
        case 15:
            [self populateLevel15];
            break;
        case 16:
            [self populateLevel16];
            break;
        case 17:
            [self populateLevel17];
            break;
        case 18:
            [self populateLevel18];
            break;
        case 19:
            [self populateLevel19];
            break;
        case 20:
            [self populateLevel20];
            break;
        case 21:
            [self populateLevel21];
            break;
        case 22:
            [self populateLevel22];
            break;
        case 23:
            [self populateLevel23];
            break;
        case 24:
            [self populateLevel24];
            break;
        case 25:
            [self populateLevel25];
            break;
        case 26:
            [self populateLevel26];
            break;
        case 27:
            [self populateLevel27];
            break;
        case 28:
            [self populateLevel28];
            break;
        case 29:
            [self populateLevel29];
            break;
        case 30:
            [self populateLevel30];
            break;
        case 31:
            currentTheme = 2;
            [self populateLevel31];
            break;
        case 32:
            [self populateLevel32];
            break;
        case 33:
            [self populateLevel33];
            break;
        case 34:
            [self populateLevel34];
            break;
        case 35:
            [self populateLevel35];
            break;
        case 36:
            [self populateLevel36];
            break;
        case 37:
            [self populateLevel37];
            break;
        case 38:
            [self populateLevel38];
            break;
        case 39:
            [self populateLevel39];
            break;
        case 40:
            [self populateLevel40];
            break;
        case 41:
            [self populateLevel41];
            break;
        case 42:
            [self populateLevel42];
            break;
        case 43:
            [self populateLevel43];
            break;
        case 44:
            [self populateLevel44];
            break;
        case 45:
            [self populateLevel45];
            break;
        case 46:
            [self populateLevel46];
            break;
        case 47:
            [self populateLevel47];
            break;
        case 48:
            [self populateLevel48];
            break;
        case 49:
            [self populateLevel49];
            break;
        case 50:
            [self populateLevel50];
            break;
        case 51:
            [self populateLevel51];
            break;
        case 52:
            [self populateLevel52];
            break;
        case 53:
            [self populateLevel53];
            break;
        case 54:
            [self populateLevel54];
            break;
        case 55:
            [self populateLevel55];
            break;
        case 56:
            [self populateLevel56];
            break;
        case 57:
            [self populateLevel57];
            break;
        case 58:
            [self populateLevel58];
            break;
        case 59:
            [self populateLevel59];
            break;
        case 60:
            [self populateLevel60];
            break;
        case 61:
            currentTheme = 3;
            [self populateLevel61];
            break;
        case 62:
            [self populateLevel62];
            break;
        case 63:
            [self populateLevel63];
            break;
        case 64:
            [self populateLevel64];
            break;
        case 65:
            [self populateLevel65];
            break;
        case 66:
            [self populateLevel66];
            break;
        case 67:
            [self populateLevel67];
            break;
        case 68:
            [self populateLevel68];
            break;
        case 69:
            [self populateLevel69];
            break;
        case 70:
            [self populateLevel70];
            break;
        case 71:
            [self populateLevel71];
            break;
        case 72:
            [self populateLevel72];
            break;
        case 73:
            [self populateLevel73];
            break;
        case 74:
            [self populateLevel74];
            break;
        case 75:
            [self populateLevel75];
            break;
        case 76:
            [self populateLevel76];
            break;
        case 77:
            [self populateLevel77];
            break;
        case 78:
            [self populateLevel78];
            break;
        case 79:
            [self populateLevel79];
            break;
        case 80:
            [self populateLevel80];
            break;
        case 81:
            [self populateLevel81];
            break;
        case 82:
            [self populateLevel82];
            break;
        case 83:
            [self populateLevel83];
            break;
        case 84:
            [self populateLevel84];
            break;
        case 85:
            [self populateLevel85];
            break;
        case 86:
            [self populateLevel86];
            break;
        case 87:
            [self populateLevel87];
            break;
        case 88:
            [self populateLevel88];
            break;
        case 89:
            [self populateLevel89];
            break;
        case 90:
            [self populateLevel90];
            break;
        case 91:
            currentTheme = 4;
            [self populateLevel91];
            break;
        case 92:
            [self populateLevel92];
            break;
        case 93:
            [self populateLevel93];
            break;
        case 94:
            [self populateLevel94];
            break;
        case 95:
            [self populateLevel95];
            break;
        case 96:
            [self populateLevel96];
            break;
        case 97:
            [self populateLevel97];
            break;
        case 98:
            [self populateLevel98];
            break;
        case 99:
            [self populateLevel99];
            break;
        case 100:
            [self populateLevel100];
            break;
        case 101:
            [self populateLevel101];
            break;
        case 102:
            [self populateLevel102];
            break;
        case 103:
            [self populateLevel103];
            break;
        case 104:
            [self populateLevel104];
            break;
        case 105:
            [self populateLevel105];
            break;
        case 106:
            [self populateLevel106];
            break;
        case 107:
            [self populateLevel107];
            break;
        case 108:
            [self populateLevel108];
            break;
        case 109:
            [self populateLevel109];
            break;
        case 110:
            [self populateLevel110];
            break;
        case 111:
            [self populateLevel111];
            break;
        case 112:
            [self populateLevel112];
            break;
        case 113:
            [self populateLevel113];
            break;
        case 114:
            [self populateLevel114];
            break;
        case 115:
            [self populateLevel115];
            break;
        case 116:
            [self populateLevel116];
            break;
        case 117:
            [self populateLevel117];
            break;
        case 118:
            [self populateLevel118];
            break;
        case 119:
            [self populateLevel119];
            break;
        case 120:
            [self populateLevel120];
            break;
        default:
            NSLog(@"Logic Error! No such level!");
            break;
    }
}

//Max diagonal arrow is 1!!!!!!

//Clocks position (2clocks)
//1
//2
//Clocks position (2clocks)

//Clocks position (4clocks)
//1    2
//4    3
//Clocks position (4clocks)

-(void) populateLevel1 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:1 clocksArg:clocks arrowsArg:arrows goalArg:9];
    [levels addObject:level];
}

-(void) populateLevel2 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:2 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel3 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:3 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel4 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:4 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

////test only
//-(void) populateLevel5 {
//    [self cleanUpArrays];
//    
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10];
//    [clocks addObject:regularClock];
//    
//    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
//    [arrows addObject:arrow];
//    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
//    [arrows addObject:arrow];
//    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
//    [arrows addObject:arrow];
//    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
//    [arrows addObject:arrow];
//    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
//    [arrows addObject:arrow];
//    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
//    [arrows addObject:arrow];
//    
//    level = [[Level alloc] initWithParamsArgLevelNumberArg:5 clocksArg:clocks arrowsArg:arrows goalArg:3];
//    [levels addObject:level];
//}

//real
-(void) populateLevel5 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:5 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel6 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:6 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel7 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:7 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel8 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:8 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel9 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:9 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel10 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:10 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel11 {
    [self cleanUpArrays];

    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:11 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel12 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:12 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel13 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:13 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel14 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:14 clocksArg:clocks arrowsArg:arrows goalArg:7];
    [levels addObject:level];
}

-(void) populateLevel15 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:15 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel16 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:16 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel17 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:17 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel18 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:18 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel19 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:19 clocksArg:clocks arrowsArg:arrows goalArg:8];
    [levels addObject:level];
}

-(void) populateLevel20 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:20 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel21 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:1 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:dizzyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:21 clocksArg:clocks arrowsArg:arrows goalArg:7];
    [levels addObject:level];
}

-(void) populateLevel22 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:9 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:dizzyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:22 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel23 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:3 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:23 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel24 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:dizzyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:24 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel25 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:dizzyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:25 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel26 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:2 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:dizzyClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:26 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel27 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:dizzyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:1 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:27 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel28 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:dizzyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:28 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel29 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:sleepyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:dizzyClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:29 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel30 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:sleepyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:dizzyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:30 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel31 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:lazyFlower];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:31 clocksArg:clocks arrowsArg:arrows goalArg:9];
    [levels addObject:level];
}

-(void) populateLevel32 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:lazyFlower];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:32 clocksArg:clocks arrowsArg:arrows goalArg:8];
    [levels addObject:level];
}

-(void) populateLevel33 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:33 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel34 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:34 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel35 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:35 clocksArg:clocks arrowsArg:arrows goalArg:8];
    [levels addObject:level];
}

-(void) populateLevel36 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:lazyFlower];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:2 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:dizzyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:36 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel37 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:lazyFlower];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:37 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel38 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:1 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:dizzyClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:lazyFlower];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:38 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel39 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:2 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:dizzyClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:39 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel40 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:dizzyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:40 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel41 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:romanClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:41 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel42 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:romanClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:42 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel43 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:romanClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:43 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel44 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:romanClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:44 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel45 {
    [self cleanUpArrays];
    
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:romanClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:45 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel46 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:romanClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:46 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel47 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:romanClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:47 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel48 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:dizzyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:romanClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:48 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel49 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:lazyFlower];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:lazyFlower];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:romanClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:49 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel50 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:romanClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:50 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel51 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:51 clocksArg:clocks arrowsArg:arrows goalArg:9];
    [levels addObject:level];
}

-(void) populateLevel52 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:52 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel53 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:53 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel54 {
    [self cleanUpArrays];
    
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:ninjaClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:54 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel55 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:ninjaClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:55 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel56 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:56 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel57 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:ninjaClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:57 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel58 {
    [self cleanUpArrays];
    
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:ninjaClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:58 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel59 {
    [self cleanUpArrays];
    
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:romanClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:dizzyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:59 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel60 {
    [self cleanUpArrays];
    
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:ninjaClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:romanClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:lazyFlower];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:60 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel61 {
    [self cleanUpArrays];
    
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:voidClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:61 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel62 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:voidClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:62 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel63 {
    [self cleanUpArrays];
    
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:voidClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:63 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel64 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:voidClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:64 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel65 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:voidClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:65 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel66 {
    [self cleanUpArrays];
    
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:romanClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:voidClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:66 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel67 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:dizzyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:5 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:voidClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:67 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel68 {
    [self cleanUpArrays];
    
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:voidClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:dizzyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:68 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel69 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:lazyFlower];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:voidClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:69 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel70 {
    [self cleanUpArrays];
    
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:dizzyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:ninjaClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:voidClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:70 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

//-(void) populateLevel71 {
//    [self cleanUpArrays];
//    
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5];
//    [clocks addObject:regularClock];
//    
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:1 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:2 destinationArg:1];
//    [arrows addObject:explosiveArrow];
//    
//    level = [[Level alloc] initWithParamsArgLevelNumberArg:71 clocksArg:clocks arrowsArg:arrows goalArg:5];
//    [levels addObject:level];
//}
//
//-(void) populateLevel72 {
//    [self cleanUpArrays];
//    
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:2];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5];
//    [clocks addObject:regularClock];
//    
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:1 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:1 destinationArg:3];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:2 destinationArg:3];
//    [arrows addObject:explosiveArrow];
//    
//    level = [[Level alloc] initWithParamsArgLevelNumberArg:72 clocksArg:clocks arrowsArg:arrows goalArg:4];
//    [levels addObject:level];
//}
//
//-(void) populateLevel73 {
//    [self cleanUpArrays];
//    
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:12];
//    [clocks addObject:regularClock];
//    
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:1 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:2 destinationArg:1];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:3 destinationArg:1];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:3 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:2 destinationArg:3];
//    [arrows addObject:explosiveArrow];
//    
//    level = [[Level alloc] initWithParamsArgLevelNumberArg:73 clocksArg:clocks arrowsArg:arrows goalArg:3];
//    [levels addObject:level];
//}
//
//-(void) populateLevel74 {
//    [self cleanUpArrays];
//    
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:5];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9];
//    [clocks addObject:regularClock];
//    
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:1 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:4 destinationArg:1];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:1 destinationArg:4];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:3 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:2 destinationArg:3];
//    [arrows addObject:explosiveArrow];
//    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
//    [arrows addObject:arrow];
//    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
//    [arrows addObject:arrow];
//    
//    level = [[Level alloc] initWithParamsArgLevelNumberArg:74 clocksArg:clocks arrowsArg:arrows goalArg:4];
//    [levels addObject:level];
//}
//
//-(void) populateLevel75 {
//    [self cleanUpArrays];
//    
//    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:10];
//    [clocks addObject:ninjaClock];
//    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:5];
//    [clocks addObject:ninjaClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:2];
//    [clocks addObject:regularClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6];
//    [clocks addObject:regularClock];
//    
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:1 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:2 destinationArg:1];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:1 destinationArg:4];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:3 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:1 originArg:4 destinationArg:2];
//    [arrows addObject:explosiveArrow];
//    explosiveArrow = [[ExplosiveArrow alloc] initWithParams:2 originArg:3 destinationArg:4];
//    [arrows addObject:explosiveArrow];
//    
//    level = [[Level alloc] initWithParamsArgLevelNumberArg:75 clocksArg:clocks arrowsArg:arrows goalArg:5];
//    [levels addObject:level];
//}

-(void) populateLevel71 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:romanClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:71 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel72 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:romanClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:72 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel73 {
    [self cleanUpArrays];
    
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:sleepyClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:ninjaClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:romanClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:73 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel74 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:voidClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:lazyFlower];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:74 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel75 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:voidClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:75 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel76 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:twoFace];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:76 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel77 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:twoFace];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:77 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel78 {
    [self cleanUpArrays];
    
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:twoFace];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:78 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel79 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:79 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel80 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:twoFace];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:twoFace];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:80 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel81 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:81 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel82 {
    [self cleanUpArrays];
    
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:twoFace];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:romanClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:voidClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:82 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel83 {
    [self cleanUpArrays];
    
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:twoFace];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:sleepyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:83 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel84 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:lazyFlower];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:twoFace];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:twoFace];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:84 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel85 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:ninjaClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:voidClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:85 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel86 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:voidClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:voidClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:twoFace];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:86 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel87 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:twoFace];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:87 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel88 {
    [self cleanUpArrays];
    
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:ninjaClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:twoFace];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:88 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel89 {
    [self cleanUpArrays];
    
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:twoFace];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:lazyFlower];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:ninjaClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:89 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel90 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:sleepyClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:90 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel91 {
    [self cleanUpArrays];
    
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:9 shortHandArg:6 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:chineseClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:91 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel92 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:6 shortHandArg:7 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:chineseClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:92 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel93 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:4 shortHandArg:3 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:chineseClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:93 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel94 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:10 shortHandArg:8 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:chineseClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:1];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:94 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel95 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:6 shortHandArg:7 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:chineseClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:95 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel96 {
    [self cleanUpArrays];
    
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:9 shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:chineseClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:1 shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:chineseClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:96 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel97 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:1 shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:chineseClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:97 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel98 {
    [self cleanUpArrays];
    
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:voidClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:10 shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:chineseClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:romanClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:98 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel99 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:ninjaClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:10 shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:chineseClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:99 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel100 {
    [self cleanUpArrays];
    
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:ninjaClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:reversedClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:8 shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:chineseClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:100 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel101 {
    [self cleanUpArrays];
    
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:2 shortHandArg:1 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:chineseClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:lazyFlower];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:dizzyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:101 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel102 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:2 shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:chineseClock];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:voidClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:102 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel103 {
    [self cleanUpArrays];
    
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:twoFace];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:11 shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:chineseClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:sleepyClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:103 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel104 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:reversedClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:11 shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:chineseClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:lazyFlower];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:104 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel105 {
    [self cleanUpArrays];
    
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:12 shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:chineseClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:dizzyClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:twoFace];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:105 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel106 {
    [self cleanUpArrays];
    
    brokenClock = [[BrokenClock alloc] initWithParams:NO locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:brokenClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:106 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel107 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_2CLOCKS_TOP];
    [clocks addObject:regularClock];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_2CLOCKS_BOTTOM];
    [clocks addObject:brokenClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:107 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel108 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    brokenClock = [[BrokenClock alloc] initWithParams:NO locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:brokenClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:108 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel109 {
    [self cleanUpArrays];
    
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_3CLOCKS_TOPLEFT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_3CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_3CLOCKS_BOTTOM];
    [clocks addObject:brokenClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:109 clocksArg:clocks arrowsArg:arrows goalArg:2];
    [levels addObject:level];
}

-(void) populateLevel110 {
    [self cleanUpArrays];
    
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:brokenClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:110 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel111 {
    [self cleanUpArrays];
    
    brokenClock = [[BrokenClock alloc] initWithParams:NO locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:brokenClock];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:brokenClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:regularClock];
    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:regularClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:111 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel112 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:2 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:lazyFlower];
    brokenClock = [[BrokenClock alloc] initWithParams:NO locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:brokenClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:112 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel113 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:4 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:brokenClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:6 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:113 clocksArg:clocks arrowsArg:arrows goalArg:5];
    [levels addObject:level];
}

-(void) populateLevel114 {
    [self cleanUpArrays];
    
    brokenClock = [[BrokenClock alloc] initWithParams:NO locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:brokenClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:dizzyClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:10 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:ninjaClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:114 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel115 {
    [self cleanUpArrays];
    
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:reversedClock];
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:ninjaClock];
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:lazyFlower];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:brokenClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:115 clocksArg:clocks arrowsArg:arrows goalArg:6];
    [levels addObject:level];
}

-(void) populateLevel116 {
    [self cleanUpArrays];
    
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:ninjaClock];
    brokenClock = [[BrokenClock alloc] initWithParams:NO locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:brokenClock];
    romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:5 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:romanClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:5 shortHandArg:4 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:chineseClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:116 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel117 {
    [self cleanUpArrays];
    
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:voidClock];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:brokenClock];
    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:7 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:dizzyClock];
    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:reversedClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:117 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel118 {
    [self cleanUpArrays];
    
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:brokenClock];
    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:11 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:sleepyClock];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:twoFace];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:twoFace];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:118 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) populateLevel119 {
    [self cleanUpArrays];
    
    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:3 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:lazyFlower];
    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:12 locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:twoFace];
    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:voidClock];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:brokenClock];
    
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:2 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:1 destinationArg:3];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:119 clocksArg:clocks arrowsArg:arrows goalArg:3];
    [levels addObject:level];
}

-(void) populateLevel120 {
    [self cleanUpArrays];
    
    ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:8 locationParam:NEWVAR_4CLOCKS_TOPLEFT];
    [clocks addObject:ninjaClock];
    brokenClock = [[BrokenClock alloc] initWithParams:YES locationParam:NEWVAR_4CLOCKS_TOPRIGHT];
    [clocks addObject:brokenClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:2 shortHandArg:1 locationParam:NEWVAR_4CLOCKS_BOTTOMRIGHT];
    [clocks addObject:chineseClock];
    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:8 shortHandArg:9 locationParam:NEWVAR_4CLOCKS_BOTTOMLEFT];
    [clocks addObject:chineseClock];
    
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:2 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:3 destinationArg:2];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:1 originArg:1 destinationArg:4];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:1];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:4 destinationArg:3];
    [arrows addObject:arrow];
    arrow = [[Arrow alloc] initWithParams:2 originArg:3 destinationArg:4];
    [arrows addObject:arrow];
    
    level = [[Level alloc] initWithParamsArgLevelNumberArg:120 clocksArg:clocks arrowsArg:arrows goalArg:4];
    [levels addObject:level];
}

-(void) cleanUpArrays {
    clock = nil;
    for (int i=clocks.count-1;i>=0;i--) {
        if([clocks objectAtIndex:i]) [clocks removeObjectAtIndex:i];
    }
    
    arrow = nil;
    for (int i=arrows.count-1;i>=0;i--) {
        if([arrows objectAtIndex:i]) [arrows removeObjectAtIndex:i];
    }
    
    level = nil;
    for (int i=levels.count-1;i>=0;i--) {
        if([levels objectAtIndex:i]) [levels removeObjectAtIndex:i];
    }
}

-(Level*) getLevel : (int) number {
    return [levels objectAtIndex:number-1];
}

@end

//    brokenClock = [[BrokenClock alloc] initWithParams:YES];
//    [clocks addObject:brokenClock];
//    twoFace = [[TwoFace alloc] initWithParams:YES shortHandArg:4];
//    [clocks addObject:twoFace];
//    sleepyClock = [[SleepyClock alloc] initWithParams:YES shortHandArg:7];
//    [clocks addObject:sleepyClock];
//    chineseClock = [[ChineseClock alloc] initWithParamsArgZodiacAtArg:5 shortHandArg:6];
//    [clocks addObject:chineseClock];
//    lazyFlower = [[LazyFlower alloc] initWithParams:YES shortHandArg:7];
//    [clocks addObject:lazyFlower];
//    reversedClock = [[ReversedClock alloc] initWithParams:YES shortHandArg:1];
//    [clocks addObject:reversedClock];
//    regularClock = [[RegularClock alloc] initWithParams:YES shortHandArg:11];
//    [clocks addObject:regularClock];
//    voidClock = [[VoidClock alloc] initWithParams:YES shortHandArg:6];
//    [clocks addObject:voidClock];
//    dizzyClock = [[DizzyClock alloc] initWithParamsArgRotatingRightArg:NO shortHandArg:5];
//    [clocks addObject:dizzyClock];
//  ninjaClock = [[NinjaClock alloc] initWithParams:YES shortHandArg:6];
//  [clocks addObject:ninjaClock];
//  romanClock = [[RomanClock alloc] initWithParams:YES shortHandArg:11];
//  [clocks addObject:romanClock];