//
//  CashBackResultViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/6.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CashBackResultViewController.h"

@interface CashBackResultViewController ()

@end

@implementation CashBackResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"返现成功";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)backClick:(UIButton *)sender {
    
     [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    
}
@end
