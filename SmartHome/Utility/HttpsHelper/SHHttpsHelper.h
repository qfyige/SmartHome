//
//  SHHttpsHelper.h
//  SmartHome
//
//  Created by hui on 16/9/12.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SHHttpsHelper : NSObject

+ (AFSecurityPolicy *)customSecurityPolicy;
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
