//
//  CosFundPlayer.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/20.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CosFundPlayer.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation CosFundPlayer
{
    NSMutableArray *dreamRewardArrNew;
}
- (id)initWithFrame:(CGRect)frame withVideoFileURL:(NSURL *)videoFileURL homeModel:(HomeModel *)homeModel
{
    
    if (self =[super initWithFrame:frame])
    {
        _model = homeModel;
        [self initPlayLayer:videoFileURL];
        [self fullScreenButton];
        [self setUIView];
        self.isFull = NO;
        self.oldFrame = frame;
        [self setRankingViewValueZFJ:homeModel];
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
    [self.fullBtn addTarget:self action:@selector(fullBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //监听视频播放
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemFailedToPlayToEndTime:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemPlaybackStalled:) name:AVPlayerItemPlaybackStalledNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemNewAccessLogEntry:) name:AVPlayerItemNewAccessLogEntryNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemNewErrorLogEntryNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemNewErrorLogEntry:) name:AVPlayerItemNewErrorLogEntryNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemFailedToPlayToEndTimeErrorKey:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:nil];
    
    //检测视频是否加载完成
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
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

#pragma mark -观察网络视频是否加载完成
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.player.currentItem.status == AVPlayerStatusReadyToPlay) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Videoloaded" object:nil];
    }
    
    NSLog(@"视频加载完成");
}

#pragma mark -全屏播放视频
- (void)fullBtnClick
{
    if(_isFull)
    {
//        [UIView animateWithDuration:1 animations:^{
//            
////            _playerLayer.transform =
//            self.transform = CGAffineTransformMakeRotation(M_PI/2);
//            
//        }];
    }
    else
    {
        
    }
    
//    self.isFull = !self.isFull;
}

- (void)setUIView
{
    _valueArr = @[@"1",@"5",@"10",@"100",@"1000"];
    _imageMove = [[UIImageView alloc]init];
    
//    //设置底层视图
//    self.downView = [[[NSBundle mainBundle]loadNibNamed:@"RightDownView" owner:self options:nil]objectAtIndex:1];
//    self.downView.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width-129, 20);
//    self.downView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//    //self.downView.alpha = 0.7;
//    [self addSubview:self.downView];
    
    //弹幕视图
    self.barrageView = [[[NSBundle mainBundle]loadNibNamed:@"RightDownView" owner:self options:nil]objectAtIndex:2];
    self.barrageView.frame = CGRectMake(0, self.frame.size.height-102-30, self.frame.size.width/2, 102);
//    self.barrageView.titltArr = @[@"FFF",@"FFF",@"FFF",@"FFFFFFF"];
    [self addSubview:self.barrageView];
    
    //右上角排行
    self.rankingView = [[[NSBundle mainBundle]loadNibNamed:@"RightDownView" owner:self options:nil]objectAtIndex:3];
    self.rankingView.frame = CGRectMake(self.frame.size.width-160, 20, 160, 85);
    [self addSubview:self.rankingView];
    self.rankingView.clipsToBounds = YES;
    
    
    //右下角视图
    _rightDownView = [[[NSBundle mainBundle]loadNibNamed:@"RightDownView" owner:self options:nil]objectAtIndex:0];
    _rightDownView.frame = CGRectMake(self.frame.size.width-160, self.frame.size.height-160, 160, 160);
    [self addSubview:_rightDownView];
    _rightDownView.RDView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    [_rightDownView.OneButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightDownView.FiveButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightDownView.TenBUtton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightDownView.OneHundredButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightDownView.OneThousandButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_rightDownView.AKeyButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightDownView.BigButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightDownView addSubview:_imageMove];
    
    //刷新排行榜
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshRanking) name:@"RefreshRanking" object:nil];
    //一键超越
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YIJIANCAOYUE) name:@"YIJIANCAOYUE" object:nil];
    self.downView.hidden = YES;
    self.rightDownView.hidden = YES;
    self.backBtn.hidden = YES;
}

//#pragma mark -一键超越
//- (void)YIJIANCAOYUE
//{
//    if([self.delegate respondsToSelector:@selector(supportButtonClick:)])
//    {
//        NSInteger index = [[dreamRewardArrNew lastObject][@"amount"] integerValue]+1;
//       [self.delegate supportButtonClick:[NSString stringWithFormat:@"%ld",(long)index]];
// 
//    }
//}

#pragma mark -刷新排行榜
- (void)RefreshRanking
{
    [self setRankingViewValueZFJ:_model];
}

#pragma mark - 右下角打赏点击事件
- (void)buttonClick:(UIButton *)button
{
    NSInteger index = button.tag - 300;
   
    if(button.tag != 306)
    {
        _imageMove.hidden = NO;
        CGRect frame;
        if(index==0)
        {
            frame = _rightDownView.OneButton.frame;
        }
        else if (index==1)
        {
            frame = _rightDownView.FiveButton.frame;
        }
        else if (index==2)
        {
            frame = _rightDownView.TenBUtton.frame;
        }
        else if (index==3)
        {
            frame = _rightDownView.OneHundredButton.frame;
        }
        else if (index==4)
        {
            frame = _rightDownView.OneThousandButton.frame;
        }

        if (index != 5) {
            
            self.indexNumber = index;
            _imageMove.frame = frame;
            _imageMove.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldKabeiBig",(long)(index+1)]];
            [UIView animateWithDuration:0.1 animations:^{
                _imageMove.frame = _rightDownView.BigButton.frame;
            } completion:^(BOOL finished) {
                _imageMove.hidden = YES;
                [_rightDownView.BigButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ldKabeiBig",(long)(index+1)]] forState:UIControlStateNormal];
            }];
        }
        if (index == 5) {
            
            _indexButton = button.tag - 300;
            if([self.delegate respondsToSelector:@selector(supportButtonClick:)])
            {
                NSString *supportValue = _valueArr[self.indexNumber];
                [self.delegate supportButtonClick:supportValue];
            }
        }        
    }
}

#pragma mark - 设置右上角排行
- (void)setRankingViewValueZFJ:(HomeModel *)model
{
    if(model==nil||_rankingView==nil)
    {
        _loadImage.hidden = YES;
        return;
    }

    NSArray *top3Reward = model.top3Reward;
    if (top3Reward.count == 0) {
        
        return;
    }
    UIView *firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 35)];
    [_rankingView addSubview:firstView];
    firstView.backgroundColor = [UIColor clearColor];
    
    UIImageView *firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(160-35-8, 0, 35, 35)];
    firstImage.image = [UIImage imageNamed:@"first.png"];
    [firstView addSubview:firstImage];
    
    UILabel *firstName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160-35-8, 25)];
    firstName.text = [NSString stringWithFormat:@"%@",[top3Reward firstObject][@"nickName"]];
    [firstView addSubview:firstName];
    firstName.textColor = [UIColor whiteColor];
    firstName.font = [UIFont systemFontOfSize:14];
    firstName.textAlignment = NSTextAlignmentRight;
    
    UILabel *firstKaBei = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 160-35-8, 10)];
    firstKaBei.textColor = [UIColor whiteColor];
    firstKaBei.text = [NSString stringWithFormat:@"%@",[top3Reward firstObject][@"amount"]];
    [firstView addSubview:firstKaBei];
    firstKaBei.font = [UIFont systemFontOfSize:10];
    firstKaBei.textAlignment = NSTextAlignmentRight;
    
    
    if (top3Reward.count >1) {
    
        UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 160, 20)];
        UIImageView *secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(160-20-15, 0, 20, 20)];
        secondImage.image = [UIImage imageNamed:@"second.png"];
    [secondView addSubview:secondImage];
        [_rankingView addSubview:secondView];
        UILabel *secondName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160-20-15, 20)];
        secondName.text = top3Reward[1][@"nickName"];
        [secondView addSubview:secondName];
        secondName.textColor = [UIColor whiteColor];
        secondName.font = [UIFont systemFontOfSize:12];
        secondName.textAlignment = NSTextAlignmentRight;
    }
    if (top3Reward.count >2) {
    
        UIImageView *thridImage = [[UIImageView alloc]initWithFrame:CGRectMake(160-20-15, 0, 20, 20)];
        thridImage.image = [UIImage imageNamed:@"third.png"];
        UIView *thridView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, 160, 20)];
        [_rankingView addSubview:thridView];
        [thridView addSubview:thridImage];
        UILabel *thridName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160-20-15, 20)];
        thridName.text = [top3Reward lastObject][@"nickName"];
        [thridView addSubview:thridName];
        thridName.textColor = [UIColor whiteColor];
        thridName.font = [UIFont systemFontOfSize:12];
        thridName.textAlignment = NSTextAlignmentRight;
    }
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

#pragma mark - PlayEndNotification 视频播放结束
- (void)avPlayerItemDidPlayToEnd:(NSNotification *)notification
{
    if ((AVPlayerItem *)notification.object != _playerItem) {
        return;
    }
    [_playerItem seekToTime:kCMTimeZero];
    [UIView animateWithDuration:0.3f animations:^{
        _playButton.alpha = 1.0f;
    }];
}

- (void)avPlayerItemFailedToPlayToEndTime:(NSNotification *)notification
{
    NSLog(@"avPlayerItemFailedToPlayToEndTime");
}

#pragma mark-网络卡顿时调用
- (void)avPlayerItemPlaybackStalled:(NSNotification *)notification
{
    NSLog(@"avPlayerItemPlaybackStalled");
}
#pragma mark - 加载成功 开始播放
- (void)avPlayerItemNewAccessLogEntry:(NSNotification *)notification
{
    NSLog(@"avPlayerItemNewAccessLogEntry");
    
    [UIView animateWithDuration:0.2 animations:^{
        _loadImage.alpha = 0;
    } completion:^(BOOL finished) {
        _loadImage.hidden = YES;
//        [_player play];
    }];
}

- (void)avPlayerItemNewErrorLogEntry:(NSNotification *)notification
{
    NSLog(@"avPlayerItemNewErrorLogEntry");
}
- (void)avPlayerItemFailedToPlayToEndTimeErrorKey:(NSNotification *)notification
{
    NSLog(@"avPlayerItemFailedToPlayToEndTimeErrorKey");
}


- (void)dealloc
{
//    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
