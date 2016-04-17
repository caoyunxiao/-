//
//  ContactSeverViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ContactSeverViewController.h"

@interface ContactSeverViewController ()

@end

@implementation ContactSeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"联系客服";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    [self.callBtn setMyCorner];
    
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

- (IBAction)call:(UIButton *)sender {
    
     NSString *allString = [NSString stringWithFormat:@"tel:4009669200"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];

}
@end
