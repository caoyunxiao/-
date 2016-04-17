//
//  RechargeViewController.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "RechargeViewController.h"

#import "payPopupView.h"                         //支付页面

#import "PayView.h"
#import "GBAlipayManager.h"                     //支付宝支付的方法
#import "GBAlipayConfig.h"                      //支付宝头文件
#import "GBWXPayManager.h"                      //微信支付的方法
#import "GBWXPayManagerConfig.h"                //微信头文件

#import "PayModel.h"                            //支付模型

#define kselectColor kColor(211, 209, 209)
#define kdefauleColor kColor(242, 244, 245)
@interface RechargeViewController ()<payPopupViewDelegate>

@property (nonatomic, copy) NSString *trandNO;           //订单号

@property (nonatomic, copy) NSString *amountSever;       //服务器返回的充值金额

@property (nonatomic, strong) PayView *pay;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"充值";
    
    [self setBackButtonWithisPush:YES AndViewcontroll:self];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.bgScroller addGestureRecognizer:tapGestureRecognizer];
    //设置滚动视图的范围
    self.bgScroller.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*1.4);
    
    [self setuUpViewBoard:self.inputView];
    
    //注册监听支付支付成功的回调方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealAlipayResult:) name:@"alipayResult" object:nil];
    
    
    //注册监听-微信支付成功的回调方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dealWXpayResult:) name:@"WXpayresult" object:nil];
}
#pragma mark - 退出键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_rechargreTextField resignFirstResponder];
}
#pragma mark - 视图添加边框
- (void)setuUpViewBoard:(UIView *)view
{
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1].CGColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)oneYuanClick:(UIButton *)sender {
    sender.backgroundColor = kselectColor;
    
    _tenYuanBtn.backgroundColor = kdefauleColor;
    _fifYuanBtn.backgroundColor = kdefauleColor;
    _oneHBtn.backgroundColor = kdefauleColor;
    _twoHBtn.backgroundColor = kdefauleColor;
    _threeHYuanBtn.backgroundColor = kdefauleColor;
    _fourHBtn.backgroundColor = kdefauleColor;
    _fiveHBtn.backgroundColor = kdefauleColor;
    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
}

- (IBAction)tenYuanClick:(UIButton *)sender
{
    sender.backgroundColor = kselectColor;
    
    _oneYuanBtn.backgroundColor = kdefauleColor;

    _fifYuanBtn.backgroundColor = kdefauleColor;
    _oneHBtn.backgroundColor = kdefauleColor;
    _twoHBtn.backgroundColor = kdefauleColor;
    _threeHYuanBtn.backgroundColor = kdefauleColor;
    _fourHBtn.backgroundColor = kdefauleColor;
    _fiveHBtn.backgroundColor = kdefauleColor;
    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
    
}

- (IBAction)fifYuanClick:(UIButton *)sender {
    sender.backgroundColor = kselectColor;
    
    _oneYuanBtn.backgroundColor = kdefauleColor;
    _tenYuanBtn.backgroundColor = kdefauleColor;
    _oneHBtn.backgroundColor = kdefauleColor;
    _twoHBtn.backgroundColor = kdefauleColor;
    _threeHYuanBtn.backgroundColor = kdefauleColor;
    _fourHBtn.backgroundColor = kdefauleColor;
    _fiveHBtn.backgroundColor = kdefauleColor;
    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
}

- (IBAction)oneHClick:(UIButton *)sender
{
    sender.backgroundColor = kselectColor;
    _oneYuanBtn.backgroundColor = kdefauleColor;
    _tenYuanBtn.backgroundColor = kdefauleColor;
    _fifYuanBtn.backgroundColor = kdefauleColor;

    _twoHBtn.backgroundColor = kdefauleColor;
    _threeHYuanBtn.backgroundColor = kdefauleColor;
    _fourHBtn.backgroundColor = kdefauleColor;
    _fiveHBtn.backgroundColor = kdefauleColor;
    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
}

- (IBAction)twoHClick:(UIButton *)sender
{
    sender.backgroundColor = kselectColor;
    _oneYuanBtn.backgroundColor = kdefauleColor;
    _tenYuanBtn.backgroundColor = kdefauleColor;
    _fifYuanBtn.backgroundColor = kdefauleColor;
    _oneHBtn.backgroundColor = kdefauleColor;
  
    _threeHYuanBtn.backgroundColor = kdefauleColor;
    _fourHBtn.backgroundColor = kdefauleColor;
    _fiveHBtn.backgroundColor = kdefauleColor;
    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
}

- (IBAction)threeHBtnClick:(UIButton *)sender {
    
    sender.backgroundColor = kselectColor;
    _oneYuanBtn.backgroundColor = kdefauleColor;
    _tenYuanBtn.backgroundColor = kdefauleColor;
    _fifYuanBtn.backgroundColor = kdefauleColor;
    _oneHBtn.backgroundColor = kdefauleColor;
    _twoHBtn.backgroundColor = kdefauleColor;
 
    _fourHBtn.backgroundColor = kdefauleColor;
    _fiveHBtn.backgroundColor = kdefauleColor;
    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
}

- (IBAction)fourBtnClick:(UIButton *)sender {
    
    sender.backgroundColor = kselectColor;
    _oneYuanBtn.backgroundColor = kdefauleColor;
    _tenYuanBtn.backgroundColor = kdefauleColor;
    _fifYuanBtn.backgroundColor = kdefauleColor;
    _oneHBtn.backgroundColor = kdefauleColor;
    _twoHBtn.backgroundColor = kdefauleColor;
    _threeHYuanBtn.backgroundColor = kdefauleColor;
  
    _fiveHBtn.backgroundColor = kdefauleColor;
    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
}

- (IBAction)fiveHBtnClick:(UIButton *)sender
{
    sender.backgroundColor = kselectColor;
    _oneYuanBtn.backgroundColor = kdefauleColor;
    _tenYuanBtn.backgroundColor = kdefauleColor;
    _fifYuanBtn.backgroundColor = kdefauleColor;
    _oneHBtn.backgroundColor = kdefauleColor;
    _twoHBtn.backgroundColor = kdefauleColor;
    _threeHYuanBtn.backgroundColor = kdefauleColor;
    _fourHBtn.backgroundColor = kdefauleColor;

    
    NSString *accountText = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    _rechargreTextField.text = accountText;
}

#pragma mark - 点击立即支持，进入立即支持页面
- (IBAction)supportClick:(UIButton *)sender {
  
    if (self.rechargreTextField.text.length<=0||self.rechargreTextField.text.floatValue<=0) {
        Alert(@"您输入的金额非法");
        
        return;
    }

    
    //显示支付页面
    _pay = [[PayView alloc] init];
    //指定支付页面的代理
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"payPopupView" owner:nil options:nil];
    
    payPopupView *bottomView = [array firstObject];
    
    self.selectAlipayBtn = bottomView.selectAlipayBTn;
    self.selectWixinBtn = bottomView.selectweixinBtn;
    self.selectAlipayBtn.selected  = YES;
    //按钮的点击方法
    [bottomView.disMissBtn addTarget:self action:@selector(payPopupViewDisMissClick:) forControlEvents:UIControlEventTouchUpInside];
    //点击支付宝支付
    [bottomView.selectAlipayBTn addTarget:self action:@selector(payPopupViewaliPaySelectClick:) forControlEvents:UIControlEventTouchUpInside];
    //点击微信支付
    [bottomView.selectweixinBtn addTarget:self action:@selector(payPopupViewweixinPaySelect:) forControlEvents:UIControlEventTouchUpInside];
    //点击立即支付
    [bottomView.payOnceBtn addTarget:self action:@selector(payPopupViepayOnceClick:) forControlEvents:UIControlEventTouchUpInside];
    
    bottomView.amoutLabel.text = [NSString stringWithFormat:@"%@元",self.rechargreTextField.text];
    
    bottomView.delegate =self;
    
    _pay.payPopupView =  bottomView;
    
    [_pay addSubview:_pay.payPopupView];
    
    [_pay show];
    
}
//点击删除按钮退出的方法
- (void)payPopupViewDisMissClick:(UIButton *)sender
{
    [(PayView *)sender.superview.superview dismiss:nil];
}
//点击支付宝支付
- (void)payPopupViewaliPaySelectClick:(UIButton *)sender
{
 
    self.selectAlipayBtn.selected = YES;
    
    self.selectWixinBtn.selected = NO;
}
//点击微信支付
- (void)payPopupViewweixinPaySelect:(UIButton *)sender
{

    self.selectAlipayBtn.selected = NO;
    self.selectWixinBtn.selected = YES;
    
   
}
//点击立即支付
- (void)payPopupViepayOnceClick:(UIButton *)sender
{
    //退出视图
      [_pay dismiss:nil];
   
        if (_selectAlipayBtn.selected == YES)
        {
            
            [self postDataMoney:self.rechargreTextField.text userid:[PersonInfo sharePersonInfo].userId payType:@"1" returnurl:@"1"];
            
        }
        //选择微信充值
        else
        {
            if ([WXApi isWXAppInstalled] == YES) {
                [self postDataMoney:self.rechargreTextField.text userid:[PersonInfo sharePersonInfo].userId payType:@"2" returnurl:@"1"];
            }

            else{
                Alert(@"您的手机未安装微信,请选择其他支付方式，或前往AppStore下载安装微信");
                
            }
            
        }

}


#pragma mark - 请求公司服务器支付参数
- (void)postDataMoney:(NSString *)money userid:(NSString *)userid payType:(NSString *)payType returnurl:(NSString *)returnurl
{
    //请求接口
    NSDictionary *wParamDict = @{@"money":money,@"userid":userid,@"paytype":payType,@"returnurl":returnurl};
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"300" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if([errorCode isEqualToString:@"3006"])
        {
            //请求成功，在此解析数据
            NSArray *dataArr = (NSArray *)resultDict;
            PayModel *payModel = [[PayModel alloc] init];
            for (NSDictionary *payDict in dataArr) {
                
                [payModel setValuesForKeysWithDictionary:payDict];
                
                self.amountSever = payModel.amount.description;
                self.trandNO = payModel.tradeNO;
            }
            
            
            if ([payType isEqualToString:@"1"]) {
#warning 邱亚青金额需改成真是金额
                [GBAlipayManager alipayWithPartner:payModel.partner seller:SellerID tradeNO:payModel.tradeNO productName:@"咖贝充值" productDescription:@"咖贝充值" amount:self.amountSever notifyURL:NOTIFY_URL itBPay:payModel.itBPay];
            }
            if ([payType isEqualToString:@"2"]) {
                
                //NSLog(@"微信支付%@",self.amountSever);
                //邱亚青微信支付
                NSString *amount = [NSString stringWithFormat:@"%.2f",[self.amountSever floatValue]];
                
                //NSLog(@"邱亚青微信支付%@",amount);
                
                [GBWXPayManager wxpayWithOrderID:payModel.tradeNO orderTitle:@"咖范咖币充值" amount:amount sellerID:MCH_ID appID:APP_ID partnerID:PARTNER_ID];
                
                //[GBWXPayManager wxpayWithOrderID:payModel.tradeNO orderTitle:@"咖范咖币充值" amount:amount];
                
            }
        }
        else
        {
            NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            Alert(@"请求支付失败");
            
            return ;
        }
    }];
    
    
}
#pragma mark - 支付宝传回的通知结果
-(void)dealAlipayResult:(NSNotification*)notification{
    
    //NSLog(@"收到支付成功的通知");
    NSString*result=notification.object;
    
    if([result isEqualToString:@"9000"]){
        //NSLog(@"支付宝支付成功");
        
        //调用服务器充值接口
        NSDictionary *wParamDict = @{@"ordersn":self.trandNO,@"money":_amountSever};
        
       // NSLog(@"订单号%@------%@金额",self.trandNO,_amountSever);
        
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"301" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            
            if([errorCode isEqualToString:@"3100"])
            {
                Alert(@"充值成功");
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"rechageSuccess" object:nil];
            }
            else
            {
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
                
                //邱亚青系统异常
                Alert([ReturnCode getResultFromReturnCode:errorCode]);
                
                return ;
            }
        }];
        
        
        
    }else{
        
        NSLog(@"支付宝支付失败");
        Alert(@"支付宝支付失败");
        
    }
}

#pragma mark - 微信支付成功的通知
-(void)dealWXpayResult:(NSNotification*)notification{
    NSString*result=notification.object;
    if([result isEqualToString:@"1"]){
        
        NSLog(@"微信支付成功");
        
        //调用服务器充值接口
        NSDictionary *wParamDict = @{@"ordersn":self.trandNO,@"money":_amountSever};
        
        
        [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"301" completed:^(NSString *errorCode, NSDictionary *resultDict) {
            
            if([errorCode isEqualToString:@"3100"])
            {
                Alert(@"充值成功");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"rechageSuccess" object:nil];
            }
            else
            {
                NSLog(@"ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
                
                //邱亚青系统异常
                Alert([ReturnCode getResultFromReturnCode:errorCode]);
                
                return ;
            }
        }];
        
        
        
    }else{
        NSLog(@"微信支付失败");
    }
    
    
    
}


#pragma mark - 视图将要出现的时候
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark - 移除通知
-(void)dealloc{
    
    NSLog(@"通知被移除了");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
/*二个人个人感情而过去而过去而过去而*/
@end
