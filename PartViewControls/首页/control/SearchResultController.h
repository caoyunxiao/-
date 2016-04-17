//
//  SearchResultController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/24.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*搜索结果显示页面*/

#import "BaseViewController.h"

@interface SearchResultController : BaseViewController

/**
 *  tbView
 */
@property (weak, nonatomic) IBOutlet UITableView *tbView;


@property (nonatomic, copy) NSString *searchTitle;

@end
