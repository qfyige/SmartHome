//
//  KMDAOModelBase.h
//  Kemai
//
//  Created by peilin on 15/4/14.
//  Copyright (c) 2015年 minhechen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCommonHeader.h"

/**
 *  0（删除）
 */
#define LOCAL_DELETE   0

/**
 *  1（新增或更新）
 */
#define LOCAL_ADD      1

/**
 *  1（新增或更新）
 */
#define LOCAL_UPDATE   1

/**
 *  2（标准态）同步完成后更改本地状态为2，表示数据没有发生变化
 */
#define LOCAL_NORMAL   2

/**
 *  本地入库前
 */
#define LOCAL_WILLADD  -1

//#define REMOTE_ADD      1
//#define REMOTE_UPDATE   3
//#define REMOTE_DELETE   5

#define KM_HTTP_ACTION          @"action"


@interface SHModelBase : NSObject 

+(LKDBHelper *)getUsingLKDBHelper;
+(LKDBHelper *)getUsingLKDBHelperWith:(NSString *)userID;
+(void) purgeUsingLKDBHelper;

@end

@interface NSObject(PrintSQL)
+(NSString*)getCreateTableSQL;
@end