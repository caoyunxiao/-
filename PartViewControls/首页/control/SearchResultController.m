//
//  SearchResultController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/24.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SearchResultController.h"
#import "TCNewDetailViewController.h"        //梦想详情页面

#import "TCHomeCell.h"


@interface SearchResultController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *_dataArray;//数据源数组
}
@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    
    [self requestDataBase:_page size:_size];
}
- (void)configUI
{
   
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    self.title = @"搜索";
    _dataArray = [[NSMutableArray alloc]init];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tbView registerNib:[UINib nibWithNibName:@"TCHomeCell" bundle:nil] forCellReuseIdentifier:@"TCHomeCell"];
    _page = 1;
    _size = 15;
    
    //下拉刷新
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [_dataArray removeAllObjects];
        [self requestDataBase:_page size:_size];
        
    }];
    //上拉加载
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page ++;
        [self requestDataBase:_page size:_size];
    }];

}
#pragma mark - 请求数据
- (void)requestDataBase:(NSInteger)page size:(NSInteger)size
{
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
    NSDictionary *wParamDict = @{@"page":pageStr,@"size":sizeStr,@"title":self.searchTitle};
    [self removeLoadingFailureViewZFJ];
    [self showLoadingViewZFJ];//显示加载动画
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"201" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if (self.tbView.mj_header.isRefreshing) {
            
            [self.tbView.mj_header endRefreshing];
        }
        if (self.tbView.mj_footer.isRefreshing) {
            
            [self.tbView.mj_footer endRefreshing];
        }
        
        [self removeLoadingViewZFJ];//移除加载动画
        if([errorCode isEqualToString:@"0"])
        {
        
            NSArray *array = (NSArray *)resultDict;
            NSLog(@"%@请求数据",array);
           
            for (NSDictionary *dict in array)
            {
                HomeModel *model = [[HomeModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            if(_dataArray.count>0)
            {
                [self removeLoadingFailureViewZFJ];
                [self.tbView reloadData];
            }
            else
            {
                [self showLoadingFailureViewZFJ:@"暂无数据,请稍后再试"];//显示加载失败
            }
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            if (_page == 1) {
                [self showLoadingFailureViewZFJ:@"暂无搜索结果"];
            }
            else
            {
               //无更多数据
            }
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            [self showLoadingFailureViewZFJ:@"加载失败,请下拉刷新一下吧"];//加载失败
        }
    }];
}

#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 275;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TCHomeCell" forIndexPath:indexPath];
    //添加数据源
    if (_dataArray.count>0) {
       // [cell showUIViewModel:[_dataArray objectAtIndex:indexPath.row]];
        //cell.model = _dataArray[indexPath.row];
        
        cell.model = [_dataArray objectAtQYQIndex:indexPath.row];
        
        
    }
    
    return cell;
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![PersonInfo sharePersonInfo].isLogIn) {
        
        [self showLogInViewController];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TCNewDetailViewController *tvc = [[TCNewDetailViewController alloc]init];
   // tvc.dreamID = [_dataArray[indexPath.row] dreamID];
    
    tvc.dreamID = [[_dataArray objectAtQYQIndex:indexPath.row ] dreamID];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
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
