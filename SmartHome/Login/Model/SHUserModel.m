//
//  SHUserModel.m
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHUserModel.h"

@implementation SHUserModel

+(NSString *)getPrimaryKey
{
    return @"userId";
}

+(NSString *)getTableName
{
    return @"sh_user";
}

@end
