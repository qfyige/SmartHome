//
//  SHAboutUsTableViewCell.m
//  SmartHome
//
//  Created by tong lele on 16/7/31.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHAboutUsTableViewCell.h"

@implementation SHAboutUsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _showImage.layer.cornerRadius = 6.0f;
    _showImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
