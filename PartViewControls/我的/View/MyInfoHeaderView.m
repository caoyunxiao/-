//
//  MyInfoHeaderView.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/9.
//  Copyright © 2015年 ZFJ. All rights reserved.
//  *******************我的顶部头视图

#import "MyInfoHeaderView.h"
#import "UIImageView+WebCache.h"
@implementation MyInfoHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code rthrthrthrgergergergerger
}
*/


- (void)awakeFromNib
{
    NSLog(@"初始化头像");
    self.myHeardIamgeView.userInteractionEnabled = NO;
    self.myHeardIamgeView.layer.borderWidth = 0.3;
    [self.myHeardIamgeView.layer setCornerRadius:self.myHeardIamgeView.height/2];
    [self.myHeardIamgeView.layer setMasksToBounds:YES];
    self.myHeardIamgeView.layer.borderColor = TCColordefault.CGColor;
    /*h45th64t6h4t6h4h*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshUI) name:@"InfoSuccess" object:nil];
    [self refreshUI];
    
}
- (void)refreshUI
{
    
    
    NSLog(@"%s",__func__);
    [self.myHeardIamgeView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:[PersonInfo sharePersonInfo].headImg]] placeholderImage:PlaceholderImage];
    
    
    if (self.myHeardIamgeView.image == nil) {
        self.myHeardIamgeView.image = [UIImage imageNamed:@"my_touxiang.png"];
    }

    self.nameLabel.text = [PersonInfo sharePersonInfo].nickname;
    self.intrduceLaebl.text = [PersonInfo sharePersonInfo].describe;
}

//点击梦想的按钮
- (IBAction)showBtnClick:(UIButton *)sender {
   
  if ([_delegate respondsToSelector:@selector(myInfoHeaderViewshowBtnClick:)]) {
        
        [_delegate myInfoHeaderViewshowBtnClick:sender];
        
    }
    
}
//点击钱包的按钮
- (IBAction)puserBtnClick:(UIButton *)sender {
    

    
    if ([_delegate respondsToSelector:@selector(myInfoHeaderViewpuserBtnClick:)]) {
        
        [_delegate myInfoHeaderViewpuserBtnClick:sender];
        
    }
}
//点击任务的按钮
- (IBAction)taskBtnClick:(UIButton *)sender {


    if ([_delegate respondsToSelector:@selector(myInfoHeaderViewtaskBtnClick:)]) {
        
        [_delegate myInfoHeaderViewtaskBtnClick:sender];
        
    }

    
}
//点击购物车的按钮
- (IBAction)shoppingCartClick:(UIButton *)sender {
    
    
    if ([_delegate respondsToSelector:@selector(myInfoHeaderViewshoppingCartClick:)]) {
        
        [_delegate myInfoHeaderViewshoppingCartClick:sender];
        
    }
    
}
//点击编辑的按钮
- (IBAction)editBtnClick:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(myInfoHeaderViewEditBtnClick)]) {
        [_delegate myInfoHeaderViewEditBtnClick];
    
    }
}

-(void)dealloc{
    
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
