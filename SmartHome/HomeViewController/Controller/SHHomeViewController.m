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
#import "SHOperationViewController.h"

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
//本地连接
- (IBAction)clickHomeButton:(id)sender {
    SHOperationViewController *operation = [[SHOperationViewController alloc] init];
    NSString *url = [[NSBundle mainBundle] pathForResource:@"operation" ofType:@"html"];
    operation.urlString = url;
    [self.navigationController pushViewController:operation animated:YES];
}
//远程连接
- (IBAction)clickCameraButton:(id)sender {
    
}

- (IBAction)clickPhoneButton:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
