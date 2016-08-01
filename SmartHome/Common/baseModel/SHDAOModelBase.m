//
//  KMDAOModelBase.m
//  Kemai
//
//  Created by peilin on 15/4/14.
//  Copyright (c) 2015年 minhechen. All rights reserved.
//

#import "SHDAOModelBase.h"

@implementation SHDAOModelBase

static LKDBHelper* lkdbHelper = nil;

+(LKDBHelper *)getUsingLKDBHelper
{
//    BOOL isLogin = [[KMUser getInstance] isLogin];
//    if (isLogin) {
//        KMUser *kmUser = [KMUser getInstance];
//        NSString *userID = [kmUser getUserID];
//        if (IS_NSStringEx(userID)) {
//            if (lkdbHelper == nil) {
//                NSString *dbname = [NSString stringWithFormat:@"%@.db",userID];
//                NSString *dbpath = [DocumentsPath stringByAppendingPathComponent:dbname];
//                lkdbHelper = [[LKDBHelper alloc] initWithDBPath:dbpath];
//            }
//        }
//    }else{
//        if (lkdbHelper == nil) {
//            lkdbHelper = [[LKDBHelper alloc] initWithDBPath:TEMP_DB_PATH];
//        }
//    }
//    return lkdbHelper;
    if (!lkdbHelper) {
        lkdbHelper = [[LKDBHelper alloc] init];
    }
    return lkdbHelper;
}

+(void) purgeUsingLKDBHelper
{
    lkdbHelper = nil;
}

@end


@implementation NSObject(PrintSQL)

+(NSString *)getCreateTableSQL
{
    LKModelInfos* infos = [self getModelInfos];
    NSString* primaryKey = [self getPrimaryKey];
    NSMutableString* table_pars = [NSMutableString string];
    for (int i=0; i<infos.count; i++) {
        
        if(i > 0)
            [table_pars appendString:@","];
        
        LKDBProperty* property =  [infos objectWithIndex:i];
        [self columnAttributeWithProperty:property];
        
        [table_pars appendFormat:@"%@ %@",property.sqlColumnName,property.sqlColumnType];
        
        if([property.sqlColumnType isEqualToString:LKSQL_Type_Text])
        {
            if(property.length>0)
            {
                [table_pars appendFormat:@"(%ld)",(long)property.length];
            }
        }
        if(property.isNotNull)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_NotNull];
        }
        if(property.isUnique)
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_Unique];
        }
        if(property.checkValue)
        {
            [table_pars appendFormat:@" %@(%@)",LKSQL_Attribute_Check,property.checkValue];
        }
        if(property.defaultValue)
        {
            [table_pars appendFormat:@" %@ %@",LKSQL_Attribute_Default,property.defaultValue];
        }
        if(primaryKey && [property.sqlColumnName isEqualToString:primaryKey])
        {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_PrimaryKey];
        }
    }
    NSString* createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[self getTableName],table_pars];
    return createTableSQL;
}

@end