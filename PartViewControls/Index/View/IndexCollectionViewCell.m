//
//  IndexCollectionViewCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "IndexCollectionViewCell.h"
//#import "IWTabBarController.h"



@interface IndexCollectionViewCell ()

@property (nonatomic, weak) UIImageView *imageView; //图片

//@property (nonatomic, weak) UIButton *startButton;  //开始按钮

@end
@implementation IndexCollectionViewCell

#pragma mark - 懒加载开始按钮
//- (UIButton *)startButton
//{
//    if (_startButton == nil) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [btn setBackgroundImage:[UIImage imageNamed:@"enter_btn"] forState:UIControlStateNormal];
//        [btn sizeToFit];
//        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
//        
//        
//        _startButton = btn;
//    }
//    return _startButton;
//}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        // 注意:一定要加载contentView
        [self.contentView addSubview:imageV];
        
    }
    return _imageView;
}
// 布局子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
   

    // 开始按钮
    //self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}
//设置图片
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

// 判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮

        
        
        
    }else{ // 非最后一页，隐藏分享和开始按钮
        
        
    }
}




@end
