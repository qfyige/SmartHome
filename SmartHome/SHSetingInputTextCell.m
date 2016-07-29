//
//  SHSetingInputTextCell.m
//  SmartHome
//
//  Created by tong li on 16/7/27.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHSetingInputTextCell.h"

@implementation SHSetingInputTextCell
-(void)awakeFromNib{
    self.mTextFeild.enabled = YES;
    self.mTextFeild.userInteractionEnabled = YES;
    NSLog(@"%ld",self.mTextFeild.canBecomeFocused);
    NSLog(@"%@",self.mTextFeild.superview);
}

@end
