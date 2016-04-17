//
//  SettingCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingItem;
@interface SettingCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)rowCount;
/**
 *  表格的数据模型
 */
@property(nonatomic,strong)SettingItem *item;
@end
