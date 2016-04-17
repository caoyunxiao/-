//
//  ZuiXinViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ZuiXinViewController.h"
#import "ShowCell.h"            //梦想秀的Cell


@interface ZuiXinViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ZuiXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self conFigUI];
    
    [self requeseBase:self.sorting];
}

- (void)conFigUI
{
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tbView.tableFooterView = [UIView new];
    
    _page = 1;
    _size = 15;
    
    _dataArr = [NSMutableArray array];
    __weak typeof(self)wself = self;
    //下拉刷新
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [wself.dataArr removeAllObjects];
        [wself requeseBase:wself.sorting];
        

    }];
    //上拉加载
    _tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page ++;
       
        [wself requeseBase:wself.sorting];
        
    }];
    

}

#pragma mark - 请求服务器数据源
- (void)requeseBase:(NSString *)sorting
{
    NSLog(@"请求服务器数据源%@",sorting);
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
    [self showLoadingViewZFJ];//显示加载动画
   // NSDictionary *wParamDict = @{@"page":pageStr,@"size":sizeStr,@"userid":@"",@"sorting":sorting};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:pageStr,@"page", sizeStr,@"size",@"",@"userid", sorting,@"sorting", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"502" completed:^(NSString *errorCode, NSDictionary *resultDict) {

        [self endRefreshingNew];
        [self removeLoadingViewZFJ];//移除加载动画
        if([errorCode isEqualToString:@"0"])
        {
            [self removeLoadingFailureViewZFJ];//移除加载失败界面
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array)
            {
                HomeModel *model = [[HomeModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArr addObject:model];
            }
            
           
            [self.tbView reloadData];
        

        }
        else if ([errorCode isEqualToString:@"110"])
        {
            if (_page == 1) {
                [self showLoadingFailureViewZFJ:@"暂无数据"];
            }
            else
            {
                
            }
        }
        else
        {
    
            [self showLoadingFailureViewZFJ:@"加载失败,请下拉刷新一下吧"];//加载失败
    
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            [self.tbView reloadData];
            
        }
    }];

}
#pragma mark - 结束刷新状态
- (void)endRefreshingNew
{
    if (self.tbView.mj_header.isRefreshing) {
        
        [self.tbView.mj_header endRefreshing];
    }
    if (self.tbView.mj_footer.isRefreshing) {
        
        [self.tbView.mj_footer endRefreshing];
    }
}

#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_dataArr count];
}

#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 309;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *str = @"ShowCell";
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShowCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    if (_dataArr.count!= 0) {
        
       // [cell showUIViewWithModelForNew:_dataArr[indexPath.row]];
        
        ;
        
         [cell showUIViewWithModelForNew:[_dataArr objectAtQYQIndex:indexPath.row]];
          
    }
    return cell;
}



#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中tableView的cell");
    
    if ([_delegate respondsToSelector:@selector(ZuiXinViewControllerDidSelectRowAtIndexPath:array:)]) {
        
        [_delegate ZuiXinViewControllerDidSelectRowAtIndexPath:indexPath array:_dataArr];
        
        
    }
}

#pragma mark -界面将要显示时
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
