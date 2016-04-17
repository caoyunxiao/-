//
//  RightDownView.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/20.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightDownView : UIView

@property (weak, nonatomic) IBOutlet UIView *RDView;
@property (weak, nonatomic) IBOutlet UIButton *ShowDanmu;//打开关闭弹幕
@property (weak, nonatomic) IBOutlet UILabel *MYKaBei;//我的咖贝
@property (weak, nonatomic) IBOutlet UIButton *GoTopUp;//去充值

@property (weak, nonatomic) IBOutlet UIView *DanMuView;//弹幕
- (IBAction)DanMuViewClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *rankingView;//排行榜

@property (nonatomic,strong) NSTimer *timer;//定时器
@property (nonatomic,strong) NSArray *titltArr;
@property (nonatomic,strong) NSMutableArray *labelArr;

@property (weak, nonatomic) IBOutlet UIView *DownView;

@property (nonatomic,assign) BOOL isShow;


@property (weak, nonatomic) IBOutlet UIButton *OneButton;//1
@property (weak, nonatomic) IBOutlet UIButton *FiveButton;//5
@property (weak, nonatomic) IBOutlet UIButton *TenBUtton;//10
@property (weak, nonatomic) IBOutlet UIButton *OneHundredButton;//100
@property (weak, nonatomic) IBOutlet UIButton *OneThousandButton;//1000
@property (weak, nonatomic) IBOutlet UIButton *AKeyButton;//一键
@property (weak, nonatomic) IBOutlet UIButton *BigButton;











@end
