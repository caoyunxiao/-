//
//  AnimailToll.m
//  他个头高投入
//
//  Created by qiuyaqingMac on 15/12/3.
//  Copyright © 2015年 TC. All rights reserved.
//

#import "AnimailToll.h"
#import "UIView+Frame.h"

@implementation AnimailToll

- (void)showRewordanimation:(UIView *)view imageName:(NSString *)imageName landscape:(BOOL)landscape
{
    
    UIImageView *leftIamgeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];


    if (landscape) {
        leftIamgeView.center = CGPointMake((view.height - leftIamgeView.height), (view.width - leftIamgeView.width));
    }
    else
    {
        leftIamgeView.center = CGPointMake((view.width - leftIamgeView.width),  (view.height - leftIamgeView.height));
    }
    
    [view addSubview:leftIamgeView];
    
    [UIView animateWithDuration:1.5 animations:^{
        //开始旋转
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        CGRect frame = [leftIamgeView frame];
        leftIamgeView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        leftIamgeView.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
        [CATransaction commit];
        
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
        [CATransaction setValue:[NSNumber numberWithFloat:4.0] forKey:kCATransactionAnimationDuration];
        
        CABasicAnimation *animation;
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0];
        animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
        animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
        animation.delegate = view;
        [leftIamgeView.layer addAnimation:animation forKey:@"rotationAnimation"];
        
        [CATransaction commit];
        
        if (landscape) {
            leftIamgeView.center = CGPointMake(-leftIamgeView.height,  (view.width - leftIamgeView.width));
        }
        else
        {
            leftIamgeView.center = CGPointMake(-leftIamgeView.width,  (view.height - leftIamgeView.height));
        }
        

        
    } completion:^(BOOL finished) {
        
        [leftIamgeView removeFromSuperview];
        
    }];
  
    
   /*hhrthrthrthrthrth*/
}

+ (void)showRewordanimation:(UIView *)view imageName:(NSString *)imageName landscape:(BOOL)landscape
{
    AnimailToll *tool = [[AnimailToll alloc] init];
    
    [tool showRewordanimation:view imageName:imageName landscape:landscape];
    
    
}
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
    if (finished)
    {
        //[self showRewordanimation:<#(UIView *)#> imageName:<#(NSString *)#>]
    }
}

@end
