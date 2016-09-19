//
//  SHHttpsHelper.h
//  SmartHome
//
//  Created by hui on 16/9/12.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "SHCommonHeader.h"
#import "SHUserModel.h"
#import "SHUserManager.h"
#import "SSZipArchive.h"

@interface SHHttpsHelper : NSObject

+ (void)setBackInfo:(NSMutableDictionary *)backInfo;
+ (void)downLoadZip;

@end
