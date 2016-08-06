//
//  SHUserManager.m
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHUserManager.h"
#import "SHModelBase.h"

@implementation SHUserManager

+ (id)sharedInstance
{
    static SHUserManager *userManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        userManager = [[SHUserManager alloc] init];
    });
    return userManager;
}

- (SHUserModel *)getUser
{
    SHUserModel *user = nil;
    LKDBHelper* globalHelper = [SHModelBase getUsingLKDBHelper];
    NSString *sqlStr = [[NSString alloc] initWithFormat:@"select * from @t"];
    NSArray *searchResultArray = [globalHelper searchWithSQL:sqlStr toClass:[SHUserModel class]];
    for (id obj in searchResultArray) {
        user = (SHUserModel *)obj;
    }
    return user;
}

- (BOOL)addUser:(SHUserModel *)userModel
{
    if (userModel) {
        return [userModel saveToDB];
    }
    return NO;
}

- (BOOL)updateUser:(SHUserModel *)userModel
{
    if (userModel && [userModel isExistsFromDB]) {
        return [userModel updateToDB];
    }
    return NO;
}

- (BOOL)deleteUser
{
    LKDBHelper* globalHelper = [SHModelBase getUsingLKDBHelper];
    return [globalHelper deleteWithClass:[SHUserModel class] where:nil];
}

@end
