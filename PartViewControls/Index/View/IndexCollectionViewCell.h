//
//  IndexCollectionViewCell.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexCollectionViewCell : UICollectionViewCell
//放置引导页的图片
@property (nonatomic, strong) UIImage *image;


// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
