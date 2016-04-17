//
//  PriviteViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/11.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "PriviteViewController.h"

@interface PriviteViewController ()<UIWebViewDelegate>

@end

@implementation PriviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI
{
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    self.title = @"隐私条款";
    _myWebView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://appweb.cosfund.com/xy/agreement.html"];
    //加载H5页面
    if (url>0) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_myWebView loadRequest:request];
    }
    
    
    
}


#pragma mark - UIWebViewDelegate的协议方法
//网页加载失败调用的方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[MBProgressHUD hideHUD];
    [self removeLoadingViewZFJ];
    
    Alert(@"网页加载失败");
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[MBProgressHUD hideHUD];
    
    [self removeLoadingViewZFJ];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[MBProgressHUD showMessage:@"页面加载中"];
    [self showLoadingViewZFJ];
    
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
