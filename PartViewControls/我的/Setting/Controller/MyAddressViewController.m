//
//  MyAddressViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "MyAddressViewController.h"
//#import "AddressModle.h"                   //收货地址数据模型

@interface MyAddressViewController ()

//@property (nonatomic, strong) AddressModle *model;   //地址模型

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    [self getData];
    [self uiConfig];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 请求数据
- (void)getData
{
    [self showLoadingViewZFJ];
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    __weak typeof(self) wself = self;
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"115" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        [wself removeLoadingViewZFJ];
        if([errorCode isEqualToString:@"0"])
        {
            
            NSArray *array = (NSArray *)resultDict;
            NSDictionary *dict = array[0];
            wself.consigneeTexitField.text = dict[@"name"];
            wself.adressTextField.text = dict[@"addr"];
            wself.phoneTextField.text = dict[@"mobile"];

            if ([[dict[@"gender"] description] isEqualToString:@"0"]) {
                
                self.manBtn.selected = YES;
                self.womanBtn.selected = NO;
            }
            if ([[dict[@"gender"] description] isEqualToString:@"1"]) {
                
                self.womanBtn.selected = YES;
                self.manBtn.selected = NO;
            }
            wself.postcodeTextField.text = dict[@"zipCode"];

        }
        else if([errorCode isEqualToString:@"110"])
        {
            Alert(@"你还没有地址信息,请添加并保存您的地址信息");
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
        
        }
    }];

}
#pragma mark - 界面布局
- (void)uiConfig
{
    //消除导航栏的影响
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.title = @"我的地址";
    //设置背景View的边框
    [self setuUpViewBoard:self.consigneeView];
    
    [self setuUpViewBoard:self.addressView];
    
    [self setuUpViewBoard:self.phoneView];
    
    [self setuUpViewBoard:self.postcodeView];
    self.saveBtn.layer.cornerRadius = 2;
    self.saveBtn.layer.masksToBounds = YES;
    
    
    
    
    
    
}

//抽方法
- (void)setuUpViewBoard:(UIView *)view
{
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1;
}
- (IBAction)saveClick:(UIButton *)sender {
    
    if (_consigneeTexitField.text.length <=0) {
        Alert(@"收货人不能为空");
        
        return;
    }
    if (_adressTextField.text.length <=0) {
        Alert(@"收货地址不能为空");
        return;
    }
    
    if (![HENLENSONG isValidateMobile:self.phoneTextField.text])
    {
        Alert(@"请输入正确的手机号码");
        return;
    }
    
    
    if (_postcodeTextField.text.length ==0) {
        Alert(@"请输入你的邮编");
        return;
    }

    
    NSString *genderSrt = nil;
    
    if (self.manBtn.selected == YES) {
        genderSrt = @"0";
    }
    if (self.womanBtn.selected == YES) {
        genderSrt = @"1";
    }
   /*
    userid
    name
    mobile
    addr
    zip
    gender
    */
    
    //[self showLoadingViewZFJ];
//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"name":self.consigneeTexitField.text,@"mobile":self.phoneTextField.text,@"addr":self.adressTextField.text,@"zip":self.postcodeTextField.text,@"gender":genderSrt};
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid",self.consigneeTexitField.text,@"name",self.phoneTextField.text,@"mobile",self.adressTextField.text,@"addr",self.postcodeTextField.text,@"zip",genderSrt,@"gender" ,nil];
    //NSLog(@"收货地址参数%@",wParamDict);
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"110" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if([errorCode isEqualToString:@"0"])
        {
            
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"AddressSrttingSuccess" object:nil];
            
            [self SHOWPrompttext:@"设置地址成功"];
            
            //[self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"收货地址设置失败");
        }
    }];
    

    
}
- (IBAction)manBtnClick:(UIButton *)sender {
    sender.selected = YES;
    
    self.womanBtn.selected = NO;
    
}
- (IBAction)womanBtnClick:(UIButton *)sender {
    
    sender.selected = YES;
    
    self.manBtn.selected = NO;
}
@end
