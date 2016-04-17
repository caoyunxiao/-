//
//  AdViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/15.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "AdViewController.h"
#import "AdWebViewController.h"     //广告介绍页面
#import "UIImageView+WebCache.h"    //网络下载图片

#import "TCRootTool.h"
@interface AdViewController ()

@end

@implementation AdViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [_myTimer invalidate];
    _myTimer = nil;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //请求光该数据
    [self conFigUI];
    
    [self requestDataBaseForAd];
    
    
}

#pragma mark - 配置文件
- (void)conFigUI
{
    _jumpBtn.layer.borderWidth = 1;
    _jumpBtn.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    _jumpBtn.layer.masksToBounds = YES;
    _jumpBtn.layer.cornerRadius = 5;
}

#pragma mark - 启动广告
- (void)requestDataBaseForAd
{
    __weak typeof(self)wself = self;
    

     _myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ADTimer) userInfo:nil repeats:YES];
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:@"100",@"fromcode", nil];
    
    [RequestEngine QyqModulescollegeWithDict:wParamDict wAction:@"904" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        NSLog(@"启动广告%@",resultDict);
        if([errorCode isEqualToString:@"0"])
        {
            NSArray *array = (NSArray *)resultDict;
            
            NSDictionary *dict = [array objectAtQYQIndex:0];
            /* cover = Cover;
             resideTime = 5;
             title = Test;
             uRL = "baidu.com";*/
            _uRL = [dict[@"uRL"] description];
            
            _adTime = (int)[[dict[@"resideTime"]description] integerValue];
            
            NSString *cover = [dict[@"cover"] description];
            
            [wself.bgIamgeView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:cover]] placeholderImage:[UIImage imageNamed:@"new_feature_4-568h@2x"]];
            
            
                 }
        else
        {
            //获取数据失败
            NSLog(@"启动广告ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            [wself.bgIamgeView setImage:[UIImage imageNamed:@"new_feature_4-568h@2x"]];
            
            _adTime = 5;
            
            return ;
            
            // Alert([ReturnCode getResultFromReturnCode:errorCode]);
        }
        
    }];
    
    
    
}

//时间方法
- (void)ADTimer
{
    NSString *string = [NSString stringWithFormat:@"剩余时间%d秒",_adTime];
    _adLabel.text = string;
    if (_adTime == 0)
    {
        
        [TCRootTool chooseRootViewController:TCKeyWindow];
        
        [_myTimer invalidate];
        _myTimer = nil;
    }
    _adTime--;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tapIamgeView:(UITapGestureRecognizer *)sender {
    
    
    AdWebViewController *adwebVc = [[AdWebViewController alloc] init];
    
  
    if (_uRL == nil) {
        adwebVc.URL = @"http://event.cosfund.com/zt/zhuti.html";
    }
    else{
        adwebVc.URL = _uRL;
    }
    [self.navigationController pushViewController:adwebVc animated:YES];
    
    
    /*给比尔太笨淘宝特别特别特别*/
    
}

//点击跳过
- (IBAction)jump:(UIButton *)sender {
    
     [TCRootTool chooseRootViewController:TCKeyWindow];
}


@end
