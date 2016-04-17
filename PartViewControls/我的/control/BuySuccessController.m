//
//  BuySuccessController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BuySuccessController.h"
#import "MycheckViewController.h"


@interface BuySuccessController ()

@end

@implementation BuySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完成";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    [self.backBtn setMyCorner];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backClick:(UIButton *)sender {
    
   
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)checkBtn:(UIButton *)sender {
    

    MycheckViewController *chectVc = [[MycheckViewController alloc] init];

    chectVc.isBuy = YES;
    [self.navigationController pushViewController:chectVc animated:YES];
    
}
@end
