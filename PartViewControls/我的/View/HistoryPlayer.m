//
//  HistoryPlayer.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "HistoryPlayer.h"

@implementation HistoryPlayer

- (id)initWithFrame:(CGRect)frame withVideoFileURL:(NSURL *)videoFileURL
{
    if (self =[super initWithFrame:frame])
    {
        [self initPlayLayer:videoFileURL];
        [self fullScreenButton];

        self.isFull = NO;
        self.oldFrame = frame;
    }
    return self;
}

#pragma mark - 初始化播放器
- (void)initPlayLayer:(NSURL *)videoFileURL
{
    if (!videoFileURL) {
        return;
    }
    self.backgroundColor = [UIColor grayColor];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:videoFileURL options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:_playerLayer];
    
}
- (void)fullScreenButton
{
    //播放按钮
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width-60)/2, (self.frame.size.height-60)/2, 60, 60)];
    [_playButton setImage:[UIImage imageNamed:@"playvideo"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(pressPlayButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_playButton];
    
    //全屏按钮
    self.fullBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-30, self.frame.size.height-30, 30, 30)];
    [self.fullBtn setImage:[UIImage imageNamed:@"fullScreen"] forState:UIControlStateNormal];
    [self addSubview:self.fullBtn];
//    [self.fullBtn addTarget:self action:@selector(fullBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //退出全屏按钮
    self.backBtn = [[UIButton alloc]init];
    self.backBtn.frame = CGRectMake(8, 20, 30, 30);
    [self.backBtn setImage:[UIImage imageNamed:@"TCBack"] forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    self.backBtn.hidden = YES;
    
    _loadImage = [[UIImageView alloc]initWithFrame:self.bounds];
    _loadImage.image = [UIImage imageNamed:@"Waitingloading"];
    [self addSubview:_loadImage];
    [self bringSubviewToFront:_loadImage];
}
- (void)pressPlayButton:(UIButton *)button
{
    if (_isplayer) {
        
        return;
    }
    [_playerItem seekToTime:kCMTimeZero];
    [_player play];
    _playButton.alpha = 0.0f;
}


@end
