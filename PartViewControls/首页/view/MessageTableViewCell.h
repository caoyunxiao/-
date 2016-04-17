//
//  MessageTableViewCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/11/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "leaveWordsModel.h"
@interface MessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *PersonName;
@property (weak, nonatomic) IBOutlet UILabel *PersonMessage;
@property (nonatomic,strong) leaveWordsModel *model;
@property (weak, nonatomic) IBOutlet UIView *MessagebackView; 

@end
