//
//  ReleaseRreamsCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseRreamsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *RDreamsName;//梦想的名字
@property (weak, nonatomic) IBOutlet UITextView *RDreamsDescribe;//描述梦想
@property (weak, nonatomic) IBOutlet UIScrollView *RDreamsShow;//存放照片的地方
@property (weak, nonatomic) IBOutlet UIButton *RDreamsAddImage;//添加照片

@property (weak, nonatomic) IBOutlet UILabel *RDreamsLabel;//

//设置UI
- (void)showUIViewWithImageArr:(NSArray *)showArr;



@end
