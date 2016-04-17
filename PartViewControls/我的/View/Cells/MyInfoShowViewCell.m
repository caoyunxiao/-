//
//  MyInfoShowViewCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/14.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "MyInfoShowViewCell.h"
#import "DreamIconView.h"                          //滚动视图上的View

#import "PersonalHomepageController.h"             //个人主页的视图控制器
#import "TCNewDetailViewController.h"              //梦想详情页面

#import "SupportModel.h"                           //支持梦想的个人详情

#import "UIImageView+WebCache.h"                   //网络下载图片

@interface MyInfoShowViewCell ()



@end
@implementation MyInfoShowViewCell


- (void)awakeFromNib
{
      self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)configDataRow:(NSIndexPath *)indexpath supportMeArray:(NSArray *)suppoortMeArr mySupportArr:(NSArray *)
mySupportArr
{
    
    if (indexpath.row==2) {
        
        self.leftTitleLabel.text = @"最近支持我的人";
        if (suppoortMeArr.count == 0) {
            
            [self addLableWithText:@"最近还没有支持你的人哦~" tag:100];
        }
        else
        {
            [[self.contentView viewWithTag:100] removeFromSuperview];
            
            for (int i= 0; i<suppoortMeArr.count; i++) {
                
                //SupportModel *model = suppoortMeArr[i];
                
                SupportModel *model = [suppoortMeArr objectAtQYQIndex:i];
                
                
                [self setUpiconViewWithFrame:CGRectMake(i*((self.width-32)/5), 0, ((self.width-32)/5), 77) model:model indexpath:indexpath];
                
                
            }
            _scrollerView.contentSize = CGSizeMake(((self.width-32)/5)*suppoortMeArr.count, _scrollerView.height);

        }
    }
    if (indexpath.row ==3) {
        
        self.leftTitleLabel.text = @"我支持过的人";
        
        //NSLog(@"我支持过的人mySupportArr.count%@",mySupportArr);
        
        if (mySupportArr.count == 0) {
            
              [self addLableWithText:@"您还没有支持过谁哦~" tag:200];
        }
        else
        {
            [[self.contentView viewWithTag:200] removeFromSuperview];
            
            
            for (int i= 0; i<mySupportArr.count; i++) {
                
//                SupportModel *model = mySupportArr[i];
                
                 SupportModel *model = [mySupportArr objectAtQYQIndex:i];
                
                
                [self setUpiconViewWithFrame:CGRectMake(i*((self.width-32)/5), 0, ((self.width-32)/5), 77) model:model indexpath:indexpath];
                
            }
            _scrollerView.contentSize = CGSizeMake(((self.width-32)/5)*mySupportArr.count, _scrollerView.height);
        }
   }
}

#pragma mark - 添加数据为空的遮罩
- (void)addLableWithText:(NSString *)text tag:(NSInteger)tag
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.height)];
    label.tag = tag;
    label.backgroundColor = [UIColor clearColor];

    label.text = text;
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = TCColordefault;
    [self.contentView addSubview:label];
}
#pragma mark - 创建头像图标
- (void)setUpiconViewWithFrame:(CGRect)Frame model:(SupportModel *)model indexpath:(NSIndexPath *)indexpath
{
    DreamIconView *dreamIconView = [[DreamIconView alloc] initWithFrame:Frame];
    
    
    [dreamIconView.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.headImg]] placeholderImage:PlaceholderImage];
    
    dreamIconView.nameLabel.text = model.nickName;
    
    dreamIconView.suppotrCountLabel.text = model.amount;
    
    dreamIconView.option =  ^{
            
    PersonalHomepageController *Vc =[[PersonalHomepageController alloc] init];
            
        if (model.userID.length !=0) {
                
                Vc.model = model;
        }
            
        [self.navc pushViewController:Vc animated:YES];
            
        };
    
    [_scrollerView addSubview:dreamIconView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
