//
//  SHSettingViewController.m
//  SmartHome
//
//  Created by tong li on 16/7/21.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHSettingViewController.h"
#import "SHSetingItemTextCell.h"
#import "SHSetingInputTextCell.h"
#import "SHDefine.h"
#import "SHHeaderView.h"
#import "SHSettingTitleView.h"
#import "SHSettingTextTableViewCell.h"
#import "SHSettingFaceBackTableViewCell.h"
#import "SHAboutUsTableViewCell.h"
#import "NSString+getSize.h"
#import "KLSwitch.h"
#import "SHSetModel.h"
#import <SVProgressHUD.h>

@interface SHSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *sumTableView;
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (strong, nonatomic) NSArray *sumArr;
@property (strong, nonatomic) NSArray *operationSettings;//中控
@property (strong, nonatomic) NSArray *monitorSetting;//监控
@property (strong, nonatomic) NSArray *chatSetting;//聊天
@property (strong, nonatomic) NSArray *messageSetting;//消息
@property (strong, nonatomic) NSArray *feedbackSetting;//反馈
@property (strong, nonatomic) NSArray *aboutUsSetting;//反馈


@property (strong, nonatomic) NSArray *datasource;//datasource

@property (strong, nonatomic) SHHeaderView *headerView;

@property (strong,nonatomic) SHSetModel *setModel;

@end

@implementation SHSettingViewController
{
    NSIndexPath *_selectIndexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self uiConfig];
    [self creatInfo];
}

-(void)uiConfig{
    _sumTableView.delegate = self;
    _sumTableView.dataSource = self;
    _sumTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _sumTableView.backgroundColor = BackgroundColor;
    [_sumTableView registerNib:[UINib nibWithNibName:@"SHSetingItemTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSetingItemTextCell"];
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHSettingTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSettingTextTableViewCell"];
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHSetingInputTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSetingInputTextCell"];
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHAboutUsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHAboutUsTableViewCell"];
    
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHSettingFaceBackTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSettingFaceBackTableViewCell"];
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHSettingTitleView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"SHSettingTitleView"];
}

- (void)creatInfo{
     _setModel = [SHSetModel shareInstance];
    
    _sumArr = [NSArray arrayWithObjects:@[@{@"image":@"Home",@"title":@"中控设置"},@{@"image":@"projector_L",@"title":@"监控设置"},@{@"image":@"Phone",@"title":@"对讲设置"},@{@"image":@"Bell",@"title":@"消息设置"}],@[@{@"image":@"Add to group",@"title":@"售后服务"},@{@"image":@"Logout",@"title":@"关于我们"}],nil];
    
    _operationSettings = @[
                            @{@"title":@"本地链接",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写您的IP地址",@"text":_setModel.localOperationIP},@{@"title":@"端口",@"placeholder":@"请填写您的端口",@"text":_setModel.localOperationPort}]}
                            ,@{@"title":@"远程链接",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写您的IP地址",@"text":_setModel.remoteOperationIP},@{@"title":@"端口",@"placeholder":@"请填写您的端口",@"text":_setModel.remoteOperationPort}]}
                            ];
    _monitorSetting = @[
                           @{@"title":@"本地链接",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写您的IP地址",@"text":_setModel.localMonitorIP},@{@"title":@"端 口",@"placeholder":@"请填写您的端口",@"text":_setModel.localMonitorPort},@{@"title":@"用户名",@"placeholder":@"请填写您的用户名",@"text":_setModel.localMonitorUser},@{@"title":@"密 码",@"placeholder":@"请填写您的密码",@"text":_setModel.localMonitorPassword}]}
                           ,@{@"title":@"远程链接",@"content":@[@{@"title":@"账 号",@"placeholder":@"请填写您的远程账户",@"text":_setModel.remoteMonitoruser},@{@"title":@"密 码",@"placeholder":@"请填写您的远程密码",@"text":_setModel.remoteMonitorPassword}]}
                           ];

    _chatSetting = @[
                           @{@"title":@"门口机一",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写门口机一的IP地址",@"text":_setModel.mechine1IP},@{@"title":@"端口",@"placeholder":@"请填写门口机一的端口",@"text":_setModel.mechine1port}]}
                           ,@{@"title":@"门口机二",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写门口机二的IP地址",@"text":_setModel.mechine2IP},@{@"title":@"端口",@"placeholder":@"请填写门口机二的端口",@"text":_setModel.mechine2Port}]}
                           ];
    _messageSetting = @[
                        @{@"subtitle":@"已开启",@"title":@"接受新消息通知",@"content":@[@{@"title":@"如果你要关闭或开启联电智能宅的新消息通知，请在设备的“设备”-“通知”功能中，找到应用程序“联电智宅”更改"}]}
                        ,@{@"title":@"通知显示消息详情",@"content":@[@{@"title":@"若关闭，当收到联电智宅信息时，通知提示就不会显示发消息人，和内容摘要"}]}
                        ,@{@"title":@"声音",@"content":@[@{@"title":@"当联电智宅在运行时，你可以设置是否需要声音"}]}
                        ];
    _feedbackSetting = @[@{@"title":@"服务需求"}];
    _aboutUsSetting = @[@{@"title":@"关于我们"}];
    _datasource = _operationSettings;
    
}


- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _sumTableView){
        return 31;
    }else{
        if(_selectIndexPath.row == 3){
            NSDictionary *dic = [[[_datasource objectAtIndex:indexPath.section] objectForKey:@"content"] objectAtIndex:indexPath.row];
            NSString *str = [dic objectForKey:@"title"];
            CGSize size = [str getSizeWithFont:[UIFont systemFontOfSize:12] width:_settingTableView.bounds.size.width - 40];
            return size.height + 24;
        }else if(_selectIndexPath.section == 1 && _selectIndexPath.row == 0){
            return  240;
        }
        return 46;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == _sumTableView){
        if(section == 0 ){
            return ScreenWidth*125/667;
        }else{
            return 50;
        }
    }else{
        return 30;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView == _sumTableView){
        if(section == 0){
            _headerView = [[[NSBundle mainBundle] loadNibNamed:@"SHHeaderView" owner:nil options:nil] lastObject];
            NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
            _headerView.frame = CGRectMake(0, 0, ScreenWidth*125/667, ScreenWidth*125/667);
            return _headerView;
        }else{
            UIView *heightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  ScreenWidth*125/667, 50)];
            heightView.backgroundColor = BackgroundColor;
            return heightView;
        }
    }else{
        NSDictionary *dic = [_datasource objectAtIndex:section];
        SHSettingTitleView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"SHSettingTitleView" owner:nil options:nil] lastObject];
        titleView.frame =CGRectMake(0, 0, ScreenWidth - ScreenWidth*125/667, 30);
        titleView.showLabel.text = [dic objectForKey:@"title"];
        titleView.showSwitch.hidden = YES;
        titleView.subTitleLabel.hidden = YES;
        titleView.saveButton.hidden = YES;
        if(_selectIndexPath.row == 3){
            if (section == 0) {
                //需显示是否开启
                titleView.subTitleLabel.hidden = NO;
            }else{
                //需显示 是否 开启
                titleView.showSwitch.hidden = NO;
                [titleView.showSwitch setDidChangeHandler:^(BOOL isOn) {
                    NSLog(@"Smallest switch changed to %d", isOn);
                }];
            }
        }else if (_selectIndexPath.section == 0){
            //保存每一个section的数据
            titleView.saveButton.hidden = NO;
            titleView.clickSaveButton = ^(){
                if(_selectIndexPath.row == 0 && section == 0){
                    SHSetingInputTextCell *cell1 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    SHSetingInputTextCell *cell2 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    if(cell1.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell1.showLabel.text]];
                    }else if(cell2.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell2.showLabel.text]];
                    }else{
                        _setModel.localOperationIP = cell1.mTextFeild.text;
                        _setModel.localOperationPort = cell2.mTextFeild.text;
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }
                    
                }else if(_selectIndexPath.row == 0 && section == 1){
                    SHSetingInputTextCell *cell1 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                    SHSetingInputTextCell *cell2 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                    if(cell1.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell1.showLabel.text]];
                    }else if(cell2.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell2.showLabel.text]];
                    }else{
                        _setModel.remoteOperationIP = cell1.mTextFeild.text;
                        _setModel.remoteOperationPort = cell2.mTextFeild.text;
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }

                    
                }else if(_selectIndexPath.row == 1 && section == 0){
                    SHSetingInputTextCell *cell1 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    SHSetingInputTextCell *cell2 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    SHSetingInputTextCell *cell3 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                    SHSetingInputTextCell *cell4 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
                    if(cell1.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell1.showLabel.text]];
                    }else if(cell2.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell2.showLabel.text]];
                    }else if(cell3.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell3.showLabel.text]];
                    }else if(cell4.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell4.showLabel.text]];
                    }else{
                        _setModel.localMonitorIP = cell1.mTextFeild.text;
                        _setModel.localMonitorPort = cell2.mTextFeild.text;
                        _setModel.localMonitorUser = cell3.mTextFeild.text;
                        _setModel.localMonitorPassword = cell4.mTextFeild.text;
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }
                }else if(_selectIndexPath.row == 1 && section == 1){
                    SHSetingInputTextCell *cell1 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    SHSetingInputTextCell *cell2 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    if(cell1.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell1.showLabel.text]];
                    }else if(cell2.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell2.showLabel.text]];
                    }else{
                        _setModel.remoteMonitoruser = cell1.mTextFeild.text;
                        _setModel.remoteMonitorPassword = cell2.mTextFeild.text;
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }
                    
                }else if(_selectIndexPath.row == 2 && section == 0){
                    SHSetingInputTextCell *cell1 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    SHSetingInputTextCell *cell2 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    if(cell1.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell1.showLabel.text]];
                    }else if(cell2.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell2.showLabel.text]];
                    }else{
                        _setModel.mechine1IP = cell1.mTextFeild.text;
                        _setModel.mechine1port = cell2.mTextFeild.text;
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }
                }else if(_selectIndexPath.row == 2 && section == 1){
                    SHSetingInputTextCell *cell1 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                    SHSetingInputTextCell *cell2 = [_settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    if(cell1.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell1.showLabel.text]];
                    }else if(cell2.mTextFeild.text.length == 0){
                        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@输入有误",cell2.showLabel.text]];
                    }else{
                        _setModel.mechine2IP = cell1.mTextFeild.text;
                        _setModel.mechine2Port = cell2.mTextFeild.text;
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }

                }
            };
        }
        return  titleView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _sumTableView){
        SHSetingItemTextCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"SHSetingItemTextCell"];
        NSArray *arr = [_sumArr objectAtIndex:indexPath.section];
        NSDictionary *dic = [arr objectAtIndex:indexPath.row];
        itemCell.showImageView.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        itemCell.showTittle.text = [dic objectForKey:@"title"];
        itemCell.backgroundColor = BackgroundColor;
        itemCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if([indexPath isEqual: _selectIndexPath]){
            itemCell.backgroundColor = SelectBackgroundColor;
            itemCell.showTittle.textColor = GreenColor;
        }else{
            itemCell.backgroundColor = BackgroundColor;
            itemCell.showTittle.textColor = WhiteColor;
        }
        return itemCell;
    }else if(_selectIndexPath.row == 3){
        NSDictionary *dic = [[[_datasource objectAtIndex:indexPath.section] objectForKey:@"content"] objectAtIndex:indexPath.row];
        SHSettingTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHSettingTextTableViewCell"];
        cell.showLabel.text = [dic objectForKey:@"title"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(_selectIndexPath.row == 0 && _selectIndexPath.section ==1){
        SHSettingFaceBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHSettingFaceBackTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(_selectIndexPath.row == 1 && _selectIndexPath.section ==1){
        SHAboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHAboutUsTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(tableView == _settingTableView){
        NSDictionary *dic = [[[_datasource objectAtIndex:indexPath.section] objectForKey:@"content"] objectAtIndex:indexPath.row];
        SHSetingInputTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHSetingInputTextCell"];
        cell.showLabel.text = [dic objectForKey:@"title"];
        cell.mTextFeild.placeholder = [dic objectForKey:@"placeholder"];
        cell.mTextFeild.text = [dic objectForKey:@"text"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dianji cell");
    
    if(tableView == _sumTableView){
        _selectIndexPath = indexPath;
        if(indexPath.section == 0){
            switch (indexPath.row) {
                case 0:
                {
                    _datasource = _operationSettings;
                }
                    break;
                case 1:
                {
                    _datasource = _monitorSetting;
                }
                    break;
                case 2:
                {
                    _datasource = _chatSetting;
                }
                    break;
                case 3:
                {
                    _datasource = _messageSetting;
                }
                    break;
                
                default:
                    break;
            }
        }else if(indexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                {
                    _datasource = _feedbackSetting;
                }
                    break;
                case 1:
                {
                    _datasource = _aboutUsSetting;
                }
                    break;
                default:
                    break;
            }

        }
        [_settingTableView reloadData];
        [_sumTableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _sumTableView){
        return _sumArr.count;
    }else{
        return _datasource.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _sumTableView){
        NSArray *arr = [_sumArr objectAtIndex:section];
        return  arr.count;
    }else{
        if(_selectIndexPath.section == 1){
            return 1;
        }else{
            NSArray *arr = [[_datasource objectAtIndex:section] objectForKey:@"content"];
            return arr.count;
        }
  
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
