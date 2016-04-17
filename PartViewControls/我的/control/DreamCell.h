//
//  DreamCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol DreamCellDelegate <NSObject>

- (void)DreamCellAddDreamButtonClick:(UIButton *)btn;

- (void)DreamCellDreamtrajectoryClick:(UITapGestureRecognizer *)Tap array:(NSArray *)array;

@end
@interface DreamCell : UITableViewCell
/**
 *  梦想标题
 */
@property (weak, nonatomic) IBOutlet UILabel *dreamTitleLabel;
/**
 *  梦想口号
 */
@property (weak, nonatomic) IBOutlet UILabel *dreamKouHao;


/**
 *  滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *dreamScrollerVire;

/**
 *  梦想描素
 */
@property (weak, nonatomic) IBOutlet UITextView *describTextView;

/**
 *  梦想状态
 */
@property (weak, nonatomic) IBOutlet UIImageView *dreamStateImage;
/**
 *  梦想名称
 */
@property (weak, nonatomic) IBOutlet UILabel *dreamNameLable;

@property (nonatomic, assign) id<DreamCellDelegate> delegate;
/**
 *  传到视图控制器的数据源数组
 */
@property (nonatomic, strong) NSArray *returnPic;
- (void)configModle:(HomeModel *)model;
@end
