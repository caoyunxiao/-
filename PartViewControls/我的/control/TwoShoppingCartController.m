//
//  TwoShoppingCartController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TwoShoppingCartController.h"

#import "SettelViewController.h"                  //结算按钮

#import "ShoppingCell.h"
#import "OnlineModel.h"
#import "PicVidListModel.h"                      //商品数组模型

#import "ProductDetailsViewController.h"        //商品详情
@interface TwoShoppingCartController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *goodsArr;

@property (nonatomic, strong) NSMutableArray *selectGoodsArr;

@end

@implementation TwoShoppingCartController

#pragma mark - 视图控制室加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //请求数据源
   // [self getShopingCartArrayData];
    [self configUI];
    //加一个监听的添加了购物车的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveShoppingCartadd:) name:@"REFRESH_SHOPPING_CART" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleShoopinCateOne:) name:@"deleShoopinCateOne" object:nil];
  
    
}
- (void)receiveShoppingCartadd:(NSNotification *)notification
{
    NSLog(@"收到了加入了购物车的通知");
    [self getShopingCartArrayData];
}
- (void)deleShoopinCateOne:(NSNotification *)notification
{
    [self getShopingCartArrayData];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getShopingCartArrayData];
    self.navigationController.navigationBarHidden = NO;
    
    
    [self initSelectGoodsArray];
#warning 一定要记得刷新数据源
    [self.tbView reloadData];
    
}

#pragma mark - 初始化购物车的数据
- (void)getShopingCartArrayData
{
    _goodsArr = [NSMutableArray array]; //购物车的数据源
    
    //NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"113" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            NSLog(@"购物车的数据源%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array) {
                
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
              
                [_goodsArr addObject:model];
            }
    
            
            [self.tbView reloadData];
            
            self.SettelButtomView.hidden = NO;
        }
        if ([errorCode isEqualToString:@"110"]) {
            [self showLoadingFailureViewZFJ:@"你的购物车空空如也"];

        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
    
    if (_goodsArr.count == 0) {
        self.SettelButtomView.hidden = YES;
    }

}
#pragma mark - 清除购物车的接口
// 获取删除购物车的接口
- (void)getDeletateShoppingDataWithGoodId:(OnlineModel *)model withIndex:(int)i WithSelectGoodsCount:(NSUInteger)count;
{
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId ,@"goodsid":model.goodsID};
    
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", model.goodsID,@"goodsid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"112" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            
            NSLog(@"获取删除购物车的接口%d",i);
            
            NSLog(@"获取删除购物车的接口选中商品的数量%ld",count);
            
            
            if (i==count-1) {
                Alert(@"删除购物车成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"deleShoppingCateTwo" object:nil];
                
            }
            [_goodsArr removeObjectsInArray:_selectGoodsArr];
            [_selectGoodsArr removeAllObjects];
            
//            NSLog(@"删除购物车成功%@",[NSThread currentThread]);
            if (_goodsArr.count==0) {
                
                [self showLoadingFailureViewZFJ:@"您的购物车空空如也"];
                _SettelButtomView.hidden = YES;
            }
            [_tbView reloadData];
            
        }
        else
        {
            NSLog(@" 清除购物车的接口ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
        }
    }];
    
    
}
#pragma mark - 初始化购物车选中数据
- (void)initSelectGoodsArray
{
   
    [_selectGoodsArr removeAllObjects];
    _selectGoodsArr = [NSMutableArray array];
    
    _selectAllBtn.selected = NO;
    OnlineModel *model = [[OnlineModel alloc] init];
    for (model in _goodsArr) {
        
        model.selected = NO;
        
    }
    
}
- (void)configUI
{
    self.title = @"购物车";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    _tbView.delegate = self;
    
    _tbView.tableFooterView = [UIView new];
    
    _tbView.dataSource = self;
    
}
#pragma mark - UITbaleView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _goodsArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ShoppingCellId = @"ShoppingCellId";
    
    
    ShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCellId] ;
    
    
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCell" owner:self options:nil] lastObject];
    }
    
    
    //OnlineModel *model = _goodsArr[indexPath.row];
    
     OnlineModel *model = [_goodsArr objectAtQYQIndex:indexPath.row];
    
    
    [cell configModel:model];
    
    [cell.selectBtn addTarget:self action:@selector(cellSelectBtnClict:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
#pragma mark - 选中Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailsViewController *prductVc = [[ProductDetailsViewController alloc] init];
    
    if (_goodsArr.count>0) {
        //OnlineModel *model = _goodsArr[indexPath.row];
        
        OnlineModel *model = [_goodsArr objectAtQYQIndex:indexPath.row];
        
        prductVc.goodsID = model.goodsID.description;
        prductVc.isShopingCate = YES;
        [self.navigationController pushViewController:prductVc animated:YES];
    }
  
}
#pragma mark - 点击cell上的按钮的方法
- (void)cellSelectBtnClict:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    ShoppingCell *cell = (ShoppingCell *)[[sender superview] superview];
    
    
    NSIndexPath * indexPath = [self.tbView indexPathForCell:cell];
    
//    OnlineModel *model = _goodsArr[indexPath.row];
    OnlineModel *model = [_goodsArr objectAtQYQIndex:indexPath.row];
    
    if (sender.selected == YES) {
        model.selected = sender.selected;
        [_selectGoodsArr addObject:model];
    }
    if (sender.selected == NO) {
        model.selected  = NO;
        
        [_selectGoodsArr removeObject:model];
    }
    
    
    if (_selectGoodsArr.count == _goodsArr.count) {
        //全选按钮选中
        _selectAllBtn.selected = YES;
        
    }
    else
    {
        _selectAllBtn.selected = NO;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//点击了全选的按钮
- (IBAction)selectAllBtnClick:(UIButton *)sender {
    
    //购物车为空
    if (_goodsArr.count==0) {
        Alert(@"你的购物车空空如也，赶紧去添加吧");
        _selectAllBtn.selected = NO;
        return;
    }
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        for (int i = 0; i<_goodsArr.count;i++ ) {
            
            OnlineModel *model = [_goodsArr objectAtQYQIndex:i];
            
            
            model.selected = YES;
            [_selectGoodsArr addObject:model];
            
        }
    }
    else
    {
        for (int i = 0; i<_goodsArr.count;i++ ) {
            
           // OnlineModel *model = _goodsArr[i];
           
             OnlineModel *model = [_goodsArr objectAtQYQIndex:i];
            
            model.selected = NO;
            [_selectGoodsArr addObject:model];
            
        }
        
        [_selectGoodsArr removeAllObjects];
    }
    
    [_tbView reloadData];
    
   /*还能输入内跟别人比分verfververv日本日本容给别人吧糖尿病人糖尿病人糖尿病人糖尿病**/
}

//点击了删除的按钮
- (IBAction)deleteBtnClick:(UIButton *)sender {
    
    NSUInteger selectGoods = _selectGoodsArr.count;
    if (_selectGoodsArr .count <=0) {
        Alert(@"你没有选中商品");
        return;
    }
    
   
    
    
    else
    {
        for (int i=0; i<_selectGoodsArr.count; i++) {
            
           // [self getDeletateShoppingDataWithGoodId:[_selectGoodsArr objectAtQYQIndex:i] withIndex:i];
            
            [self getDeletateShoppingDataWithGoodId:[_selectGoodsArr objectAtQYQIndex:i] withIndex:i WithSelectGoodsCount:selectGoods];
            
        }
    }

  
    NSLog(@"点击了删除按钮");

}
//点击了结算的按钮
- (IBAction)settelBtnClick:(UIButton *)sender {
    
    if (_selectGoodsArr .count <=0) {
        Alert(@"你没有选中商品");
        return;
    }
    NSLog(@"点击了结算按钮");
    
    SettelViewController *settelVc = [[SettelViewController alloc] init];
    
    settelVc.goodArr = [NSMutableArray arrayWithArray:_selectGoodsArr];
    
    
    [self.navigationController pushViewController:settelVc animated:YES];

}
#pragma mark - 本类将要被释放移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
