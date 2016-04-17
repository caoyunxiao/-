//
//  ShowCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/9/23.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "UCZProgressView.h"

@interface ShowCell : UITableViewCell{
    UCZProgressView *_setProgress;
    CosFundPlayer *_cfPlayer;
}


@property (weak, nonatomic) IBOutlet UIImageView *SCImageView;//首页图片
@property (weak, nonatomic) IBOutlet UILabel *SCName;//标题
@property (weak, nonatomic) IBOutlet UILabel *SCDiscription;//描述
@property (weak, nonatomic) IBOutlet UIView *SCOneView;//
@property (weak, nonatomic) IBOutlet UIView *SCTwoVIew;//进度条
@property (weak, nonatomic) IBOutlet UILabel *SCKaBei;//咖贝

- (void)showUIViewWithModelForNew:(HomeModel *)model;




@end
