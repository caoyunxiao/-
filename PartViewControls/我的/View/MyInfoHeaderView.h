//
//  MyInfoHeaderView.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyInfoHeaderViewDelegate <NSObject>
@optional
/**
 *  点击梦想秀的按钮
 *
 *  @param sender <#sender description#>
 */
- (void)myInfoHeaderViewshowBtnClick:(UIButton *)sender;
/**
 *  点击我的钱包按钮
 *
 *  @param sender <#sender description#>
 */
- (void)myInfoHeaderViewpuserBtnClick:(UIButton *)sender;
/**
 *  点击购物车按钮
 *
 *  @param sender <#sender description#>
 */
- (void)myInfoHeaderViewshoppingCartClick:(UIButton *)sender;

- (void)myInfoHeaderViewtaskBtnClick:(UIButton *)sender;

/**
 *  点击编辑的按钮
 */
- (void)myInfoHeaderViewEditBtnClick;
/**
 *  <#Description#>
 */

@end
@interface MyInfoHeaderView : UIView

@property (nonatomic, weak) id<MyInfoHeaderViewDelegate> delegate;
/**
 *  点击头像
 *
 *  @param sender 
 */


@property (weak, nonatomic) IBOutlet UIImageView *myHeardIamgeView;

/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  自我介绍
 */
@property (weak, nonatomic) IBOutlet UILabel *intrduceLaebl;

/**
 *  用来接收按钮梦想秀按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@property (weak, nonatomic) IBOutlet UIButton *purseBtn;

@property (weak, nonatomic) IBOutlet UIButton *taskBtn;

@property (weak, nonatomic) IBOutlet UIButton *shoppingCartBtn;

- (IBAction)showBtnClick:(UIButton *)sender;

- (IBAction)puserBtnClick:(UIButton *)sender;

- (IBAction)taskBtnClick:(UIButton *)sender;

- (IBAction)shoppingCartClick:(UIButton *)sender;

- (IBAction)editBtnClick:(UIButton *)sender;
/**fdbvdebedbefbeberberberhwthw4rthw4th4wthberb*/
@end
