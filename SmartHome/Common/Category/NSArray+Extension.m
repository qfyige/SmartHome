//
//  NSArray+Extension.m
//  Kemai
//
//  Created by AzureSky on 16/1/31.
//  Copyright © 2016年 minhechen. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (NSString *)JSONDataString
{
    //检测数字是否可转换为json
    BOOL value = [NSJSONSerialization isValidJSONObject:self];
    if (!value) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                      encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (NSArray *)getContentArrayWithField:(NSString *)field
{
    NSMutableArray *tempArray = [NSMutableArray array];
    if (self.count <= 0) return nil;
    for (NSDictionary *dictArray in self) {
        NSString *value = [dictArray objectForKey:[NSString stringWithFormat:@"%@",field]];
        if ([value isKindOfClass:[NSNull class]]) {
            continue;
        }
        [tempArray addObject:value];
    }
    return tempArray;
}

@end


@implementation NSMutableArray (Extension)

- (void)replaceObjectAtIndexCheck:(NSUInteger)index withObjectCheck:(id)object
{
    if (index >= self.count) {
        
        return;
    }
    
    if (!object || [object isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:object];
}

@end
