//
//  LoadingButton.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/11/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingButton : UIButton{
    NSMutableArray *_imageArr;
}

@property (nonatomic,strong) GifView *pathViewFailure;

@property (weak, nonatomic) IBOutlet UIView *myLoadView;


@property (weak, nonatomic) IBOutlet UILabel *upLoadText;
@end
