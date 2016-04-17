//
//  SGCollectionController.h
//  SGImagePickerController
//
//  Created by yyx on 15/9/20.
//  Copyright (c) 2015年 yyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAssetsGroup;

@interface SGCollectionController : UICollectionViewController
{
    UILabel *_numLabel;
}
@property (nonatomic,strong) ALAssetsGroup *group;


@end
