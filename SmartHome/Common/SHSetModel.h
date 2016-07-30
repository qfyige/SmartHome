//
//  SHSetModel.h
//  SmartHome
//
//  Created by tong lele on 16/7/31.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHSetModel : NSObject

//中控设置 本地 IP
@property (copy,nonatomic) NSString *localOperationIP;
//中控设置 本地 端口
@property (copy,nonatomic) NSString *localOperationPort;
//中控设置 远程 IP
@property (copy,nonatomic) NSString *remoteOperationIP;
//中控设置 远程 端口
@property (copy,nonatomic) NSString *remoteOperationPort;
//监控设置 本地 IP
@property (copy,nonatomic) NSString *localMonitorIP;
//监控设置 本地 端口
@property (copy,nonatomic) NSString *localMonitorPort;
//监控设置 本地 用户名
@property (copy,nonatomic) NSString *localMonitorUser;
//监控设置 本地 密码
@property (copy,nonatomic) NSString *localMonitorPassword;
//监控设置 远程 账号
@property (copy,nonatomic) NSString *remoteMonitoruser;
//监控设置 远程 密码
@property (copy,nonatomic) NSString *remoteMonitorPassword;
//对讲设置 门口机1 IP
@property (copy,nonatomic) NSString *mechine1IP;
//对讲设置 门口机1 端口
@property (copy,nonatomic) NSString *mechine1port;
//对讲设置 门口机2 IP
@property (copy,nonatomic) NSString *mechine2IP;
//对讲设置 门口机2 端口
@property (copy,nonatomic) NSString *mechine2Port;
//通知显示消息详情
@property (copy,nonatomic) NSString *isShowMessageDetail;
//通知出现声音
@property (copy,nonatomic) NSString *isNeedAudio;
//通知是否开启
@property (copy,nonatomic) NSString *isOpenNotification;

@end
