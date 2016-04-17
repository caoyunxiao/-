//
//  SureSuessController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SureSuessController.h"

@interface SureSuessController ()

@end

@implementation SureSuessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"完成";
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
   
    [self.backBtn setMyCorner];
    /*沐浴乳么投影机额头有金额投影机**/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    /*进 的fge分vbevbevervwjrgjsdfo0他不iykruy6kuykj让他不会让他把isdfo的  第三方违反水电费第三方是打发我的飞*/
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
    
    //[self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedIndex" object:@(5)];
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
    
    
    
    /*分二个如果v让我体会不让我体会认同和别人挺好他 ergergerergerg反而更v二个人个人股二个人了让各位如果阿胶可怜人够了可感觉而过而 */
    
}
@end
