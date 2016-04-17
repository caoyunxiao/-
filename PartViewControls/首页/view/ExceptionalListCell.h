//
//  ExceptionalListCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dreamRewardModel.h"

@interface ExceptionalListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)showUIViewWith:(dreamRewardModel *)model;

@end
