//
//  SCNavigationController.h
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-17.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCDefines.h"

@protocol SCNavigationControllerDelegate;

@interface SCNavigationController : UINavigationController


- (void)showCameraWithParentController:(UIViewController*)parentController;

@property (nonatomic, assign) id <SCNavigationControllerDelegate> scNaigationDelegate;
@property (nonatomic,assign) BOOL ISME;//判断是否是添加梦想轨迹
@property (nonatomic,strong) NSDictionary *Trajectorydict;//添加的梦想轨迹数据
@end



@protocol SCNavigationControllerDelegate <NSObject>
@optional
- (BOOL)willDismissNavigationController:(SCNavigationController*)navigatonController;

- (void)didTakePicture:(SCNavigationController*)navigationController imagearr:(NSArray*)imagearr;

@end