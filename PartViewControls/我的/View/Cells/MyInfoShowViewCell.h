//
//  MyInfoShowViewCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/14.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoShowViewCell : UITableViewCell

/**
 *  用来获取视图控制器
 */
@property (nonatomic, strong) UINavigationController *navc;


/**
 *  左边标题文字
 */
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;



/**
 *  cell上的滚动视图
 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;




/**
 *  传递数据源
 *
 *  @param indexpath     index
 *  @param suppoortMeArr 支持我的人数据源
 *  @param mySupportArr  我支持的人数据源
 */
- (void)configDataRow:(NSIndexPath *)indexpath supportMeArray:(NSArray *)suppoortMeArr mySupportArr:(NSArray *)
mySupportArr;

@end
