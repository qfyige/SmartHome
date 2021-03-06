//
//  SHLoginViewController.m
//  SmartHome
//
//  Created by tong li on 16/7/21.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHLoginViewController.h"
#import "SHHomeViewController.h"
#import "SHHttpsHelper.h"
#import "JDES.h"

@interface SHLoginViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    UITextField *passwordTextField;
}

@end

@implementation SHLoginViewController

#pragma mark -
#pragma mark - initView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setUpViewContent];
    [self addBackButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpViewContent
{
    CGFloat width = self.view.width;
    CGFloat height = self.view.height;
    CGFloat top = height*0.1;
    CGFloat labelW = width*0.5;
    CGFloat labelH = 50.0;
    CGFloat lineViewH = 0.5;
    NSInteger fontNum = 17;
    Weakly(ws)
    
    UIImage *image = [UIImage imageNamed:@"loginIcon"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.view).offset(top);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"欢迎进入联电国际智能家居\nV0.2";
    label.font = SH_SYSTEM_FONT_(fontNum);
    label.textColor = BlackColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(imageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    phoneTextField = [[UITextField alloc] init];
    phoneTextField.font = SH_SYSTEM_FONT_(fontNum);
    phoneTextField.placeholder = @"请输入账号";
    phoneTextField.textColor = BlackColor;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.textAlignment = NSTextAlignmentCenter;
    [phoneTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    NSString *phoneText = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_phone"];
    if (phoneText.length > 0) {
        phoneTextField.text = phoneText;
    }else{
        [phoneTextField becomeFirstResponder];
    }
    [self.view addSubview:phoneTextField];
    
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(label.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    UILabel *phoneLineView = [[UILabel alloc] init];
    phoneLineView.backgroundColor = BlackColor;
    [self.view addSubview:phoneLineView];
    
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(phoneTextField.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(labelW, lineViewH));
    }];
    
    passwordTextField = [[UITextField alloc] init];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    passwordTextField.textColor = BlackColor;
    passwordTextField.font = SH_SYSTEM_FONT_(fontNum);
    passwordTextField.textAlignment = NSTextAlignmentCenter;
    passwordTextField.delegate = self;
    passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    if (phoneText.length > 0) {
        [passwordTextField becomeFirstResponder];
    }
    [self.view addSubview:passwordTextField];
    
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(phoneLineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    UILabel *passwordLineView = [[UILabel alloc] init];
    passwordLineView.backgroundColor = BlackColor;
    [self.view addSubview:passwordLineView];
    
    [passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(passwordTextField.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(labelW, lineViewH));
    }];
    
    //    UIButton *registerButton = [[UIButton alloc] init];
    //    registerButton.titleLabel.font = SH_SYSTEM_FONT_(fontNum);
    //    [registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    //    [registerButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:registerButton];
    //
    //    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(passwordLineView);
    //        make.top.equalTo(passwordLineView.mas_bottom);
    //        make.size.mas_equalTo(CGSizeMake(labelW/3, labelH));
    //    }];
    //
    //    UIButton *frogetPasswordButton = [[UIButton alloc] init];
    //    frogetPasswordButton.titleLabel.font = SH_SYSTEM_FONT_(fontNum);
    //    [frogetPasswordButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //    [frogetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    //    [frogetPasswordButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    //    [frogetPasswordButton addTarget:self action:@selector(frogetPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:frogetPasswordButton];
    //
    //    [frogetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(passwordLineView);
    //        make.top.equalTo(passwordLineView.mas_bottom);
    //        make.size.mas_equalTo(CGSizeMake(labelW/3, labelH));
    //    }];
    //
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.backgroundColor = BlackColor;
    loginButton.layer.cornerRadius = 4.0;
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.borderWidth = 0.5f;
    loginButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [loginButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = SH_SYSTEM_FONT_(fontNum);
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-top*2);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark -
#pragma mark - btnClick

- (void)close
{
    [self tapClick:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if([phoneTextField canResignFirstResponder]) {
        [phoneTextField resignFirstResponder];
    }
    if ([passwordTextField canResignFirstResponder]) {
        [passwordTextField resignFirstResponder];
    }
}
//
//- (void)registerButtonAction
//{
//    SHRegisterViewController *registerVC = [[SHRegisterViewController alloc] init];
//    [self.navigationController pushViewController:registerVC animated:YES];
//}
//
//- (void)frogetPasswordButtonAction
//{
//}

- (void)loginButtonAction:(id)sender
{
    [self.view endEditing:YES];
    if (phoneTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"账号不能为空"];
        return;
    } else if (passwordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }else{
        [SVProgressHUD showWithStatus:@"登录中..."];
    }
    //系统类型:1:IPHONE,2:ANDROID,3IPAD
    NSString *mobModel = @"";
    if (IS_IPAD) {
        mobModel = @"3";
    }else{
        mobModel = @"1";
    }
    NSString *str = [NSString stringWithFormat:@"{\"seckey\":\"\",\"method\":\"login\",\"infopackage\":{\"userId\":\"%@\",\"password\":\"%@\",\"mobile\":\"\",\"mobModel\":\"%@\",\"mobBrand\":\"\"}}",phoneTextField.text,passwordTextField.text,mobModel];
    NSString *encrityKey = [JDES AES128Encrypt:str WithGkey:@"ldshldshldshldsh" gIv:@"ldshldshldshldsh"];
    [SHRequestHelper sendMessage:encrityKey complete:^(SocketRequestModel *requestModel) {
        [SVProgressHUD dismiss];
        NSString *method = requestModel.method;
        if([method isEqualToString:@"login"]){
            if (requestModel.resultCode == 1004) {
                if (IS_NSArray(requestModel.backinfo)) {
                    [[SHLoginManager shareInstance] userLoginDataWith:requestModel.backinfo[0] password:passwordTextField.text];
                    [self close];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"登录失败"];
            }
        }
    } fail:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        NSLog(@"%@",error.description);
    }];
}

#pragma mark -
#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return  YES;
}

@end
