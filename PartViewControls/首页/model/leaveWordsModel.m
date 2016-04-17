//
//  leaveWordsModel.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/27.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "leaveWordsModel.h"

@implementation leaveWordsModel


- (void)setContent:(NSString *)content
{
    _content = content;
    CGSize s = [content boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    self.Contentsize = s;
    if (s.width > ScreenWidth-40) {
        
        CGSize News = [content boundingRectWithSize:CGSizeMake(ScreenWidth-40,9999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        self.Contentsize = News;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
