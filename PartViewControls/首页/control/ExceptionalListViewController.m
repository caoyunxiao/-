//
//  ExceptionalListViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ExceptionalListViewController.h"
#import "ExceptionalListCell.h"
#import "dreamRewardModel.h"

@interface ExceptionalListViewController ()
{
    int indexPage;
}
@end

@implementation ExceptionalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"打赏列表";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
//    [self setDataBaseInDataArray];
    [self uiConfig];
}

- (void)uiConfig
{
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    _dataArray = [NSMutableArray array];
    self.ExceptionalListTable.delegate = self;
    self.ExceptionalListTable.dataSource = self;
    [self setExtraCellLineHidden:self.ExceptionalListTable];
    self.navigationController.navigationBarHidden = NO;
    
    indexPage = 1;
    //下拉刷新
    self.ExceptionalListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
//        NSDictionary *dict = @{@"dreamid":_homeModel.dreamID,@"page":@(1),@"size":@(20)};
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_homeModel.dreamID,@"dreamid",@(1),@"page",@(20),@"size", nil];
        [RequestEngine UserModulescollegeWithDict:dict wAction:@"512" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            
            [self endRefreshingNew];
            if ([errorCode isEqualToString:@"0"]) {
                
                [self removeLoadingFailureViewZFJ];
                [_dataArray removeAllObjects];
                NSArray *DatasArray = (NSArray *)resultDict;
                for (NSDictionary *dict in DatasArray) {
                    
                   dreamRewardModel *model = [[dreamRewardModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [_dataArray addObject:model];
                   
                }
                 [self.ExceptionalListTable reloadData];
            }
            else
            {
                [self showLoadingFailureViewZFJ:@"暂无数据"];
                NSLog(@"%@",[ReturnCode getResultFromReturnCode:errorCode]);
            }
        }];
    }];
    
    //上拉加载更多
    self.ExceptionalListTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        indexPage++;
        NSDictionary *dict = @{@"dreamid":_homeModel.dreamID,@"page":@(indexPage),@"size":@(20)};
        [RequestEngine UserModulescollegeWithDict:dict wAction:@"512" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            
            [self endRefreshingNew];
            if ([errorCode isEqualToString:@"0"]) {
                
                [self removeLoadingFailureViewZFJ];
                NSArray *DatasArray = (NSArray *)resultDict;
                for (NSDictionary *dict in DatasArray) {
                    
                    dreamRewardModel *model = [[dreamRewardModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [_dataArray addObject:model];
                   
                }
                 [self.ExceptionalListTable reloadData];
            }
            else
            {
                [self showLoadingFailureViewZFJ:@"暂无数据"];
                NSLog(@"%@",[ReturnCode getResultFromReturnCode:errorCode]);
            }
        }];
        
    }];
    
     [self.ExceptionalListTable.mj_header beginRefreshing];
    
}


#pragma mark -结束刷新
- (void)endRefreshingNew
{
    if (self.ExceptionalListTable.mj_header.isRefreshing) {
        
        [self.ExceptionalListTable.mj_header endRefreshing];
    }
    if (self.ExceptionalListTable.mj_footer.isRefreshing) {
        
        [self.ExceptionalListTable.mj_footer endRefreshing];
    }
}

- (void)setDataBaseInDataArray
{
    _dataArray = [[NSMutableArray alloc]init];
    NSArray *dreamRewardArr = _homeModel.dreamReward;
    
    NSMutableArray *amountArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in dreamRewardArr)
    {
        NSString *amount = [NSString stringWithFormat:@"%@",dict[@"amount"]];
        [amountArr addObject:amount];
    }
    NSArray *arrayNew = [amountArr sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *dreamRewardArrNew = [[NSMutableArray alloc]init];
    for (int i = 0; i<arrayNew.count; i++)
    {
//        NSString *str = arrayNew[i];
        
         NSString *str = [arrayNew objectAtQYQIndex:i];
        
        for (NSDictionary *dict in dreamRewardArr)
        {
            NSString *amount = [NSString stringWithFormat:@"%@",dict[@"amount"]];
            if([str isEqualToString:amount])
            {
                [dreamRewardArrNew addObject:dict];
            }
        }
    }
    for (NSDictionary *dict in dreamRewardArrNew)
    {
        dreamRewardModel *model = [[dreamRewardModel alloc]init];
        [model setValuesForKeysWithDictionary:dict];
        [_dataArray addObject:model];
    }
    if(_dataArray.count>0)
    {
        [self.ExceptionalListTable reloadData];
    }
}

#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ExceptionalListCell";
    ExceptionalListCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ExceptionalListCell" owner:self options:nil]objectAtIndex:0];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(_dataArray.count>0)
    {
       // [cell showUIViewWith:[_dataArray objectAtIndex:indexPath.row]];
        
        [cell showUIViewWith:[_dataArray objectAtQYQIndex:indexPath.row]];
    }
    return cell;
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //CGPoint contentOffsetPoint = self.ExceptionalListTable.contentOffset;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
