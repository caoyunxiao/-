//
//  OnlineViewController.m
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "OnlineViewController.h"
#import "ShopCell.h"
#import "ListTopViewController.h"
#import "SreachViewController.h"     //周边搜索
#import "ListModel.h"                //列表模型

@interface OnlineViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation OnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setShopRightButton];
    [self uiConfig];
    //请求列表的数据源
    _listArr = [NSMutableArray array];
    [self requestListData];
    
    self.ShopTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_listArr removeAllObjects];
        
        [self requestListData];
        
    }];

}
- (void)uiConfig
{
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
//    self.title = @"明星周边";
  
    _ShopTableView.delegate = self;
    _ShopTableView.dataSource = self;
    _ShopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _SearchTextField.delegate = self;
    _searchisShow = NO;
    
    _SearchView.clipsToBounds = YES;

    _SearchView.alpha = 0.9;
    
    _SearchButton.layer.masksToBounds = YES;
    _SearchButton.layer.cornerRadius = 5;
    
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [searchBtn setImage:[UIImage imageNamed:@"Shop_Search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    _dataArrayTop = @[@"shop1.png",@"shop2.png",@"shop3.png",@"shop4.png",@"shop5.png"];
    _TitleArrayTop = @[@"TOP10",@"新品",@"打折品",@"明星限量版",@"礼品"];
    
    _dataArrDown = @[@"shop6.png",@"shop7.png"];
    _TitleArrDown = @[@"送他",@"送她",@"送Bady",@"门票",@"服装"];
    
    [_SearchView bringSubviewToFront:self.view];
}
#pragma mark - 退键盘的方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   [textField resignFirstResponder];
   
    return YES;
}
- (void)requestListData
{
    __weak typeof(self)wself = self;
    [self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:nil wAction:@"602" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
         [wself removeLoadingViewZFJ];
        if (self.ShopTableView.mj_header.isRefreshing) {
            
            [self.ShopTableView.mj_header endRefreshing];
        }
        if([errorCode isEqualToString:@"0"])
        {
            [wself removeLoadingFailureViewZFJ];
            
            NSLog(@"%@",resultDict);
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array) {
                ListModel *modle = [[ListModel alloc] init];
                modle.iD = [dict[@"iD"] description];
                modle.name = dict[@"name"];
                [wself.listArr addObject:modle];
            }
            [self.ShopTableView reloadData];
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            [self showLoadingFailureViewZFJ:@"数据加载失败,请重新加载"];
        }
    }];
    
}


#pragma mark -  点击事件
-(void)singleTap:(UIGestureRecognizer*)sender
{
    _searchisShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _SearchView.frame = CGRectMake(0, -46, ScreenWidth, 46);
    }];
}

#pragma mark - 点击搜索框
- (void)searchBtnClick
{
    if(!_searchisShow)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _SearchView.frame = CGRectMake(0, 0, ScreenWidth, 46);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _SearchView.frame = CGRectMake(0, -46, ScreenWidth, 46);
        }];
    }
    _searchisShow = !_searchisShow;
}

#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = _dataArrDown.count + 4;
    return count;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger height = ScreenWidth/2;
    NSInteger index1 = _dataArrayTop.count/2;
    NSInteger index2 = _dataArrayTop.count%2;
    if(indexPath.row==0)
    {
        if(index2==0)
        {
            return index1*height;
        }
        else
        {
            return (index1+1)*height;
        }
    }
    else if(indexPath.row>=1&&indexPath.row<=3)
    {
        return 46;
    }
    else
    {
        return height;
    }
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row>=1&&indexPath.row<=3)
    {
        static NSString *str = @"ShopCellTwo";
        ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:self options:nil]objectAtIndex:1];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(_TitleArrDown.count>0)
        {
            //cell.titleName.text = _TitleArrDown[indexPath.row-1];
            
            cell.titleName.text = [_TitleArrDown objectAtQYQIndex:indexPath.row-1];
            
        }
        return cell;
    }
    else
    {
        static NSString *str = @"LeftCellOne";
        ShopCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopCell" owner:self options:nil]objectAtIndex:0];
            cell.clipsToBounds = YES;
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(indexPath.row==0&&_dataArrayTop.count>0)
        {
            [cell showTopUIViewWithArray:_dataArrayTop];
        }
        else
        {
            if(_dataArrDown.count>0)
            {
                cell.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth/2);
                [cell showUIViewDownWithString:_dataArrDown[indexPath.row-4]];
            }
        }
        return cell;
    }
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger num = indexPath.row - 1;
    ListTopViewController *lvc = [[ListTopViewController alloc]init];
    //lvc.title = _TitleArrDown[num];
    lvc.title = [_TitleArrDown objectAtQYQIndex:num];
    
    NSLog(@"列表清单%@",_listArr);
  
    for (ListModel *model in _listArr) {
        
        if ([lvc.title isEqualToString:model.name]) {
            
            lvc.typeID = model.iD;
            lvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:lvc animated:YES];
        }


     }
}
#pragma mark - 滚动视图代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _searchisShow = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _SearchView.frame = CGRectMake(0, -46, ScreenWidth, 46);
    }];
    [self.view endEditing:YES];
}
#pragma mark - 图片点击代理事件
- (void)selectOneImageByClick:(NSInteger)index
{
    [_SearchTextField resignFirstResponder];
    NSInteger num = index - 60;
    ListTopViewController *lvc = [[ListTopViewController alloc]init];
    //lvc.title = _TitleArrayTop[num];
    lvc.title = [_TitleArrayTop objectAtQYQIndex:num];
    lvc.hidesBottomBarWhenPushed = YES;
    if ([lvc.title isEqualToString:@"TOP10"]) {
        
        [self.navigationController pushViewController:lvc animated:YES];
    }
    for (ListModel *model in _listArr) {
        
        if ([lvc.title isEqualToString:model.name]) {
            
            
            lvc.typeID = model.iD;
            [self.navigationController pushViewController:lvc animated:YES];
        }
    
    }
}
#pragma mark - 搜索按钮
- (IBAction)SearchButton:(UIButton *)sender
{
    if(self.SearchTextField.text.length>0)
    {
      
        SreachViewController *svc = [[SreachViewController alloc] init];
        
        svc.title = @"商品搜索";
        
        [self.navigationController pushViewController:svc animated:YES];
    }
    else
    {
        //没有输入搜索内容
        Alert(@"请输入搜索内容");
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_SearchTextField resignFirstResponder];
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
