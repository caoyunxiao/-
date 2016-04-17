//
//  AdViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/15.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*广告启动页面*/

#import <UIKit/UIKit.h>

@interface AdViewController : UIViewController
{
    NSTimer *_myTimer;
    
    int _adTime;
    
    NSString *_resideTime;
    NSString *_adTitle;
    NSString *_uRL;
}
//背景图片
@property (weak, nonatomic) IBOutlet UIImageView *bgIamgeView;


- (IBAction)tapIamgeView:(UITapGestureRecognizer *)sender;
//时间
@property (weak, nonatomic) IBOutlet UILabel *adLabel;


@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

- (IBAction)jump:(UIButton *)sender;

@end
