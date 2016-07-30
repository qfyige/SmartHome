//
//  SHMessageCell.m
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHMessageCell.h"
#import "SHCommonHeader.h"

@implementation SHMessageCell

@synthesize upLineView;
@synthesize timeLabel;
@synthesize titleLabel;
@synthesize subTitleLabel;
@synthesize iconImageView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        [self initView];
    }
    return self;
}

- (void)initView
{
    CGFloat width = ScreenWidth;
    CGFloat labelH = 20;
    CGFloat labelW = width*0.5;
    CGFloat iconW = 31;
    CGFloat top = 5;
    UIFont *font = SH_SYSTEM_FONT_(12);
    Weakly(ws)
    
    iconImageView = [[UIImageView alloc] init];
    [iconImageView.layer setCornerRadius:iconW * 0.5];
    [iconImageView.layer setBorderWidth:0.5];
    [iconImageView.layer setBorderColor:BlackColor.CGColor];
    [iconImageView setClipsToBounds:YES];
    [self addSubview:iconImageView];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(top);
        make.left.equalTo(ws).offset(top*4);
        make.size.mas_equalTo(CGSizeMake(iconW, iconW));
    }];
    
    titleLabel = [[UILabel alloc] init];
    [titleLabel setTextColor:BlackColor];
    [titleLabel setFont:SH_SYSTEM_FONT_(15)];
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView);
        make.left.equalTo(iconImageView.mas_right).offset(top);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    subTitleLabel = [[UILabel alloc] init];
    [subTitleLabel setTextColor:BlackColor];
    [subTitleLabel setFont:font];
    [self addSubview:subTitleLabel];
    
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(titleLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    timeLabel = [[UILabel alloc] init];
    [timeLabel setTextColor:BlackColor];
    [timeLabel setFont:font];
    [self addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subTitleLabel.mas_bottom);
        make.left.equalTo(titleLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    upLineView = [[UIView alloc] init];
    [upLineView setBackgroundColor:BlackColor];
    [self addSubview:upLineView];
    
    [upLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws);
        make.left.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(width, 0.5));
    }];
}

- (void)setMessageWithModel:(SHMessageModel *)model
{
    if (model) {
        if (model.title) {
            [titleLabel setText:model.title];
        }else{
            [titleLabel setText:@""];
        }
        if (model.subTitle) {
            [subTitleLabel setText:model.subTitle];
        }else{
            [subTitleLabel setText:@""];
        }
        if (model.time) {
            [timeLabel setText:model.time];
        }else{
            [timeLabel setText:@""];
        }
    }
}

@end
