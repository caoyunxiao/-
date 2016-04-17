//
//  CommentsListCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/24.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "CommentsListCell.h"

@implementation CommentsListCell

- (void)awakeFromNib
{
//    NSString *str = self.CLCellFirstLabel.text;
    self.CLCellFirstLabel.layer.masksToBounds = YES;
    self.CLCellFirstLabel.layer.cornerRadius = 5;
    self.CLCellFirstLabel.userInteractionEnabled = YES;
    
    self.CLCellSecondLabel.layer.masksToBounds = YES;
    self.CLCellSecondLabel.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CLCellFirstLabelTap:)];
    [self.CLCellFirstLabel addGestureRecognizer:tap];
}

- (void)CLCellFirstLabelTap:(UITapGestureRecognizer *)tap
{
    if([self.delegate respondsToSelector:@selector(CLCellFirstLabelTap:)])
    {
        [self.delegate CLCellFirstLabelTap:0];
    }
}

- (void)showUIViewWithModel:(leaveWordsModel *)model
{
    self.CLCellName.text = model.nickName;
//    self.CLCellFirstLabel.text = model.content;
//    CGRect rect1 = [self dynamicHeight:model.content fontSize:12];
//    self.CLCellFirstLabel.frame = CGRectMake(0, 20, rect1.size.width+5, 20);

    NSArray *replyWord = model.replyWord;
    NSDictionary *dict = [replyWord firstObject];
    self.CLCellSecondLabel.text = dict[@"content"];
    CGRect rect2 = [self dynamicHeight:dict[@"content"] fontSize:12];
    self.CLCellSecondLabel.frame = CGRectMake(0, 20, rect2.size.width+5, 20);
}

- (CGRect)dynamicHeight:(NSString *)str fontSize:(NSInteger)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
