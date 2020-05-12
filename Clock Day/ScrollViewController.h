//
//  ScrollViewController.h
//  Clock Day
//
//  Created by Yoseph Winata on 3/04/13.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import <Foundation/Foundation.h>

@protocol ScrollViewControllerDelegate

-(void)paintLoadingScreen;

-(void) dePaintLevelPage1;
-(void) depaintCollectionsPage;
-(void) paintAchBoard:(NSString*) fileName;
-(void) becomesClicked:(UIImageView*)imageParam
           fileNameArg:(NSString*)fileNameParam
               rectArg:(CGRect)rectParam;
-(void)eventHandlerThemeButtonDelegate:(int)page;
-(void) paintLevel:(int)number;
-(NSString*) generateKey:(int) levelNumber;
-(int) getTotalStars;
-(void)intToLabelArgIntArg:(int)intParam
           digitHundredArg:(UIImageView*)digitHundredParam
               digitTenArg:(UIImageView*)digitTenParam
               digitOneArg:(UIImageView*)digitOneParam
                 prefixArg:(NSString*)prefixParam;
-(void) resetClicked:(UIImageView*)imageParam
         fileNameArg:(NSString*)fileNameParam
             rectArg:(CGRect)rectParam;
-(void) facebookLikeIsClickedNoReward;
-(void)makePremiumPurchase;
-(void) depaintPremiumBoard;

-(void)audioMainT1;
-(void)audioMainT2;
-(void)audioMainT3;
-(void)audioMainT4;
-(void)sfxButtonClick;

@end

@interface ScrollViewController : UIScrollView {
    Model *gameModel;
    
    UIImageView *imageTheme1Background, *imageTheme2Background, *imageTheme3Background, *imageTheme4Background, *imageTheme5Background, *theme1Button, *theme2Button, *theme3Button, *theme4Button, *theme5Button, *followImage, *followFbButtonImage;
    UIImageView *themeNote2, *themeNote3, *themeNote4;
    UIImageView *imageLevelPage1Transparent, *imageLevelPage2Transparent;
    NSMutableArray *levelButtons;
    NSString *prefixNumLevel;
    id <ScrollViewControllerDelegate> myDelegate;
    
    UIImageView *collectionsLongBG;
    UIImageView *ordinaryAchImage, *sleepyAchImage, *flowerAchImage, *reversedAchImage, *ninjaAchImage, *icyAchImage, *devilAchImage, *angelAchImage, *chineseAchImage, *brokenAchImage;
    
    UIImageView *backgroundPremium, *premiumBoardImage, *premiumUnlockImage;
    
    UIImageView *theme1Right, *theme2Left, *theme2Right, *theme3Left, *theme3Right, *theme4Left, *theme4Right, *themeXLeft;
    UIImageView *theme1LevelLeft, *theme1LevelRight, *theme2LevelLeft, *theme2LevelRight, *theme3LevelLeft, *theme3LevelRight, *theme4LevelLeft, *theme4LevelRight;
    
    UIImageView *creditsLongImage, *creditsContent, *creditsTitle, *creditsBack;
}

@property Model *gameModel;
@property (nonatomic)id <ScrollViewControllerDelegate> myDelegate;

-(void) paintTransparentViews;
-(void) paintTransparentViewsLevels;
-(void) paintThemeBoxes:(int)subPageParam
       isFromWinPageArg:(BOOL)isFromWinPageParam;
-(void) paintLevelButtons:(int)page subPageArg:(int)subPageParam;
-(void)paintCollectionsPage2;
-(void) achInteractionEnable;
-(void) depaintCollectionPage2;
-(void) depaintPremiumBoard;
-(void)paintLongCreditsPage;
-(void)depaintLongCreditsPage;

@end
