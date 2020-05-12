//
//  InAppPurchaseManager.m
//  Clock Day
//
//  Created by Yoseph Winata on 3/12/2013.
//  Copyright (c) 2013 No Vacancy. All rights reserved.
//

#import "InAppPurchaseManager.h"


@implementation InAppPurchaseManager

@synthesize inAppDelegate;

- (void)requestProUpgradeProductData
{
    
    NSSet *productIdentifiers = [NSSet setWithObject:kInAppPurchaseProUpgradeProductId];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    NSSet *productIdentifiers20 = [NSSet setWithObject:ProductIDCapsules20];
    productsRequestC20 = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers20];
    productsRequestC20.delegate = self;
    [productsRequestC20 start];
    
    NSSet *productIdentifiers50 = [NSSet setWithObject:ProductIDCapsules50];
    productsRequestC50 = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers50];
    productsRequestC50.delegate = self;
    [productsRequestC50 start];
    
    NSSet *productIdentifiers500 = [NSSet setWithObject:ProductIDCapsules500];
    productsRequestC500 = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers500];
    productsRequestC500.delegate = self;
    [productsRequestC500 start];
    
    // we will release the request object in the delegate callback
}

#pragma mark -
#pragma mark SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    //proUpgradeProduct = [products count] == 1 ? [[products firstObject] retain] : nil;
    proUpgradeProduct = [products count] == 1 ? [products firstObject] : nil;
    if (proUpgradeProduct)
    {
        NSLog(@"Product title: %@" , proUpgradeProduct.localizedTitle);
        NSLog(@"Product description: %@" , proUpgradeProduct.localizedDescription);
        NSLog(@"Product price: %@" , proUpgradeProduct.price);
        NSLog(@"Product id: %@" , proUpgradeProduct.productIdentifier);
        NSLog(@"\n");
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
//    [productsRequest release];
    productsRequest = nil;
    productsRequestC20 = nil;
    productsRequestC50 = nil;
    productsRequestC500 = nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}


//
// call this method once on startup
//
- (void)loadStore
{
    // restarts any purchases if they were interrupted last time the app was open
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // get the product description (defined in early sections)
    [self requestProUpgradeProductData];
}

//
// call this before making a purchase
//
- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

//
// kick off the upgrade transaction - starts
//
- (void)purchaseProUpgrade
{
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:kInAppPurchaseProUpgradeProductId];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)purchaseCapsules20
{
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:ProductIDCapsules20];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)purchaseCapsules50
{
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:ProductIDCapsules50];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)purchaseCapsules500
{
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:ProductIDCapsules500];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//
// kick off the upgrade transaction - ends
//

//My additional codes to handle error when in-app purchase setting is disabled
-(void)checkAndExecutePurchase:(NSString*)productID {
    
    if ([self canMakePurchases] == TRUE) {
        
        [[self inAppDelegate] paintProcessingImage];
        
        if ([productID  isEqual: kInAppPurchaseProUpgradeProductId]) {
            [self purchaseProUpgrade];
        } else if ([productID  isEqual: ProductIDCapsules20]) {
            [self purchaseCapsules20];
        } else if ([productID  isEqual: ProductIDCapsules50]) {
            [self purchaseCapsules50];
        } else if ([productID  isEqual: ProductIDCapsules500]) {
            [self purchaseCapsules500];
        }
        
    } else {
        
        UIAlertView *tmp = [[UIAlertView alloc]
                            
                            initWithTitle:@"Prohibited"
                            
                            message:@"Please enable in-app purchases by going to (Settings - General - Restrictions)"
                            
                            delegate:self
                            
                            cancelButtonTitle:nil
                            
                            otherButtonTitles:@"Ok", nil];
        
        [tmp show];
    }
}

#pragma -
#pragma Purchase helpers

//
// saves a record of the transaction by storing the receipt to disk
//
- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
    if ([transaction.payment.productIdentifier isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"proUpgradeTransactionReceipt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:ProductIDCapsules20])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"purchaseCapsules20TransactionReceipt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:ProductIDCapsules50])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"purchaseCapsules50TransactionReceipt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([transaction.payment.productIdentifier isEqualToString:ProductIDCapsules500])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"purchaseCapsules500TransactionReceipt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//
// enable pro features
//
- (void)provideContent:(NSString *)productId
{
    if ([productId isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // enable the pro features
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUpgradePurchased" ];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[self inAppDelegate] providePurchaseUnlockLevels];
    }
    else if ([productId isEqualToString:ProductIDCapsules20])
    {
        [[self inAppDelegate] providePurchaseCapsules20];
    }
    else if ([productId isEqualToString:ProductIDCapsules50])
    {
        [[self inAppDelegate] providePurchaseCapsules50];
    }
    else if ([productId isEqualToString:ProductIDCapsules500])
    {
        [[self inAppDelegate] providePurchaseCapsules500];
    }
}

//
// removes the transaction from the queue and posts a notification with the transaction result
//
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful
{
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction, @"transaction" , nil];
    if (wasSuccessful)
    {
        // send out a notification that we’ve finished the transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
    }
    else
    {
        // send out a notification for the failed transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
}

//
// called when the transaction was successful
//
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
    NSLog(@"Transaction completed\n");
}

//
// called when a transaction has been restored and and successfully completed
//
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction.originalTransaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
    
    [[self inAppDelegate] depaintProcessingImage];
    NSLog(@"Transaction restored\n");
}

//
// called when a transaction has failed
//
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    }
    else
    {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
    
    [[self inAppDelegate] depaintProcessingImage];
    NSLog(@"Transaction failed\n");
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver methods

//
// called when the transaction status is updated
//
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void)restoreCompletedTransactions {
    [[self inAppDelegate] paintProcessingImage];
    [[self inAppDelegate] depaintProcessingCallTimer];
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}

@end
