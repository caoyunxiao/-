//
//  WelfareViewController.m
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "WelfareViewController.h"
#import "WelfareCell.h"
#import "WelfareModel.h"
#import "CashBackViewController.h"
#import "LGIndexViewController.h"              //登陆页面

#import "DetailWebViewController.h"            //加载H5页面
@interface WelfareViewController ()

@property (nonatomic, strong) UIView *noLoginView;                //未登陆页面弹出页面

@property (nonatomic, strong) NSMutableArray *dataArray;            //数据源模型

@end

@implementation WelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self uiConfig];
       
   
}

- (void)uiConfig
{
    //去除导航栏影响的
    if (iOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    self.WelfareTableView.delegate = self;
    self.WelfareTableView.dataSource = self;
    [self setExtraCellLineHidden:self.WelfareTableView];
    
//    self.title = @"福利社";
    
    _dataArray = [[NSMutableArray alloc]init];
    

}

#pragma mark - 请求列表数据
- (void)requestDataBase
{
    //NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
      NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    
    NSLog(@"请求列表数据%@",[PersonInfo sharePersonInfo].userId);
    [self showLoadingViewZFJ];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"308" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        [self removeLoadingViewZFJ];
        if([errorCode isEqualToString:@"0"])
        {
            //移除加载失败的动画
            [self removeLoadingFailureViewZFJ];
            NSLog(@"福利社列表%@",resultDict);
            NSArray *resultArr = (NSArray *)resultDict;
            CashBackViewController *cvc =[[ CashBackViewController alloc]init];
            
            [self.navigationController pushViewController:cvc animated:YES];
            for (NSDictionary *dict in resultArr)
            {
                
            }
            if(_dataArray.count>0)
            {
                [self.WelfareTableView reloadData];
            }
            else
            {
                [self showLoadingFailureViewZFJ:@"暂无数据,请稍后再试"];//显示加载失败
            }
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            Alert(@"你还没有返现活动");
        }
        else
        {
            //获取数据失败
            NSLog(@"福利社ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            [self showLoadingFailureViewZFJ:@"加载失败,请下拉刷新一下吧"];//加载失败
        }
    }];
}


#pragma mark - 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
#pragma mark - 创建tableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"WelfareCell";
    WelfareCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WelfareCell" owner:self options:nil]lastObject];
       
        
    }
    [cell configImageWithIndexpath:indexPath];
    
    return cell;
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==0) {
        
        DetailWebViewController *vc = [[DetailWebViewController alloc] init];
        vc.eventURL = @"http://appweb.cosfund.com/indexol.aspx";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    else
    {
        if ([PersonInfo sharePersonInfo].isLogIn != YES) {
            
            [self showLogInViewController];
            
            return;
        }
        
        [self requestDataBase];
        //        CashBackViewController *cvc =[[ CashBackViewController alloc]init];
        //
        //        [self.navigationController pushViewController:cvc animated:YES];
    }
    


}

@end
