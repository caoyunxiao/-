//
//  CashBackViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "WelfareModel.h"              //福利社模型

@interface CashBackViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *CashBackTableView;

@property (nonatomic, strong) WelfareModel *model;
@end
