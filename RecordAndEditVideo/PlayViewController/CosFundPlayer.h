//
//  CosFundPlayer.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/20.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RightDownView.h"
#import "HomeModel.h"

@protocol supportButtonClickDelegate <NSObject>

- (void)supportButtonClick:(NSString *)supportValue;

@end

@interface CosFundPlayer : UIView{
    NSArray *_valueArr;
    
    NSInteger _indexButton;
}

@property (nonatomic,assign) id<supportButtonClickDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withVideoFileURL:(NSURL *)videoFileURL homeModel:(HomeModel *)homeModel;
- (void)initPlayLayer:(NSURL *)videoFileURL;
@property (strong, nonatomic) AVPlayer *player;           //
@property (strong, nonatomic) AVPlayerLayer *playerLayer; //
@property (strong, nonatomic) AVPlayerItem *playerItem;   //
@property (nonatomic,strong) HomeModel *model;
@property (strong, nonatomic) UIImageView *loadImage;       //
@property (strong, nonatomic) UIButton *fullBtn;       //全屏barrage
@property (strong, nonatomic) UIButton *playButton;       //播放
@property (strong, nonatomic) UIButton *backBtn;       //退出全屏
@property (strong, nonatomic) RightDownView *downView;       //底层视图
@property (strong, nonatomic) UIView *downRightView;       //底层右下角视图
@property (strong, nonatomic) RightDownView *rightDownView;       //
@property (strong, nonatomic) RightDownView *barrageView;       //弹幕视图
@property (strong, nonatomic) RightDownView *rankingView;       //右上角排行
@property (nonatomic,assign) BOOL isplayer;                     //是否播放
@property (nonatomic,copy) NSString *MYCaBei;//我的咖贝
@property (nonatomic,strong) UIImageView *imageMove;//选中的卡贝数

@property (nonatomic,assign) BOOL isFull;

@property (nonatomic,assign) CGRect oldFrame;


@property (nonatomic,assign) const NSInteger indexNumber;


@end
