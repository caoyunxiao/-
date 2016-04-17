//
//  HistoryPlayer.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryPlayer : UIView


- (id)initWithFrame:(CGRect)frame withVideoFileURL:(NSURL *)videoFileURL;

@property (strong, nonatomic) AVPlayer *player;           //
@property (strong, nonatomic) AVPlayerLayer *playerLayer; //
@property (strong, nonatomic) AVPlayerItem *playerItem;   //
@property (strong, nonatomic) UIImageView *loadImage;       //
@property (strong, nonatomic) UIButton *fullBtn;       //全屏barrage
@property (strong, nonatomic) UIButton *playButton;       //播放
@property (strong, nonatomic) UIButton *backBtn;       //退出全屏

@property (nonatomic,assign) BOOL isplayer;                     //是否播放


@property (nonatomic,assign) BOOL isFull;

@property (nonatomic,assign) CGRect oldFrame;



@end
