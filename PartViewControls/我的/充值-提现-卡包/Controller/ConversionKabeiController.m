//
//  ConversionKabeiController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ConversionKabeiController.h"

#import "SureExchangeViewController.h"                 //确认充值页面
#import "RatioModle.h"                                 //兑换比率模型

#define kdeaultColor kColor(206, 207, 209)  //206 , 207, 209
#define kselectColor kColor(242 , 244, 245)
@interface ConversionKabeiController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *ratioArr;

@end

@implementation ConversionKabeiController

- (void)viewDidLoad {
    [super viewDidLoad];
/*tggtegergergergerg*/
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    //请求服务器汇率参数
    [self requestDataBase];

    [self conFigUI];
    
}
#pragma mark - 配置文件
- (void)conFigUI
{
    //label的宽度自适应字体的宽度
    self.ruleLabel.adjustsFontSizeToFitWidth = YES;
    self.showLabel.adjustsFontSizeToFitWidth = YES;
    self.inputMoney.delegate = self;
    self.bgScrollerView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*1.4);
    
    [self setuUpViewBoard:self.imputMonery];
    [self setuUpViewBoard:self.showMoney];
    
    //退键盘的方法
    UIControl *control=[[UIControl alloc]initWithFrame:self.view.bounds];
    [self.bgScrollerView addSubview:control];
    [control addTarget:self action:@selector(hideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollerView sendSubviewToBack:control];
    
    //下拉刷新
    _bgScrollerView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
       [self requestDataBase];
        
    }];

}
- (void)hideKeyboard
{
    [_inputMoney resignFirstResponder];
}
#pragma mark - 请求服务器汇率接口(901)
- (void)requestDataBase
{
    _ratioArr = [NSMutableArray array];
    [self showLoadingViewZFJ];
    __weak typeof(self)wself = self;
    [RequestEngine UserModulescollegeWithDict:nil wAction:@"901" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        if (self.bgScrollerView.mj_header.isRefreshing) {
            
            [self.bgScrollerView.mj_header endRefreshing];
        }
        if (self.bgScrollerView.mj_footer.isRefreshing) {
            
            [self.bgScrollerView.mj_footer endRefreshing];
        }

        //移除等待动画
        [wself removeLoadingViewZFJ];
        if([errorCode isEqualToString:@"0"])
        {
            //移除加载失败的动画
            [wself removeLoadingFailureViewZFJ];
            NSArray *array = (NSArray *)resultDict;
            for (NSDictionary *dict in array) {
                
                RatioModle *model = [[RatioModle alloc] init];
                model.max = [dict[@"max"] description];
                model.min = [dict[@"min"] description];
                model.ratio = dict[@"ratio"];
                [_ratioArr addObject:model];
                
            }
            //刷新页面
            [wself conFigUI];
        }
        else
        {
            //获取数据失败
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            [wself showLoadingFailureViewZFJ:@"加载失败,请下拉刷新一下吧"];//加载失败
        }
    }];

}
#pragma mark - 封装计算汇率的方法
- (NSString *)calculateRatio:(NSString *)money
{
    RatioModle *model = [[RatioModle alloc] init];
    
    for (model in _ratioArr) {
        
        if ([money floatValue] >=[model.min floatValue] && [money floatValue]<=[model.max floatValue]) {
            
            return model.ratio;
        }
        
        if ([money floatValue] <100)
        {
            return @"1.0";
        }
    }
    
    return nil;
}

#pragma mark - 设置边框
- (void)setuUpViewBoard:(UIView *)view
{
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1;
}
#pragma mark - 取消所有的选中状态
- (void)cancleSelect
{
    _oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
}
#pragma mark - UITextField的代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self cancleSelect];
    
}
//结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self cancleSelect];

    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:textField.text] floatValue]*100)*[textField.text floatValue]];
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
    
}
#pragma mark - 兑换咖贝
- (IBAction)sureBtnClick:(UIButton *)sender {
    
    if (_inputMoney.text.length <=0) {
        
        Alert(@"输入的金额不能为空");
        return;
        
    }
    //NSLog(@"确认兑换");
    //邱亚青请求兑换咖贝的接口
    NSString *money = [NSString stringWithFormat:@"%.2lf",_inputMoney.text.floatValue];
   // NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId,@"money":money};
     NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid",money,@"money", nil];
    
   // NSLog(@"%@求兑换咖贝的接口",wParamDict);
   // NSLog(@"%@",wParamDict);
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"302" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if([errorCode isEqualToString:@"3100"])
        {
            NSLog(@"%@",resultDict);
            
            //兑换成功请求的接口
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ConversionKabeiSuccess" object:nil];
            
            SureExchangeViewController *sVc = [[SureExchangeViewController alloc] init];
            
            [self.navigationController pushViewController:sVc animated:YES];
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            
            Alert([ReturnCode getResultFromReturnCode:errorCode]);
            
            return ;
        }
    }];

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)oneViewTap:(UITapGestureRecognizer *)sender {
    sender.view.backgroundColor = kdeaultColor;

    //_oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%d",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
    
}
- (IBAction)tenViewTap:(UITapGestureRecognizer *)sender {
    
    sender.view.backgroundColor = kdeaultColor;
    _oneView.backgroundColor = kselectColor;
    //_TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%ld",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
}
- (IBAction)FifteenTap:(UITapGestureRecognizer *)sender {
    
     NSLog(@"%ld",sender.view.tag);
    sender.view.backgroundColor = kdeaultColor;
    _oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    //_FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%ld",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
}
- (IBAction)OneHTap:(UITapGestureRecognizer *)sender {
    
    NSLog(@"%ld",sender.view.tag);
    sender.view.backgroundColor = kdeaultColor;
    _oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    //_OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%ld",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
}
- (IBAction)TwoViewTap:(UITapGestureRecognizer *)sender {
    
    NSLog(@"%ld",sender.view.tag);
    sender.view.backgroundColor = kdeaultColor;
    _oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    //_TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%d",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
}
- (IBAction)threenHTap:(UITapGestureRecognizer *)sender {
    NSLog(@"300元");
    sender.view.backgroundColor = kdeaultColor;
    _oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    //_ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%d",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
}
- (IBAction)fourHTap:(UITapGestureRecognizer *)sender {
    sender.view.backgroundColor = kdeaultColor;
    
    _oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    //_fourHView.backgroundColor = kselectColor;
    _FiveHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%ld",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
}
- (IBAction)fiveHTAp:(UITapGestureRecognizer *)sender {
    
    sender.view.backgroundColor = kdeaultColor;
    _oneView.backgroundColor = kselectColor;
    _TenView.backgroundColor = kselectColor;
    _FifteenView.backgroundColor = kselectColor;
    _OneHSView.backgroundColor = kselectColor;
    _TwoHView.backgroundColor = kselectColor;
    _ThreenHView.backgroundColor = kselectColor;
    _fourHView.backgroundColor = kselectColor;
    
    _inputMoney.text = [NSString stringWithFormat:@"%d",sender.view.tag];
    _showLabel.text = [NSString stringWithFormat:@"%.0f咖贝",([[self calculateRatio:_inputMoney.text] floatValue]*100)*[_inputMoney.text floatValue]];
    
    _ratioLabel.text = [NSString stringWithFormat:@"兑换比率[1:%.0f]",[[self calculateRatio:_inputMoney.text] floatValue]*100];
    
    /*认识他更好让他哈人吐哈人体哈人挺好*/
}
@end
