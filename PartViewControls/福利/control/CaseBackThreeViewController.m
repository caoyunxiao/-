//
//  CaseBackThreeViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/6.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CaseBackThreeViewController.h"
#import "CashBackResultViewController.h"

@interface CaseBackThreeViewController ()<UIAlertViewDelegate>

@end

@implementation CaseBackThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"确认提现";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    _alipayaccountLabel.text = [NSString stringWithFormat:@"支付宝账号:%@",_alipayAccount];
    _aliUserNameLabel.text = [NSString stringWithFormat:@"支付宝用户名:%@",_aliUseName];
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
#pragma mark - 请求提现的接口
- (void)requestDataBase
{
    
//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"ordersn":_ordersn,@"alipayname":_aliUseName,@"alipayid":_alipayAccount};
    
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid",_ordersn,@"ordersn",_aliUseName,@"alipayname",_alipayAccount,@"alipayid", nil];
    //NSLog(@"请求提现的接口%@",wParamDict);
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"309" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        //NSLog(@"请求提现的接口errorCode%@",errorCode);
        if([errorCode isEqualToString:@"1400"])
        {
            //NSLog(@"支付宝提取现金%@",resultDict);
            CashBackResultViewController *caseVc = [[CashBackResultViewController alloc] init];
            [self.navigationController pushViewController:caseVc animated:YES];
            
        }
       else if ([errorCode isEqualToString:@"1401"]) {
            
            Alert(@"返现失败");
            
        }
        else if ([errorCode isEqualToString:@"1402"]) {
            
            Alert(@"返现已经领取");
            
        }
        else
        {
            //获取数据失败
            //NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            //Alert([ReturnCode getResultFromReturnCode:errorCode]);
        }
    }];
    

}

//确认提现
- (IBAction)sureCase:(UIButton *)sender {
    
    UIAlertView *alevew = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请确认账号无误!费用返还此账号，将无法撤销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alevew show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [self requestDataBase];
    }
}
@end
