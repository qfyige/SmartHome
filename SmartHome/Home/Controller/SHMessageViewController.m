//
//  SHMessageViewController.m
//  SmartHome
//
//  Created by hui.li on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHMessageViewController.h"
#import "SHMessageCell.h"
#import "SHMessageModel.h"

@interface SHMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataArray;
}

@property (nonatomic,strong) UITableView *mainTableView;

@end

@implementation SHMessageViewController

@synthesize mainTableView;

#pragma mark -
#pragma mark - system

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];
    [self updateTableView];
}

#pragma mark -
#pragma mark - initData

- (void)initData
{
    dataArray = [NSMutableArray arrayWithCapacity:2];
    
    {
        SHMessageModel *model = [[SHMessageModel alloc] init];
        [model setTitle:@"联电讲坛 第一季"];
        [model setTime:@"2016.05.16"];
        [model setSubTitle:@"跟随着撒大声地阿萨德阿萨德"];
        [dataArray addObject:model];
    }
    {
        SHMessageModel *model = [[SHMessageModel alloc] init];
        [model setTitle:@"联电讲坛 第二季"];
        [model setTime:@"2016.05.16"];
        [model setSubTitle:@"跟随着撒大声地阿萨德阿萨德"];
        [dataArray addObject:model];
    }
    {
        SHMessageModel *model = [[SHMessageModel alloc] init];
        [model setTitle:@"联电讲坛 第三季"];
        [model setTime:@"2016.05.16"];
        [model setSubTitle:@"跟随着撒大声地阿萨德阿萨德"];
        [dataArray addObject:model];
    }
    {
        SHMessageModel *model = [[SHMessageModel alloc] init];
        [model setTitle:@"联电讲坛 第四季"];
        [model setTime:@"2016.05.16"];
        [model setSubTitle:@"跟随着撒大声地阿萨德阿萨德"];
        [dataArray addObject:model];
    }
    {
        SHMessageModel *model = [[SHMessageModel alloc] init];
        [model setTitle:@"联电讲坛 第五季"];
        [model setTime:@"2016.05.16"];
        [model setSubTitle:@"跟随着撒大声地阿萨德阿萨德"];
        [dataArray addObject:model];
    }
}


#pragma mark -
#pragma mark - 更新数据更新界面

- (void)updateTableView
{
    [mainTableView reloadData];
}

#pragma mark -
#pragma mark - initView

- (void)initView
{
    self.view.backgroundColor = WhiteColor;
    [self initMainTableView];
    [self addBackButton];
}

- (void)initMainTableView
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [mainTableView setDelegate:self];
    [mainTableView setDataSource:self];
    [mainTableView setShowsVerticalScrollIndicator:NO];
    [mainTableView setShowsHorizontalScrollIndicator:NO];
    [mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [mainTableView setTableFooterView:[[UIView alloc] init]];
    [self.view addSubview:mainTableView];
    
    Weakly(ws);
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).offset(SH_NAV_HEIGHT);
        make.left.equalTo(ws.view);
        make.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view);
    }];
}

#pragma mark -
#pragma mark - btnClick

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPAD) {
        return 100;
    }else{
        return 65;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SHMessageCell";
    SHMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SHMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row < [dataArray count]) {
        SHMessageModel *model = [dataArray objectAtIndexCheck:indexPath.row];
        [cell setMessageWithModel:model];
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *deleteAlertView = [[UIAlertView alloc]initWithTitle:@"确定删除吗？" message:@"删除后不可恢复" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [deleteAlertView setTag:indexPath.row];
        [deleteAlertView show];
    }
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) return;
    if (alertView.tag) {
        NSInteger row = alertView.tag;
//        SHMeeageModel *model = [dataArray objectAtIndexCheck:row-1];
        [dataArray removeObjectAtIndex:row-1];
        
        [mainTableView beginUpdates];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        [mainTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [mainTableView endUpdates];
    }
}

@end