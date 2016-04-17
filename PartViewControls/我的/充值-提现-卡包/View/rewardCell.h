//
//  rewardCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/12.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardModle.h"

@interface rewardCell : UITableViewCell
/**
 *  打赏人
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  打赏时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**
 *  打赏咖贝
 */
@property (weak, nonatomic) IBOutlet UILabel *kabeiLabel;

- (void)configModle:(RewardModle *)model;

@end
