//
//  SocketRequestModel.h
//  SmartHome
//
//  Created by hui.li on 16/8/5.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketRequestModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSArray *backinfo;

@end
