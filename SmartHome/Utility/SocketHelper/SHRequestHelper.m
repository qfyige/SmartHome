//
//  SHRequestHelper.m
//  SmartHome
//
//  Created by tong lele on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHRequestHelper.h"
#import "SocketHelper.h"

@implementation SHRequestHelper

+ (void)connectComplete:(CompleteBlock)complete fail:(FailBlock)fail{
    SocketHelper *helper = [SocketHelper shareInstance];
    helper.complete = complete;
    helper.fail = fail;
    helper.isOpenSocket = YES;
    [helper setUpWebSocket];
}

+ (void)sendMessage:(id)message complete:(CompleteBlock)complete fail:(FailBlock)fail{
    SocketHelper *helper = [SocketHelper shareInstance];
    helper.complete = complete;
    helper.isOpenSocket = NO;
    helper.fail = fail;
    //待补充message 格式问题
    [helper sendMessage:message];
}

@end
