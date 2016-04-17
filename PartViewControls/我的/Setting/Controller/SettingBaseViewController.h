//
//  SettingBaseViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingBaseViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

/**
 *  表格数据，里面存储CZSettingGroup
 */
@property(nonatomic,strong)NSMutableArray *cellData;

@property (nonatomic, strong)  UITableView *tbView;
@end
