//
//  SocketHelper.m
//  SmartHome
//
//  Created by tong lele on 16/7/12.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SocketHelper.h"

#define HostUrl @"ws://101.201.209.42:8080/ldnet/evermobws"
#define authkey @"0B51D241121C19364C9D0EC3BC8CA417"


@implementation SocketHelper
{
    SRWebSocket *_webSocket;
}

+ (SocketHelper *)shareInstance{
    static SocketHelper *socketHelper = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        socketHelper = [[SocketHelper alloc] init];
    });
    return socketHelper;
}

-(instancetype)init{
    self = [super init];
    if(self) {
        return self;
    }
    return nil;
}
//启动websocket
- (void)setUpWebSocket{
    NSString *url = [NSString stringWithFormat:@"%@?fromid=device08&fromtype=m&clientmodel=XXX1&authkey=0B51D241121C19364C9D0EC3BC8CA417&appid=appid0001",HostUrl];
    _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:url]];
    _webSocket.delegate =self;
    [_webSocket open];
}
//发送信息
- (void)sendMessage:(id)message{
    [_webSocket send:message];
}
#pragma mark --Delegate
//接收消息 存储数据
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"%@",message);
    if(_complete){
        _complete(message);
    }
}


//连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    if(_complete){
        _complete(@{@"data":@"success"});
    }

    NSLog(@"connect success");
}
//连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"%@",error.description);
    if(_fail){
        _fail(error);
    }
}
//关闭websocket

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"%@code——%ld",reason,code);
}




@end
