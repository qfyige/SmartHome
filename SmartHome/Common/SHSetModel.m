//
//  SHSetModel.m
//  SmartHome
//
//  Created by tong lele on 16/7/31.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHSetModel.h"

#define VerifyString(string) string == nil?@"":string

@implementation SHSetModel

static SHSetModel *setModel = nil;
+(SHSetModel *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setModel = [[SHSetModel alloc] init];
    });
    return setModel;
}

-(instancetype)init{
    self = [super init];
    if(self != nil){
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        _localOperationIP = VerifyString([ud objectForKey:@"localOperationIP"]);
        _localOperationPort = VerifyString([ud objectForKey:@"localOperationPort"]);
        _remoteOperationIP = VerifyString([ud objectForKey:@"remoteOperationIP"]);
        _remoteOperationPort = VerifyString([ud objectForKey:@"remoteOperationPort"]);
        _localMonitorIP = VerifyString([ud objectForKey:@"localMonitorIP"]);
        _localMonitorPort = VerifyString([ud objectForKey:@"localMonitorPort"]);
        _localMonitorUser = VerifyString([ud objectForKey:@"localMonitorUser"]);
        _localMonitorPassword = VerifyString([ud objectForKey:@"localMonitorPassword"]);
        _remoteMonitoruser = VerifyString([ud objectForKey:@"remoteMonitoruser"]);
        _remoteMonitorPassword = VerifyString([ud objectForKey:@"remoteMonitorPassword"]);
        _mechine1IP = VerifyString([ud objectForKey:@"mechine1IP"]);
        _mechine1port = VerifyString([ud objectForKey:@"mechine1port"]);
        _mechine2IP = VerifyString([ud objectForKey:@"mechine2IP"]);
        _mechine2Port = VerifyString([ud objectForKey:@"mechine2Port"]);
        _isShowMessageDetail = VerifyString([ud objectForKey:@"isShowMessageDetail"]);
        _isNeedAudio = VerifyString([ud objectForKey:@"isNeedAudio"]);
        _isOpenNotification = VerifyString([ud objectForKey:@"isOpenNotification"]);
        return self;
    }
    return nil;
}



/*
 //中控设置 本地 IP
 @property (copy,nonatomic) NSString *localOperationIP;
 */
-(void)setLocalOperationIP:(NSString *)localOperationIP{
    _localMonitorIP = [localOperationIP copy];
    [[NSUserDefaults standardUserDefaults] setObject:localOperationIP forKey:@"localOperationIP"];
}

/*
 //中控设置 本地 端口
 @property (copy,nonatomic) NSString *localOperationPort;
 */

-(void)setLocalOperationPort:(NSString *)localOperationPort{
    _localMonitorPort = [localOperationPort copy];
    [[NSUserDefaults standardUserDefaults] setObject:localOperationPort forKey:@"localOperationPort"];
}


/*
 //中控设置 远程 IP
 @property (copy,nonatomic) NSString *remoteOperationIP;
*/

-(void)setRemoteOperationIP:(NSString *)remoteOperationIP{
    _remoteOperationIP = [remoteOperationIP copy];
    [[NSUserDefaults standardUserDefaults] setObject:remoteOperationIP forKey:@"remoteOperationIP"];
}

/*
 //中控设置 远程 端口
 @property (copy,nonatomic) NSString *remoteOperationPort;
 */
-(void)setRemoteOperationPort:(NSString *)remoteOperationPort{
    _remoteOperationPort = [remoteOperationPort copy];
    [[NSUserDefaults standardUserDefaults] setObject:remoteOperationPort forKey:@"remoteOperationPort"];
}
/*
  //监控设置 本地 IP
 @property (copy,nonatomic) NSString *localMonitorIP;
 */
-(void)setLocalMonitorIP:(NSString *)localMonitorIP{
    _localMonitorIP = [localMonitorIP copy];
    [[NSUserDefaults standardUserDefaults] setObject:localMonitorIP forKey:@"localMonitorIP"];
}

/*
 //监控设置 本地 端口
 @property (copy,nonatomic) NSString *localMonitorPort;
 */

-(void)setLocalMonitorPort:(NSString *)localMonitorPort{
    _localMonitorPort = [localMonitorPort copy];
    [[NSUserDefaults standardUserDefaults] setObject:localMonitorPort forKey:@"localMonitorPort"];
}


/*
 //监控设置 本地 用户名
 @property (copy,nonatomic) NSString *localMonitorUser;
 */

-(void)setLocalMonitorUser:(NSString *)localMonitorUser{
    _localMonitorUser = [localMonitorUser copy];
    [[NSUserDefaults standardUserDefaults] setObject:localMonitorUser forKey:@"localMonitorUser"];
}


/*
 //监控设置 本地 密码
 @property (copy,nonatomic) NSString *localMonitorPassword;
 */

-(void)setLocalMonitorPassword:(NSString *)localMonitorPassword{
    _localMonitorPassword = [localMonitorPassword copy];
    [[NSUserDefaults standardUserDefaults] setObject:localMonitorPassword forKey:@"localMonitorPassword"];

}

/*
 //监控设置 远程 账号
 @property (copy,nonatomic) NSString *remoteMonitoruser;
 */
-(void)setRemoteMonitoruser:(NSString *)remoteMonitoruser{
    _remoteMonitoruser = [remoteMonitoruser copy];
    [[NSUserDefaults standardUserDefaults] setObject:remoteMonitoruser forKey:@"remoteMonitoruser"];
}

/*
 //监控设置 远程 密码
 @property (copy,nonatomic) NSString *remoteMonitorPassword;
 */
-(void)setRemoteMonitorPassword:(NSString *)remoteMonitorPassword{
    _remoteMonitorPassword = [remoteMonitorPassword copy];
    [[NSUserDefaults standardUserDefaults] setObject:remoteMonitorPassword forKey:@"remoteMonitorPassword"];
}

/*
 //对讲设置 门口机1 IP
 @property (copy,nonatomic) NSString *mechine1IP;
 */

-(void)setMechine1IP:(NSString *)mechine1IP{
    _mechine1IP = [mechine1IP copy];
    [[NSUserDefaults standardUserDefaults] setObject:mechine1IP forKey:@"mechine1IP"];
}


/*
 //对讲设置 门口机1 端口
 @property (copy,nonatomic) NSString *mechine1port;
 */
-(void)setMechine1port:(NSString *)mechine1port{
    _mechine1port = [mechine1port copy];
    [[NSUserDefaults standardUserDefaults] setObject:mechine1port forKey:@"mechine1port"];
}

/*
 //对讲设置 门口机2 IP
 @property (copy,nonatomic) NSString *mechine2IP;
 */

-(void)setMechine2IP:(NSString *)mechine2IP{
    _mechine2IP = [mechine2IP copy];
    [[NSUserDefaults standardUserDefaults] setObject:mechine2IP forKey:@"mechine2IP"];

}


/*
 //对讲设置 门口机2 端口
 @property (copy,nonatomic) NSString *mechine2Port;
 */

-(void)setMechine2Port:(NSString *)mechine2Port{
    _mechine2Port = [mechine2Port copy];
    [[NSUserDefaults standardUserDefaults] setObject:mechine2Port forKey:@"mechine2Port"];

}


/*
 //通知显示消息详情
 @property (copy,nonatomic) NSString *isShowMessageDetail;
 */

-(void)setIsShowMessageDetail:(NSString *)isShowMessageDetail{
    _isShowMessageDetail = [isShowMessageDetail copy];
    [[NSUserDefaults standardUserDefaults] setObject:isShowMessageDetail forKey:@"isShowMessageDetail"];

}

/*
 //通知出现声音
 @property (copy,nonatomic) NSString *isNeedAudio;
 */
-(void)setIsNeedAudio:(NSString *)isNeedAudio{
    _isNeedAudio = [isNeedAudio copy];
    [[NSUserDefaults standardUserDefaults] setObject:isNeedAudio forKey:@"isNeedAudio"];

}

/*
 //通知是否开启
 @property (copy,nonatomic) NSString *isOpenNotification;
 */
-(void)setIsOpenNotification:(NSString *)isOpenNotification{
    _isOpenNotification = [isOpenNotification copy];
    [[NSUserDefaults standardUserDefaults] setObject:isOpenNotification forKey:@"isOpenNotification"];
\
}



@end
