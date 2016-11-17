//
//  DESHelper.h
//  SmartHome
//
//  Created by tong li on 2016/10/26.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESHelper : NSObject

/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

//解密
+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;

@end
