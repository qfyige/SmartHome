//
//  SHDownLoadZipManager.m
//  SmartHome
//
//  Created by tong li on 16/9/7.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHDownLoadZipManager.h"

#define KZipBundleName @"asset_zip"
#define KZipAssetsName @"assets"

@implementation SHDownLoadZipManager{
   NSString *_updateBundlePath;
}

// 本地base目录
- (NSString *)baseBundlePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * bundlePath = [documentsDirectory stringByAppendingPathComponent:@"bundle"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL isDirExist = [fileManager fileExistsAtPath:bundlePath isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        [fileManager createDirectoryAtPath:bundlePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return bundlePath;
}

//本地文件
- (NSString *)localBundlePath
{
    NSString * bundleName = KZipBundleName;
    NSString * bundlePath =[[self baseBundlePath] stringByAppendingPathComponent:bundleName];
    return bundlePath;
}

//本地asset
- (NSString *)localAssetsPath
{
    NSString * assetsPath =[[self baseBundlePath] stringByAppendingPathComponent:KZipAssetsName];
    return assetsPath;
}

// 本地下载目录
- (NSString *)downBundlePath
{
    NSString * bundleName = [NSString stringWithFormat:@"download_%@",KZipBundleName];
    NSString * bundlePath =[[self baseBundlePath] stringByAppendingPathComponent:bundleName];
    return bundlePath;
}

- (void)bundleCheckUpdate:(void(^)(BOOL reasult))aBundleCallBack
{
    NSFileManager*fileManager =[NSFileManager defaultManager];
#warning user server url
    NSString * serverFilePath = @"server address";
    NSString * downFilePath = [self downBundlePath];
    
    BOOL isDir = NO;
    if([fileManager fileExistsAtPath:downFilePath isDirectory:&isDir]){
        [fileManager removeItemAtPath:downFilePath error:nil];
    }
#warning add request
    /*
        if ([result isKindOfClass:[BaseRequestModel class]])
        {
            BaseRequestModel *model = (BaseRequestModel *)result;
            if (model.errorCode == 0) //下载成功
            {
                //解压之前先删除本地jsbundle
                BOOL isDir = NO;
                NSString * unzipBundleFilePath = [self localBundlePath];
                if ([fileManager fileExistsAtPath:unzipBundleFilePath isDirectory:&isDir]){
                    [fileManager removeItemAtPath:unzipBundleFilePath error:nil];
                }
                
                //解压之前先删除本地assets
                isDir = YES;
                NSString * unzipAssetsFilePath = [self localAssetsPath];
                if ([fileManager fileExistsAtPath:unzipAssetsFilePath isDirectory:&isDir]){
                    [fileManager removeItemAtPath:unzipAssetsFilePath error:nil];
                }
                
                // 解压到目录 baseBundlePath 下， bundle名为：jsbundleName
                BOOL unRet = [SSZipArchive unzipFileAtPath:downFilePath toDestination:[self baseBundlePath]];
                if ( unRet){ // 解压成功
                     [UserAppData setReactCurrentVer:serverVer];
                }
            }
        }
        if ( aBundleCallBack){
            aBundleCallBack.doneBlock(result,tag);
        }
    };
     */
}


@end
