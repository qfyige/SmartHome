//
//  SHSetingInputTextCell.h
//  SmartHome
//
//  Created by tong li on 16/7/27.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHSetingInputTextCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (strong, nonatomic)  UITextField *mTextFeild;

@end
