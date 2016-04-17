//
//  TCHomeViewController.m
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TCHomeViewController.h"
#import "TCHomeCell.h"

#import "SearchViewController.h"
#import "HomeModel.h"
#import "LGIndexViewController.h"
#import "PersonalFileViewController.h"
#import "TCNewDetailViewController.h"

#import "ExplainViewController.h"


@interface TCHomeViewController ()<UIAlertViewDelegate>
{
    /**
     *  升级URL
     */
    NSString *UrlString;
}
@end

@implementation TCHomeViewController


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
//    //收到登陆成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"loginSuccess" object:nil];
    
    //收到退出登陆的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExitLogin) name:@"ExitLogin" object:nil];
   
    /**
     *  检测是否需要更新
     */
//    [self registerMediaNotification];
   
    [self configUI];
    
  
    
    
}

- (void)loginSuccess:(NSNotification *)no
{
    _signBtn.hidden = NO;
    
}

//退出登陆
- (void)ExitLogin
{
    _signBtn.hidden = NO;
    
}

#pragma mark - 设置配置文件
- (void)configUI
{
    self.title = @"首页";
    
    //圆角
    self.TCSearch.layer.masksToBounds = YES;
    self.TCSearch.layer.cornerRadius = 5;
    self.TCSearch.layer.borderColor = [UIColor whiteColor].CGColor;
    self.TCSearch.layer.borderWidth = 1.0;
    
    _dataArray = [[NSMutableArray alloc]init];
    _TCTableView.delegate = self;
    _TCTableView.dataSource = self;
    self.TCTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[_TCTableView registerNib:[UINib nibWithNibName:@"TCHomeCell" bundle:nil] forCellReuseIdentifier:@"TCHomeCell"];
    _page = 1;
    _size = 15;
    
    //下拉刷新
    __weak typeof(self)wself = self;
    _TCTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _page = 1;
        [_dataArray removeAllObjects];
//        [self DeterminethecurrentAppid];
        [wself requestDataBase:_page size:_size];
        
    }];
    
    [_TCTableView.mj_header beginRefreshing];
    //上拉加载
    _TCTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        _page ++;
        [wself requestDataBase:_page size:_size];
    }];
}

/**
 *  当程序进入前台和后台的相关处理
 */
- (void)registerMediaNotification{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(applicationDidEnterForeground:)name:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication]];
    
}

#pragma mark ========== 当程序进入前台时
- (void)applicationDidEnterForeground:(NSNotification *)notification{

//   [self DeterminethecurrentAppid];
}


#pragma mark -判断当前APP版本是否需要更新
- (void)DeterminethecurrentAppid
{
    [RequestEngine UserModulescollegeWithDict:@{@"appid":KMyappid} wAction:@"903" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        NSLog(@"判断当前APP版本是否需要更新%@",errorCode);
        if ([errorCode isEqualToString:@"0"]) {
            
            NSLog(@"%@",resultDict);
            NSArray *arr = (NSArray *)resultDict;
            if (![[arr firstObject][@"appversion"] isEqualToString:@"1.0.2"]) {
                
                UrlString = [arr firstObject][@"downloadurl"];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示！" message:@"发现新版本呢!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"去下载", nil];
                [alertView show];
                 alertView.tag = 10000;
            }
            else
            {
                //保存当前版本号
                [PersonInfo sharePersonInfo].appversion = [arr firstObject][@"appversion"]?[arr firstObject][@"appversion"]:@"1.0.2";
            }
        }else
        {
             [PersonInfo sharePersonInfo].appversion = @"1.0.2";
        }
    }];
}

#pragma mark -点击下载
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UrlString?UrlString:@"http://www.cosfund.com"]];
    }
}

#pragma mark - 请求数据
- (void)requestDataBase:(NSInteger)page size:(NSInteger)size
{
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    NSString *sizeStr = [NSString stringWithFormat:@"%ld",(long)_size];
    //NSDictionary *wParamDict = @{@"page":pageStr,@"size":sizeStr};
    
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:sizeStr,@"size", pageStr,@"page" ,nil];
    [self removeLoadingFailureViewZFJ];
    [self showLoadingViewZFJ];//显示加载动画
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"202" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if (self.TCTableView.mj_header.isRefreshing) {
            
            [self.TCTableView.mj_header endRefreshing];
        }
        if (self.TCTableView.mj_footer.isRefreshing) {
            
            [self.TCTableView.mj_footer endRefreshing];
        }
        
        [self removeLoadingViewZFJ];//移除加载动画
        if([errorCode isEqualToString:@"0"])
        {
            NSLog(@"%@",resultDict);
            [self removeLoadingFailureViewZFJ];
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array)
            {
                HomeModel *model = [[HomeModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            if(_dataArray.count>0)
            {
                if (page == 1) {
                    
                    
                    UIImage *image = [UIImage imageNamed:@"wuxing_banaer"];
                    [_dataArray insertObject:image atIndex:0];
                }
                [self.TCTableView reloadData];
            }
            
            else
            {
                [self showLoadingFailureViewZFJ:@"暂无数据,请稍后再试"];//显示加载失败
            }
        }
        if ([errorCode isEqualToString:@"110"]) {
            //Alert(@"暂无更多数据");
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
    static NSString *cellId = @"TCHomeCell";
    
    TCHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TCHomeCell" owner:nil options:nil]lastObject];
        
    }
    
    if (indexPath.row == 0) {
        
        if (_dataArray.count != 0) {
            /**
             *  第一个cell没有按钮
             */
            for (UIView *view in cell.TCImageView.subviews) {
                
                if ([view isKindOfClass:[UIButton class]]) {
                    
                    [view removeFromSuperview];
                }
            }
            
            //cell.TCImageView.image = _dataArray[indexPath.row];
            
            cell.TCImageView.image = [_dataArray objectAtQYQIndex:indexPath.row];
            
            cell.TCImageView.contentMode = UIViewContentModeScaleToFill;
            cell.clipsToBounds = YES;
            cell.name.text = nil;
        }
    }
    //添加数据源
    else
    {
        if (_dataArray.count>0) {
            cell.model = [_dataArray objectAtQYQIndex:indexPath.row];
            
        }
    }
    
    return cell;
}

#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        ExplainViewController *exVc = [[ExplainViewController alloc] init];
        
        [self.navigationController pushViewController:exVc animated:YES];
    }
    else
    {
        if (![PersonInfo sharePersonInfo].isLogIn) {
            
            LGIndexViewController *lvc = [[LGIndexViewController alloc]init];
            lvc.isPresent = YES;
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
            [self.navigationController presentViewController:nvc animated:YES completion:nil];
            return;
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        TCNewDetailViewController *tvc = [[TCNewDetailViewController alloc]init];
        if (_dataArray.count>0) {
            
           // HomeModel *model = _dataArray[indexPath.row];
            
             HomeModel *model = [_dataArray objectAtQYQIndex:indexPath.row];
             tvc.dreamID = model.dreamID.description;
            tvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.TCSearch.layer.cornerRadius = 35/2;
    self.TCSearch.frame = CGRectMake(18, 18, 35, 35);

}


#pragma mark - 搜索
- (IBAction)TCSearch:(UIButton *)sender
{
    SearchViewController *svc = [[SearchViewController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:svc];
    [self presentViewController:nvc animated:YES completion:nil];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}


//- (void)sentCompletionInformation
//{
//    BOOL isLogIn = [PersonInfo sharePersonInfo].isLogIn;
//    if(isLogIn)
//    {
//        PersonalFileViewController *rvc =[[PersonalFileViewController alloc]init];
//        rvc.isPress = YES;
//        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:rvc];
//        [self presentViewController:nvc animated:YES completion:nil];
//    }
//}


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










- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


//签到的按钮
- (IBAction)signBtnClick:(UIButton *)sender {
    
    if ([PersonInfo sharePersonInfo].isLogIn != YES) {
        
        LGIndexViewController *lvc = [[LGIndexViewController alloc]init];
        lvc.isPresent = YES;
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self.navigationController presentViewController:nvc animated:YES completion:nil];
        
        return;
    }
    
    [self doTask];
    
    //sender.hidden = YES;
}
#pragma mark - 签到的方法
- (void)doTask
{
    __weak typeof(self)wself = self;
    
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"taskid":@"2"};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid",@"2",@"taskid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"108" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if([errorCode isEqualToString:@"4001"])
        {
            //成功获取奖励后，重新刷新钱包金额
           
            wself.signBtn.hidden = YES;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"signSuccess" object:nil];
            
            
            Alert(@"签到成功,已经获取300咖贝奖励");
        }
        
        else if ([errorCode isEqualToString:@"4002"])
        {
            Alert(@"奖励领取异常，联系客服");
        }
        else if ([errorCode isEqualToString:@"4003"])
        {
            Alert(@"任务状态异常，联系客服");
        }
        else if ([errorCode isEqualToString:@"4004"])
        {
            Alert(@"任务逻辑未完成，联系客服");
        }
        else if ([errorCode isEqualToString:@"4005"])
        {
            Alert(@"不满足任务条件，不能领取奖励");
        }
        else if ([errorCode isEqualToString:@"4007"])
        {
            wself.signBtn.hidden = YES;
            
            Alert(@"任务已经完成,不能重复任务");
        }
        else
        {
            NSLog(@"做任务ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            //Alert([ReturnCode getResultFromReturnCode:errorCode]);
            return ;
            
        }
        
    }];

}

@end
