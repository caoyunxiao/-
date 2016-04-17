//
//  PublishedPhotosCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol showGigImageViewDelegate <NSObject>

@optional

- (void)showOneGigImageView:(NSInteger)index;
- (void)addOneImageButtonClick:(UIButton *)button;
- (void)PPCTwoBigImageClick;

- (void)dreamLabelTapClick:(UIButton *)button;

@end


@interface PublishedPhotosCell : UITableViewCell<UITextFieldDelegate>
{
    CosFundPlayer *_cfPlayer;
}

@property (strong, nonatomic) AVPlayerItem *playerItem;   //
@property (strong, nonatomic) AVPlayer *player;           //
@property (strong, nonatomic) UIButton *playButton;       //

@property (nonatomic,assign) id<showGigImageViewDelegate> delegate;

@property (nonatomic,strong) UIButton *addButton;//添加一张新的照片

//标题部分-PPCOne
@property (weak, nonatomic) IBOutlet UITextField *PPCOneTitle;//梦想标题
@property (weak, nonatomic) IBOutlet UIImageView *PPCOneImage;//是否选择提示图片
@property (weak, nonatomic) IBOutlet UIView *PPCOneView;

//封面部分-PPCTwo
@property (weak, nonatomic) IBOutlet UIImageView *PPCTwoImage;//是否选择提示图片
@property (weak, nonatomic) IBOutlet UIImageView *PPCTwoBigImage;//封面照
@property (weak, nonatomic) IBOutlet UIButton *PPCTwoButton;//选择一张照片作为封面
@property (weak, nonatomic) IBOutlet UIView *PPCTwoView;//显示或者隐藏视图

//梦想照片-PPCThree
@property (weak, nonatomic) IBOutlet UILabel *PPCThreeTitle;//梦想是视频或者图片
@property (weak, nonatomic) IBOutlet UIView *PPCThreeView;


//梦想描述-PPCFour
@property (weak, nonatomic) IBOutlet UITextView *PPCFourDescribe;//梦想描述
@property (weak, nonatomic) IBOutlet UIImageView *PPCFourImage;//是否选择提示图片
@property (weak, nonatomic) IBOutlet UIView *PPCFourView;

//拉赞口号-PPCFive
@property (weak, nonatomic) IBOutlet UITextField *PPCFiveSlogan;
@property (weak, nonatomic) IBOutlet UIImageView *PPCFiveImage;//是否选择提示图片
@property (weak, nonatomic) IBOutlet UIView *PPCFiveView;

//请选择1-3个和梦想相关的标签-PPCSix
@property (weak, nonatomic) IBOutlet UIImageView *PPCSixImage;//是否选择提示图片
@property (weak, nonatomic) IBOutlet UIView *PPCSixView;
@property (weak, nonatomic) IBOutlet UIView *PPCSixLabelView;//存放label的标签

//请选择梦想完成日期-PPCSeven
@property (weak, nonatomic) IBOutlet UIImageView *PPCSevenImage;//是否选择提示图片
@property (weak, nonatomic) IBOutlet UIView *PPCSevenView;
@property (weak, nonatomic) IBOutlet UIView *PPCSevenDateView;//存放时间button的view
@property (weak, nonatomic) IBOutlet UIButton *PPCSevenOneWeek;//一周
@property (weak, nonatomic) IBOutlet UIButton *PPCSevenTwoWeek;//二周
@property (weak, nonatomic) IBOutlet UIButton *PPCSevenThreeWeek;//三周
@property (weak, nonatomic) IBOutlet UIButton *PPCSevenFourWeek;//四周

//一周最低达成金额（至少50000咖贝）-PPCEight
@property (weak, nonatomic) IBOutlet UITextField *PPCEightText;//梦想金额
@property (weak, nonatomic) IBOutlet UIImageView *PPCEightImage;//是否选择提示图片


@property (weak, nonatomic) IBOutlet UILabel *NeedKabei;
             //完成梦想需要的咖贝数
@property (weak, nonatomic) IBOutlet UILabel *DayNumber;

             //完成梦想需要的天数


@property (weak, nonatomic) IBOutlet UIView *PPCEightView;

//可随时进入您的梦想秀主页添加梦想进度每天最多添加一次-PPCNine
@property (weak, nonatomic) IBOutlet UILabel *PPCNineLabel;//提示

//发布部分-PPCTen
@property (weak, nonatomic) IBOutlet UIButton *PPCTenBtn;//发布按钮

@property (nonatomic,copy) void(^PlayerButtonClick)();   //播放按钮点击

//如果是照片 在第三行显示照片排列
- (void)showUIViewWithImageArray:(NSArray *)imageArray;

//设置标签
- (void)showAllLabelViewWithLabelArr:(NSArray *)labelArray;

//视频
- (void)showUIViewVideoWithURL:(NSURL *)videoURL homeModel:(HomeModel *)homeModel;



























@end
