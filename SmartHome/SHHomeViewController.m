//
//  SHHomeViewController.m
//  SmartHome
//
//  Created by tong li on 16/7/21.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHSettingViewController.h"
#import "SHDefine.h"

@interface SHHomeViewController ()

@end

@implementation SHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//个人中心
- (IBAction)peopleCenter:(id)sender {
    SHSettingViewController *set = GetStoryBoardWithViewControllerName(@"SHSettingViewController");
    [self.navigationController pushViewController:set animated:YES];
}

// 消息
- (IBAction)notification:(id)sender {
    
}
//个人家具
- (IBAction)clickHomeButton:(id)sender {
    
}

- (IBAction)clickCameraButton:(id)sender {
    
}

- (IBAction)clickPhoneButton:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
