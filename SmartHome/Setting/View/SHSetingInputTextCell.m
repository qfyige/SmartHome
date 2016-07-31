//
//  SHSetingInputTextCell.m
//  SmartHome
//
//  Created by tong li on 16/7/27.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHSetingInputTextCell.h"
#import "SHDefine.h"

@implementation SHSetingInputTextCell
-(void)awakeFromNib{

    self.mTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(80, 8, ScreenWidth -100 - ScreenWidth*125/667, 31)];
    self.mTextFeild.placeholder = @"请输入您的IP地址";
    self.mTextFeild.font = [UIFont systemFontOfSize:12];
    self.mTextFeild.textColor = RGBColor(189, 189, 189, 1);
    [self.contentView addSubview:self.mTextFeild];
    self.mTextFeild.enabled = YES;
    self.mTextFeild.userInteractionEnabled = YES;
    self.mTextFeild.delegate= self;
}

@end
