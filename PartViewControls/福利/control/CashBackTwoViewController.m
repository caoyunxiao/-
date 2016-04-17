//
//  CashBackTwoViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/6.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CashBackTwoViewController.h"
#import "CaseBackThreeViewController.h"      //提现的视图控制器


@interface CashBackTwoViewController ()

@end

@implementation CashBackTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}
#pragma mark - 配置文件
- (void)configUI
{
    self.title = @"支付宝返现";
    
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    self.bgScrollerView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*1.1);
    UIControl *control=[[UIControl alloc]initWithFrame:self.view.bounds];
    [self.bgScrollerView addSubview:control];
    [control addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollerView sendSubviewToBack:control];
    
    
}

- (void)hideKeyboard
{
    [self.alipayAccountLabel resignFirstResponder];
    [self.alipayUserNameLabel resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Case:(id)sender {
    
    if (_alipayAccountLabel.text.length<=0) {
        Alert(@"支付宝账号为空")
        return;
    }
    
    if (_alipayUserNameLabel.text.length <=0) {
        Alert(@"支付宝用户名为空");
        return;
    }
    
    
    CaseBackThreeViewController *caVc = [[CaseBackThreeViewController alloc] init];
    
    caVc.alipayAccount = _alipayAccountLabel.text;
    caVc.aliUseName = _alipayUserNameLabel.text;
    caVc.ordersn = _ordersn;
    [self.navigationController pushViewController:caVc animated:YES];
    

}

@end










