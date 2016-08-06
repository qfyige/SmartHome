//
//  SHUserManager.h
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHUserModel.h"

@interface SHUserManager : NSObject

+ (id)sharedInstance;
- (SHUserModel *)getUser;
- (BOOL)addUser:(SHUserModel *)userDataModel;
- (BOOL)updateUser:(SHUserModel *)userDataModel;
- (BOOL)deleteUser;

@end
