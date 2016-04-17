//
//  TCNTableViewHeaderView.m
//  CosFund
//
//  Created by 曹云霄 on 15/12/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TCNTableViewHeaderView.h"

@implementation TCNTableViewHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"TCNewHomeCell" owner:self options:nil] firstObject];
        [self uiConfigAction];
        
    }
    return self;
}

- (void)uiConfigAction
{
    
}

@end
