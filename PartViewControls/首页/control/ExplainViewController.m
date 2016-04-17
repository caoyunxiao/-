//
//  ExplainViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ExplainViewController.h"

@interface ExplainViewController ()<UIWebViewDelegate>

@end

@implementation ExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    
}

- (void)configUI
{
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    
    self.title = @"规则介绍";
    _myWebView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://event.cosfund.com/zt/zhuti.html"];
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

@end
