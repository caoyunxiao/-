//
//  ShopCell.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/9/25.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopCellDelgate <NSObject>

@optional

- (void)selectOneImageByClick:(NSInteger)index;//图片点击代理事件

@end

@interface ShopCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleName;

//展示排列上部数据
- (void)showTopUIViewWithArray:(NSArray *)array;

//显示下排数据
- (void)showUIViewDownWithString:(NSString *)str;

@property (nonatomic,assign) id<ShopCellDelgate> delegate;//设置代理

@end
