//
//  ScrollViewController.m
//  Clock Day
//
//  Created by Yoseph Winata on 3/04/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "ScrollViewController.h"
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation ScrollViewController

@synthesize gameModel, myDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        prefixNumLevel = @"NUMBER_levelbutton_";
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)paintTransparentViews {
    NSString *imageString = @"TransparentView";
    NSString* backgroundPath = [[NSBundle mainBundle] pathForResource:imageString ofType:@"png"];
    
    imageTheme1Background = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [imageTheme1Background setFrame:gameModel.backgroundRect];
    imageTheme1Background.userInteractionEnabled = YES;
    [self addSubview:imageTheme1Background];
    
    imageTheme2Background = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [imageTheme2Background setFrame:gameModel.scrollPage2Rect];
    imageTheme2Background.userInteractionEnabled = YES;
    [self addSubview:imageTheme2Background];
    
    imageTheme3Background = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [imageTheme3Background setFrame:gameModel.scrollPage3Rect];
    imageTheme3Background.userInteractionEnabled = YES;
    [self addSubview:imageTheme3Background];
    
    imageTheme4Background = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [imageTheme4Background setFrame:gameModel.scrollPage4Rect];
    imageTheme4Background.userInteractionEnabled = YES;
    [self addSubview:imageTheme4Background];
    
    imageTheme5Background = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [imageTheme5Background setFrame:gameModel.scrollPage5Rect];
    imageTheme5Background.userInteractionEnabled = YES;
    [self addSubview:imageTheme5Background];
    
    //test
//    [self setContentOffset:CGPointMake(gameModel.screenWidth, 0.0) animated:YES];
}

-(void)paintTransparentViewsLevels {
    NSString *imageString = @"TransparentView";
    NSString* backgroundPath = [[NSBundle mainBundle] pathForResource:imageString ofType:@"png"];
    
    imageLevelPage1Transparent = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [imageLevelPage1Transparent setFrame:gameModel.backgroundRect];
    imageLevelPage1Transparent.userInteractionEnabled = YES;
    [self addSubview:imageLevelPage1Transparent];
    
    imageLevelPage2Transparent = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [imageLevelPage2Transparent setFrame:gameModel.scrollPage2Rect];
    imageLevelPage2Transparent.userInteractionEnabled = YES;
    [self addSubview:imageLevelPage2Transparent];
}

-(void) paintThemeBoxes:(int)subPageParam
       isFromWinPageArg:(BOOL)isFromWinPageParam {
    
    NSString* theme1Path = [[NSBundle mainBundle] pathForResource:@"Theme1" ofType:@"png"];
    theme1Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme1Path]];
    [theme1Button setFrame:gameModel.themeButtonRect];
    theme1Button.userInteractionEnabled = YES;
    [imageTheme1Background addSubview:theme1Button];
    
    if ([gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 30 && [[self myDelegate] getTotalStars] >= 50) {
        NSString* theme2Path = [[NSBundle mainBundle] pathForResource:@"Theme2" ofType:@"png"];
        theme2Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme2Path]];
        [theme2Button setFrame:gameModel.themeButtonRect];
        theme2Button.userInteractionEnabled = YES;
        [imageTheme2Background addSubview:theme2Button];
    } else {
        NSString* theme2LockedPath = [[NSBundle mainBundle] pathForResource:@"Theme2_Locked" ofType:@"png"];
        theme2Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme2LockedPath]];
        [theme2Button setFrame:gameModel.themeLockedRect];
        theme2Button.userInteractionEnabled = NO;
        [imageTheme2Background addSubview:theme2Button];
        
        NSString* theme2NotePath = [[NSBundle mainBundle] pathForResource:@"ThemeNote2" ofType:@"png"];
        themeNote2 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme2NotePath]];
        [themeNote2 setFrame:gameModel.lockedNote2Rect];
        themeNote2.userInteractionEnabled = NO;
        [imageTheme2Background addSubview:themeNote2];
    }
    
    if ([gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 60 && [[self myDelegate] getTotalStars] >= 105) {
        NSString* theme3Path = [[NSBundle mainBundle] pathForResource:@"Theme3" ofType:@"png"];
        theme3Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme3Path]];
        [theme3Button setFrame:gameModel.themeButtonRect];
        theme3Button.userInteractionEnabled = YES;
        [imageTheme3Background addSubview:theme3Button];
    } else {
        NSString* theme3LockedPath = [[NSBundle mainBundle] pathForResource:@"Theme3_Locked" ofType:@"png"];
        theme3Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme3LockedPath]];
        [theme3Button setFrame:gameModel.themeLockedRect];
        theme3Button.userInteractionEnabled = NO;
        [imageTheme3Background addSubview:theme3Button];
        
        NSString* theme3NotePath = [[NSBundle mainBundle] pathForResource:@"ThemeNote3" ofType:@"png"];
        themeNote3 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme3NotePath]];
        [themeNote3 setFrame:gameModel.lockedNote3Rect];
        themeNote3.userInteractionEnabled = NO;
        [imageTheme3Background addSubview:themeNote3];
    }
    
    if ([gameModel.prefs integerForKey:@"latestUnlockedLevel"] > 90 && [[self myDelegate] getTotalStars] >= 160) {
        NSString* theme4Path = [[NSBundle mainBundle] pathForResource:@"Theme4" ofType:@"png"];
        theme4Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme4Path]];
        [theme4Button setFrame:gameModel.themeButtonRect];
        theme4Button.userInteractionEnabled = YES;
        [imageTheme4Background addSubview:theme4Button];
    } else {
        NSString* theme4LockedPath = [[NSBundle mainBundle] pathForResource:@"Theme4_Locked" ofType:@"png"];
        theme4Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme4LockedPath]];
        [theme4Button setFrame:gameModel.themeLockedRect];
        theme4Button.userInteractionEnabled = NO;
        [imageTheme4Background addSubview:theme4Button];
        
        NSString* theme4NotePath = [[NSBundle mainBundle] pathForResource:@"ThemeNote4" ofType:@"png"];
        themeNote4 = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme4NotePath]];
        [themeNote4 setFrame:gameModel.lockedNote4Rect];
        themeNote4.userInteractionEnabled = NO;
        [imageTheme4Background addSubview:themeNote4];
    }
    
    NSString* themeLevelsPath = [[NSBundle mainBundle] pathForResource:@"ThemeLevels" ofType:@"png"];
    theme5Button = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:themeLevelsPath]];
    [theme5Button setFrame:gameModel.themeLockedRect];
    theme5Button.userInteractionEnabled = NO;
    [imageTheme5Background addSubview:theme5Button];
    
    NSString* followPath = [[NSBundle mainBundle] pathForResource:@"ThemeNoteX" ofType:@"png"];
    followImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:followPath]];
    [followImage setFrame:gameModel.lockedNoteXRect];
    followImage.userInteractionEnabled = NO;
    [imageTheme5Background addSubview:followImage];
    
    NSString* fbPath = [[NSBundle mainBundle] pathForResource:@"FacebookRect" ofType:@"png"];
    followFbButtonImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:fbPath]];
    [followFbButtonImage setFrame:gameModel.lockedNoteXFacebookRect];
    followFbButtonImage.userInteractionEnabled = YES;
    [imageTheme5Background addSubview:followFbButtonImage];
    
    ///DRAW arrows - starts
    NSString* theme1RightPath = [[NSBundle mainBundle] pathForResource:@"Theme1_Right" ofType:@"png"];
    theme1Right = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme1RightPath]];
    [theme1Right setFrame:gameModel.themeRightRect];
    theme1Right.userInteractionEnabled = YES;
    [imageTheme1Background addSubview:theme1Right];
    
    NSString* theme2LeftPath = [[NSBundle mainBundle] pathForResource:@"Theme2_Left" ofType:@"png"];
    theme2Left = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme2LeftPath]];
    [theme2Left setFrame:gameModel.themeLeftRect];
    theme2Left.userInteractionEnabled = YES;
    [imageTheme2Background addSubview:theme2Left];
    
    NSString* theme2RightPath = [[NSBundle mainBundle] pathForResource:@"Theme2_Right" ofType:@"png"];
    theme2Right = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme2RightPath]];
    [theme2Right setFrame:gameModel.themeRightRect];
    theme2Right.userInteractionEnabled = YES;
    [imageTheme2Background addSubview:theme2Right];
    
    NSString* theme3LeftPath = [[NSBundle mainBundle] pathForResource:@"Theme3_Left" ofType:@"png"];
    theme3Left = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme3LeftPath]];
    [theme3Left setFrame:gameModel.themeLeftRect];
    theme3Left.userInteractionEnabled = YES;
    [imageTheme3Background addSubview:theme3Left];
    
    NSString* theme3RightPath = [[NSBundle mainBundle] pathForResource:@"Theme3_Right" ofType:@"png"];
    theme3Right = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme3RightPath]];
    [theme3Right setFrame:gameModel.themeRightRect];
    theme3Right.userInteractionEnabled = YES;
    [imageTheme3Background addSubview:theme3Right];
    
    NSString* theme4LeftPath = [[NSBundle mainBundle] pathForResource:@"Theme4_Left" ofType:@"png"];
    theme4Left = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme4LeftPath]];
    [theme4Left setFrame:gameModel.themeLeftRect];
    theme4Left.userInteractionEnabled = YES;
    [imageTheme4Background addSubview:theme4Left];
    
    NSString* theme4RightPath = [[NSBundle mainBundle] pathForResource:@"Theme4_Right" ofType:@"png"];
    theme4Right = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme4RightPath]];
    [theme4Right setFrame:gameModel.themeRightRect];
    theme4Right.userInteractionEnabled = YES;
    [imageTheme4Background addSubview:theme4Right];
    
    NSString* themeXLeftPath = [[NSBundle mainBundle] pathForResource:@"ThemeX_Left" ofType:@"png"];
    themeXLeft = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:themeXLeftPath]];
    [themeXLeft setFrame:gameModel.themeLeftRect];
    themeXLeft.userInteractionEnabled = YES;
    [imageTheme5Background addSubview:themeXLeft];
    
    ///DRAW arrows - ends
    
    //fly to a particular subpage
    if (isFromWinPageParam == NO) {
        [self setContentOffset:CGPointMake(gameModel.screenWidth * (subPageParam - 1), 0.0) animated:NO];
    } else {
        [self setContentOffset:CGPointMake(gameModel.screenWidth * (subPageParam - 1), 0.0) animated:YES];
    }
}

//sisim
-(void)dePaintLevelPageFromScroll {
    for (int i=0; i<30; i++) {
        [[levelButtons objectAtIndex:i] removeFromSuperview];
    }
    for (int j=0; j<levelButtons.count; j++)
        [levelButtons removeObjectAtIndex:j];
    
    levelButtons = nil;
    
    [self depaintThemeAndLevelArrows];
    
    [imageLevelPage1Transparent removeFromSuperview];
    [imageLevelPage2Transparent removeFromSuperview];
    
    imageLevelPage1Transparent = nil;
    imageLevelPage2Transparent = nil;
}

-(void)verifyTheme:(int)buttonParam {
    [[self myDelegate] sfxButtonClick];
    
    switch (gameModel.currentTheme) {
        case 1:
            [self eventHandlerLevelButton:buttonParam];
            
            //audio
            [[self myDelegate]audioMainT1];
            break;
        case 2:
            [self eventHandlerLevelButton:buttonParam+30];
            
            [[self myDelegate]audioMainT2];
            break;
        case 3:
            [self eventHandlerLevelButton:buttonParam+60];
            
            [[self myDelegate]audioMainT3];
            break;
        case 4:
            [self eventHandlerLevelButton:buttonParam+90];
            
            [[self myDelegate]audioMainT4];
            break;
            
        default:
            break;
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == premiumUnlockImage) {
        [[self myDelegate] becomesClicked:premiumUnlockImage fileNameArg:@"Unlock_Button_Clicked" rectArg:gameModel.unlockPremiumRect];
    } else if ([touch view] == followFbButtonImage) {
        [[self myDelegate] becomesClicked:followFbButtonImage fileNameArg:@"FacebookRect_Clicked" rectArg:gameModel.lockedNoteXFacebookRect];
    }
    //Extremely bad code structure - replace later - Ends
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == theme1Button) {
        gameModel.currentTheme = 1;
        [self eventHandlerThemeButton:1];
    }
    else if ([touch view] == theme2Button) {
        gameModel.currentTheme = 2;
        [self eventHandlerThemeButton:2];
    }
    else if ([touch view] == theme3Button) {
        gameModel.currentTheme = 3;
        [self eventHandlerThemeButton:3];
    }
    else if ([touch view] == theme4Button) {
        gameModel.currentTheme = 4;
        [self eventHandlerThemeButton:4];
    }
    else if ([touch view] == [levelButtons objectAtIndex:0])
    {
        [self verifyTheme:1];
    }
    else if ([touch view] == [levelButtons objectAtIndex:1])
    {
        [self verifyTheme:2];
    }
    else if ([touch view] == [levelButtons objectAtIndex:2])
    {
        [self verifyTheme:3];
    }
    else if ([touch view] == [levelButtons objectAtIndex:3])
    {
        [self verifyTheme:4];
    }
    else if ([touch view] == [levelButtons objectAtIndex:4])
    {
        [self verifyTheme:5];
    }
    else if ([touch view] == [levelButtons objectAtIndex:5])
    {
        [self verifyTheme:6];
    }
    else if ([touch view] == [levelButtons objectAtIndex:6])
    {
        [self verifyTheme:7];
    }
    else if ([touch view] == [levelButtons objectAtIndex:7])
    {
        [self verifyTheme:8];
    }
    else if ([touch view] == [levelButtons objectAtIndex:8])
    {
        [self verifyTheme:9];
    }
    else if ([touch view] == [levelButtons objectAtIndex:9])
    {
        [self verifyTheme:10];
    }
    else if ([touch view] == [levelButtons objectAtIndex:10])
    {
        [self verifyTheme:11];
    }
    else if ([touch view] == [levelButtons objectAtIndex:11])
    {
        [self verifyTheme:12];
    }
    else if ([touch view] == [levelButtons objectAtIndex:12])
    {
        [self verifyTheme:13];
    }
    else if ([touch view] == [levelButtons objectAtIndex:13])
    {
        [self verifyTheme:14];
    }
    else if ([touch view] == [levelButtons objectAtIndex:14])
    {
        [self verifyTheme:15];
    }
    else if ([touch view] == [levelButtons objectAtIndex:15])
    {
        [self verifyTheme:16];
    }
    else if ([touch view] == [levelButtons objectAtIndex:16])
    {
        [self verifyTheme:17];
    }
    else if ([touch view] == [levelButtons objectAtIndex:17])
    {
        [self verifyTheme:18];
    }
    else if ([touch view] == [levelButtons objectAtIndex:18])
    {
        [self verifyTheme:19];
    }
    else if ([touch view] == [levelButtons objectAtIndex:19])
    {
        [self verifyTheme:20];
    }
    else if ([touch view] == [levelButtons objectAtIndex:20])
    {
        [self verifyTheme:21];
    }
    else if ([touch view] == [levelButtons objectAtIndex:21])
    {
        [self verifyTheme:22];
    }
    else if ([touch view] == [levelButtons objectAtIndex:22])
    {
        [self verifyTheme:23];
    }
    else if ([touch view] == [levelButtons objectAtIndex:23])
    {
        [self verifyTheme:24];
    }
    else if ([touch view] == [levelButtons objectAtIndex:24])
    {
        [self verifyTheme:25];
    }
    else if ([touch view] == [levelButtons objectAtIndex:25])
    {
        [self verifyTheme:26];
    }
    else if ([touch view] == [levelButtons objectAtIndex:26])
    {
        [self verifyTheme:27];
    }
    else if ([touch view] == [levelButtons objectAtIndex:27])
    {
        [self verifyTheme:28];
    }
    else if ([touch view] == [levelButtons objectAtIndex:28])
    {
        [self verifyTheme:29];
    }
    else if ([touch view] == [levelButtons objectAtIndex:29])
    {
        [self verifyTheme:30];
    }
    else if ([touch view] == premiumUnlockImage)
    {
        [[self myDelegate] sfxButtonClick];
        
        [[self myDelegate] resetClicked:premiumUnlockImage fileNameArg:@"Unlock_Button" rectArg:gameModel.unlockPremiumRect];
        
        //test
        [[self myDelegate] makePremiumPurchase];
    }
    else if ([touch view] == followFbButtonImage)
    {
        [[self myDelegate] sfxButtonClick];
        
        [[self myDelegate] resetClicked:followFbButtonImage fileNameArg:@"FacebookRect" rectArg:gameModel.lockedNoteXFacebookRect];
        [[self myDelegate] facebookLikeIsClickedNoReward];
    }
    else if ([touch view] == ordinaryAchImage) {
        if ([gameModel.prefs boolForKey:@"achOrdinary"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_BeyondOrdinary"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_BeyondOrdinary"];
        }
        [self achInteractionDisable];
    } else if ([touch view] == reversedAchImage) {
//        if ([gameModel.prefs boolForKey:@"achReversed"] == FALSE) {
//            [[self myDelegate] paintAchBoard:@"AchShadow_InvertedView"];
//        } else {
//            [[self myDelegate] paintAchBoard:@"AchSticker_InvertedView"];
//        }
//        [self achInteractionDisable];
    } else if ([touch view] == sleepyAchImage) {
        if ([gameModel.prefs boolForKey:@"achSleepy"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_Sleepyhead"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_Sleepyhead"];
        }
        [self achInteractionDisable];
    } else if ([touch view] == flowerAchImage) {
        if ([gameModel.prefs boolForKey:@"achFlower"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_FloralCharm"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_FloralCharm"];
        }
        [self achInteractionDisable];
    } else if ([touch view] == ninjaAchImage) {
        if ([gameModel.prefs boolForKey:@"achNinja"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_TheArtOfNinja"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_TheArtOfNinja"];
        }
        [self achInteractionDisable];
    } else if ([touch view] == icyAchImage) {
        if ([gameModel.prefs boolForKey:@"achIcy"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_ChillySeason"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_ChillySeason"];
        }
        [self achInteractionDisable];
    } else if ([touch view] == devilAchImage) {
        if ([gameModel.prefs boolForKey:@"achDevil"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_DemonsHunter"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_DemonsHunter"];
        }
        [self achInteractionDisable];
    } else if ([touch view] == angelAchImage) {
        if ([gameModel.prefs boolForKey:@"achAngel"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_AngelsGift"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_AngelsGift"];
        }
        [self achInteractionDisable];
    } else if ([touch view] == chineseAchImage) {
        if ([gameModel.prefs boolForKey:@"achChinese"] == FALSE) {
            [[self myDelegate] paintAchBoard:@"AchShadow_NewYearsEve"];
        } else {
            [[self myDelegate] paintAchBoard:@"AchSticker_NewYearsEve"];
        }
        [self achInteractionDisable];
    }
}

//-(void)purchasePremium{
//    if ([SKPaymentQueue canMakePayments]) {
//        
//        NSLog(@"In-app purchase setting is enabled, good!");
//        
//        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"iphone.clockday.premium"]];
//        
//        
//        
//        request.delegate = self;
//        
//        [request start];
//        
//        
//        
//        
//        
//    } else {
//        
//        UIAlertView *tmp = [[UIAlertView alloc]
//                            
//                            initWithTitle:@"Prohibited"
//                            
//                            message:@"Parental Control is enabled, cannot make a purchase!"
//                            
//                            delegate:self
//                            
//                            cancelButtonTitle:nil
//                            
//                            otherButtonTitles:@"Ok", nil];
//        
//        [tmp show];
//        
//    }
//}
//
//-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
//
//{
//    
//    
//    
//    // remove wait view here
//    
//    printf("productsRequest executed YAY\n");
//    
//    
//    
//    SKProduct *validProduct = nil;
//    
//    int count = [response.products count];
//    
//    
//    
//    if (count>0) {
//        
//        validProduct = [response.products objectAtIndex:0];
//        
//        
//        
//        SKPayment *payment = [SKPayment paymentWithProductIdentifier:@"iphone.clockday.premium"];
//        
//        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
//        
//        
//        [[SKPaymentQueue defaultQueue] addPayment:payment]; // <-- KA CHING!
//        
//        printf("ka ching\n");
//        
//        
//        
//    } else {
//        
//        UIAlertView *tmp = [[UIAlertView alloc]
//                            
//                            initWithTitle:@"Not Available"
//                            
//                            message:@"No products to purchase"
//                            
//                            delegate:self
//                            
//                            cancelButtonTitle:nil
//                            
//                            otherButtonTitles:@"Ok", nil];  
//        
//        [tmp show];  
//        
//        
//    }  
//    
//}


-(void) paintLevelButtons:(int)page
               subPageArg:(int)subPageParam {
    
    NSString *buttonName, *lockedButtonName;
    NSString *path, *lockedPath;
    UIImageView *tempButtonImage;
    UIImageView *left3Number, *center3Number, *right3Number, *left2Number, *right2Number, *center1Number;
    UIImageView *leftStarLevel, *rightStarLevel;
    NSString *left3Path, *center3Path, *right3Path, *left2Path, *right2Path, *center1Path;
    NSString *leftStarLevelPath, *rightStarLevelPath;
    
    int j = 0;
    
    switch (page) {
        case 1:
            j = 0;
            buttonName = [NSString stringWithFormat: @"LevelButtonHost1"];
            [self drawTheme1LevelArrows];
            break;
        case 2:
            j = 30;
            buttonName = [NSString stringWithFormat: @"LevelButtonHost2"];
            [self drawTheme2LevelArrows];
            break;
        case 3:
            j = 60;
            buttonName = [NSString stringWithFormat: @"LevelButtonHost3"];
            [self drawTheme3LevelArrows];
            break;
        case 4:
            j = 90;
            buttonName = [NSString stringWithFormat: @"LevelButtonHost4"];
            [self drawTheme4LevelArrows];
            break;
            
        default:
            NSLog(@"Logic error - HEPN996M");
            break;
    }
    
    levelButtons = [[NSMutableArray alloc] initWithCapacity:30];
    
    //set up normal button name string
    path = [[NSBundle mainBundle] pathForResource:buttonName ofType:@"png"];
    
    //set up locked button string
    lockedButtonName = [NSString stringWithFormat: @"LevelButton_Locked"];
    lockedPath = [[NSBundle mainBundle] pathForResource:lockedButtonName ofType:@"png"];
    
    for (int i=1; i<=30; i++) {
        if (i+j > [gameModel.prefs integerForKey:@"latestUnlockedLevel"]) {
            //draw padlock
            [levelButtons addObject:[[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:lockedPath]]];
            [[levelButtons objectAtIndex:i-1] setFrame:[[gameModel.levelButtonRects objectAtIndex:(i-1)%15] CGRectValue]];
            tempButtonImage = [levelButtons objectAtIndex:i-1];
            tempButtonImage.userInteractionEnabled = NO;
            if (i <= 15) {
                [imageLevelPage1Transparent addSubview:[levelButtons objectAtIndex:i-1]];
            } else if (i<=30) {
                [imageLevelPage2Transparent addSubview:[levelButtons objectAtIndex:i-1]];
            }
        } else {
        
            [levelButtons addObject:[[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:path]]];
            [[levelButtons objectAtIndex:i-1] setFrame:[[gameModel.levelButtonRects objectAtIndex:(i-1)%15] CGRectValue]];
            tempButtonImage = [levelButtons objectAtIndex:i-1];
            tempButtonImage.userInteractionEnabled = YES;
            if (i <= 15) {
                [imageLevelPage1Transparent addSubview:[levelButtons objectAtIndex:i-1]];
            } else if (i<=30) {
                [imageLevelPage2Transparent addSubview:[levelButtons objectAtIndex:i-1]];
            }
        
            if (i+j>0 && i+j<10) {
                center1Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_levelbutton_2" ofType:@"png"];
                center1Number = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:center1Path]];
                [center1Number setFrame:gameModel.level1DigitRect];
                [[levelButtons objectAtIndex:i-1] addSubview:center1Number];
            
                [[self myDelegate] intToLabelArgIntArg:i+j digitHundredArg:center1Number digitTenArg:nil digitOneArg:nil prefixArg:prefixNumLevel];
                
                
                
                
            } else if (i+j>=10 && i+j<=99) {
                left2Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_levelbutton_2" ofType:@"png"];
                left2Number = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:left2Path]];
                [left2Number setFrame:gameModel.level2DigitsLeftRect];
                [[levelButtons objectAtIndex:i-1] addSubview:left2Number];
            
                right2Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_levelbutton_2" ofType:@"png"];
                right2Number = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:right2Path]];
                [right2Number setFrame:gameModel.level2DigitsRightRect];
                [[levelButtons objectAtIndex:i-1] addSubview:right2Number];
            
                [[self myDelegate] intToLabelArgIntArg:i+j digitHundredArg:left2Number digitTenArg:right2Number digitOneArg:nil prefixArg:prefixNumLevel];
            
            } else if (i+j>=100 && i+j<=999) {
                left3Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_levelbutton_2" ofType:@"png"];
                left3Number = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:left3Path]];
                [left3Number setFrame:gameModel.level3DigitsLeftRect];
                [[levelButtons objectAtIndex:i-1] addSubview:left3Number];
            
                center3Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_levelbutton_2" ofType:@"png"];
                center3Number = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:center3Path]];
                [center3Number setFrame:gameModel.level3DigitsCentreRect];
                [[levelButtons objectAtIndex:i-1] addSubview:center3Number];
            
                right3Path = [[NSBundle mainBundle] pathForResource:@"NUMBER_levelbutton_2" ofType:@"png"];
                right3Number = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:right3Path]];
                [right3Number setFrame:gameModel.level3DigitsRightRect];
                [[levelButtons objectAtIndex:i-1] addSubview:right3Number];
            
                [[self myDelegate] intToLabelArgIntArg:i+j digitHundredArg:left3Number digitTenArg:center3Number digitOneArg:right3Number prefixArg:prefixNumLevel];
            } else {
                NSLog(@"Logic error - AS&84G7\n");
            }
        
            //draw the stars - starts
            NSInteger numberOfStars = [gameModel.prefs integerForKey:[[self myDelegate] generateKey:j+i]];
//          printf("level = %i\n", j+i);
//          printf("numberOfStars = %i\n", numberOfStars);

            if (numberOfStars == 0) {
                leftStarLevelPath = [[NSBundle mainBundle] pathForResource:@"BlankStar_Small" ofType:@"png"];
                rightStarLevelPath = [[NSBundle mainBundle] pathForResource:@"BlankStar_Small" ofType:@"png"];
            } else if (numberOfStars == 1) {
                leftStarLevelPath = [[NSBundle mainBundle] pathForResource:@"FullStar_Small" ofType:@"png"];
                rightStarLevelPath = [[NSBundle mainBundle] pathForResource:@"BlankStar_Small" ofType:@"png"];
            } else if (numberOfStars == 2) {
                leftStarLevelPath = [[NSBundle mainBundle] pathForResource:@"FullStar_Small" ofType:@"png"];
                rightStarLevelPath = [[NSBundle mainBundle] pathForResource:@"FullStar_Small" ofType:@"png"];
            } else {
                NSLog(@"Logic Error - Invalid numberOfStars");
            }
        
            leftStarLevel = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:leftStarLevelPath]];
            [leftStarLevel setFrame:gameModel.leftStarLevelRect];
            [[levelButtons objectAtIndex:i-1] addSubview:leftStarLevel];
        
            rightStarLevel = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:rightStarLevelPath]];
            [rightStarLevel setFrame:gameModel.rightStarLevelRect];
            [[levelButtons objectAtIndex:i-1] addSubview:rightStarLevel];
            //draw the stars - ends
        
            //retrieve starts
//          NSInteger myInt = [gameModel.prefs integerForKey:[self generateKey:currentLevel.currentLevel]];
//          printf("stars at this level = %i\n", myInt);
            //retrieve ends
        }
    }
    
    //fly to a particular subpage
    [self setContentOffset:CGPointMake(gameModel.screenWidth * (subPageParam - 1), 0.0) animated:NO];
    
    if ([gameModel.prefs boolForKey:@"isPremiumPaid"] == NO) {
        [self paintPremiumBoard];
    }
    
}

-(void) drawTheme1LevelArrows {
    NSString* theme1RightPath = [[NSBundle mainBundle] pathForResource:@"Theme1_Right" ofType:@"png"];
    theme1LevelRight = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme1RightPath]];
    [theme1LevelRight setFrame:gameModel.themeRightRect];
    theme1LevelRight.userInteractionEnabled = YES;
    [imageLevelPage1Transparent addSubview:theme1LevelRight];
    
    NSString* theme1LeftPath = [[NSBundle mainBundle] pathForResource:@"Theme1_Left" ofType:@"png"];
    theme1LevelLeft = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme1LeftPath]];
    [theme1LevelLeft setFrame:gameModel.themeLeftRect];
    theme1LevelLeft.userInteractionEnabled = YES;
    [imageLevelPage2Transparent addSubview:theme1LevelLeft];
}

-(void) drawTheme2LevelArrows {
    NSString* theme2RightPath = [[NSBundle mainBundle] pathForResource:@"Theme2_Right" ofType:@"png"];
    theme2LevelRight = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme2RightPath]];
    [theme2LevelRight setFrame:gameModel.themeRightRect];
    theme2LevelRight.userInteractionEnabled = YES;
    [imageLevelPage1Transparent addSubview:theme2LevelRight];
    
    NSString* theme2LeftPath = [[NSBundle mainBundle] pathForResource:@"Theme2_Left" ofType:@"png"];
    theme2LevelLeft = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme2LeftPath]];
    [theme2LevelLeft setFrame:gameModel.themeLeftRect];
    theme2LevelLeft.userInteractionEnabled = YES;
    [imageLevelPage2Transparent addSubview:theme2LevelLeft];
}

-(void) drawTheme3LevelArrows {
    NSString* theme3RightPath = [[NSBundle mainBundle] pathForResource:@"Theme3_Right" ofType:@"png"];
    theme3LevelRight = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme3RightPath]];
    [theme3LevelRight setFrame:gameModel.themeRightRect];
    theme3LevelRight.userInteractionEnabled = YES;
    [imageLevelPage1Transparent addSubview:theme3LevelRight];
    
    NSString* theme3LeftPath = [[NSBundle mainBundle] pathForResource:@"Theme3_Left" ofType:@"png"];
    theme3LevelLeft = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme3LeftPath]];
    [theme3LevelLeft setFrame:gameModel.themeLeftRect];
    theme3LevelLeft.userInteractionEnabled = YES;
    [imageLevelPage2Transparent addSubview:theme3LevelLeft];
}

-(void) drawTheme4LevelArrows {
    NSString* theme4RightPath = [[NSBundle mainBundle] pathForResource:@"Theme4_Right" ofType:@"png"];
    theme4LevelRight = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme4RightPath]];
    [theme4LevelRight setFrame:gameModel.themeRightRect];
    theme4LevelRight.userInteractionEnabled = YES;
    [imageLevelPage1Transparent addSubview:theme4LevelRight];
    
    NSString* theme4LeftPath = [[NSBundle mainBundle] pathForResource:@"Theme4_Left" ofType:@"png"];
    theme4LevelLeft = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:theme4LeftPath]];
    [theme4LevelLeft setFrame:gameModel.themeLeftRect];
    theme4LevelLeft.userInteractionEnabled = YES;
    [imageLevelPage2Transparent addSubview:theme4LevelLeft];
}

-(void)paintPremiumBoard {
    
    NSString* backgroundPath = [[NSBundle mainBundle] pathForResource:@"TransparentView" ofType:@"png"];
    backgroundPremium = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [backgroundPremium setFrame:gameModel.fullScreenRect];
    backgroundPremium.userInteractionEnabled = YES;
    [imageLevelPage2Transparent addSubview:backgroundPremium];
    
    NSString* boardPath = [[NSBundle mainBundle] pathForResource:@"Premium_Board" ofType:@"png"];
    premiumBoardImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:boardPath]];
    [premiumBoardImage setFrame:gameModel.premiumBoardRect];
    premiumBoardImage.userInteractionEnabled = YES;
    [backgroundPremium addSubview:premiumBoardImage];
    
    NSString* achBackPath = [[NSBundle mainBundle] pathForResource:@"Unlock_Button" ofType:@"png"];
    premiumUnlockImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:achBackPath]];
    [premiumUnlockImage setFrame:gameModel.unlockPremiumRect];
    premiumUnlockImage.userInteractionEnabled = YES;
    [premiumBoardImage addSubview:premiumUnlockImage];
}

-(void) depaintPremiumBoard {
    [premiumUnlockImage removeFromSuperview];
    [premiumBoardImage removeFromSuperview];
    [backgroundPremium removeFromSuperview];
    
    premiumUnlockImage = nil;
    premiumBoardImage = nil;
    backgroundPremium = nil;
}

-(void) depaintThemeAndLevelArrows {
    [theme1Right removeFromSuperview];
    [theme2Left removeFromSuperview];
    [theme2Right removeFromSuperview];
    [theme3Left removeFromSuperview];
    [theme3Right removeFromSuperview];
    [theme4Left removeFromSuperview];
    [theme4Right removeFromSuperview];
    [themeXLeft removeFromSuperview];
    [theme1LevelLeft removeFromSuperview];
    [theme1LevelRight removeFromSuperview];
    [theme2LevelLeft removeFromSuperview];
    [theme2LevelRight removeFromSuperview];
    [theme3LevelLeft removeFromSuperview];
    [theme3LevelRight removeFromSuperview];
    [theme4LevelLeft removeFromSuperview];
    [theme4LevelRight removeFromSuperview];
    
    theme1Right = nil;
    theme2Left = nil;
    theme2Right = nil;
    theme3Left = nil;
    theme3Right = nil;
    theme4Left = nil;
    theme4Right = nil;
    themeXLeft = nil;
    theme1LevelLeft = nil;
    theme1LevelRight = nil;
    theme2LevelLeft = nil;
    theme2LevelRight = nil;
    theme3LevelLeft = nil;
    theme3LevelRight = nil;
    theme4LevelLeft = nil;
    theme4LevelRight = nil;
}

-(void) dePaintThemeMenu {
    //Probably just dePaint the top hierarchy,, or maybe not? not sure...
    [self depaintThemeAndLevelArrows];
    
    [theme1Button removeFromSuperview];
    theme1Button = nil;
    [theme2Button removeFromSuperview];
    theme2Button = nil;
    [theme3Button removeFromSuperview];
    theme3Button = nil;
    [theme4Button removeFromSuperview];
    theme4Button = nil;
    [theme5Button removeFromSuperview];
    theme5Button = nil;
    [followImage removeFromSuperview];
    followImage = nil;
    [followFbButtonImage removeFromSuperview];
    followFbButtonImage = nil;
    
    [themeNote2 removeFromSuperview];
    themeNote2 = nil;
    [themeNote3 removeFromSuperview];
    themeNote3 = nil;
    [themeNote4 removeFromSuperview];
    themeNote4 = nil;
    
    [imageTheme1Background removeFromSuperview];
    imageTheme1Background = nil;
    [imageTheme2Background removeFromSuperview];
    imageTheme2Background = nil;
    [imageTheme3Background removeFromSuperview];
    imageTheme3Background = nil;
    [imageTheme4Background removeFromSuperview];
    imageTheme4Background = nil;
    [imageTheme5Background removeFromSuperview];
    imageTheme5Background = nil;
    
    [self removeFromSuperview];
}

-(void)eventHandlerLevelButton:(int)levelNumber {
    
    [[self myDelegate] paintLoadingScreen];
    
    if (IS_WIDESCREEN) {
        [NSTimer scheduledTimerWithTimeInterval:0.15
                                         target:self
                                       selector:@selector(delayForLoading:)
                                       userInfo:[NSNumber numberWithInt:levelNumber]
                                        repeats:NO];
    } else {
        [NSTimer scheduledTimerWithTimeInterval:0.4 //0.1
                                         target:self
                                       selector:@selector(delayForLoading:)
                                       userInfo:[NSNumber numberWithInt:levelNumber]
                                        repeats:NO];
    }
    
    
}

-(void)delayForLoading:(NSTimer *) timer {
    [self dePaintLevelPageFromScroll];
    [[self myDelegate] dePaintLevelPage1];
    [[self myDelegate] paintLevel:[timer.userInfo intValue]];
}

-(void)eventHandlerThemeButton:(int)themeNumber
{
    [[self myDelegate] sfxButtonClick];
    
    [self dePaintThemeMenu];
    [[self myDelegate] eventHandlerThemeButtonDelegate:themeNumber];
}

//ordinaryAch, sleepyAch, flowerAch, reversedAch, ninjaAch, icyAch, devilAch, angelAch, chineseAch, brokenAch;
-(void)paintCollectionsPage2 {
    NSString* backgroundPath = [[NSBundle mainBundle] pathForResource:@"LongAchievement_Background" ofType:@"png"];
    collectionsLongBG = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    [collectionsLongBG setFrame:gameModel.collectionsLongRect];
    collectionsLongBG.userInteractionEnabled = YES;
    [self addSubview:collectionsLongBG];
    
    NSString* ordinaryPath;
    if ([gameModel.prefs boolForKey:@"achOrdinary"] == TRUE) {
        ordinaryPath = [[NSBundle mainBundle] pathForResource:@"Ordinary_Ach" ofType:@"png"];
    } else {
        ordinaryPath = [[NSBundle mainBundle] pathForResource:@"Ordinary_AchShadow" ofType:@"png"];
    }
    ordinaryAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:ordinaryPath]];
    [ordinaryAchImage setFrame:gameModel.ordinaryAch];
    ordinaryAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:ordinaryAchImage];
    
    NSString* sleepyPath;
    if ([gameModel.prefs boolForKey:@"achSleepy"] == TRUE) {
        sleepyPath = [[NSBundle mainBundle] pathForResource:@"Sleepy_Ach" ofType:@"png"];
    } else {
        sleepyPath = [[NSBundle mainBundle] pathForResource:@"Sleepy_AchShadow" ofType:@"png"];
    }
    sleepyAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:sleepyPath]];
    [sleepyAchImage setFrame:gameModel.sleepyAch];
    sleepyAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:sleepyAchImage];
    
    NSString* flowerPath;
    if ([gameModel.prefs boolForKey:@"achFlower"] == TRUE) {
        flowerPath = [[NSBundle mainBundle] pathForResource:@"Flower_Ach" ofType:@"png"];
    } else {
        flowerPath = [[NSBundle mainBundle] pathForResource:@"Flower_AchShadow" ofType:@"png"];
    }
    flowerAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:flowerPath]];
    [flowerAchImage setFrame:gameModel.flowerAch];
    flowerAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:flowerAchImage];
    
    NSString* reversedPath;
    if ([gameModel.prefs boolForKey:@"achReversed"] == TRUE) {
        reversedPath = [[NSBundle mainBundle] pathForResource:@"Reversed_Ach" ofType:@"png"];
    } else {
        reversedPath = [[NSBundle mainBundle] pathForResource:@"Reversed_AchShadow" ofType:@"png"];
    }
    reversedAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:reversedPath]];
    [reversedAchImage setFrame:gameModel.reversedAch];
    reversedAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:reversedAchImage];

    NSString* ninjaPath;
    if ([gameModel.prefs boolForKey:@"achNinja"] == TRUE) {
        ninjaPath = [[NSBundle mainBundle] pathForResource:@"Ninja_Ach" ofType:@"png"];
    } else {
        ninjaPath = [[NSBundle mainBundle] pathForResource:@"Ninja_AchShadow" ofType:@"png"];
    }
    ninjaAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:ninjaPath]];
    [ninjaAchImage setFrame:gameModel.ninjaAch];
    ninjaAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:ninjaAchImage];
    
    NSString* icyPath;
    if ([gameModel.prefs boolForKey:@"achIcy"] == TRUE) {
        icyPath= [[NSBundle mainBundle] pathForResource:@"Icy_Ach" ofType:@"png"];
    } else {
        icyPath= [[NSBundle mainBundle] pathForResource:@"Icy_AchShadow" ofType:@"png"];
    }
    icyAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:icyPath]];
    [icyAchImage setFrame:gameModel.icyAch];
    icyAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:icyAchImage];
    
    NSString* devilPath;
    if ([gameModel.prefs boolForKey:@"achDevil"] == TRUE) {
        devilPath = [[NSBundle mainBundle] pathForResource:@"Devil_Ach" ofType:@"png"];
    } else {
        devilPath = [[NSBundle mainBundle] pathForResource:@"Devil_AchShadow" ofType:@"png"];
    }
    devilAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:devilPath]];
    [devilAchImage setFrame:gameModel.devilAch];
    devilAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:devilAchImage];
    
    NSString* angelPath;
    if ([gameModel.prefs boolForKey:@"achAngel"] == TRUE) {
        angelPath = [[NSBundle mainBundle] pathForResource:@"Angel_Ach" ofType:@"png"];
    } else {
        angelPath = [[NSBundle mainBundle] pathForResource:@"Angel_AchShadow" ofType:@"png"];
    }
    angelAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:angelPath]];
    [angelAchImage setFrame:gameModel.angelAch];
    angelAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:angelAchImage];
    
    NSString* chinesePath;
    if ([gameModel.prefs boolForKey:@"achChinese"] == TRUE) {
        chinesePath = [[NSBundle mainBundle] pathForResource:@"Chinese_Ach" ofType:@"png"];
    } else {
        chinesePath = [[NSBundle mainBundle] pathForResource:@"Chinese_AchShadow" ofType:@"png"];
    }
    chineseAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:chinesePath]];
    [chineseAchImage setFrame:gameModel.chineseAch];
    chineseAchImage.userInteractionEnabled = YES;
    [collectionsLongBG addSubview:chineseAchImage];
    
//    NSString* brokenPath = [[NSBundle mainBundle] pathForResource:@"Broken_AchShadow" ofType:@"png"];
//    brokenAchImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:brokenPath]];
//    [brokenAchImage setFrame:gameModel.brokenAch];
//    brokenAchImage.userInteractionEnabled = YES;
//    [collectionsLongBG addSubview:brokenAchImage];
}

-(void) depaintCollectionPage2 {
    [chineseAchImage removeFromSuperview];
    [angelAchImage removeFromSuperview];
    [devilAchImage removeFromSuperview];
    [icyAchImage removeFromSuperview];
    [ninjaAchImage removeFromSuperview];
    [flowerAchImage removeFromSuperview];
    [sleepyAchImage removeFromSuperview];
    [reversedAchImage removeFromSuperview];
    [ordinaryAchImage removeFromSuperview];
    
    [collectionsLongBG removeFromSuperview];
    
    chineseAchImage = nil;
    angelAchImage = nil;
    devilAchImage = nil;
    icyAchImage = nil;
    ninjaAchImage = nil;
    flowerAchImage = nil;
    sleepyAchImage = nil;
    reversedAchImage = nil;
    ordinaryAchImage = nil;
    
    collectionsLongBG = nil;
    
//    [[self myDelegate] depaintCollectionsPage];
}

-(void) achInteractionDisable {
    collectionsLongBG.userInteractionEnabled = NO;
    //don't forget to disable the back & share buttons
}

-(void) achInteractionEnable {
    collectionsLongBG.userInteractionEnabled = YES;
}

-(void)paintLongCreditsPage {
    NSString* backgroundPath = [[NSBundle mainBundle] pathForResource:@"LongAchievement_Background" ofType:@"png"];
    creditsLongImage = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:backgroundPath]];
    //[creditsLongImage setFrame:gameModel.creditsLongRect];
    [creditsLongImage setFrame:gameModel.creditsLongRect];
    creditsLongImage.userInteractionEnabled = YES;
    [self addSubview:creditsLongImage];
    
    NSString* contentPath = [[NSBundle mainBundle] pathForResource:@"Credits_Content" ofType:@"png"];
    creditsContent = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:contentPath]];
    [creditsContent setFrame:gameModel.creditsContentRect];
    creditsContent.userInteractionEnabled = YES;
    [creditsLongImage addSubview:creditsContent];
    
    NSString* titlePath = [[NSBundle mainBundle] pathForResource:@"ClockDay_Title" ofType:@"png"];
    creditsTitle = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:titlePath]];
    [creditsTitle setFrame:gameModel.creditsTitleRect];
    creditsTitle.userInteractionEnabled = YES;
    [creditsLongImage addSubview:creditsTitle];
}

-(void)depaintLongCreditsPage {
    [creditsLongImage removeFromSuperview];
    [creditsContent removeFromSuperview];
    [creditsTitle removeFromSuperview];
    
    creditsLongImage = nil;
    creditsContent = nil;
    creditsTitle = nil;
}

@end
