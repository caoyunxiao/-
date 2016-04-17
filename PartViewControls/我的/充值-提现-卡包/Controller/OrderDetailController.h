//
//  OrderDetailController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OrderDetailController : BaseViewController
/**
 *  滚动视图
 */
@property (weak, nonatomic) IBOutlet UITableView *tbView;

@property (nonatomic, strong) NSArray *orderArr;
@end
