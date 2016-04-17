//
//  ReceiveGoodsCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModle.h"

@interface ReceiveGoodsCell : UITableViewCell
/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  mobile
 */
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
/**
 *  地址
 */
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;

- (void)configModel:(AddressModle *)model;
@end
