//
//  WelfareCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/11/18.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WelfareCell : UITableViewCell
/**
 *  背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


/**
 *  传递数据模型
 *
 *  @param model <#model description#>
 */
- (void)configImageWithIndexpath:(NSIndexPath *)indexpath;

@end
