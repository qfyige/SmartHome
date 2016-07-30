//
//  KMLoginManager.m
//  Kemai
//
//  Created by hui.li on 16/3/10.
//  Copyright © 2016年 minhechen. All rights reserved.
//

#import "SHLoginManager.h"
#import "SHLoginViewController.h"

@implementation SHLoginManager

+ (BOOL)isLogin
{
    return NO;
}

+ (void)userLoginDataWith:(NSMutableDictionary *)responseObj
{
}

+ (void)userPresentLogin:(UIViewController *)viewController
{
    SHLoginViewController *kmLoginVC = [[SHLoginViewController alloc] init];
    [viewController presentViewController:[[UINavigationController alloc] initWithRootViewController:kmLoginVC] animated:YES completion:nil];
}

+ (void)userLogout
{
}

@end
