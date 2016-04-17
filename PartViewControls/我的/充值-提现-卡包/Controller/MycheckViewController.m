//
//  MycheckViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "MycheckViewController.h"
#import "RechargeModle.h"       //充值的模型
#import "ExchangeModle.h"       //兑换的模型
#import "OrederModel.h"         //订单的模型
#import "OnlineModel.h"         //显示商品详情的模型
#import "OrderDetailController.h"

#import "ExchargeCell.h"        //充值Cell
#import "OrderCell.h"
#import "rewardCell.h"

@interface MycheckViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  存放充值模型数组
 */
@property (nonatomic, strong) NSMutableArray *rechargeModleArr;
/**
 *  存放兑换模型的数组
 */
@property (nonatomic, strong) NSMutableArray *exchargeModleArr;
/**
 *  存放打赏模型的数组
 */
@property (nonatomic, strong) NSMutableArray *rewardModleArr;
/**
 *  订单模型数组
 */
@property (nonatomic, strong) NSMutableArray *orderModleArr;



@end

@implementation MycheckViewController

#pragma mark - 获取购买订单记录
- (void)requestOrderList
{
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
//    NSDictionary *wParamDict = @{@"page":pageStr,@"size":sizeStr,@"userid":[PersonInfo sharePersonInfo].userId,@"type":@"10"};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:pageStr,@"page", sizeStr,@"size",[PersonInfo sharePersonInfo].userId, @"userid", @"10",@"type", nil];

    __weak typeof(self)wself = self;
    [self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"118" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }
        if (wself.tbView.mj_footer.isRefreshing) {
            
            [wself.tbView.mj_footer endRefreshing];
        }
        [self removeLoadingViewZFJ];
        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];
            NSArray *array = (NSArray *)resultDict;
            
            for (NSDictionary *dict in array) {
                
                NSLog(@"获取购买订单记录%@",array);
                OrederModel *model = [[OrederModel alloc] init];
                model.ctid = [dict[@"ctid"] description];
                model.totalPrice = dict[@"totalPrice"];
                model.createTime = dict[@"createTime"];
                model.orderSN = [dict[@"orderSN"] description];
                model.saleGoodsList = [NSMutableArray array];
                
                for (NSDictionary *goodsDict in dict[@"saleGoodsList"] ) {
                    OnlineModel *onlineModle = [[OnlineModel alloc] init];
                    onlineModle.cover = goodsDict[@"cover"];
                    onlineModle.caBei = [goodsDict[@"caBei"] description];
                    onlineModle.price = [goodsDict[@"price"] description];
                    onlineModle.name = [goodsDict[@"name"] description];
                    onlineModle.discription = goodsDict[@"discription"];
                    onlineModle.total = [goodsDict[@"total"] description];
                    [model.saleGoodsList addObject:onlineModle];
                    
                }
                [wself.orderModleArr addObject:model];
            }
            
            [wself.tbView reloadData];
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            if (_page==1) {
                [self showLoadingFailureViewZFJ:@"暂无购买商品记录"];
            }
            else
            {
                Alert(@"暂无更多数据");
            }

        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            //Alert([ReturnCode getResultFromReturnCode:errorCode]);
            [self showLoadingFailureViewZFJ:@"加载失败，请刷新一下吧"];
            
        }
    }];

}
#pragma mark - 获取兑换记录
- (void)requestExchangeDataBase
{
    
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"page":pageStr,@"size":sizeStr};
    
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId, @"userid", pageStr,@"page", sizeStr,@"size", nil];
    __weak typeof(self)wself = self;
    //[self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"310" completed:^(NSString *errorCode, NSDictionary *resultDict) {
       // [self removeLoadingViewZFJ];
        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }
        if (wself.tbView.mj_footer.isRefreshing) {
            
            [wself.tbView.mj_footer endRefreshing];
        }
        
        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];
            //NSLog(@"获取兑换记录%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array) {
              
                ExchangeModle *model = [[ExchangeModle alloc] init];
                
                model.amount = [dict[@"amount"] description];
                model.exchangeTime = dict[@"exchangeTime"] ;
                model.kaBei = [dict[@"kaBei"] description];
                model.orderSN = [dict[@"orderSN"] description];
                if (![model.amount isEqualToString:@"0"]) {
                    [wself.exchargeModleArr addObject:model];
                }
                
            }
            
            [wself.tbView reloadData];
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            if (_page==1) {
                [self showLoadingFailureViewZFJ:@"暂无兑换记录"];
            }
            else
            {
                Alert(@"暂无更多数据");
            }
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            //Alert([ReturnCode getResultFromReturnCode:errorCode]);
            
            [self showLoadingFailureViewZFJ:@"加载失败，请刷新一下吧"];
        }
    }];
    

}
#pragma mark - 获取打赏记录的数据源
- (void)requestRewardDataBase
{
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"page":pageStr,@"size":sizeStr};
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", pageStr,@"page", sizeStr,@"size", nil];
    
    __weak typeof(self)wself = self;
    //[self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"210" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        }
        if (wself.tbView.mj_footer.isRefreshing) {
            
            [wself.tbView.mj_footer endRefreshing];
        }
        //[self removeLoadingViewZFJ];
        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];
           // NSLog(@"打赏%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array) {
                
                RewardModle *model = [[RewardModle alloc] init];
                model.amount = [dict[@"amount"] description];
                model.createTime = [dict[@"createTime"] description];
                model.nickName = dict[@"nickName"];
                [wself.rewardModleArr addObject:model];
            }
            
            [wself.tbView reloadData];
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            if (_page==1) {

                [self showLoadingFailureViewZFJ:@"您还没有打赏记录哦!"];
            }
            else
            {
                //Alert(@"暂无更多数据");
            }
            
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
           /*而过去二个*/
            [self showLoadingFailureViewZFJ:@"加载失败，请刷新试一下吧!"];
        }
    }];

}
#pragma mark- 获取充值的记录
- (void)requestrechargeableDataBase
{
    
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"page":pageStr,@"size":sizeStr};
    
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", pageStr,@"page", sizeStr,@"size", nil];
    
    __weak typeof(self)wself = self;
    //[self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"306" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        //if (wself.tbView.mj_header.isRefreshing) {
            
            [wself.tbView.mj_header endRefreshing];
        //}
       // if (wself.tbView.mj_footer.isRefreshing) {
            
            [wself.tbView.mj_footer endRefreshing];
        //}
        [self removeLoadingViewZFJ];
        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];
            NSArray *array = (NSArray *)resultDict;
            NSLog(@"%@",array);
            for (NSDictionary *dict in array) {
                
                RechargeModle *model = [[RechargeModle alloc] init];
                
                model.amount = [dict[@"amount"] description];
                model.cashBack = [dict[@"cashBack"] description];
                model.kabei = [dict[@"kabei"] description];
                model.payTime = dict[@"payTime"];
                model.orderSN = dict[@"orderSN"];
            
                [wself.rechargeModleArr addObject:model];
            }
            
            [wself.tbView reloadData];
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            if (_page==1) {
                 [self showLoadingFailureViewZFJ:@"您还没有充值记录!"];
            
            }
            else
            {
                //Alert(@"暂无更多数据");
            }
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            //Alert([ReturnCode getResultFromReturnCode:errorCode]);
            [self showLoadingFailureViewZFJ:@"加载失败，刷新试一下吧!"];
        }
    }];

}
#pragma mark - 视图加载的页面
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
#warning 先写配置文件
     [self configUI];
    if (_isBuy == YES) {
        self.orderBtn.selected = YES;
        
        _reCahargeBtn.selected = NO;
        _rewardBtn.selected = NO;
        _exchargeBtn.selected = NO;
        [self requestOrderList];
    }
    else
    {
         self.reCahargeBtn.selected = YES;
        _orderBtn.selected = NO;
        _rewardBtn.selected = NO;
        _exchargeBtn.selected = NO;
        [self requestrechargeableDataBase];    //获取充值的记录
    }
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    //下拉刷新
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        if (_reCahargeBtn.selected == YES) {
             [self.rechargeModleArr removeAllObjects];
            [self requestrechargeableDataBase];
        }
       else if (_exchargeBtn.selected == YES) {
             [self.exchargeModleArr removeAllObjects];
            [self requestExchangeDataBase];
        }
       else if (_rewardBtn.selected == YES) {
            
            [self.rewardModleArr removeAllObjects];
            
            [self requestRewardDataBase];
        }
        else
        {
            [self.orderModleArr removeAllObjects];
            [self requestOrderList];
        }
      
        
        
    }];
    //上拉加载
    self.tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
         _page ++;
        if (_reCahargeBtn.selected == YES) {
      
            [self requestrechargeableDataBase];
        }
       else if (_exchargeBtn.selected == YES) {
    
            [self requestExchangeDataBase];
        }
       else if (_rewardBtn.selected == YES) {
         
            
            [self requestRewardDataBase];
        }
         else
        {
            [self requestOrderList];
        }

    }];
    
}
#pragma mark - 配置文件
- (void)configUI
{
    self.title = @"我的账单";
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.tbView.tableFooterView = [[UIView alloc] init];
    _page = 1;
    _size = 15;
    
    _rewardModleArr = [NSMutableArray array];       //打赏
    _orderModleArr = [NSMutableArray array];        //订单
    _rechargeModleArr = [NSMutableArray array];     //充值
    _exchargeModleArr = [NSMutableArray array];     //兑换
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

#pragma mark - UITableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_reCahargeBtn.selected == YES) {
        return _rechargeModleArr.count;
    }
    
    if (_exchargeBtn.selected == YES)
    {
        return _exchargeModleArr.count;
    }
    if (_rewardBtn.selected == YES) {
        return _rewardModleArr.count;
    }
    
    return _orderModleArr.count;
    
}
#pragma mark - 返回cell 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_orderBtn.selected == YES) {
        return 65;
    }
    return 44;
    
}
#pragma mark - 返回cell详情
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //重用Id
    static NSString *rechargeId = @"rechargeId";
    static NSString *exchargeId = @"ExchargeCellId";
    static NSString *rewardId = @"rewardCellId";
    static NSString *orderId = @"OrderCellId";
    
    if (_reCahargeBtn.selected == YES) {
        
               //从重用队列里面获取
        UITableViewCell *rechargeCell = [tableView dequeueReusableCellWithIdentifier:rechargeId];
        //获取不到,创建新的对象
        if (nil == rechargeCell) {
            rechargeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:rechargeId];
        }
        
        //显示数据
        if (_rechargeModleArr.count>0) {
            //RechargeModle *model = _rechargeModleArr[indexPath.row];
            
            RechargeModle *model = [_rechargeModleArr objectAtQYQIndex:indexPath.row];
            rechargeCell.textLabel.textColor =  TCColordefault;
            rechargeCell.textLabel.font = [UIFont systemFontOfSize:15];
            rechargeCell.textLabel.text = model.payTime;
            rechargeCell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",model.amount];
        }
        
        return rechargeCell;

    }
    if (_exchargeBtn.selected == YES) {
        
        ExchargeCell *exchagrgeCell = [tableView dequeueReusableCellWithIdentifier:exchargeId];
        
        if (exchagrgeCell == nil) {
            exchagrgeCell = [[[NSBundle mainBundle]loadNibNamed:@"ExchargeCell" owner:nil options:nil]lastObject];
    
        }
        ExchangeModle *model = [[ExchangeModle alloc] init];
        if (_exchargeModleArr.count >0) {
             //model = _exchargeModleArr[indexPath.row];
            
            model = [_exchargeModleArr objectAtQYQIndex:indexPath.row];
            
        }
       
        
        [exchagrgeCell configModle:model];
        
        return exchagrgeCell;
    }
    if (_rewardBtn.selected == YES) {
        
        rewardCell *Cell = [tableView dequeueReusableCellWithIdentifier:rewardId];
        
        if (Cell == nil) {
            Cell = [[[NSBundle mainBundle]loadNibNamed:@"rewardCell" owner:nil options:nil]lastObject];
            
        }
        RewardModle *model = [[RewardModle alloc] init];
        if (_rewardModleArr.count>0) {
//            model = _rewardModleArr[indexPath.row];
            model = [_rewardModleArr objectAtQYQIndex:indexPath.row];
            
        }
         [Cell configModle:model];
        return Cell;

        
    }
    else
    {
        OrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:orderId];
        if (orderCell == nil) {
            orderCell = [[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil]lastObject];
            
            if (_orderModleArr.count>0) {
               // OrederModel *model = _orderModleArr[indexPath.row];
                
                OrederModel *model = [_orderModleArr objectAtQYQIndex:indexPath.row];
                [orderCell config:model];
            }
           
        }
       return orderCell;
    
    }
    
    
}
#pragma mark - 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_orderBtn.selected == YES) {
        
        OrderDetailController *orderVc = [[OrderDetailController alloc] init];
        
        //OrederModel *orderM = _orderModleArr[indexPath.row];
        
        OrederModel *orderM = [_orderModleArr objectAtQYQIndex:indexPath.row];
        orderVc.orderArr = [NSMutableArray arrayWithArray:orderM.saleGoodsList];
        NSLog(@"#pragma mark - 选中cell%@",orderM.saleGoodsList);
        
        
        [self.navigationController pushViewController:orderVc animated:YES];
        /*以后就然后认让她干活不让他和博尔特还不让他忽然他同和认同和不如天河北*/
    }
}
#pragma mark - 点击充值的按钮
- (IBAction)reChargeClick:(UIButton *)sender {
    
    //获取充值的数据源
    _page = 1;
    
    [_rechargeModleArr removeAllObjects];
    [self requestrechargeableDataBase];
    sender.selected = YES;
    _exchargeBtn.selected = NO;
    _orderBtn.selected = NO;
    _rewardBtn.selected = NO;
    [_tbView reloadData];
    /*gbrtfbebebetbterfbttt*/
}
#pragma mark - 点击兑换的按钮
- (IBAction)exchargeClick:(UIButton *)sender {
    
    sender.selected = YES;
    _page = 1;
    
    //获取兑换的数据源
    [_exchargeModleArr removeAllObjects];
    [self requestExchangeDataBase];
    _reCahargeBtn.selected = NO;
    _orderBtn.selected = NO;
    _rewardBtn.selected = NO;

     [_tbView reloadData];
}
#pragma mark - 点击打赏的按钮
- (IBAction)rewardBtnClick:(UIButton *)sender {
    sender.selected = YES;
    _page = 1;
    [_rewardModleArr removeAllObjects];
    //获取打赏的数据源
    [self requestRewardDataBase];
    _reCahargeBtn.selected = NO;
    _exchargeBtn.selected = NO;
    _orderBtn.selected = NO;
    
    [_tbView reloadData];
}
#pragma mark - 点击订单的按钮
- (IBAction)orderClick:(UIButton *)sender {
    sender.selected = YES;
    //gbgbgbgbftbg订单的
    _page = 1;
    [_orderModleArr removeAllObjects];
    [self requestOrderList];
    
    _reCahargeBtn.selected = NO;
    _exchargeBtn.selected = NO;
    _rewardBtn.selected = NO;
    
     [_tbView reloadData];
    
}
@end
