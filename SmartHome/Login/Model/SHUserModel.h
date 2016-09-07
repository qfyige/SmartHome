//
//  SHUserModel.h
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHModelBase.h"

@interface SHUserModel : SHModelBase

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *seckey;
@property (nonatomic, copy) NSString *password;

@end
