//
//  DreamHistoryCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface DreamHistoryCell : UITableViewCell
/**
 *  梦想名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  时间标题
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/**
 *  状态按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

- (void)configData:(HomeModel *)model;
@end
