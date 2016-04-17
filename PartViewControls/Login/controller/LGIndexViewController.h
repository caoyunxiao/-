//
//  LGIndexViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface LGIndexViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;//logo

@property (weak, nonatomic) IBOutlet UIButton *registeredBtn;//注册
- (IBAction)registeredBtnClick:(UIButton *)sender;

- (IBAction)QQClick:(UIButton *)sender;//qq
- (IBAction)WEIXINClick:(UIButton *)sender;//微信


@property (weak, nonatomic) IBOutlet UIButton *LogInBtn;//登录按钮
- (IBAction)LogInBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *imageView;//最下面底层视图

@property (nonatomic,assign) BOOL isPresent;//

- (IBAction)priviteClick:(UIButton *)sender;


@end
