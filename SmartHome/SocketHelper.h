//
//  SocketHelper.h
//  SmartHome
//
//  Created by tong lele on 16/7/12.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SRWebSocket.h>

@interface SocketHelper : NSObject<SRWebSocketDelegate>

//通过单利创建
+ (SocketHelper *)shareInstance;

//启动websocket
- (void)setUpWebSocket;

//发送信息
- (void)sendMessage:(id)message;
@end
