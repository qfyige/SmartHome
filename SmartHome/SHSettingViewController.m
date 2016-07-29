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


@interface SHSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *sumTableView;
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (strong, nonatomic) NSArray *sumArr;
@property (strong, nonatomic) NSArray *operationSettings;//中控
@property (strong, nonatomic) NSArray *monitorSetting;//监控
@property (strong, nonatomic) NSArray *chatSetting;//聊天
@property (strong, nonatomic) NSArray *messageSetting;//消息
@property (strong, nonatomic) SHHeaderView *headerView;


@end

@implementation SHSettingViewController
{
    NSIndexPath *_selectIndexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _sumTableView.delegate = self;
    _sumTableView.dataSource = self;
    _sumTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _sumTableView.backgroundColor = BackgroundColor;
    [_sumTableView registerNib:[UINib nibWithNibName:@"SHSetingItemTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSetingItemTextCell"];
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHSetingInputTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSetingInputTextCell"];
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHSettingTitleView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"SHSettingTitleView"];
    [self creatInfo];
}

- (void)creatInfo{
    _sumArr = [NSArray arrayWithObjects:@{@"image":@"Home",@"title":@"中控设置"},@{@"image":@"projector_L",@"title":@"监控设置"},@{@"image":@"Bell",@"title":@"消息设置"},@{@"image":@"Phone",@"title":@"对讲设置"},nil];
    _operationSettings = @[
                            @{@"title":@"本地链接",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写您的IP地址"},@{@"title":@"端口",@"placeholder":@"请填写您的端口"}]}
                            ,@{@"title":@"远程链接",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写您的IP地址"},@{@"title":@"端口",@"placeholder":@"请填写您的端口"}]}
                            ];
    _monitorSetting = @[
                           @{@"title":@"本地链接",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写您的IP地址"},@{@"title":@"端 口",@"placeholder":@"请填写您的端口"},@{@"title":@"用户名",@"placeholder":@"请填写您的用户名"},@{@"title":@"密 码",@"placeholder":@"请填写您的密码"}]}
                           ,@{@"title":@"远程链接",@"content":@[@{@"title":@"账 号",@"placeholder":@"请填写您的远程账户"},@{@"title":@"密 码",@"placeholder":@"请填写您的远程密码"}]}
                           ];

    _chatSetting = @[
                           @{@"title":@"门口机一",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写门口机一的IP地址"},@{@"title":@"端口",@"placeholder":@"请填写门口机一的端口"}]}
                           ,@{@"title":@"门口机二",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写门口机二的IP地址"},@{@"title":@"端口",@"placeholder":@"请填写门口机二的端口"}]}
                           ];
    _messageSetting = @[
                        @{@"title":@"门口机一",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写门口机一的IP地址"},@{@"title":@"端口",@"placeholder":@"请填写门口机一的端口"}]}
                        ,@{@"title":@"门口机二",@"content":@[@{@"title":@"IP地址",@"placeholder":@"请填写门口机二的IP地址"},@{@"title":@"端口",@"placeholder":@"请填写门口机二的端口"}]}
                        ];
    
}


- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _sumTableView){
        return 31;
    }else{
        return 46;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == _sumTableView){
        return ScreenWidth*125/667;
    }else{
        return 30;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView == _sumTableView){
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"SHHeaderView" owner:nil options:nil] lastObject];
        NSLog(@"%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
        _headerView.frame = CGRectMake(0, 0, ScreenWidth*125/667, ScreenWidth*125/667);
        return _headerView;
    }else{
        NSDictionary *dic = [_operationSettings objectAtIndex:section];
        SHSettingTitleView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"SHSettingTitleView" owner:nil options:nil] lastObject];
        titleView.frame =CGRectMake(0, 0, ScreenWidth - ScreenWidth*125/667, 30);
        titleView.showLabel.text = [dic objectForKey:@"title"];
        return  titleView;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _sumTableView){
        SHSetingItemTextCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"SHSetingItemTextCell"];
        NSDictionary *dic = [_sumArr objectAtIndex:indexPath.row];
        itemCell.showImageView.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        itemCell.showTittle.text = [dic objectForKey:@"title"];
        itemCell.backgroundColor = BackgroundColor;
        itemCell.selectionStyle = UITableViewCellSelectionStyleGray;
        return itemCell;
    }else if(tableView == _settingTableView){
        NSDictionary *dic = [[[_operationSettings objectAtIndex:indexPath.section] objectForKey:@"content"] objectAtIndex:indexPath.row];
        SHSetingInputTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHSetingInputTextCell"];
        cell.showLabel.text = [dic objectForKey:@"title"];
        cell.showTextFeild.placeholder = [dic objectForKey:@"placeholder"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"dianji cell");
    
    if(tableView == _sumTableView){
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _sumTableView){
        return 1;
    }else{
        return _operationSettings.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _sumTableView){
        return _sumArr.count;
    }else{
        NSArray *arr = [[_operationSettings objectAtIndex:section] objectForKey:@"content"];
        return arr.count;
  
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
