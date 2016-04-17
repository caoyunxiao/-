//
//  CommentsListCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/24.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leaveWordsModel.h"


@protocol CLCellFirstLabelTapDelegate <NSObject>

@optional

- (void)CLCellFirstLabelTap:(NSInteger)textTag;

@end

@interface CommentsListCell : UITableViewCell

@property (nonatomic,assign) id<CLCellFirstLabelTapDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *CLCellName;//评论人昵称
@property (weak, nonatomic) IBOutlet UILabel *CLCellFirstLabel;//第一条评论
@property (weak, nonatomic) IBOutlet UILabel *CLCellSecondLabel;//第二条评论
@property (weak, nonatomic) IBOutlet UILabel *CLCellReply;//回复


- (void)showUIViewWithModel:(leaveWordsModel *)model;




@end
