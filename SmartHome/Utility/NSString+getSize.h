//
//  NSString+getSize.h
//  SmartHome
//
//  Created by tong lele on 16/7/31.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (getSize)

-(CGSize)getSizeWithFont:(UIFont*)font;

-(CGSize)getSizeWithFont:(UIFont *)font width:(CGFloat)width;

@end
