//
//  SettingBaseViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SettingBaseViewController.h"

#import "SettingItem.h"
#import "SettingLabelItem.h"
#import "SettingGroup.h"

#import "SettingCell.h"

@interface SettingBaseViewController ()



@end

@implementation SettingBaseViewController


-(NSMutableArray *)cellData{
    if (!_cellData) {
        _cellData = [NSMutableArray array];
    }
    
    return _cellData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /**vewrgvewrgvergvewrgewr*/
    [self creatTableView];
}

#pragma mark - 创建表格视图
- (void)creatTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64) style:UITableViewStyleGrouped];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    
    
//    _tbView.sectionHeaderHeight = 10;
//    _tbView.sectionFooterHeight = 0;
    //_tbView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉分割线
   
    [self.view addSubview:_tbView];
    
    
}

#pragma mark - UITableview代理方法
//返回组的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellData.count;
}
//返回组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.cellData[section];
    
    return group.items.count;
}

//返回每组的Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    
    //获取组的数据模型
//    SettingGroup *group = self.cellData[indexPath.section];
    
    SettingGroup *group = [self.cellData objectAtQYQIndex:indexPath.section];
    
    
    //获取行的数据模型
  //  SettingItem *item = group.items[indexPath.row];
    
    SettingItem *item = [group.items objectAtQYQIndex:indexPath.row];
    
    
    //设置模型，显示数据
    cell.item = item;
    
    [cell setIndexPath:indexPath rowCount:group.items.count];

    return cell;
    
}
#pragma mark - cell的点中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    SettingGroup *group = self.cellData[indexPath.section];
//    
//    SettingItem *item = group.items[indexPath.row];
    
    SettingGroup *group = [self.cellData objectAtQYQIndex:indexPath.section];

    SettingItem *item = [group.items objectAtQYQIndex:indexPath.row];
    
    
    //判断是否有 "特殊的操作"
    if (item.operation) {
        //有特殊的操作，operation是有值，然后调用
        item.operation();
    }else if(item.vcClass){
        //创建控制器再显示
        UIViewController *vc = [[item.vcClass alloc] init];
        //设置下一个视图控制器的标题
        //[vc setTitle:item.title];
        
        [self.navigationController pushViewController:vc animated:YES];
    }

  
    
}
#pragma mark - 头部标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //获取组模型
    SettingGroup *group = self.cellData[section];
    return group.headerTitle;
    
}

#pragma mark 尾部标题
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    //获取组模型
    //SettingGroup *group = self.cellData[section];
    /*放过他吧晕晕乎乎问题和以后如何让她和人体额笨笨*/
    SettingGroup *group = [self.cellData objectAtQYQIndex:section];
    
    return group.footerTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
