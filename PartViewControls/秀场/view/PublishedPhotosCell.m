//
//  PublishedPhotosCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "PublishedPhotosCell.h"
#import "DreamLabelModel.h"

@implementation PublishedPhotosCell

- (void)awakeFromNib {
    
    [self setBorderStyle];
    [self uiConfig];
}
- (void)uiConfig
{
    self.PPCFourDescribe.showsHorizontalScrollIndicator = NO;
    self.PPCFourDescribe.showsVerticalScrollIndicator = NO;
    self.PPCFourDescribe.returnKeyType = UIReturnKeyDone;
    
    [self setDateButton];
    
    self.PPCTwoBigImage.contentMode = UIViewContentModeScaleAspectFill;
    self.PPCTwoBigImage.userInteractionEnabled = YES;
    self.PPCTwoBigImage.clipsToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PPCTwoBigImageTap:)];
    [self.PPCTwoBigImage addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    self.PPCThreeView.clipsToBounds = YES;
}

#pragma mark - 设置标签
- (void)showAllLabelViewWithLabelArr:(NSArray *)labelArray;
{
    for (UIView *view in self.PPCSixLabelView.subviews) {
        
        [view removeFromSuperview];
    }
    
    
    //总个视图的宽度
    CGFloat AllWith = ScreenWidth -16*2;
    //间隔
    int margin = 3;
    //单个标签的宽度
    CGFloat Width = (AllWith-4*margin)/5;
    //单个标签的高度
    CGFloat Height = 18;
    
    int totalloc=5;
    for (int i = 0; i<labelArray.count; i++) {
        
        int row = i/totalloc;//行号
        
        int loc = i%totalloc;//列号
        
        DreamLabelModel *model = [labelArray objectAtIndex:i];
        
        CGFloat BtnX = (margin+Width)*loc;
        CGFloat BtnY = margin+(margin+Height)*row;
        UIButton *markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        markBtn.frame = CGRectMake(BtnX, BtnY, Width, Height);
        
        [markBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        markBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [markBtn setTitle:model.name forState:UIControlStateNormal];
        
        markBtn.layer.masksToBounds = YES;
        markBtn.layer.cornerRadius = 5;
        markBtn.selected = model.isSelect;
        if (markBtn.selected == YES) {
            [markBtn setBackgroundColor:[UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1]];
        }
        else
        {
            [markBtn setBackgroundColor:[UIColor lightGrayColor]];
            
        }
        
        markBtn.tag = i;
        
        
        [markBtn addTarget:self action:@selector(dreamLabelTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.PPCSixLabelView addSubview:markBtn];
    }
}

#pragma mark - 设置梦想完成时间
- (void)setDateButton
{
    
    self.PPCSevenOneWeek.layer.borderWidth = 1.0;
    self.PPCSevenOneWeek.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1].CGColor;
    
    self.PPCSevenTwoWeek.layer.borderWidth = 1.0;
    self.PPCSevenTwoWeek.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1].CGColor;
    
    self.PPCSevenThreeWeek.layer.borderWidth = 1.0;
    self.PPCSevenThreeWeek.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1].CGColor;
    
    self.PPCSevenFourWeek.layer.borderWidth = 1.0;
    self.PPCSevenFourWeek.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1].CGColor;
    
    self.PPCEightText.layer.borderWidth = 1.0;
    self.PPCEightText.layer.borderColor = [UIColor colorWithRed:197/255.0 green:197/255.0 blue:199/255.0 alpha:1].CGColor;
}

#pragma mark - 设置边框
- (void)setBorderStyle
{
    self.PPCOneView.layer.masksToBounds = YES;
    self.PPCOneView.layer.cornerRadius = 5;
    self.PPCOneView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.PPCOneView.layer.borderWidth = 1.0;
    
    self.PPCFourView.layer.masksToBounds = YES;
    self.PPCFourView.layer.cornerRadius = 5;
    self.PPCFourView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.PPCFourView.layer.borderWidth = 1.0;
    
    self.PPCFiveView.layer.masksToBounds = YES;
    self.PPCFiveView.layer.cornerRadius = 5;
    self.PPCFiveView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.PPCFiveView.layer.borderWidth = 1.0;
    
    self.PPCSixView.layer.masksToBounds = YES;
    self.PPCSixView.layer.cornerRadius = 5;
    self.PPCSixView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.PPCSixView.layer.borderWidth = 1.0;
    
    self.PPCSevenView.layer.masksToBounds = YES;
    self.PPCSevenView.layer.cornerRadius = 5;
    self.PPCSevenView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.PPCSevenView.layer.borderWidth = 1.0;
    
    self.PPCEightView.layer.masksToBounds = YES;
    self.PPCEightView.layer.cornerRadius = 5;
    self.PPCEightView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    self.PPCEightView.layer.borderWidth = 1.0;
    
}


#pragma mark - 如果是照片 在第三行显示照片排列
- (void)showUIViewWithImageArray:(NSArray *)imageArray
{
    for (UIView *view in self.PPCThreeView.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSInteger aa = imageArray.count%3;
    NSInteger lineNum = imageArray.count/3;
    if(aa!=0)
    {
        lineNum ++;
    }
    CGFloat width = ((ScreenWidth - 16)-4)/3;
    for (int i =0; i<imageArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake((width + 2)*(i%3), (width + 2)*(i/3), width, width);
        imageView.backgroundColor = [UIColor lightGrayColor];
        [self.PPCThreeView addSubview:imageView];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        NSData *imageData = UIImageJPEGRepresentation(imageArray[i], 0.001);
        imageView.image = [UIImage imageWithData:imageData];
        
        imageView.tag = 90 + i;
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImageViewSingleTap:)];
        [imageView addGestureRecognizer:tap];
    }
    if(imageArray.count+1<=3)
    {
        self.PPCThreeView.frame = CGRectMake(8, 38, ScreenWidth-16, width*2);
    }
    else
    {
        self.PPCThreeView.frame = CGRectMake(8, 38, ScreenWidth-16, width*2+2);
    }
    if(imageArray.count+1<7)
    {
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake((width + 2)*(imageArray.count%3), (width + 2)*(imageArray.count/3), width, width)];
        [self.PPCThreeView addSubview:_addButton];
        [_addButton setImage:[UIImage imageNamed:@"SV_Add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 视频
- (void)showUIViewVideoWithURL:(NSURL *)videoURL homeModel:(HomeModel *)homeModel
{
    CGFloat width = ScreenWidth-16;
    _cfPlayer = [[CosFundPlayer alloc]initWithFrame:CGRectMake(0, 0, width, width*320/568) withVideoFileURL:videoURL homeModel:homeModel];
    _cfPlayer.clipsToBounds = YES;
    [self.PPCThreeView addSubview:_cfPlayer];
    _cfPlayer.fullBtn.hidden = YES;
    _cfPlayer.backBtn.hidden = YES;
    _cfPlayer.barrageView.hidden = YES;
    _cfPlayer.rankingView.hidden = YES;
    _cfPlayer.isplayer = YES;
    [_cfPlayer.playButton addTarget:self action:@selector(ClickPlayerButton) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -播放按钮点击
- (void)ClickPlayerButton
{
    
    if (_PlayerButtonClick) {
        
        _PlayerButtonClick();
    }
}

#pragma mark -点击选中的图片
- (void)showBigImageViewSingleTap:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 90;
    if([self.delegate respondsToSelector:@selector(showOneGigImageView:)])
    {
        [self.delegate showOneGigImageView:index];
    }
}

#pragma mark - 点击梦想标签
- (void)dreamLabelTap:(UIButton *)button
{

    if([self.delegate respondsToSelector:@selector(dreamLabelTapClick:)])
    {
        [self.delegate dreamLabelTapClick:button];
    }
}





#pragma mark - 点击封面图片
- (void)PPCTwoBigImageTap:(UITapGestureRecognizer *)tap
{
    if([self.delegate respondsToSelector:@selector(PPCTwoBigImageClick)])
    {
        [self.delegate PPCTwoBigImageClick];
    }
}

#pragma mark - 添加一张照片
- (void)addButtonClick
{
    if([self.delegate respondsToSelector:@selector(addOneImageButtonClick:)])
    {
        [self.delegate addOneImageButtonClick:_addButton];
    }
}

#pragma mark - PlayEndNotification...播放完成
- (void)avPlayerItemDidPlayToEnd:(NSNotification *)notification
{
    if ((AVPlayerItem *)notification.object != _playerItem) {
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        _playButton.alpha = 1.0f;
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
