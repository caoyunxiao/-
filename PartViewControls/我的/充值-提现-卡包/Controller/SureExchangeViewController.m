//
//  SureExchangeViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SureExchangeViewController.h"


@interface SureExchangeViewController ()

@end

@implementation SureExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"兑换应成功";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  返回我的钱包
 *
 *  @param sender <#sender description#>
 */
- (IBAction)backMymoney:(UIButton *)sender {
    

    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*如果他不而他本人特别特别让他把*/
@end
