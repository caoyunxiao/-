//
//  ContactSeverViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/10.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactSeverViewController : BaseViewController
/**
 *  拨打服务热线
 *
 *  @param sender <#sender description#>
 */
- (IBAction)call:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *callBtn;

@end
