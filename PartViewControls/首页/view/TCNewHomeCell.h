//
//  TCNewHomeCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/20.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "MessageTableViewCell.h"

@protocol TCNewHomeCellDelegate <NSObject>

@optional

- (void)addDreamButtonClick:(UIButton *)button;

@end

@interface TCNewHomeCell : UITableViewCell
{
    
    CGFloat _heightOld;
    
    BOOL isFirstFive;
    BOOL isFirstOne;
    BOOL isCellTwo;
    BOOL isCellFour;
    BOOL isCellThree;
}

@property (nonatomic,assign) id<TCNewHomeCellDelegate> delegate;

@property (nonatomic,strong) UIButton *CellFiveSentMessage;


//CellOne
@property (weak, nonatomic) IBOutlet UIView *TCNHCellOneView;//视频播放器视图



//CellTwo
@property (weak, nonatomic) IBOutlet UILabel *CellTwoTitle;//标题
@property (weak, nonatomic) IBOutlet UILabel *CellTwoKouHao;//口号
@property (weak, nonatomic) IBOutlet UIView *CellTwoLine;//分割线
@property (weak, nonatomic) IBOutlet UIScrollView *CellTwoScollView;//滚动视图
@property (nonatomic,assign) const NSInteger indexNumber;


//CellThree
@property (weak, nonatomic) IBOutlet UIButton *CellThreeOneBtn;//一
@property (weak, nonatomic) IBOutlet UIButton *CellThreeFiveBtn;//5
@property (weak, nonatomic) IBOutlet UIButton *CellThreeTenBtn;//10
@property (weak, nonatomic) IBOutlet UIButton *CellThreeYiBaiBtn;//100
@property (weak, nonatomic) IBOutlet UIButton *CellThreeYiQianBtn;//1000
@property (weak, nonatomic) IBOutlet UIButton *CellThreeYiJianBtn;//一键
@property (weak, nonatomic) IBOutlet UILabel *CellThreeAllFor;//共支持了
@property (weak, nonatomic) IBOutlet UIButton *CellThreeTopUp;//去充值
@property (weak, nonatomic) IBOutlet UILabel *dreamSlogan;    //梦想口号
@property (weak, nonatomic) IBOutlet UILabel *MyKabeiString; //我的咖贝余额



//CellFour
@property (weak, nonatomic) IBOutlet UILabel *stareer;//星星
@property (weak, nonatomic) IBOutlet UIView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *CellFourTopView;//头部视图
@property (weak, nonatomic) IBOutlet UIImageView *CellFourHeadImage;//头像
@property (weak, nonatomic) IBOutlet UIView *CellFourHasDown;//梦想已达
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;//梦想完成度
@property (weak, nonatomic) IBOutlet UILabel *NeededCompleteDream;//完成梦想需要
@property (nonatomic,copy)  NSString  *NeededMoney;//需要的咖贝数
@property (weak, nonatomic) IBOutlet UILabel *hasDown;//已经完成
@property (weak, nonatomic) IBOutlet UILabel *exceptionalPeople;//打赏人数
@property (weak, nonatomic) IBOutlet UILabel *remainingDays;//剩余天数
@property (weak, nonatomic) IBOutlet UIView *CellFourLabel;//标签视图
@property (weak, nonatomic) IBOutlet UILabel *CellFourDreamTitle;//梦想标题
@property (weak, nonatomic) IBOutlet UILabel *CellFourMiaoShu;//梦想简介
@property (weak, nonatomic) IBOutlet UILabel *createUser;
@property (weak, nonatomic) IBOutlet UIButton *EndDreamButton;   //结束梦想
@property (weak, nonatomic) IBOutlet UIButton *ReportButton;//梦想举报
@property (nonatomic,strong) UCZProgressView *setProgress;   //指示器



//CellFive
@property (weak, nonatomic) IBOutlet UIButton *CellFiveBtn;//更多
@property (weak, nonatomic) IBOutlet UITableView *MessageTableView;

//@property (weak, nonatomic) IBOutlet UIButton *CellFiveSentMessage;//发送留言
@property (weak, nonatomic) IBOutlet UIView *CellFive;


//TCNHCellSix
@property (weak, nonatomic) IBOutlet UIButton *CellSixShare;//分享
@property (weak, nonatomic) IBOutlet UIView *ShareBackView;//分享背景View

@property (nonatomic,strong) UIButton *AddButton;//添加新的进度


- (void)showCellOneUIViewWithHomeModel:(HomeModel *)model;
- (void)showCellTwoUIViewWithHomeModel:(HomeModel *)model;
- (void)showCellThreeUIViewWithHomeModel:(HomeModel *)model;
- (void)showCellFourUIViewWithHomeModel:(HomeModel *)model;
- (void)showCellFiveUIViewWithHomeModel:(NSArray *)leaveWordsArr;

#pragma mark -咖贝余额，支持咖贝数
- (void)ShowMoneyNumber:(NSString *)dreameid;

@property (nonatomic,copy) void(^PersonImageClickBlock)(NSString *UserID);  //用户头像点击
@property (nonatomic,copy) void (^ReportButtonClickBlock)(NSString *UserID); //举报按钮点击
@property (nonatomic,strong) HomeModel *Model;                              //数据源模型




@end
