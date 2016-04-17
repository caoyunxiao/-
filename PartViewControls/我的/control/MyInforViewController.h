//
//  MyInforViewController.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  /*************************我的主页面********************/

#import "BaseViewController.h"
#import "MyInfoHeaderView.h"                     //头部视图

#import "MyInfoShowViewCell.h"                   //我的梦想秀的Cell

#import "MyPurseCell.h"

@interface MyInforViewController : BaseViewController<MyInfoHeaderViewDelegate,UITableViewDataSource,UITableViewDelegate,MyPurseCellDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tbView;

@property (nonatomic, assign) NSInteger buttonFlag;
/*trgbhrthbrtbhnrnhrthbrthb*/
/**
 *  用来接收头部视图的梦想按钮
 */
@property (nonatomic, strong) UIButton *showBtn;
/**
 *  用来接收头部视图的钱包按钮
 */
@property (nonatomic, strong) UIButton *purseBtn;
/**
 *  用来接收头部视图的任务按钮
 */
@property (nonatomic, strong) UIButton *taskBtn;
/**
 *  用来接收购物车按钮
 */
@property (nonatomic, strong) UIButton *shoppingCartBtn;

/**
 *  底部结算视图
 */
@property (weak, nonatomic) IBOutlet UIView *myShoppingButtomView;
/**
 *  全选的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *selectBtnClick;

/**
 *  点解全选的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)shoppingButtomSelectAllBtn:(UIButton *)sender;
/**
 *  删除的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
/**
 *  点击删除的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)deleteBtnClick:(UIButton *)sender;

/**
 *  点击结算的按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)settelBtnClick:(UIButton *)sender;
@end
