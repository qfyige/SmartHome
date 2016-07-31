//
//  SHBaseViewController.m
//  SmartHome
//
//  Created by tong lele on 16/7/31.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHBaseViewController.h"

@interface SHBaseViewController ()

@end

@implementation SHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)addBackButton{
    [self.view addSubview:self.backButton];
    [self.view bringSubviewToFront:self.backButton];
}

- (UIButton *)backButton{
    if(_backButton == nil){
        _backButton = [[ UIButton alloc] initWithFrame:CGRectMake(0,20, 50, 50)];
        [_backButton setImage:[UIImage imageNamed:@"Arrowleft"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _backButton;
}

- (void)back{
    if(self.navigationController){
        NSArray *array = self.navigationController.viewControllers;
        if([array count] == 1){
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
