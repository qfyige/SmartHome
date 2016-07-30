//
//  SHRegisterViewController.m
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHRegisterViewController.h"
#import "SHCommonHeader.h"

@interface SHRegisterViewController ()<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    UITextField *passwordTextField;
}

@end

@implementation SHRegisterViewController

#pragma mark -
#pragma mark - initView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setUpViewContent];
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
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"填写信息";
    label.font = SH_SYSTEM_FONT_(25);
    label.textColor = BlackColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.view).offset(top);
        make.size.mas_equalTo(CGSizeMake(labelW, labelH));
    }];
    
    phoneTextField = [[UITextField alloc] init];
    phoneTextField.font = SH_SYSTEM_FONT_(fontNum);
    phoneTextField.placeholder = @"请输入账号";
    phoneTextField.textColor = BlackColor;
    phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField.textAlignment = NSTextAlignmentCenter;
    [phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
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
    
    UIButton *registerButton = [[UIButton alloc] init];
    registerButton.titleLabel.font = SH_SYSTEM_FONT_(fontNum);
    [registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLineView);
        make.top.equalTo(passwordLineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(labelW/3, labelH));
    }];
    
    UIButton *frogetPasswordButton = [[UIButton alloc] init];
    frogetPasswordButton.titleLabel.font = SH_SYSTEM_FONT_(fontNum);
    [frogetPasswordButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [frogetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [frogetPasswordButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [frogetPasswordButton addTarget:self action:@selector(frogetPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:frogetPasswordButton];
    
    [frogetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passwordLineView);
        make.top.equalTo(passwordLineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(labelW/3, labelH));
    }];
    
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
        make.bottom.equalTo(ws.view).offset(-top);
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

- (void)registerButtonAction
{
    SHRegisterViewController *registerVC = [[SHRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)frogetPasswordButtonAction
{
}

- (void)loginButtonAction:(id)sender
{
    [self.view endEditing:YES];
    if ( phoneTextField.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空"];
        return;
    } else if (passwordTextField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    } else if (passwordTextField.text.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"密码应该为6-18位"];
        return;
    }else{
        [SVProgressHUD showWithStatus:@"登录中..."];
    }
    
    //    NSDictionary *parameters = @{@"account":phoneTextField.text,
    //                                 @"password":passwordTextField.text};
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