//
//  KMLoginManager.h
//  Kemai
//
//  Created by hui.li on 16/3/10.
//  Copyright © 2016年 minhechen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SHLoginManager : NSObject

/**
 *  查看登录状态
 */
+ (BOOL)isLogin;

/**
 *  登录方法
 *
 *  @param responseObj 登录返回的信息
 */
+ (void)userLoginDataWith:(NSMutableDictionary *)responseObj;

/**
 *  登出
 */
+ (void)userLogout;

/**
 *  跳转到登录页
 *
 *  @param viewController 需要跳转到登录页VC
 */
 + (void)userPresentLogin:(UIViewController *)viewController;

@end
