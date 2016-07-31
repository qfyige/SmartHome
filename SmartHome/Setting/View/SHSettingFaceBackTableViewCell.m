//
//  SHSettingFaceBackTableViewCell.m
//  SmartHome
//
//  Created by tong lele on 16/7/31.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHSettingFaceBackTableViewCell.h"

@implementation SHSettingFaceBackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showText.layer.cornerRadius = 6.0f;
    self.showText.clipsToBounds = YES;
    self.submitButton.layer.cornerRadius = 15.0f;
    self.submitButton.clipsToBounds = YES;
}


- (IBAction)clickSubmitButton:(id)sender {
    if(_clickSubmitBlock){
        _clickSubmitBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
