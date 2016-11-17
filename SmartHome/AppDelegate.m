//
//  AppDelegate.m
//  SmartHome
//
//  Created by tong lele on 16/7/12.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "AppDelegate.h"
#import "SHRequestHelper.h"
#import "JPUSHService.h"
#import <IQKeyboardManager.h>
#import "SHHttpsHelper.h"
#import "SHUserModel.h"
#import "SHUserManager.h"
#import "SHLoginViewController.h"
#import "JDES.h"


@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self setUpJpushLaunchOptions:launchOptions];
    [IQKeyboardManager sharedManager].enable = YES;
    [SHRequestHelper connectComplete:^(SocketRequestModel *requestModel) {
        NSLog(@"%@",requestModel);
        [self autoLogin];
    } fail:^(NSError *error) {
        NSLog(@"socket connect error %@",error.description);
    }];
    [self addNot];
    return YES;
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    /// Required -    DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application        didReceiveRemoteNotification:
(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error
          );
}

- (void)setUpJpushLaunchOptions:(NSDictionary *)launchOptions{
    NSMutableSet *categories = [NSMutableSet set];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
        category.identifier = @"identifier1";
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"test2";
        action.title = @"test";
        action.activationMode = UIUserNotificationActivationModeBackground;
        action.authenticationRequired = YES;
        //YES显示为红色，NO显示为蓝色
        action.destructive = NO;
        NSArray *actions = @[ action ];
        [category setActions:actions forContext:UIUserNotificationActionContextMinimal];
        [categories addObject:category];
    }
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
        //       categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:categories];
    }else{
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:@"b97094dc63a06b00b81aefe1" channel:@"AppStore" apsForProduction:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark -
#pragma mark -- 业务逻辑

- (void)addNot
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appHtml5Update:) name:@"appHtml5Update" object:nil];
}

- (void)appHtml5Update:(NSNotification *)not
{
    if (not.object) {
        SocketRequestModel *requestModel = (SocketRequestModel *)not.object;
        NSMutableDictionary *backInfo = (NSMutableDictionary *)requestModel.backinfo;
        if (backInfo[@"downloadUrl"]) {
            [SHHttpsHelper setBackInfo:backInfo];
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发现新版界面，请更新！" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (buttonIndex != alertView.cancelButtonIndex) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:@"下载中..."];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [SHHttpsHelper downLoadZip];
                });
            });
        });
    }
}

- (void)autoLogin
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if (IS_NSString(userId)) {
        [SHModelBase getUsingLKDBHelperWith:userId];
        SHUserModel *model = [[SHUserManager sharedInstance] getUser];
        if (model) {
            //系统类型:1:IPHONE,2:ANDROID,3IPAD
            NSString *mobModel = @"";
            if (IS_IPAD) {
                mobModel = @"3";
            }else{
                mobModel = @"1";
            }
            NSString *str = [NSString stringWithFormat:@"{\"seckey\":\"\",\"method\":\"login\",\"infopackage\":{\"userId\":\"%@\",\"password\":\"%@\",\"mobile\":\"\",\"mobModel\":\"%@\",\"mobBrand\":\"\"}}",model.userId,model.password,mobModel];
            NSString *encrityKey = [JDES AES128Encrypt:str WithGkey:@"ldshldshldshldsh" gIv:@"ldshldshldshldsh"];

            [SHRequestHelper sendMessage:encrityKey complete:^(SocketRequestModel *requestModel) {
                NSString *method = requestModel.method;
                if([method isEqualToString:@"login"]){
                    if (requestModel.resultCode == 1004) {
                        if (IS_NSArray(requestModel.backinfo)) {
                            [[SHLoginManager shareInstance] userLoginDataWith:requestModel.backinfo[0] password:model.password];
                        }
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"登录失败"];
                    }
                }
            } fail:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
                NSLog(@"%@",error.description);
            }];
        }
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "litong.SmartHome" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SmartHome" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SmartHome.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
