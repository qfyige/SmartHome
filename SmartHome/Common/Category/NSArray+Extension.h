//
//  NSArray+Extension.h
//  Kemai
//
//  Created by AzureSky on 16/1/31.
//  Copyright © 2016年 minhechen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/*
 将数组转换成json
 */
- (NSString *)JSONDataString;

/*!
 @method objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)objectAtIndexCheck:(NSUInteger)index;
/**
 *  获取指定字段的数组
 *
 *  @param field 字段名称
 *
 *  @return 数组
 */
- (NSArray *)getContentArrayWithField:(NSString *)field;
@end


@interface NSMutableArray (Extension)

/*
 检查数组越界和替换对象是否为nil
 */
- (void)replaceObjectAtIndexCheck:(NSUInteger)index withObjectCheck:(id)object;

@end
