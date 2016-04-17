//
//  ProductDetailsViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProductDetailsCell.h"
#import "BuyDownView.h"
#import "LCActionSheet.h"                          //底部弹出视图

#import "SettelViewController.h"                   //结算页面
#import "PhoneCell.h"

#import "PicVidListModel.h"
@interface ProductDetailsViewController (){
    CALayer     *layer;
    NSInteger    _cnt;
    BuyDownView *_BuyDownView;
}

@property (nonatomic, strong) OnlineModel *myModel;
@property (nonatomic, strong) LCActionSheet *sheetView;

@property (nonatomic, strong) NSMutableArray *shoppingCataArr;    //专门用来存放GooidsID
@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = self.PDVTableView.backgroundColor;
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self setShopRightButton];
    [self uiConfig];
    
    [self requestDataBase];
    
}
#pragma mark - 配置文件
- (void)uiConfig
{
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    self.navigationController.navigationBar.alpha = 0.0;
    
    _cnt = 0;
    _isShow = NO;
    _buyCount = 1;
    self.PDVTableView.delegate = self;
    self.PDVTableView.dataSource = self;
    self.PDVTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    //创建底部视图
   
    self.PDVTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self requestDataBase];
        
    }];

}
- (void)creatButtomView
{
    _BuyDownView = [[[NSBundle mainBundle]loadNibNamed:@"BuyDownView" owner:self options:nil] lastObject];
    _BuyDownView.backgroundColor = [UIColor whiteColor];
    
    [_BuyDownView configModel:_myModel];
    
    _BuyDownView.buyReductionBtm.enabled = NO;
    _BuyDownView.buyCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyCount];
    [_BuyDownView.buyReductionBtm addTarget:self action:@selector(buyReductionBtmClick) forControlEvents:UIControlEventTouchUpInside];
    [_BuyDownView.buyAddButton addTarget:self action:@selector(buyAddButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_BuyDownView.sureBtn addTarget:self action:@selector(sureBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 请求商品详情数据
- (void)requestDataBase
{
    [self showLoadingViewZFJ];
    NSDictionary *wParamDict = @{@"goodsid":self.goodsID};
    __weak typeof(self)wself = self;
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"605" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        [wself removeLoadingViewZFJ];
         [wself.PDVTableView.mj_header endRefreshing];
        
        if([errorCode isEqualToString:@"0"])
        {
          
            NSArray *array = (NSArray *)resultDict;
            NSDictionary *dict = array[0];
    
            _myModel = [[OnlineModel alloc]init];
            _myModel.caBei = [dict[@"caBei"] description];
            _myModel.cover = dict[@"cover"];
            _myModel.color = dict[@"color"];
            _myModel.discription = dict[@"discription"];
            _myModel.goodsID = dict[@"goodsID"];
            _myModel.name = dict[@"name"];
            _myModel.picVidList = [NSMutableArray array];
            for (NSDictionary *dict2 in dict[@"picVidList"]) {
                PicVidListModel *model2 = [[PicVidListModel alloc] init];
                
                model2.describe = dict2[@"describe"];
                model2.type = dict2[@"type"];
                model2.url = dict2[@"url"];
                [_myModel.picVidList addObject:model2];
                
            }
            _myModel.price = dict[@"price"];
            _myModel.salesGoodsID = [dict[@"salesGoodsID"] description];
            _myModel.salesID = [dict[@"salesID"] description];
            _myModel.style = dict[@"style"];
            _myModel.total = [dict[@"total"] description];
            _myModel.type = [dict[@"type"] description];
        
            [wself.PDVTableView reloadData];
            [wself creatButtomView];
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            [wself showLoadingFailureViewZFJ:@"数据加载失败，请下拉刷新一下吧"];
            
        }
    }];

}
#pragma mark - 确认加入购物车或者立即购买支付
- (void)sureBtnDidClick:(UIButton *)btn
{
    
  [_sheetView dismiss];
        
       
  [self getShoppingCate];
    
    
}
#pragma mark - 跳转到结算页面
- (void)gotoSettelViewController
{
    SettelViewController *setVc = [[SettelViewController alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    
//    OnlineModel *model = [[OnlineModel alloc] init];
//    model = _myModel;
            //修改商品的数量
    _myModel.total = _BuyDownView.buyCountLabel.text;
        //把商品详情数组包装成数组
    [array addObject:_myModel];
    setVc.goodArr = array;
    [self.navigationController pushViewController:setVc animated:YES];

}
#pragma mark - 商品数量减
- (void)buyReductionBtmClick
{
    if(_buyCount==1)
    {
        _BuyDownView.buyReductionBtm.enabled = NO;
        return;
    }
    _buyCount --;
    _BuyDownView.buyCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyCount];
  
   
}
#pragma mark - 商品数量加
- (void)buyAddButtonClick
{
    _buyCount ++;
    _BuyDownView.buyCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_buyCount];
    if(_buyCount>1)
    {
        _BuyDownView.buyReductionBtm.enabled = YES;
    }
    NSMutableString *priceStr = [[NSMutableString alloc] init];
    [priceStr appendString:_BuyDownView.buyPrice.text];
    NSRange range = [priceStr rangeOfString:@"￥"];
    [priceStr deleteCharactersInRange:range];
    
}
#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 377;
    }
    else if(indexPath.row == 1)
    {
        return 110;
    }
    else
    {
        return 50;
    }
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        //商品大图
        static NSString *str = @"ProductDetailsCellOne";
        ProductDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductDetailsCell" owner:self options:nil]objectAtIndex:0];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
        }
        if(self.myModel!=nil)
        {
            
            [cell showUIViewOneCellWith:_myModel];
        }
        return cell;
    }
    else if(indexPath.row == 1)
    {
        //简介 描述
        static NSString *str = @"ProductDetailsCellTwo";
        ProductDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductDetailsCell" owner:self options:nil]objectAtIndex:1];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(self.myModel!=nil)
        {

            [cell showUIViewTwoCellWith:_myModel];
        }
        return cell;
    }
    else
    {
        //客服电话
        static NSString *str = @"PhoneCellId";
        PhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"PhoneCell" owner:nil options:nil] lastObject];
            cell.clipsToBounds = YES;
            
        }
        [cell.phoneCellBtn addTarget:self action:@selector(phoneCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
}
#pragma mark - 拨打客服电话
- (void)phoneCellBtnClick:(UIButton *)btn
{
    NSString *allString = [NSString stringWithFormat:@"tel:4009669200"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}


#pragma mark - 返回按钮
- (IBAction)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 购物车
- (IBAction)shopCarBtnClick:(UIButton *)sender
{
    if ([PersonInfo sharePersonInfo].isLogIn != YES) {
        
        [self showLogInViewController];
        
        return;
        
    }
    TwoShoppingCartController *tvc = [[TwoShoppingCartController alloc]init];
    
    tvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tvc animated:YES];
}

#pragma mark - 获取PDVTableView的cell
- (ProductDetailsCell *)cellAtIndexRow:(NSInteger)row andAtSection:(NSInteger) section
{
    ProductDetailsCell * cell = (ProductDetailsCell *)[self.PDVTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
    return cell;
}
#pragma mark - 立即购买
- (IBAction)BuyNowBtn:(UIButton *)sender
{
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    _isShoping = YES;

    _sheetView = [[LCActionSheet alloc] initWithView:_BuyDownView];
    [_sheetView show];
    
    
}
#pragma mark - 请求购物车数据
- (void)getShoppingCate
{
    _shoppingCataArr = [NSMutableArray array]; //购物车的数据源
     
    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"113" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array) {
                
                OnlineModel *model = [[OnlineModel alloc] init];
                model.goodsID = [dict[@"goodsID"] description];
                [_shoppingCataArr addObject:model.goodsID];
            }
            //已经存在购物车里面了
            if ([_shoppingCataArr indexOfObject:[_myModel.goodsID description]] != NSNotFound) {
                
                if (_isShoping ==YES) {
                    Alert(@"您的商品已经在购物车里面了,请点击右上角到购物车进行结算");
                }
                else
                {
            
                    NSString *userid = [PersonInfo sharePersonInfo].userId;
                    NSString *total = _BuyDownView.buyCountLabel.text;
                    [self addToCartWithuserid:userid goodsid:_myModel.goodsID total:total];

                }
                
            }
            else
            {
                if (_isShoping ==YES) {
                    
                    NSString *userid = [PersonInfo sharePersonInfo].userId;
                    NSString *total = _BuyDownView.buyCountLabel.text;
                    [self addToCartWithuserid:userid goodsid:_myModel.goodsID total:total];
                
                }
                else
                {
                    NSString *userid = [PersonInfo sharePersonInfo].userId;
                    NSString *total = _BuyDownView.buyCountLabel.text;
                    [self addToCartWithuserid:userid goodsid:_myModel.goodsID total:total];
                }
            }
            
        }
        else if ([errorCode isEqualToString:@"110"]) {
            
            if (_isShoping ==YES) {
                NSString *userid = [PersonInfo sharePersonInfo].userId;
                NSString *total = _BuyDownView.buyCountLabel.text;
                [self addToCartWithuserid:userid goodsid:_myModel.goodsID total:total];
            }
            else
            {
                NSString *userid = [PersonInfo sharePersonInfo].userId;
                NSString *total = _BuyDownView.buyCountLabel.text;
                [self addToCartWithuserid:userid goodsid:_myModel.goodsID total:total];
            }

        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"请求数据失败");
        }
    }];
    
}
#pragma mark - 添加购物车
- (IBAction)AddToCartBtn:(UIButton *)sender
{
    
    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
    if(isLogIn != YES)
    {
        [self showLogInViewController];
        return;
    }
    
    
    _isShoping = NO;
    
    _sheetView = [[LCActionSheet alloc] initWithView:_BuyDownView];
    
    [_sheetView show];
    
}
#pragma mark - 添加到购物车111
- (void)addToCartWithuserid:(NSString *)userid goodsid:(NSString *)goodsid total:(NSString *)total
{
    NSDictionary *wParamDict = @{@"userid":userid,@"goodsid":goodsid,@"total":total};
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"111" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            
            NSArray *array = (NSArray *)resultDict;
            NSDictionary *dict = [array lastObject];
            NSLog(@"添加到购物车111%@",array);
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

            NSLog(@"添加到购物车111%@",resultDict);
            NSNotification *notification =[NSNotification notificationWithName:@"REFRESH_SHOPPING_CART" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            if (_isShoping ==YES) {
                
                SettelViewController *setVc = [[SettelViewController alloc] init];
                NSMutableArray *array = [NSMutableArray array];
                
                [array addObject:model];
                setVc.goodArr = array;
                [self.navigationController pushViewController:setVc animated:YES];

            }
            else
            {
                Alert(@"添加成功");
            }
            
            
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
}
#pragma mark - 视图即将显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    
//    if (_isShopingCate== YES) {
//        self.downButtonView.hidden = YES;
//    }
}
#pragma mark - 视图将要消失
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark - 视图将要收到内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
