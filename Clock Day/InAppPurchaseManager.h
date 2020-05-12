//
//  InAppPurchaseManager.h
//  Clock Day
//
//  Created by Yoseph Winata on 3/12/2013.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
// add a couple notifications sent out when the transaction completes
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"

//THESE LINES ARE THE PRODUCT IDs - starts
#define kInAppPurchaseProUpgradeProductId @"iphone.clockday.premium"
#define ProductIDCapsules20 @"iphone.clockday.capsules20"
#define ProductIDCapsules50 @"iphone.clockday.capsules50"
#define ProductIDCapsules500 @"iphone.clockday.capsules500"
//THESE LINES ARE THE PRODUCT IDs - ends

@protocol InAppPurchaseManagerDelegate

-(void)providePurchaseUnlockLevels;
-(void)providePurchaseCapsules20;
-(void)providePurchaseCapsules50;
-(void)providePurchaseCapsules500;
-(void)paintProcessingImage;
-(void)depaintProcessingImage;
-(void)depaintProcessingCallTimer;

@end

@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate>
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
    SKProductsRequest *productsRequestC20;
    SKProductsRequest *productsRequestC50;
    SKProductsRequest *productsRequestC500;
    
    id <InAppPurchaseManagerDelegate> inAppDelegate;
}

@property (nonatomic)id <InAppPurchaseManagerDelegate> inAppDelegate;


-(void)requestProUpgradeProductData;

- (void)loadStore;
-(void)checkAndExecutePurchase:(NSString*)productID;

-(void)restoreCompletedTransactions;

@end
