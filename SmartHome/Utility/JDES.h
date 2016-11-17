//
//  JDES.h
//  Edutcaion
//
//  Created by jiaoguangzhou on 14-10-30.
//  Copyright (c) 2014年 sinobpo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JDES : NSObject
+(NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key;//des加密
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;//des解密

+(NSString *)AES128Encrypt:(NSString *)plainText WithGkey:(NSString *)gkey gIv:(NSString *)gIv;
+(NSString *)AES128Decrypt:(NSString *)encryptText WithGkey:(NSString *)gkey gIv:(NSString *)gIv;

@end
