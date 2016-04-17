//
//  PayView.m
//  payView
//
//  Created by 329463417 on 15/10/19.
//  Copyright (c) 2015年 329463417. All rights reserved.
//

#import "PayView.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
// 颜色
#define LCColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface PayView () 
{
    /** 暗黑色的view */
    UIView *_darkView;
    
    /** 所有按钮的底部view */
    UIView *_bottomView;
    

}
@property (nonatomic, strong) UIWindow *backWindow;
@end
@implementation PayView

- (instancetype)init
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
- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
    
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         

                          _backWindow.hidden = YES;
                     }
                     completion:^(BOOL finished) {
    
    
                         
                         [self removeFromSuperview];
                     }];
}

- (void)show {
    
    _backWindow.hidden = NO;
    
    
                         [_darkView setAlpha:0.8f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                          [_bottomView setFrame:CGRectMake(0, 100, SCREEN_SIZE.width, 404/(SCREEN_SIZE.height/667))];
    
    _payPopupView.bounds = CGRectMake(0, 0, 0.8*SCREEN_SIZE.width, 0.90*SCREEN_SIZE.width);
    _payPopupView.center = CGPointMake(SCREEN_SIZE.width*0.50, SCREEN_SIZE.height*0.5);
    
    

}



@end



















