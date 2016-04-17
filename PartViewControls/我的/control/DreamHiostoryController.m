//
//  DreamHiostoryController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "DreamHiostoryController.h"

#import "DreamHistoryDetailViewController.h"
#import "DreamHistoryCell.h"                 //cell

#import "TCNewDetailViewController.h"        //梦想详情页面
@interface DreamHiostoryController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *listArr;
@end

@implementation DreamHiostoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestDataBase:_page size:_size];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 请求服务器参数
- (void)requestDataBase:(NSInteger)page size:(NSInteger)size
{
    
    __weak typeof(self) wself = self;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
    
    //NSDictionary *wParamDict = @{@"userid":self.userId,@"page":pageStr,@"size":sizeStr};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"userid",pageStr,@"page",sizeStr,@"size", nil];
    

    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"510" completed:^(NSString *errorCode, NSDictionary *resultDict) {
   
        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }
        if (wself.tbView.mj_footer.isRefreshing) {
            
            [wself.tbView.mj_footer endRefreshing];
        }

        [wself removeLoadingViewZFJ];//移除加载
        
        if([errorCode isEqualToString:@"0"])
        {
            [wself removeLoadingFailureViewZFJ];
           // NSLog(@"梦想秀列表%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            
            for (NSDictionary *dict in array) {
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                
                [wself.listArr addObject:model];
                
            }
            
            
            [wself.tbView reloadData];
        }
        else if ([errorCode isEqualToString:@"110"]){
            
            if (_page>1) {
                
            }
            else
            {
                [self showLoadingFailureViewZFJ:@"还未发布梦想哦!"];
            }
            
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            [self showLoadingFailureViewZFJ:@"数据加载失败,请稍后再试"];    //加载失败
            /*和net然后呢听你被他net你被他用net你**/
            return ;
            
        }
    }];

}
#pragma mark - 配置UI
- (void)configUI
{
    self.title = @"梦想秀历史";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    self.tbView.dataSource = self;
    self.tbView.delegate = self;
    self.tbView.tableFooterView = [UIView new];
    _page = 1;
    _size = 15;
    _listArr = [NSMutableArray array];
    
    //下拉刷新
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [_listArr removeAllObjects];
        [self requestDataBase:_page size:_size];
    }];
    //上拉加载
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page ++;
        [self requestDataBase:_page size:_size];
    }];

}


#pragma mark - UITableView协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
#pragma mark - 返回UITableViewCell的详情部分
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"DreamHistoryCellId";
    
    DreamHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DreamHistoryCell" owner:nil options:nil] lastObject];
        
    }
    if (_listArr.count>0) {
        //HomeModel *model = _listArr[indexPath.row];
        
        HomeModel *model = [_listArr objectAtQYQIndex:indexPath.row];
        
        /*特热歌人个人各混凝土混凝土好女孩他那天和你挺怀念他还能和他那也挺好呢*/
        [cell configData:model];
    }
    
    
    return cell;
    
}
#pragma mark - 点击cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    
     //HomeModel *model = _listArr[indexPath.row];
   
     HomeModel *model = [_listArr objectAtQYQIndex:indexPath.row];
    
    if ([model.state.description isEqualToString:@"1"]) {
        
        if (_isCao == YES) {
            
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }
        TCNewDetailViewController *detailVc = [[TCNewDetailViewController alloc] init];
         detailVc.dreamID = model.dreamID;
        detailVc.isMyinfoEnter = YES;
         [self.navigationController pushViewController:detailVc animated:YES];
    }

    else
    {
            DreamHistoryDetailViewController *detailVc = [[DreamHistoryDetailViewController alloc] init];
        
        
            detailVc.dreamID = model.dreamID;
        
            [self.navigationController pushViewController:detailVc animated:YES];
        
       

    }
    
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
