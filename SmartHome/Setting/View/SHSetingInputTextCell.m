//
//  SHSetingInputTextCell.m
//  SmartHome
//
//  Created by tong li on 16/7/27.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHSetingInputTextCell.h"
#import <Masonry.h>
@implementation SHSetingInputTextCell
-(void)awakeFromNib{
    self.mTextFeild.frame =CGRectMake(80, 8, 220, 31);
    [self.contentView addSubview:self.mTextFeild];
    self.mTextFeild.enabled = YES;
    self.mTextFeild.userInteractionEnabled = YES;
    self.mTextFeild.delegate= self;
}

@end
