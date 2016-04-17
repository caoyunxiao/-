//
//  Created by 刘超 on 15/4/26.
//  Copyright (c) 2015年 Leo. All rights reserved.
//
//  Email:  leoios@sina.com
//  GitHub: http://github.com/LeoiOS
//  如有问题或建议请给我发Email, 或在该项目的GitHub主页lssues我, 谢谢:)
//

#import "LCActionSheet.h"

// 屏幕尺寸
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
// 颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface LCActionSheet ()
{
    
  /** 暗黑色的view */
    UIView *_darkView;
    
}

@property (nonatomic, strong) UIWindow *backWindow;


@end

@implementation LCActionSheet



- (instancetype)initWithView:(UIView *)buydownView;
{
    if (self = [super init]) {
        UIView *darkView = [[UIView alloc] init];
        [darkView setAlpha:0];
        [darkView setUserInteractionEnabled:NO];
        [darkView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [darkView setBackgroundColor:LCColor(46, 49, 50)];
        [self addSubview:darkView];
        _darkView = darkView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [darkView addGestureRecognizer:tap];
        
        //_buyDownView = [[[NSBundle mainBundle]loadNibNamed:@"BuyDownView" owner:nil options:nil] lastObject];
        _buyDownView = buydownView;
        //buydownView.backgroundColor = TCColor;
        [self addSubview:_buyDownView];
        
        [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [self.backWindow addSubview:self];
    }
    
    return self;
}

- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}


- (void)dismiss
{
    [self dismiss:nil];
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _buyDownView.frame;
                         frame.origin.y += frame.size.height;
                         [_buyDownView setFrame:frame];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         _backWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                     }];
}


- (void)show {
    
    _backWindow.hidden = NO;
    _buyDownView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 240);
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.8f];
                         [_darkView setUserInteractionEnabled:YES];

                         _buyDownView.frame = CGRectMake(0, ScreenHeight-240, ScreenWidth, 240);
                     }
                     completion:nil];
    
    
    
}

@end
