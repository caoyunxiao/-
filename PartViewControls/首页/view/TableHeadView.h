//
//  TableHeadView.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/12.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeadView : UIView

@property (weak, nonatomic) IBOutlet UIView *HeadView;

@property (weak, nonatomic) IBOutlet UIView *HeadLine;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UIView *HeadRightView;

@property (weak, nonatomic) IBOutlet UILabel *HeadName;
@property (weak, nonatomic) IBOutlet UILabel *HeadSlogan;
@property (weak, nonatomic) IBOutlet UILabel *HeadDream;
@property (weak, nonatomic) IBOutlet UIImageView *TopImageView;

@property (weak, nonatomic) IBOutlet UIView *HeadAlpgaView;
@property (weak, nonatomic) IBOutlet UIView *SDCScrollView;



@end
