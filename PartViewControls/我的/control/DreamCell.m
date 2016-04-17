//
//  DreamCell.m
//  CosFund
//
//  Created by qiuyaqingMac on 15/12/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "DreamCell.h"
#import "DreamPicVidModel.h"       //梦想媒体模型

@implementation DreamCell

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configModle:(HomeModel *)model
{
    self.dreamTitleLabel.text = model.name.description;
    
    self.dreamNameLable.text = model.name.description;
    
//    self.dreamNameLable.width = [self INcomingStringReturn:self.dreamNameLable.text]+20;
    
    
    self.dreamKouHao.text = [NSString stringWithFormat:@"梦想口号:%@",model.slogan];
    

   // self.dreamKouHao.x = ScreenWidth - self.dreamKouHao.width-20;
    

    if ([model.state.description isEqualToString:@"2"]) {
        
        [self.dreamStateImage setImage:[UIImage imageNamed:@"my_dream_success.png"]];
    }
    else
    {
        [self.dreamStateImage setImage:[UIImage imageNamed:@"my_dream_fail.png"]];
    }
    
    self.describTextView.text = model.describe;
    
    NSArray *picVid = model.picVid;
    NSMutableArray *picArrGroup = [NSMutableArray array];
    NSMutableArray *picArrZero = [NSMutableArray array];
    NSMutableArray *picArrOne = [NSMutableArray array];
    NSMutableArray *picArrTwo = [NSMutableArray array];
    NSMutableArray *picArrThree = [NSMutableArray array];
    NSMutableArray *picArrFour = [NSMutableArray array];
    
    for (int i =0; i<picVid.count;i++ ) {
        
        //NSDictionary *dict = picVid[i];
        
        NSDictionary *dict = [picVid objectAtQYQIndex:i];
        
        DreamPicVidModel *picModel = [[DreamPicVidModel alloc] init];
        picModel.Batch = [dict[@"Batch"] description];
        picModel.CreateTime = dict[@"CreateTime"];
        picModel.DreamID = [dict[@"DreamID"] description];
        picModel.MediaID = [dict[@"MediaID"] description];
        picModel.State = [dict[@"State"] description];
        picModel.Type = [dict[@"Type"] description];
        picModel.Url = [dict[@"Url"] description];
        if ([picModel.Batch isEqualToString:@"0"] ) {
            [picArrZero addObject:picModel];
           
            
        }
        if ([picModel.Batch isEqualToString:@"1"]) {
            [picArrOne addObject:picModel];
            
        }
        if ([picModel.Batch isEqualToString:@"2"]) {
            [picArrTwo addObject:picModel];
            
        }
        if ([picModel.Batch isEqualToString:@"3"]) {
            [picArrThree addObject:picModel];
            
        }
        
        if ([picModel.Batch isEqualToString:@"4"]) {
            [picArrFour addObject:picModel];
            
        }
        
    }
    if (picArrZero.count>0) {
         NSLog(@"第1期添加了");
         [picArrGroup addObject:picArrZero];
    }
    if (picArrOne.count>0) {
        NSLog(@"第2期添加了");
        [picArrGroup addObject:picArrOne];
    }

    if (picArrTwo.count>0) {
        NSLog(@"第3期添加了");
        [picArrGroup addObject:picArrTwo];
    }

    if (picArrThree.count>0) {
         NSLog(@"第4期添加了");
        [picArrGroup addObject:picArrThree];
    }
    if (picArrFour.count>0) {
         NSLog(@"第5期添加了");
        [picArrGroup addObject:picArrFour];
    }
    
    _returnPic = picArrGroup;
    
    NSLog(@"index ++;%@",picArrGroup);
    
    int index = 0;
    
    for (int t=0; t<picArrGroup.count; t++) {
        
        index ++;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(75*t, 0, 70, 70)];
        
        view.backgroundColor = [UIColor whiteColor];
        [self.dreamScrollerVire addSubview:view];
        view.clipsToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.layer.borderWidth = 1.0f;
        imageView.layer.borderColor = TCColor.CGColor;
        imageView.tag = 100+t;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DreamtrajectoryClick:)]];
        [view addSubview:imageView];
        //加徽标
        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        
//        [picArrGroup objectAtQYQIndex:t];
        
        labe.text = [NSString stringWithFormat:@"%lu",[[picArrGroup objectAtQYQIndex:t] count]];
        
        labe.font = [UIFont systemFontOfSize:8];
        labe.textAlignment = NSTextAlignmentCenter;
        labe.backgroundColor = [UIColor whiteColor];
        labe.textColor = TCColor;
        labe.layer.masksToBounds = YES;
        labe.layer.cornerRadius = 5;
        labe.center = CGPointMake(imageView.frame.size.width*8/10, imageView.frame.size.height*2/10);
        [imageView addSubview:labe];
        
        //第几期
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
        [view addSubview:label];
        label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height*9/10);
        label.text = [NSString stringWithFormat:@"第%d期",t+1];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        DreamPicVidModel *picModel = picArrGroup[t][0];
        if ([picModel.Type isEqualToString:@"2"]) {
            
        UIImageView *PlayimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        PlayimageView.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
        [imageView addSubview:PlayimageView];
        PlayimageView.image = [UIImage imageNamed:@"playvideo"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
        imageView.contentMode = UIViewContentModeScaleAspectFill;

        }
        else
        {
        
            [imageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:picModel.Url]] placeholderImage:PlaceholderImage];
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;

            imageView.backgroundColor = [UIColor clearColor];
    
        }
      
    }
    //判断是否显示添加梦想感言
     if([model.userID.description isEqualToString:[PersonInfo sharePersonInfo].userId] && [model.state.description isEqualToString:@"2"] && picArrFour.count==0) {
         
        UIButton *AddButton = [[UIButton alloc]initWithFrame:CGRectMake(75*(index), 0, 70, 70)];
        [self.dreamScrollerVire addSubview:AddButton];
        AddButton.backgroundColor = [UIColor whiteColor];
        [AddButton setImage:[UIImage imageNamed:@"SV_Add"] forState:UIControlStateNormal];
        [AddButton addTarget:self action:@selector(addDreamButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.dreamScrollerVire .contentSize = CGSizeMake(75*(index+2), 0);
            }
    else
    {
        self.dreamScrollerVire .contentSize = CGSizeMake(75*(index+1), 0);

    }


}

/**
 *  计算字符串宽度
 *
 *  @return
 */
- (CGFloat)INcomingStringReturn:(NSString *)Str
{
    CGFloat width = [Str boundingRectWithSize:CGSizeMake(9999, 30) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
    return width;
}

#pragma mark - 按钮点击的方法
- (void)addDreamButtonClick:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(DreamCellAddDreamButtonClick:)]) {
        [_delegate DreamCellAddDreamButtonClick:btn];
        
    }
}

#pragma mark -响应的梦想轨迹点击
- (void)DreamtrajectoryClick:(UITapGestureRecognizer *)Tap
{
    if ([_delegate respondsToSelector:@selector(DreamCellDreamtrajectoryClick:array:)]) {
        
        [_delegate DreamCellDreamtrajectoryClick:Tap array:_returnPic];
        
    }

}


@end
