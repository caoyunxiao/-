//
//  AdWebViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/7.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "AdWebViewController.h"
#import "TCRootTool.h"

@interface AdWebViewController ()<UIWebViewDelegate>

@end

@implementation AdWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
    
}

- (void)configUI
{
    //设置返回按钮
    [self setBackBtn];
    _myWebView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.URL];
    //加载H5页面
    if (url>0) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_myWebView loadRequest:request];
    }
    
    
    
}

//创建返回按钮
- (void)setBackBtn
{
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"TCBack"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)backBtnClick:(UIButton *)btn
{
    [TCRootTool chooseRootViewController:TCKeyWindow];
    
}
#pragma mark - UIWebViewDelegate的协议方法
//网页加载失败调用的方法
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
   // [MBProgressHUD hideHUD];
   
    [self removeLoadingViewZFJ];
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
