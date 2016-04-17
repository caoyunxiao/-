//
//  AboutViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
   
    
}

- (void)configUI
{
    self.title = @"关于";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    _bgScrollerView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*1.1);
    
    //_bgScrollerView.bounces = NO;
    _bgScrollerView.showsVerticalScrollIndicator = NO;
    self.versonLabel.text = [NSString stringWithFormat:@"版本号——%@",@"1.0.2"];
    _backSetting.layer.borderWidth = 1;
    _backSetting.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    
    [_backSetting setMyCorner];
    
    [_backSetting addTarget:self action:@selector(backSetting:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}
/**
 *  返回设置页面
 *
 *  @param sender <#sender description#>
 */
- (void)backSetting:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    

    
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
