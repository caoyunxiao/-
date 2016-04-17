//
//  DreamHistoryDetailViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface DreamHistoryDetailViewController : BaseViewController

/**
 *  背景滚动视图
 */
@property (weak, nonatomic) IBOutlet UITableView *tbView;

//梦想模型
@property (nonatomic, copy) HomeModel *homeModel;

@property (nonatomic, copy) NSString *dreamID;
@property (nonatomic,assign) BOOL isDetailGoto;//是否是详情页切换过来

/*功能不让你被人体内部认购糖尿病人他过年不让给他不能给你报告*/
@end
