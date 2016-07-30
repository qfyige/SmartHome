//
//  NSString+getSize.m
//  SmartHome
//
//  Created by tong lele on 16/7/31.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "NSString+getSize.h"

@implementation NSString (getSize)

-(CGSize)getSizeWithFont:(UIFont*)font{
    CGSize detailSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    return detailSize;
}

-(CGSize)getSizeWithFont:(UIFont *)font width:(CGFloat)width{
    CGSize detailSize = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    return detailSize;

}

@end
