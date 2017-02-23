//
//  LSNetworkConnectObsever.m
//  LetvShop
//
//  Created by tong li on 2016/11/16.
//  Copyright © 2016年 letv. All rights reserved.
//

#import "LSNetworkConnectObsever.h"
#import "AFNetworkReachabilityManager.h"
#import "SVProgressHUD.h"

@implementation LSNetworkConnectObsever{
    AFNetworkReachabilityManager *_manager;
}

+(id)shareInstance{
    static  id reach = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        reach = [[LSNetworkConnectObsever alloc] init];
    });
    return reach;
}

-(BOOL)reachable{
    _manager = [AFNetworkReachabilityManager sharedManager];
    return _manager.reachable;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _manager = [AFNetworkReachabilityManager sharedManager];
        [_manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSString *alertString;
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    alertString = @"未知网络";
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    alertString = @"未连接网络";
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"networkDisConnect" object:nil];

                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    alertString = @"已连接wifi网络";
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectWifi" object:nil];
                    
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    alertString = @"已连接蜂窝网";
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectViaWWAN" object:nil];
                }
                default:
                    break;
            }
        }];
        return self;
    }
    return nil;
}

-(void)starNotifier{
    [_manager startMonitoring];
}



@end
