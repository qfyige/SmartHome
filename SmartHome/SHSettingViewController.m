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

@interface SHSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *sumTableView;
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (strong, nonatomic) NSArray *sumArr;
@property (strong, nonatomic) NSMutableArray *operationSettings;
@property (strong, nonatomic) NSMutableArray *monitorSetting;
@property (strong, nonatomic) NSMutableArray *chatSetting;
@property (strong, nonatomic) NSMutableArray *messageSetting;


@end

@implementation SHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sumTableView.delegate = self;
    _sumTableView.dataSource = self;
    _settingTableView.delegate = self;
    _settingTableView.dataSource = self;
    _sumTableView.backgroundColor = BackgroundColor;
    [_sumTableView registerNib:[UINib nibWithNibName:@"SHSetingItemTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSetingItemTextCell"];
    [_settingTableView registerNib:[UINib nibWithNibName:@"SHSetingInputTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SHSetingInputTextCell"];
    [self creatInfo];
}

- (void)creatInfo{
    _sumArr = [NSArray arrayWithObjects:@{@"image":@"Home",@"title":@"中控设置"},@{@"image":@"projector_L",@"title":@"监控设置"},@{@"image":@"Bell",@"title":@"消息设置"},@{@"image":@"Phone",@"title":@"对讲设置"},nil];
    
    
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
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _sumTableView){
        SHSetingItemTextCell *itemCell = [tableView dequeueReusableCellWithIdentifier:@"SHSetingItemTextCell"];
        NSDictionary *dic = [_sumArr objectAtIndex:indexPath.row];
        itemCell.showImageView.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        itemCell.showTittle.text = [dic objectForKey:@"title"];
        itemCell.backgroundColor = BackgroundColor;
        return itemCell;
    }
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _sumTableView){
        return _sumArr.count;
    }
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
