//
//  ProductDetailsCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "ProductDetailsCell.h"
#import "SDCycleScrollView.h"              //网络滚动视图
#import "UIImageView+WebCache.h"          //网络图片下载
#import "PicVidListModel.h"                   //图片数组模型

@implementation ProductDetailsCell

- (void)awakeFromNib {
    // Initialization code


}

- (void)creatSDCScrollViewWithModel:(OnlineModel *)modle
{

    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    NSMutableArray *imagesTitles = [NSMutableArray array];
    for (PicVidListModel *picModel in modle.picVidList) {
        
        NSLog(@"图片%@",picModel.url);
        [imagesURLStrings addObject:[BaseViewController getImageUrlWithKey:picModel.url]];
        [imagesTitles addObject:picModel.describe];
        
    }
     NSLog(@"图片imagesURL%@",imagesURLStrings);
//    NSArray *imagesURLStrings = @[
//                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                  ];
//    NSArray *imagesTitles = @[@"感谢您的支持，如果下载的",
//                        @"如果代码在使用过程中出现问题",
//                        @"您可以发邮件到gsdios@126.com",
//                        @"感谢您的支持"
//                        ];
    
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, self.sDCScrollView.height) imageURLStringsGroup:nil]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    cycleScrollView2.titlesGroup = imagesTitles;
    cycleScrollView2.dotColor = TCColor; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = PlaceholderImage;
    [self.sDCScrollView addSubview:cycleScrollView2];
    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    //             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
//
}
//展示第一个cell
- (void)showUIViewOneCellWith:(OnlineModel *)model
{
    
  
    [self creatSDCScrollViewWithModel:model];
    
    NSString *price = model.price.description;
    if(![price isEqual:[NSNull null]]&&price.length!=0)
    {
        self.priceLabel.text = [NSString stringWithFormat:@"%@",price];
    }
    NSString *name = model.name;
    if(![name isEqual:[NSNull null]]&&name.length!=0)
    {
        self.titleLabel.text = name;
    }
    NSString *kabei = model.caBei;
    if(![kabei isEqual:[NSNull null]]&&kabei.length!=0)
    {
        self.kabeiLabel.text = kabei;
    }
}
//商品描述
- (void)showUIViewTwoCellWith:(OnlineModel *)model
{
    NSString *Introduction = model.discription;
    if(![Introduction isEqual:[NSNull null]]&&Introduction.length!=0)
    {
        self.Introduction.text = Introduction;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
