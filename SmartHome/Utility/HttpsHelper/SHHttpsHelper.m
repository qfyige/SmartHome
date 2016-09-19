//
//  SHHttpsHelper.m
//  SmartHome
//
//  Created by hui on 16/9/12.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHHttpsHelper.h"

@implementation SHHttpsHelper

static  NSMutableDictionary *dict;

+ (void)setBackInfo:(NSMutableDictionary *)backInfo
{
    if (backInfo) {
        dict = backInfo;
    }
}

+ (void)downLoadZip
{
    NSString *url = dict[@"downloadUrl"];
    if (IS_NSStringEx(url)) {
        [SVProgressHUD showWithStatus:@"下载中..."];
        NSString *zipName = [url lastPathComponent];
//            NSURL *httpsUrl = [NSURL URLWithString:@"https://101.201.209.42:8443/ldnet/upload/controlPage/html.zip"];//访问路径
        NSURL *httpsUrl = [NSURL URLWithString:url];//访问路径
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:httpsUrl];
        SecIdentityRef identity = NULL;
        SecTrustRef trust = NULL;
        //绑定证书，证书放在Resources文件夹中
        NSData *PKCS12Data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]];//证书文件名和文件类型
        [self extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data];
        [request setClientCertificateIdentity:identity];//设定访问路径
        [request setValidatesSecureCertificate:NO];//是否验证服务器端证书，如果此项为yes那么服务器端证书必须为合法的证书机构颁发的，而不能是自己用openssl 或java生成的证书
        //初始化保存ZIP文件路径
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *savePath = [path stringByAppendingPathComponent:zipName];
        NSLog(@"hui-->savePath-->%@",savePath);
        //初始化临时文件路径
        NSString *tempPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.temp",zipName]];
        NSLog(@"hui-->tempPath-->%@",tempPath);
        //设置文件保存路径
        [request setDownloadDestinationPath:savePath];
        //设置临时文件路径
        [request setTemporaryFileDownloadPath:tempPath];
        //设置是是否支持断点下载
        [request setAllowResumeForFileDownloads:YES];
        [request startSynchronous];
        NSError *error = [request error];
        if (!error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"下载成功"];
            NSString *response = [request responseString];
            NSLog(@"response is : %@",response);
            SHUserModel *userModel = [[SHUserManager sharedInstance] getUser];
            path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/",userModel.userId]];
            BOOL success = [SSZipArchive unzipFileAtPath:savePath toDestination:path];
            if (success) {
                [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
                NSLog(@"unzipFileAtPath is success");
                [SVProgressHUD showSuccessWithStatus:@"解压成功"];
            }
        } else {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"下载失败"];
            NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
            NSLog(@"%@",[error userInfo]);
        }
    }
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    
    CFStringRef password = CFSTR("ever@01"); //证书密码
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { password };
    
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(NULL, keys,values, 1,NULL, NULL);
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    //securityError = SecPKCS12Import((CFDataRef)inPKCS12Data,(CFDictionaryRef)optionsDictionary,&items);
    securityError = SecPKCS12Import((CFDataRef)inPKCS12Data,optionsDictionary,&items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failed with error code %d",(int)securityError);
        return NO;
    }
    return YES;
}

@end
