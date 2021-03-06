//
//  SocketHelper.m
//  SmartHome
//
//  Created by tong lele on 16/7/12.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SocketHelper.h"
#import "JDES.h"

#define HostUrl @"ws://101.201.209.42:8080/ldnet/evermobws"
#define authkey @"0B51D241121C19364C9D0EC3BC8CA417"
#define Fromid @"0987654345678agy1"

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

//启动websocket
- (void)setUpWebSocket{
    if (_webSocket) {
        [_webSocket close];
        _webSocket.delegate = nil;
    }
    //ws://101.201.209.42:8080/ldnet/evermobws?fromid=0987654345678agy1&fromtype=m&clienttype=XXX&clientmodel=XXX&authkey=0B51D241121C19364C9D0EC3BC8CA417&appid=appid0001
#warning test fromid 需要修改唯一标识
    NSString *url = [NSString stringWithFormat:@"%@?fromid=ldsh&fromtype=m&clienttype=XXX&clientmodel=XXX&authkey=0B51D241121C19364C9D0EC3BC8CA417&appid=appid0001",HostUrl];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    _webSocket.delegate = self;
    [_webSocket open];
}

//发送信息
- (void)sendMessage:(id)message{
    if (message) {
        [_webSocket send:message];
    }
}

#pragma mark --Delegate

//接收消息 存储数据
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{

    if(_complete){
        if ([message isKindOfClass:[NSString class]]) {
           NSDictionary* dict = [self dictionaryWithJsonString:message];

            //连接服务器 用fromid 解密第一次
            if(dict == nil){
            
                NSString *json = [JDES AES128Decrypt:message WithGkey:@"ldshldshldshldsh" gIv:@"ldshldshldshldsh"];
               NSString* headerData = [json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
                headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                headerData = [headerData stringByReplacingOccurrencesOfString:@"\0" withString:@""];
                dict = [self dictionaryWithJsonString:headerData];
            }
            //连接成功登陆服务器用 sever 返回的seckey 解密
            if(dict == nil){
                NSString *seckey = [[NSUserDefaults standardUserDefaults] objectForKey:Seckey];
                NSString *json = [JDES AES128Decrypt:message WithGkey:[seckey substringToIndex:16] gIv:[seckey substringToIndex:16]];
                NSString* headerData = [json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
                headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                headerData = [headerData stringByReplacingOccurrencesOfString:@"\0" withString:@""];
                dict = [self dictionaryWithJsonString:headerData];

            }
            
            NSLog(@"dict___%@",dict);
            SocketRequestModel *requestModel = [[SocketRequestModel alloc] init];
            if ([dict objectForKey:@"result"]) {
                requestModel.resultCode = [[dict objectForKey:@"result"] integerValue];
            }
            if ([dict objectForKey:@"method"]) {
                requestModel.method = [NSString stringWithFormat:@"%@",[dict objectForKey:@"method"]];
            }
            if ([dict objectForKey:@"backinfo"]) {
                requestModel.backinfo = [dict objectForKey:@"backinfo"];
                if(requestModel.backinfo && requestModel.backinfo.count >0){
                    //获取key 并保存
                    NSDictionary *smallDic = [requestModel.backinfo firstObject];
                    NSString *seckey = [smallDic objectForKey:@"seckey"];
                    if(seckey){
                        [[NSUserDefaults standardUserDefaults] setObject:seckey forKey:Seckey];
                    }
                }
            }
            if ([requestModel.method isEqualToString:@"appHtml5Update"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"appHtml5Update" object:requestModel];
            }
            _complete(requestModel);
        }else{
            _complete(nil);
        }
    }
}

//连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"webSocketDidOpen connect success");
    if (self.isOpenSocket) {
        _complete(nil);
    }
}

//连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError %@",error.description);
    if(_fail){
        _fail(error);
    }
}

//关闭websocket
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    if(_fail){
        _fail(nil);
    }
    NSLog(@"didCloseWithCode %@code——%ld",reason,code);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSLog(@"didReceivePong");
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
