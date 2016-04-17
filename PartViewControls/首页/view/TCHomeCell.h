//
//  TCHomeCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/9/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface TCHomeCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;//梦想名称
@property (weak, nonatomic) IBOutlet UILabel *createUser;//创建人
@property (weak, nonatomic) IBOutlet UIImageView *TCImageView;//梦想图片
@property (nonatomic,strong) HomeModel *model;//数据源

@end
