//
//  SHHomeViewController.m
//  SmartHome
//
//  Created by tong li on 16/7/21.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHHomeViewController.h"
#import "SHSettingViewController.h"
#import "SHMessageViewController.h"
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
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
     self.barBottomConstraint.constant = -ScreenWidth * 55 /667;
    [self uiConfig];
}

-(void)uiConfig{
    self.barBottomConstraint.constant = -ScreenWidth * 55 /667;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick)];
    [self.view addGestureRecognizer:tap];
}

-(void)tapclick{
    [UIView animateWithDuration:0.3f animations:^{
        self.barView.y = self.view.maxY;
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
        SHMessageViewController *messageVC = [[SHMessageViewController alloc] init];
        [self.navigationController pushViewController:messageVC animated:YES];
    }
}

//本地连接
- (IBAction)clickHomeButton:(id)sender {
    if ([self isLogin]) {
        SHOperationViewController *operation = [[SHOperationViewController alloc] init];
        SHUserModel *userModel = [[SHUserManager sharedInstance] getUser];
        NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:userModel.userId];
        NSString *urlString = @"";
        if (IS_IPAD) {
            urlString = [NSString stringWithFormat:@"%@/html/iPad.html",path];
        }else{
            urlString = [NSString stringWithFormat:@"%@/html/iTouch.html",path];
        }
        operation.urlString = urlString;
        [self.navigationController pushViewController:operation animated:YES];
    }
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
    if ([[SHLoginManager shareInstance] isLogin]) {
        return YES;
    }else{
        [SHLoginManager userPresentLogin:self];
        return NO;
    }
}

- (IBAction)clickMenuButton:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.barView.y = self.view.maxY - self.barView.height;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
