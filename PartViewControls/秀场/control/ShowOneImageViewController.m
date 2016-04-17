//
//  ShowOneImageViewController.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ShowOneImageViewController.h"

@interface ShowOneImageViewController ()

@end

@implementation ShowOneImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uiConfig];
    [self setBackButtonWithisPush:NO AndViewcontroll:self];
}

- (void)uiConfig
{
    self.navigationController.navigationBarHidden = YES;
    self.ShowBigImage.image = self.bigImage;
    self.ShowBigImage.contentMode = UIViewContentModeScaleAspectFill;
    self.ShowBigImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [self.ShowBigImage addGestureRecognizer:tap];
}

- (void)singleTap:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
