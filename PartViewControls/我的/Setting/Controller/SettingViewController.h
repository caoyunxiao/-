//
//  SettingViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SettingBaseViewController.h"

@interface SettingViewController : SettingBaseViewController

@property (SDDispatchQueueSetterSementics, nonatomic) dispatch_queue_t ioQueue;

@end
