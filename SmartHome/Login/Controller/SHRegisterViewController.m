//
//  SHRegisterViewController.m
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHRegisterViewController.h"

@interface SHRegisterViewController ()<UITextFieldDelegate>
{
    UITextField *accountTextField;
    UITextField *passwordTextField;
    UITextField *confirmPasswordTextField;
    UITextField *contactTextField;
    UITextField *phoneTextField;
    UITextField *SNTextField;
    UITextField *locationTextField;
    UITextField *detailTextField;
}

@end

@implementation SHRegisterViewController

#pragma mark -
#pragma mark - initView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setUpViewContent];
    [self addBackButton];
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
    CGFloat labelH = 30.0;
    CGFloat textFieldX = width*0.225;
    CGFloat textFieldY = height*0.25;
    CGFloat textFieldW = width*0.25;
    CGFloat textFieldH = labelH;
    CGFloat textFieldPadding = width*0.05;
    CGFloat padding = 20;
    NSInteger fontNum = 17;
    if (IS_IPAD) {
        labelH = 50;
        textFieldH = labelH;
        padding = labelH;
    }
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
    
    NSMutableArray *placeArray = [NSMutableArray arrayWithCapacity:4];
    [placeArray addObject:@[@"账号",@"密码"]];
    [placeArray addObject:@[@"确认密码",@"联系人"]];
    [placeArray addObject:@[@"手机号",@"SN注册码"]];
    [placeArray addObject:@[@"所在地",@"详细地址"]];
    
    for (NSInteger i = 0; i < 4; i++) {
        NSArray *array = [placeArray objectAtIndex:i];
        UITextField *fTextField = nil;
        CGFloat x = textFieldX;
        for (NSUInteger j = 0; j < 2; j++) {
            NSInteger index = i*4 + j;
            fTextField = [self getDefaultTextField:[array objectAtIndex:j] fontNum:fontNum index:index];
            fTextField.frame = CGRectMake(x, textFieldY, textFieldW, textFieldH);
            [self.view addSubview:fTextField];
            x = fTextField.maxX + textFieldPadding;
        }
        textFieldY = fTextField.maxY + padding;
    }
    
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.backgroundColor = BlackColor;
    loginButton.layer.cornerRadius = 4.0;
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.borderWidth = 0.5f;
    loginButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [loginButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [loginButton setTitle:@"注册账号" forState:UIControlStateNormal];
    loginButton.titleLabel.font = SH_SYSTEM_FONT_(fontNum);
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view).offset(-top);
        make.size.mas_equalTo(CGSizeMake(labelW, 50));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
}

- (NSMutableArray *)getTextFieldArray:(id)obejct1 object2:(id)object2
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:obejct1];
    [array addObject:object2];
    return array;
}

- (UITextField *)getDefaultTextField:(NSString *)placeholder fontNum:(NSInteger)fontNum index:(NSInteger)index
{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = SH_SYSTEM_FONT_(fontNum);
    textField.placeholder = placeholder;
    textField.textColor = BlackColor;
    textField.layer.cornerRadius = 2.0;
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 0.5f;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.keyboardType = UIKeyboardTypeASCIICapable;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    switch (index) {
        case 0:
            accountTextField = textField;
            break;
        case 1:
            passwordTextField = textField;
            break;
        case 2:
            confirmPasswordTextField = textField;
            break;
        case 3:
            contactTextField = textField;
            break;
        case 4:
            phoneTextField = textField;
            break;
        case 5:
            SNTextField = textField;
            break;
        case 6:
            locationTextField = textField;
            break;
        case 7:
            detailTextField = textField;
            break;
            
        default:
            break;
    }
    return textField;
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
    if([accountTextField canResignFirstResponder]) {
        [accountTextField resignFirstResponder];
    }
    if ([passwordTextField canResignFirstResponder]) {
        [passwordTextField resignFirstResponder];
    }
    if([confirmPasswordTextField canResignFirstResponder]) {
        [confirmPasswordTextField resignFirstResponder];
    }
    if ([contactTextField canResignFirstResponder]) {
        [contactTextField resignFirstResponder];
    }
    if([phoneTextField canResignFirstResponder]) {
        [phoneTextField resignFirstResponder];
    }
    if ([SNTextField canResignFirstResponder]) {
        [SNTextField resignFirstResponder];
    }
    if([locationTextField canResignFirstResponder]) {
        [locationTextField resignFirstResponder];
    }
    if ([detailTextField canResignFirstResponder]) {
        [detailTextField resignFirstResponder];
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
//    [self.view endEditing:YES];
//    if (accountTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"账号不能为空"];
//        return;
//    } else if (passwordTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
//        return;
//    } else if (confirmPasswordTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"确认密码不能为空"];
//        return;
//    } else if (contactTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"联系人不能为空"];
//        return;
//    } else if (phoneTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"手机不能为空"];
//        return;
//    } else if (SNTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"SN注册码不能为空"];
//        return;
//    } else if (locationTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"所在地不能为空"];
//        return;
//    } else if (detailTextField.text.length == 0) {
//        [SVProgressHUD showErrorWithStatus:@"详细地址不能为空"];
//        return;
//    } else if (passwordTextField.text.length < 6) {
//        [SVProgressHUD showErrorWithStatus:@"密码应该为6-18位"];
//        return;
//    } else if (confirmPasswordTextField.text.length < 6) {
//        [SVProgressHUD showErrorWithStatus:@"确认密码应该为6-18位"];
//        return;
//    } else if (![confirmPasswordTextField.text isEqualToString:passwordTextField.text]) {
//        [SVProgressHUD showErrorWithStatus:@"密码和确认密码应该一致"];
//        return;
//    }else{
//        [SVProgressHUD showWithStatus:@"注册中..."];
//    }
//    NSDictionary *parameters = @{@"account":accountTextField.text,
//                                     @"password":passwordTextField.text};
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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