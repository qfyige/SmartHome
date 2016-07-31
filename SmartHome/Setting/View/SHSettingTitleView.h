//
//  SHSettingTitleView.h
//  SmartHome
//
//  Created by tong li on 16/7/28.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLSwitch.h"
@interface SHSettingTitleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet KLSwitch *showSwitch;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (nonatomic,copy) void(^clickSaveButton)();

@end
