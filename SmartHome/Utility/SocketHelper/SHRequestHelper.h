//
//  SHRequestHelper.h
//  SmartHome
//
//  Created by tong lele on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock) (NSDictionary *requestDictionary);
typedef void(^FailBlock) (NSError *error);

@interface SHRequestHelper : NSObject

+ (void)sendMessage:(id)message complete:(CompleteBlock)complete fail:(FailBlock)fail;

+ (void)connectComplete:(CompleteBlock)complete fail:(FailBlock)fail;

@end
