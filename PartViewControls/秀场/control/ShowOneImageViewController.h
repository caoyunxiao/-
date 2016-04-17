//
//  ShowOneImageViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/30.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface ShowOneImageViewController : BaseViewController

@property (nonatomic,strong) UIImage *bigImage;

@property (weak, nonatomic) IBOutlet UIImageView *ShowBigImage;

@end
