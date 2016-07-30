//
//  SHMessageCell.h
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMessageModel.h"

@interface SHMessageCell : UITableViewCell

@property (nonatomic,strong) UIView *upLineView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UIImageView *iconImageView;

- (void)setMessageWithModel:(SHMessageModel *)model;

@end
