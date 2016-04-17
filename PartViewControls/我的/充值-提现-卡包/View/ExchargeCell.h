//
//  ExchargeCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExchangeModle.h"

@interface ExchargeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchgeKabeiLable;

- (void)configModle:(ExchangeModle *)model;

@end
