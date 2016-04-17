//
//  RegisterSuccessViewController.m
//  CosFund
//
//  Created by 张福杰 on 15/11/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "TCHomeViewController.h"
#import "PersonalFileViewController.h"


@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Gototchomeview.layer.borderWidth = 1.0f;
    self.Gototchomeview.layer.borderColor = [UIColor redColor].CGColor;
    self.title = @"注册完成";
}


#pragma mark -去完善个人资料或者去个人主页
- (IBAction)GotolisthomeAnddata:(UIButton *)sender {
    
    [PersonInfo sharePersonInfo].isLogIn = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
    if (sender.tag == 100) {

        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedIndex" object:@(0)];

    }
    else if (sender.tag == 101)
    {
       
        [PersonInfo sharePersonInfo].isLogIn = YES;
        PersonalFileViewController *person = [[PersonalFileViewController alloc]init];
        person.isBackhome = YES;
        [self.navigationController pushViewController:person animated:YES];
    }
}


@end
