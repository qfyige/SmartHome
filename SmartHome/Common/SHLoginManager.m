//
//  KMLoginManager.m
//  Kemai
//
//  Created by hui.li on 16/3/10.
//  Copyright © 2016年 minhechen. All rights reserved.
//

#import "SHLoginManager.h"
#import "SHLoginViewController.h"
#import "SHUserModel.h"
#import "SHUserManager.h"
#import "YYModel.h"

@implementation SHLoginManager

+ (SHLoginManager *)shareInstance{
    static SHLoginManager *loginManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        loginManager = [[SHLoginManager alloc] init];
    });
    return loginManager;
}

- (BOOL)isLogin
{
    return self.isLoginStatus;
}

- (void)userLoginDataWith:(NSDictionary *)responseObj password:(NSString *)password
{
    if (IS_NSDictionary(responseObj)) {
        //hui 多用户登录同一手机 先注销再登录
        [SHModelBase purgeUsingLKDBHelper];
        NSString *userId = responseObj[@"userId"];
        if (IS_NSStringEx(userId)) {
            [SHModelBase getUsingLKDBHelperWith:userId];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
            SHUserModel *userModel = [SHUserModel yy_modelWithJSON:responseObj];
            if (IS_NSString(password)) {
                userModel.password = password;
            }
            if ([userModel isExistsFromDB]) {
                [[SHUserManager sharedInstance] updateUser:userModel];
            }else{
                [[SHUserManager sharedInstance] addUser:userModel];
            }
            self.isLoginStatus = YES;
        }
    }
}

- (void)userLogout
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userId"];
    [SHModelBase purgeUsingLKDBHelper];
    self.isLoginStatus = NO;
}

+ (void)userPresentLogin:(UIViewController *)viewController
{
    SHLoginViewController *kmLoginVC = [[SHLoginViewController alloc] init];
    [viewController presentViewController:[[UINavigationController alloc] initWithRootViewController:kmLoginVC] animated:YES completion:nil];
}

@end
