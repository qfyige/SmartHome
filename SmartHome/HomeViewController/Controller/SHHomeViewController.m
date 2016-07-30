//
//  SHHomeViewController.m
//  SmartHome
//
//  Created by tong li on 16/7/21.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHSettingViewController.h"
#import "SHCommonHeader.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
//个人中心
- (IBAction)peopleCenter:(id)sender {
    SHSettingViewController *set = GetStoryBoardWithViewControllerName(@"SHSettingViewController");
    [self.navigationController pushViewController:set animated:YES];
}

// 消息
- (IBAction)notification:(id)sender {
    if ([self isLogin]) {
    }
}
//个人家具
- (IBAction)clickHomeButton:(id)sender {
    if ([self isLogin]) {
    }
}

- (IBAction)clickCameraButton:(id)sender {
    if ([self isLogin]) {
    }
}

- (IBAction)clickPhoneButton:(id)sender {
    if ([self isLogin]) {
    }
}

- (BOOL)isLogin {
    if ([SHLoginManager isLogin]) {
        return YES;
    }else{
        [SHLoginManager userPresentLogin:self];
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
