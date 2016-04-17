//
//  ListTopViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ListTopViewController.h"
#import "ListNewCell.h"
#import "ProductDetailsViewController.h"
#import "OnlineModel.h"
#import "PicVidListModel.h"           //商品图片数组

@interface ListTopViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
}


@property (nonatomic, strong) NSMutableArray *dataArray;



@end

@implementation ListTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置购物车
    [self setShopRightButton];
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self uiConfig];
    if ([self.title isEqualToString:@"TOP10"]) {
        
        [self requestTopListDataBase];
    }
    else
    {
        [self requestOherDataBase];
    }
    
   
    
}


#pragma mark - 配置文件
- (void)uiConfig
{
    self.ListTopTableView.delegate = self;
    self.ListTopTableView.dataSource = self;
    [self setExtraCellLineHidden:self.ListTopTableView];
    
    _page = 1;
    _size = 15;
    _dataArray = [NSMutableArray array];
    //下拉刷新
    _ListTopTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if ([self.title isEqualToString:@"TOP10"]) {
            [_dataArray removeAllObjects];
            [self requestTopListDataBase];
        }
        else
        {
            [_dataArray removeAllObjects];
            _page = 1;
            [self requestOherDataBase];
        }
        
    }];
    //上拉加载
    if (![self.title isEqualToString:@"TOP10"]) {
        
        _ListTopTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _page ++;
            [self requestOherDataBase];
            
        }];

    }
}

#pragma mark - 请求Top10数据
- (void)requestTopListDataBase
{
    //加载等待视图
    [self showLoadingViewZFJ];
    __weak typeof(self)wself = self;
    [RequestEngine UserModulescollegeWithDict:nil wAction:@"600" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        [wself removeLoadingViewZFJ];
        if (wself.ListTopTableView.mj_header.isRefreshing) {
            
            [wself.ListTopTableView.mj_header endRefreshing];
        }
        if (wself.ListTopTableView.mj_footer.isRefreshing) {
            
            [wself.ListTopTableView.mj_footer endRefreshing];
        }

        if([errorCode isEqualToString:@"0"])
        {
            [wself removeLoadingFailureViewZFJ];
            NSArray *goodsArr = (NSArray *)resultDict;
            NSLog(@"请求Top10数据%@",goodsArr);
            for (NSDictionary *dict in goodsArr)
            {
                OnlineModel *model = [[OnlineModel alloc]init];
                model.caBei = [dict[@"caBei"] description];
                model.cover = dict[@"cover"];
                model.color = dict[@"color"];
                model.discription = dict[@"discription"];
                model.goodsID = dict[@"goodsID"];
                model.name = dict[@"name"];
                model.picVidList = [NSMutableArray array];
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
                
                [wself.dataArray addObject:model];
            }
            [wself.ListTopTableView reloadData];

          
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            [wself showLoadingFailureViewZFJ:@"数据加载失败，请刷新试一下..."];
        }
    }];
}
#pragma mark - 请求非TOP10页面的数据
- (void)requestOherDataBase
{
    //加载等待视图
    //加载等待视图
    [self showLoadingViewZFJ];
    __weak typeof(self)wself = self;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
//    NSDictionary *wdict = @{@"page":pageStr,@"size":sizeStr,@"typeid":_typeID};
    NSDictionary *wdict = [NSDictionary dictionaryWithObjectsAndKeys:pageStr,@"page",sizeStr,@"size",_typeID,@"typeid", nil];
    

    [RequestEngine UserModulescollegeWithDict:wdict wAction:@"601" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        [wself removeLoadingViewZFJ];
        if (wself.ListTopTableView.mj_header.isRefreshing) {
            
            [wself.ListTopTableView.mj_header endRefreshing];
        }
        if (wself.ListTopTableView.mj_footer.isRefreshing) {
            
            [wself.ListTopTableView.mj_footer endRefreshing];
        }

        if([errorCode isEqualToString:@"0"])
        {
            [wself removeLoadingFailureViewZFJ];
            NSArray *goodsArr = (NSArray *)resultDict;
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
                
                [wself.dataArray addObject:model];
            }
            
            [wself.ListTopTableView reloadData];
            
        }
        if ([errorCode isEqualToString:@"110"]) {
            if (_page==1) {
                [wself showLoadingFailureViewZFJ:@"暂无商品数据!"];
            }
            else
            {
                //Alert(@"已经无更多数据");
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
    if(_dataArray.count>0)
    {
        [cell showUIViewWithModel:[_dataArray objectAtQYQIndex:indexPath.row]];
    }
    return cell;
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailsViewController *pvc = [[ProductDetailsViewController alloc]init];
    if (_dataArray.count>0) {
        OnlineModel *model = [_dataArray objectAtQYQIndex:indexPath.row];
        pvc.goodsID = model.goodsID.description ;
        [self.navigationController pushViewController:pvc animated:YES];

    }
    
    
  }




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
