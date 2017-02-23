//
//  LSNetworkConnectObsever.h
//  LetvShop
//
//  Created by tong li on 2016/11/16.
//  Copyright © 2016年 letv. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LSNetworkConnectObsever : NSObject

+ (id)shareInstance;
- (void)starNotifier;
-(BOOL)reachable;//获取网络状态

@end
