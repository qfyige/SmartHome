//
//  SHHomeViewController.m
//  SmartHome
//
//  Created by tong li on 16/7/21.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHSettingViewController.h"
#import "SHOperationViewController.h"
#import "SHCommonHeader.h"

@interface SHHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *barView;

@end

@implementation SHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.barBottomConstraint.constant = -ScreenWidth * 55 /667;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapclick{
    [UIView animateWithDuration:1.0f animations:^{
        self.barBottomConstraint.constant = -self.barView.frame.size.height;
    }];
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

//本地连接
- (IBAction)clickHomeButton:(id)sender {
//    if ([self isLogin]) {
        SHOperationViewController *operation = [[SHOperationViewController alloc] init];
        NSString *url = [[NSBundle mainBundle] pathForResource:@"operation" ofType:@"html"];
        operation.urlString = url;
        [self.navigationController pushViewController:operation animated:YES];
//    }
}
//远程连接
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
- (IBAction)clickMenuButton:(id)sender {
    [UIView animateWithDuration:1.0f animations:^{
        self.barBottomConstraint.constant = 0;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
