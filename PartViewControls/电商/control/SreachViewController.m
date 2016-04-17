//
//  SreachViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SreachViewController.h"
#import "ProductDetailsViewController.h"
#import "ListNewCell.h"

#import "OnlineModel.h"
#import "PicVidListModel.h"
@interface SreachViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SreachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self configUI];
    [self requestDataBase];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark = 配置问价
- (void)configUI
{
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    //设置购物车
    [self setShopRightButton];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.tableFooterView = [UIView new];
  
    _page = 1;
    _size = 15;
    
    //下拉刷新
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_dataArray removeAllObjects];
        _page = 1;
        [self requestDataBase];
        
    }];
    //上拉加载
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page ++;
        [self requestDataBase];
    }];

    
}
#pragma mark - 请求数据源
- (void)requestDataBase
{
    //加载等待视图
    //加载等待视图
    [self showLoadingViewZFJ];
    __weak typeof(self)wself = self;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
   // NSDictionary *wdict = @{@"page":pageStr,@"size":sizeStr,@"title":self.title};
    NSDictionary *wdict = [NSDictionary dictionaryWithObjectsAndKeys:pageStr,@"page",sizeStr,@"size",self.title,@"title", nil];
    
    [RequestEngine UserModulescollegeWithDict:wdict wAction:@"604" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        [wself removeLoadingViewZFJ];
        if (self.tbView.mj_header.isRefreshing) {
            
            [self.tbView.mj_header endRefreshing];
        }
        if (self.tbView.mj_footer.isRefreshing) {
            
            [self.tbView.mj_footer endRefreshing];
        }

        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];
            NSArray *goodsArr = (NSArray *)resultDict;
            NSLog(@"请求数据源%@",goodsArr);
            for (NSDictionary *dict in goodsArr)
            {
                OnlineModel *model = [[OnlineModel alloc]init];
                model.caBei = [dict[@"caBei"] description];
                model.cover = dict[@"cover"];
                model.color = dict[@"color"];
                model.discription = dict[@"discription"];
                model.goodsID = dict[@"goodsID"];
                model.name = dict[@"name"];
                for (NSDictionary *dict2 in dict[@"picVidList"]) {
                    PicVidListModel *model2 = [[PicVidListModel alloc] init];
                    model2.describe = dict2[@"describe"];
                    model2.type = dict2[@"type"];
                    model2.url = dict2[@"url"];
                    [model.picVidList addObject:model2];
                    
                }
                
                model.price = dict[@"price"];
                model.salesGoodsID = [dict[@"salesGoodsID"] description];
                model.salesID = [dict[@"salesID"] description];
                model.style = dict[@"style"];
                model.total = [dict[@"total"] description];
                model.type = [dict[@"type"] description];
                
               [_dataArray addObject:model];
            }
            
            [wself.tbView reloadData];
            
        }
        if ([errorCode isEqualToString:@"110"]) {
            
            [wself.tbView reloadData];
            if (_page==1) {
                [wself showLoadingFailureViewZFJ:@"赞无商品数据"];
            }
            else
            {
                Alert(@"已经无更多数据");
            }
        }
        if ([errorCode isEqualToString:@"107"]) {
            if (_page==1) {
                [wself showLoadingFailureViewZFJ:@"赞无商品数据"];
            }
            else
            {
                Alert(@"已经无更多数据");
            }

        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            [wself showLoadingFailureViewZFJ:@"数据加载失败，请刷新试一下..."];
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
    return 145;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"ListNewCell";
    ListNewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ListNewCell" owner:self options:nil]objectAtIndex:0];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    //OnlineModel *modle = _dataArray[indexPath.row];
    
     OnlineModel *modle = [_dataArray objectAtQYQIndex:indexPath.row];
    
    [cell showUIViewWithModel:modle];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailsViewController *pvc = [[ProductDetailsViewController alloc]init];
    if (_dataArray.count>0) {
        //OnlineModel *model = _dataArray[indexPath.row];
        
        OnlineModel *model = [_dataArray objectAtQYQIndex:indexPath.row];
        
        pvc.goodsID = model.goodsID.description;
          [self.navigationController pushViewController:pvc animated:YES];
    }
    
  
  
}

#pragma mark --下拉刷新--
- (void)headerRefresh
{
    [_dataArray removeAllObjects];
    _page = 1;
    [self requestDataBase];
}
#pragma mark --上拉加载--
- (void)footerRefresh
{
    _page ++;
    [self requestDataBase];
}



@end
