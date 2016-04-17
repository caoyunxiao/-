//
//  SettelViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SettelViewController.h"

#import "MyAddressViewController.h"      //地址编辑的界面
#import "BuySuccessController.h"         //购买成功

#import "ReceiveGoodsCell.h"             //收货人信息的cell
#import "SettleCell.h"                   //结算的Cell

#import "AddressModle.h"                 //地址模型

@interface SettelViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AddressModle *addModel;           //地址模型

@property (nonatomic, copy) NSString *kabei;

@property (nonatomic, copy) NSString *balance;

@end

@implementation SettelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"购物车结算";
    
   // [self getAddressData];
    
    [self getPayPrinceType:@"rmb" goodsids:self.goodArr];
    [self getPayPrinceType:@"cb" goodsids:self.goodArr];
    
    [self configUI];
    
    
}
#pragma mark - 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self getAddressData];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 初始化数据源
//获取地址的信息
- (void)getAddressData
{
    __weak typeof(self) wself = self;
    self.addModel = [[AddressModle alloc] init];
    [self showLoadingViewZFJ];

    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"115" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        [wself removeLoadingViewZFJ];//移除加载
    
        if([errorCode isEqualToString:@"0"])
        {
            [wself removeLoadingFailureViewZFJ];
            NSLog(@"收货地址%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            NSDictionary *dict = array[0];
          
            wself.addModel.name = dict[@"name"];
            wself.addModel.mobile = dict[@"mobile"];
            wself.addModel.addr = dict[@"addr"];
        
            [wself.tbView reloadData];
        }
        if ([errorCode isEqualToString:@"110"]) {
            [wself removeLoadingFailureViewZFJ];
            Alert(@"请先设置您的收货地址信息");
        }
        else
        {
            NSLog(@"收货地址ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            [wself showLoadingFailureViewZFJ:@"数据加载失败,请稍后再试"];    //加载失败
            
            return ;
            
        }
    }];

}
//获取支付价格的数据
- (void)getPayPrinceType:(NSString *)type goodsids:(NSArray *)goodsArr
{
    
    OnlineModel *model = [[OnlineModel alloc] init];
    
   // NSMutableArray *goodsids = [NSMutableArray array];
    
    NSMutableArray *singleArr = [NSMutableArray array];
    //拼接价格
    for (model in goodsArr) {
        for (int i=0; i<model.total.floatValue; i++) {
            
            [singleArr addObject:model.goodsID];
           
        }
    }
#warning  将商品Id拼接成字符串
    NSString *string = [singleArr componentsJoinedByString:@","];
    

    __weak typeof(self) wself = self;
    //NSDictionary *wParamDict = @{@"goodsids":string,@"type":type};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:type,@"type",string,@"goodsids",nil];
    
    [self removeLoadingFailureViewZFJ];
    //[self showLoadingViewZFJ];//显示加载动画
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"116" completed:^(NSString *errorCode, NSDictionary *resultDict) {
          [self removeLoadingViewZFJ];//移除加载动画
        if([errorCode isEqualToString:@"0"])
        {
            [wself removeLoadingViewZFJ];
            NSLog(@"结算的价格%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            //如果请求的是咖贝
            if ([type isEqualToString:@"rmb"]) {
                NSLog(@"结算的人民币价格%@",array[0]);
                
                wself.priceBuyLabel.text = [array[0] description];
                
                wself.balance = [array[0] description];
                wself.priceLabel.text = [NSString stringWithFormat:@"￥%@元",wself.balance];
            }
            if ([type isEqualToString:@"cb"]) {
                
                NSLog(@"结算咖贝的价格%@",array[0]);
                wself.kabeiBuyLabel.text = [array[0] description];
                
                wself.kabei = [array[0] description];
            
            }
            [self.tbView reloadData];
        }
        else
        {
            NSLog(@"结算的价格ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            [wself showLoadingFailureViewZFJ:[ReturnCode getResultFromReturnCode:errorCode]];    //加载失败
            
            return ;
            
        }
    }];

}

#pragma mark - 设置最终结算的商品(120)
- (void)settingSettalGooids
{
    
    NSString *salesid;
    NSMutableArray *singleArr = [NSMutableArray array];
    OnlineModel *model = [[OnlineModel alloc] init];
    //拼接价格
    for (model in _goodArr) {
        for (int i=0; i<model.total.floatValue; i++) {
            
            [singleArr addObject:model.goodsID];
            salesid = model.salesID;
        }
#warning  将商品Id拼接成字符串

    }
    NSString *string = [singleArr componentsJoinedByString:@","];
    
  
    
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", salesid,@"salesid", string,@"goodsids", nil];
    
    NSLog(@"设置最终结算的商品(120)%@",wParamDict);
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"120" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
    
            if (self.balabceBtn.selected ==YES) {
                [self postBuyShoppingWithType:@"rmb"];
            }
            if (self.kabeiBtn.selected == YES) {
                [self postBuyShoppingWithType:@"cb"];
            }

        }
        else
        {
            NSLog(@"结算的价格ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            Alert(@"结算失败");
            return ;
            
        }
    }];

}

#pragma mark - 初始化界面
- (void)configUI
{
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    
    self.tbView.sectionHeaderHeight = 5;
    self.tbView.sectionFooterHeight = 5;
    
    //默认选中余额购买
    self.balabceBtn.selected = YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return _goodArr.count;
        
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    return 92;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *cellId = @"ReceiveGoodsCellId";
        
        ReceiveGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ReceiveGoodsCell" owner:nil options:nil]lastObject];
            
        }
    
        [cell configModel:self.addModel];
        return cell;
        
        
    }
    NSString *cellId = @"SettleCellId";
    SettleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SettleCell" owner:nil options:nil]lastObject];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //传递数据模型
    
    OnlineModel *model = [_goodArr objectAtQYQIndex:indexPath.row];
    
    [cell configModel:model];
    
    return cell;
    
}
#pragma mark - 返回HeaderView的标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        NSString *footStr = [NSString stringWithFormat:@"共%ld件商品",_goodArr.count];
        return footStr;
    }
    
    return nil;
}
#pragma mark - 点击cell跳入的视图控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        //地址编辑的界面
        MyAddressViewController *adressVc = [[MyAddressViewController alloc] init];
        
        [self.navigationController pushViewController:adressVc animated:YES];
        
    }
}

#pragma mark - 购买商品的接口
- (void)postBuyShoppingWithType:(NSString *)type
{
    __weak typeof(self) wself = self;
    OnlineModel *model = self.goodArr[0];
    NSString *salesid = model.salesID;
    
    NSString *amount;
    if ([type isEqualToString:@"rmb"]) {
        amount = self.balance;
    }
    if ([type isEqualToString:@"cb"]) {
        amount = self.kabei;
    }
    
//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"salesid":salesid,@"type":type,@"amount":amount};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", salesid,@"salesid", type,@"type", amount,@"amount", nil];
    
    
    NSLog(@"购买商品的接口%@",wParamDict);
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"307" completed:^(NSString *errorCode, NSDictionary *resultDict) {
    
        if([errorCode isEqualToString:@"3015"])
        {
            NSLog(@"购买商品的接口%@",resultDict);
            BuySuccessController *buyVc = [[BuySuccessController alloc] init];
            [wself.navigationController pushViewController:buyVc animated:YES];
            //发送购买成功的通知；
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shoppingSuccess" object:nil];
            
            
        }
        else
        {
            NSLog(@"购买商品ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
            return ;
            
        }
    }];

}
#pragma mark - 确认付款
- (IBAction)verifyBtnClick:(UIButton *)sender {
    
    if (self.addModel.addr.length <=0) {
        Alert(@"请填写您的收货人信息");
        
        return;
    }
    [self settingSettalGooids];
}

#pragma mark - 余额购买
- (IBAction)balanceBuyTAp:(UITapGestureRecognizer *)sender {
    
    self.balabceBtn.selected = YES;
    
    self.kabeiBtn.selected = NO;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@元",self.balance];
    
}
#pragma mark - 咖贝购买
- (IBAction)kaibeiBuyTap:(UITapGestureRecognizer *)sender {
    
    self.balabceBtn.selected = NO;
    
    self.kabeiBtn.selected = YES;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@咖贝",self.kabei];
}
@end
