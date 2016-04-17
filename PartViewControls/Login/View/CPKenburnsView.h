//
//  CPKenburnsView.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CPKenburnsImageViewState) {
    CPKenburnsImageViewStateAnimating,
    CPKenburnsImageViewStatePausing
};

typedef NS_ENUM(NSInteger, CPKenburnsImageViewZoomCourse) {
    CPKenburnsImageViewZoomCourseRandom                = 0,
    CPKenburnsImageViewZoomCourseUpperLeftToLowerRight = 1,
    CPKenburnsImageViewZoomCourseUpperRightToLowerLeft = 2,
    CPKenburnsImageViewZoomCourseLowerLeftToUpperRight = 3,
    CPKenburnsImageViewZoomCourseLowerRightToUpperLeft = 4
};
typedef NS_ENUM(NSInteger, CPKenburnsImageViewZoomPoint) {
    CPKenburnsImageViewZoomPointLowerLeft  = 0,
    CPKenburnsImageViewZoomPointLowerRight = 1,
    CPKenburnsImageViewZoomPointUpperLeft  = 2,
    CPKenburnsImageViewZoomPointUpperRight = 3
};

@interface CPKenburnsImageView : UIImageView

@end

@interface CPKenburnsView : UIView

@property (nonatomic, strong) CPKenburnsImageView * imageView;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) CGFloat animationDuration;  //default is 13.f
@property (nonatomic, assign) CGFloat zoomRatio; // default 0.1  0 ~ 1 not working
@property (nonatomic, assign) CGFloat endZoomRate; // default 1.2
@property (nonatomic, assign) CGFloat startZoomRate; // default 1.3
@property (nonatomic, assign) UIEdgeInsets padding; // default UIEdgeInsetsMake(10, 10, 10, 10);
@property (nonatomic, assign) CPKenburnsImageViewZoomCourse course; // default is 0

@property (nonatomic, assign) CPKenburnsImageViewState state;

- (void)restartMotion;
- (void)showWholeImage;
- (void)zoomAndRestartAnimation;
- (void)zoomAndRestartAnimationWithCompletion:(void(^)(BOOL finished))completion;
@end
