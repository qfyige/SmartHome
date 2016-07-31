//
//  SHSettingTitleView.m
//  SmartHome
//
//  Created by tong li on 16/7/28.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHSettingTitleView.h"
#import "SHDefine.h"

@implementation SHSettingTitleView


-(void)awakeFromNib{
    [self.showSwitch setOnTintColor:GreenColor];
    self.saveButton.layer.cornerRadius = (self.frame.size.height -24)/2;
    self.saveButton.clipsToBounds = YES;
}

- (IBAction)clickSaveButton:(id)sender {
    if(_clickSaveButton){
        _clickSaveButton();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
