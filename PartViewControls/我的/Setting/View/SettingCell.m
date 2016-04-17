//
//  SettingCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/9/29.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingLabelItem.h"
#import "UIImage+Resizable.h"

@interface SettingCell ()

/**
 *  Label
 */
@property(nonatomic,weak)UILabel *mLabel;

@property(nonatomic,strong)UIImageView *myArrow;

@end

@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        [self.textLabel setTextColor:TCColordefault];
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIImageView *)myArrow
{
    if (!_myArrow) {
        _myArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _myArrow;
}
- (UILabel *)mLabel
{
    if (_mLabel == nil) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, self.height)];
        _mLabel = label ;
        _mLabel.textAlignment = NSTextAlignmentCenter;
        
        _mLabel.textColor = [UIColor whiteColor];
        
        _mLabel.backgroundColor = TCColor;
    
        _mLabel.layer.cornerRadius = 2;
        
        _mLabel.layer.masksToBounds = YES;
        
        [self addSubview:_mLabel];
        
    }
    return _mLabel;
    /*天宝核对好吧额当天发布哈尔研讨会认识人挺好吧滨合同和比尔何如火热和太热退货同行*/
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyInfoCell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
    }
    
    
    return cell;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;

    [self setUpData];
    [self setUpRightView];
    

}
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    
}

- (void)setUpRightView
{
    if ([_item isKindOfClass:[SettingArrowItem class]]) { // 箭头
        self.accessoryView = self.myArrow;
    }
        
    else if ([_item isKindOfClass:[SettingLabelItem class]]){
        SettingLabelItem *labelItem = (SettingLabelItem *)_item;
        
        UILabel *label = self.mLabel;
        label.text = labelItem.text;
        
    }else{ // 没有
        self.accessoryView = nil;
        [_mLabel removeFromSuperview];
        _mLabel = nil;
    }
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(NSInteger)count
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    if (count == 1) { // 只有一行
//        bgView.image = [UIImage resizableWithImageName:@"common_card_background"];
//        selBgView.image = [UIImage resizableWithImageName:@"common_card_background_highlighted"];
        bgView.image = nil;
        selBgView.image = nil;
        
    }else if(indexPath.row == 0){ // 顶部cell
        bgView.image = [UIImage resizableWithImageName:@"common_card_top_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_top_background_highlighted"];
        
    }else if (indexPath.row == count - 1){ // 底部
        bgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_bottom_background_highlighted"];
        
    }else{ // 中间
        bgView.image = [UIImage resizableWithImageName:@"common_card_middle_background"];
        selBgView.image = [UIImage resizableWithImageName:@"common_card_middle_background_highlighted"];
    }
    
}


@end
