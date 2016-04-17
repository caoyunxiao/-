//
//  TaskCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/31.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"

@interface TaskCell : UITableViewCell

/**
 *  标题
 */

@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;

/**
 *  任务完成的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *finish;

/**
 *  奖励的咖贝
 */
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
/**
 *  任务类型
 */
@property (nonatomic, copy) NSString *type;

//第三个Cell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  给cell赋值
 *
 *  @param IndexPath cell的索引
 */
- (void)configData:(TaskModel *)model;

- (void)configDataWithThreeCell:(TaskModel *)model;
@end
