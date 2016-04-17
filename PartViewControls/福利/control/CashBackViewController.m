//
//  CashBackViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CashBackViewController.h"
#import "CashBackCell.h"
#import "CashBackTwoViewController.h"
#import "IfCaseModel.h"                  //返现模型

@interface CashBackViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSMutableArray *dataArray;


@end

@implementation CashBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uiConfig];
    //[self requestIfCaseData];
    
}
#pragma mark - 配置文件
- (void)uiConfig
{
    //_dataArray = [[NSMutableArray alloc]init];
    self.CashBackTableView.delegate = self;
    self.CashBackTableView.dataSource = self;
    
    self.CashBackTableView.tableFooterView = [[UIView alloc] init];
    
    self.title = @"活动返现";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
}
#pragma mark - viewVillAppear
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self requestIfCaseData];
}
#pragma mark - 读取返现的接口
- (void)requestIfCaseData
{
    _dataArray = [[NSMutableArray alloc]init];
    __weak typeof(self)wself = self;
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"308" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if([errorCode isEqualToString:@"0"])
        {
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array) {
                
                IfCaseModel *model = [[IfCaseModel alloc] init];
                model.amount = [dict[@"amount"] description];
                model.kabei = [dict[@"kabei"] description];
                model.orderSN = [dict[@"orderSN"] description];
                
                model.payTime = dict[@"payTime"] ;
                [wself.dataArray addObject:model];
                
            }
            [wself.CashBackTableView reloadData];
            NSLog(@"是否返现%@",resultDict);
           
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
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
    return 44;
}

#pragma mark - 创建tableView的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"CashBackCell";
    CashBackCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CashBackCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //IfCaseModel *model = _dataArray[indexPath.row];
    
    IfCaseModel *model = [_dataArray objectAtQYQIndex:indexPath.row];
    
    NSString *name = [NSString stringWithFormat:@"Runningman活动返现金额%@",model.amount];
    
    cell.nameLabel.text = name;
  
    return cell;
}
#pragma mark - 选中tableView的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳到支付宝返现页面
    
    CashBackTwoViewController *cashTwoVc = [[CashBackTwoViewController alloc] init];
    
    IfCaseModel *model = [_dataArray objectAtQYQIndex:0];
    
    cashTwoVc.ordersn = model.orderSN;
    
    
    [self.navigationController pushViewController:cashTwoVc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
