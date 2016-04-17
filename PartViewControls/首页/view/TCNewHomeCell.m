//
//  TCNewHomeCell.m
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/20.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "TCNewHomeCell.h"
#import "DreamLabelModel.h"
#import "leaveWordsModel.h"

@implementation TCNewHomeCell

- (void)awakeFromNib {
    // Initialization code

    
    self.CellFourHasDown.layer.masksToBounds = YES;
    self.CellFourHasDown.layer.cornerRadius = 55/2;
    
    self.CellThreeTopUp.layer.masksToBounds = YES;
    self.CellThreeTopUp.layer.cornerRadius = 5;
    self.CellThreeTopUp.layer.borderColor = [UIColor whiteColor].CGColor;
    self.CellThreeTopUp.layer.borderWidth = 1.0;
    self.CellThreeTopUp.hidden = YES;
    
    self.EndDreamButton.layer.cornerRadius = 3;
    self.EndDreamButton.layer.masksToBounds = YES;
    self.ReportButton.layer.cornerRadius = 3;
    self.ReportButton.layer.masksToBounds = YES;
    self.CellSixShare.layer.cornerRadius = 3;
    self.CellSixShare.layer.masksToBounds = YES;
    self.ShareBackView.layer.cornerRadius = 3;
    self.ShareBackView.layer.masksToBounds = YES;
    
    _heightOld = 40;
    
    self.CellFourHeadImage.layer.masksToBounds = YES;
    self.CellFourHeadImage.layer.cornerRadius = self.CellFourHeadImage.width/2;
    self.CellFourHeadImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.CellFourHeadImage.layer.borderWidth = 2.0;
    
    self.stareer.layer.masksToBounds = YES;
    self.stareer.layer.cornerRadius = 20/2;
    self.stareer.layer.borderColor = [UIColor whiteColor].CGColor;
    self.stareer.layer.borderWidth = 2.0;
    
    isFirstFive = NO;
    isFirstOne = NO;
    isCellTwo = NO;
    isCellFour = NO;
    isCellThree = NO;
    
//    _CellFiveSentMessage = [[UIButton alloc]init];
//    _CellFiveSentMessage.hidden = YES;
//    [_CellFiveSentMessage setTitle:@"发送留言" forState:UIControlStateNormal];
//    [_CellFiveSentMessage setBackgroundColor:[UIColor colorWithRed:210/255.0 green:0 blue:104/255.0 alpha:1.0]];
//    [_CellFiveSentMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    _CellFiveSentMessage.titleLabel.font = [UIFont systemFontOfSize:14];
//    [self.CellFive addSubview:_CellFiveSentMessage];
    
    
}

- (void)showCellOneUIViewWithHomeModel:(HomeModel *)model
{
    if(isFirstOne)
    {
        return;
    }
    isFirstOne = YES;
}


#pragma mark -第二个cell
- (void)showCellTwoUIViewWithHomeModel:(HomeModel *)model
{

    /**
     *  重新计算frame
     */
    self.dreamSlogan.text = model.slogan;
    CGSize s = [model.slogan boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    CGRect kouhaoFrame = self.CellTwoKouHao.frame;
    kouhaoFrame.origin.x = self.bounds.size.width-60-s.width;
    self.CellTwoKouHao.frame = kouhaoFrame;
    
//    self.CellTwoKouHao.frame = CGRectMake(ScreenWidth-60-s.width, self.CellTwoKouHao.frame.origin.y, self.CellTwoKouHao.frame.size.width, self.CellTwoKouHao.frame.size.height);
    self.dreamSlogan.frame = CGRectMake(self.bounds.size.width-8-s.width, self.dreamSlogan.frame.origin.y, s.width, 20);
    self.CellTwoTitle.text = model.name;
    
    
    _Model = model;
    NSArray *picVid = model.picVid;
    int Batch = 0;
    for (int i=0; i<picVid.count; i++) {
//        NSDictionary *dict = picVid[i];
        
        NSDictionary *dict = [picVid objectAtQYQIndex:i];
        
        if (Batch <= [dict[@"Batch"] intValue]) {
          Batch = [dict[@"Batch"] intValue];
        }
    }
    

    
    
    [[NSUserDefaults standardUserDefaults] setObject:@(Batch) forKey:@"batch"];
    for (int i = 0; i<Batch+1; i++)
    {

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(75*i, 0, 70, 70)];
        view.backgroundColor = [UIColor blackColor];
        [self.CellTwoScollView addSubview:view];
        view.clipsToBounds = YES;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.layer.borderWidth = 1.0f;
        imageView.layer.borderColor = TCColor.CGColor;
        imageView.tag = 100+i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DreamtrajectoryClick:)]];
        [view addSubview:imageView];
        int indexPage = 0;
        for (NSDictionary *dict in picVid) {
            
            //判断是否是视频轨迹
            if ([dict[@"Batch"] integerValue] == i && [dict[@"Type"] integerValue] == 2) {
                
                UIImageView *PlayimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
                PlayimageView.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
                [imageView addSubview:PlayimageView];
                PlayimageView.image = [UIImage imageNamed:@"playvideo"];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:model.cover]] placeholderImage:PlaceholderImage];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                break;

            }
            else
            {
                if ([dict[@"Batch"] integerValue] == i && [dict[@"Type"] integerValue] == 1) {
                    
                    indexPage ++;
                }
            }
        }
            if (indexPage) {
                
                for (NSDictionary *dict in picVid) {
                    
                    if ([dict[@"Type"] integerValue] == 1 && [dict[@"Batch"] integerValue] == i) {
                        
                        [imageView sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:dict[@"Url"]]] placeholderImage:PlaceholderImage];
                        imageView.contentMode = UIViewContentModeScaleAspectFill;
                        imageView.backgroundColor = [UIColor clearColor];
                        break;
                    }
                }
                UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
                labe.text = [NSString stringWithFormat:@"%d",indexPage];
                labe.font = [UIFont systemFontOfSize:8];
                labe.textAlignment = NSTextAlignmentCenter;
                labe.backgroundColor = [UIColor whiteColor];
                labe.textColor = TCColor;
                labe.layer.masksToBounds = YES;
                labe.layer.cornerRadius = 5;
                labe.center = CGPointMake(imageView.frame.size.width*8/10, imageView.frame.size.height*2/10);
                [imageView addSubview:labe];
            }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
        [view addSubview:label];
        label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height*9/10);
        label.text = [NSString stringWithFormat:@"第%d期",i+1];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    //判断是否显示添加梦想轨迹
    if([model.userID integerValue]== [[PersonInfo sharePersonInfo].userId integerValue] && Batch <= 2 ) {
        self.AddButton = [[UIButton alloc]initWithFrame:CGRectMake(75*(Batch+1), 0, 70, 70)];
        [self.CellTwoScollView addSubview:self.AddButton];
        self.AddButton.backgroundColor = [UIColor whiteColor];
        [self.AddButton setImage:[UIImage imageNamed:@"SV_Add"] forState:UIControlStateNormal];
        [self.AddButton addTarget:self action:@selector(addDreamButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.CellTwoScollView .contentSize = CGSizeMake(75*(Batch+2), 0);
    }
    else
    {
        self.CellTwoScollView .contentSize = CGSizeMake(75*(Batch+1), 0);
    }
    
}

#pragma mark -响应的梦想轨迹点击
- (void)DreamtrajectoryClick:(UITapGestureRecognizer *)Tap
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshFirstCell" object:@(Tap.view.tag)];
    NSArray *array = _Model.picVid;
    //判断两次点击是否是同一个
    if (Tap.view.tag == self.indexNumber || array.count == 1) {
        
        return;
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshFirstCell" object:@(Tap.view.tag)];
    }
    self.indexNumber = Tap.view.tag;
}


#pragma mark -添加梦想轨迹加号点击
- (void)addDreamButtonClick:(UIButton *)button
{
    if([self.delegate respondsToSelector:@selector(addDreamButtonClick:)])
    {
        [self.delegate addDreamButtonClick:button];
    }
}

- (NSString *)getHowManyDays:(NSDictionary *)dict
{
    //剩余时间
    NSString *endDate = [dict objectForKey:@"CreateTime"];
    NSArray *array = [endDate componentsSeparatedByString:@"("];
    endDate = [array lastObject];
    array = [endDate componentsSeparatedByString:@"+"];
    endDate = [array firstObject];
    
    endDate = [endDate substringWithRange:NSMakeRange(0, 10)];
    
    NSString *endDateStr = [BaseViewController getTimerStrFromTimestamp:endDate];//截止日期
    NSString *nowTimer = [BaseViewController getTimerStrFromTimestamp:[BaseViewController getTheTimestamp]];//现在时间
    NSString *dayTimer = [self intervalFromLastDate:endDateStr toTheDate:nowTimer];
    NSString *strDay = [NSString stringWithFormat:@"第%@天",dayTimer];
    return strDay;
}



#pragma mark -我的咖贝数，和我支持梦想的咖贝数
- (void)ShowMoneyNumber:(NSString *)dreameid
{
//    NSDictionary *wParamDict = @{@"userid":[PersonInfo sharePersonInfo].userId};
    
    NSDictionary *wParamDict = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", nil];
    
    [RequestEngine UserModulescollegeWithDict:wParamDict wAction:@"305" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if([errorCode isEqualToString:@"0"])
        {
            NSArray *array = (NSArray *)resultDict;
            NSString *string = [array[0] stringValue];
            if ([array[0] integerValue]>10000) {
                
                self.MyKabeiString.text = [NSString stringWithFormat:@"我的咖贝：%ldW咖贝",(long)[array[0] integerValue]/10000];
            }
            else
            {
               self.MyKabeiString.text = [NSString stringWithFormat:@"我的咖贝：%@咖贝",string];
            }
        }
        if ([errorCode isEqualToString:@"3003"]) {
            
          self.MyKabeiString.text = [NSString stringWithFormat:@"我的咖贝：%@咖贝",@"0"];
        }
        else
        {
            NSLog(@"咖贝余额ReturnCode  ===  %@",[ReturnCode getResultFromReturnCode:errorCode]);
            return ;
        }
    }];
    
    //获取对梦想的支持咖贝数
   // NSDictionary *personID = @{@"userid":[PersonInfo sharePersonInfo].userId,@"dreamid":dreameid};
    
    NSDictionary *personID = [NSDictionary dictionaryWithObjectsAndKeys:[PersonInfo sharePersonInfo].userId,@"userid", dreameid,@"dreamid", nil];
    
    [RequestEngine UserModulescollegeWithDict:personID wAction:@"508" completed:^(NSString *errorCode, NSDictionary *resultDict) {
                
        NSArray *array = (NSArray *)resultDict;
        if ([[array firstObject] integerValue]>10000) {
           self.CellThreeAllFor.text = [NSString stringWithFormat:@"我支持的咖贝数:%ldW咖贝",(long)[array[0] integerValue]/10000];
        }
        else
        {
           self.CellThreeAllFor.text = [NSString stringWithFormat:@"我支持的咖贝数:%@咖贝",[[array firstObject] stringValue]];
        }
    }];
}




- (void)showCellFourUIViewWithHomeModel:(HomeModel *)model
{
    
    _Model = model;
    //是否显示终结梦想按钮
    if ([model.userID integerValue] == [[PersonInfo sharePersonInfo].userId integerValue]) {
        
        _EndDreamButton.hidden = NO;
    }
    else
    {
        CGRect frame = _ReportButton.frame;
        if (frame.origin.x != ScreenWidth-_ReportButton.frame.size.width-20) {
            
            frame.origin.x = ScreenWidth-_ReportButton.frame.size.width-20;
            _ReportButton.frame = frame;
        }
        _EndDreamButton.hidden = YES;
    }
    //获取用户简单信息
    [RequestEngine UserModulescollegeWithDict:@{@"userid":model.userID} wAction:@"511" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        if ([errorCode isEqualToString:@"0"]) {
            
            NSArray *array = (NSArray *)resultDict;
            self.CellFourHeadImage.userInteractionEnabled = YES;
            self.CellFourHeadImage.contentMode = UIViewContentModeScaleAspectFill;
            self.CellFourHeadImage.clipsToBounds = YES;
            [self.CellFourHeadImage sd_setImageWithURL:[NSURL URLWithString:[BaseViewController getImageUrlWithKey:array[0][@"headImg"]]] placeholderImage:PlaceholderImage];
            
        }
        else
        {
            NSLog(@"%@",[ReturnCode getResultFromReturnCode:errorCode]);
        }
        
    }];

    [self.CellFourHeadImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clickimage)]];
    //梦想标签
    NSArray *dreamLable = model.dreamLable;
    if(dreamLable.count>0)
    {
        //CellFourLabel
        for (int i = 0; i<dreamLable.count; i++)
        {
//            NSDictionary *dict = dreamLable[i];
            
             NSDictionary *dict = [dreamLable objectAtQYQIndex:i];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70*i, 0, 55, 15)];
            label.text = dict[@"name"];
            label.tag = [dict[@"lableID"] integerValue];
            label.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1];
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 5;
            label.textColor = [UIColor whiteColor];
            [self.CellFourLabel addSubview:label];
        }
    }
    self.CellFourDreamTitle.text = model.name;
    self.CellFourMiaoShu.text = model.describe;
    self.createUser.text = model.createUser;
    self.NeededCompleteDream.text = [NSString stringWithFormat:@"完成梦想需要:%@咖贝",model.minimumValue];
    self.NeededMoney = model.minimumValue;
    //打赏集合
    self.hasDown.text = [NSString stringWithFormat:@"已完成:%@咖贝",model.raiseAmount];
    //剩余时间
    self.remainingDays.text = [NSString stringWithFormat:@"剩余:%@",[BaseViewController intervalSinceNow:model.endDate]];
    //获取梦想打赏次数
    NSDictionary *dict = @{@"dreamid":model.dreamID};
    [RequestEngine UserModulescollegeWithDict:dict wAction:@"523" completed:^(NSString *errorCode, NSDictionary *resultDict) {
        
        NSInteger GoodNumber = 0;
        if ([errorCode isEqualToString:@"0"]) {
            
            NSArray *arr = (NSArray *)resultDict;
            GoodNumber = [[arr firstObject] integerValue];
            
        }
        else if ([errorCode isEqualToString:@"110"])
        {
            GoodNumber = 0;
        }
        self.exceptionalPeople.text = [NSString stringWithFormat:@"打赏次数:%ld次",(long)GoodNumber];
    }];
    
    if(_setProgress==nil)
    {
        _setProgress = [[UCZProgressView alloc]initWithFrame:self.CellFourHasDown.bounds];
        [self.CellFourHasDown addSubview:_setProgress];
        _setProgress.showsText = YES;
        _setProgress.radius = self.CellFourHasDown.bounds.size.width/2-2;
        _setProgress.tintColor = [UIColor colorWithRed:210/255.0 green:0 blue:104/255.0 alpha:1.0];
        CGFloat raisePercent = [model.raisePercent floatValue];
        [_setProgress setProgress:raisePercent animated:NO];
    }
    [self.CellFourHasDown bringSubviewToFront:self.completeBtn];
}


#pragma mark -用户头像点击
- (void)Clickimage
{
    if (_PersonImageClickBlock) {
        
        _PersonImageClickBlock(_Model.userID);
    }
}

#pragma amrk -举报按钮点击
- (IBAction)ReportButtonClick:(id)sender {
    
    if (_ReportButtonClickBlock) {
        
        _ReportButtonClickBlock(_Model.userID);
    }
}


#pragma mark - 回复
- (void)setReplyWordUIViewWith:(UIView *)leaveView dict:(NSDictionary *)dict
{
    UILabel *labelKey = [[UILabel alloc]initWithFrame:CGRectMake(8, 50, 30, 20)];
    labelKey.text = @"回复:";
    [leaveView addSubview:labelKey];
    labelKey.textAlignment = NSTextAlignmentCenter;
    labelKey.textColor = [UIColor whiteColor];
    labelKey.font = [UIFont systemFontOfSize:12];
    
    NSString *content = [NSString stringWithFormat:@" %@",dict[@"content"]];
    CGRect rect = [self dynamicHeight:content fontSize:12];
    UILabel *ReplyLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, rect.size.width+5, 20)];
    ReplyLabel.backgroundColor = [UIColor colorWithRed:168/255.0 green:169/255.0 blue:170/255.0 alpha:1.0];
    ReplyLabel.textColor = [UIColor blackColor];
    ReplyLabel.font = [UIFont systemFontOfSize:12];
    ReplyLabel.text = content;
    ReplyLabel.layer.masksToBounds = YES;
    ReplyLabel.layer.cornerRadius = 10;
    [leaveView addSubview:ReplyLabel];
}

#pragma mark - 计算时间差
- (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSArray *timeArray1=[dateString1 componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtQYQIndex:0];
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtQYQIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d1=[date dateFromString:dateString1];
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1;
//    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
//    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];//以时分秒的形式返回
    
    NSInteger daySen = 24*60*60;
    
    NSInteger houseInt = [house integerValue];
    NSInteger minInt = [min integerValue];
    NSInteger senInt = [sen integerValue];
    
    CGFloat dayNum = (houseInt*60*60+minInt*60+senInt)/daySen;
    
    //返回剩余多少天
    return [NSString stringWithFormat:@"%.0f",dayNum];
}




- (CGRect)dynamicHeight:(NSString *)str fontSize:(NSInteger)fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect;
}

#pragma mark - 设置标签颜色
- (NSArray *)setMarkBackColor
{
    //设定7种颜色 存放在数组里面
    NSMutableArray *colorArray = [[NSMutableArray alloc]init];
    UIColor *colorA = [UIColor colorWithRed:245/255.0 green:138/255.0 blue:39/255.0 alpha:1.00f];
    UIColor *colorB = [UIColor colorWithRed:253/255.0 green:194/255.0 blue:50/255.0 alpha:1.00f];
    UIColor *colorC = [UIColor colorWithRed:143/255.0 green:195/255.0 blue:56/255.0 alpha:1.00f];
    UIColor *colorD = [UIColor colorWithRed:168/255.0 green:92/255.0 blue:23/255.0 alpha:1.00f];
    UIColor *colorE = [UIColor colorWithRed:238/255.0 green:53/255.0 blue:79/255.0 alpha:1.00f];
    UIColor *colorF = [UIColor colorWithRed:150/255.0 green:64/255.0 blue:146/255.0 alpha:1.00f];
    UIColor *colorG = [UIColor colorWithRed:103/255.0 green:105/255.0 blue:116/255.0 alpha:1.00f];
    UIColor *colorH = [UIColor colorWithRed:60/255.0 green:193/255.0 blue:236/255.0 alpha:1.00f];
    UIColor *colorI = [UIColor colorWithRed:86/255.0 green:136/255.0 blue:119/255.0 alpha:1.00f];
    UIColor *colorJ = [UIColor colorWithRed:112/255.0 green:148/255.0 blue:202/255.0 alpha:1.00f];
    [colorArray addObject:colorA];
    [colorArray addObject:colorB];
    [colorArray addObject:colorC];
    [colorArray addObject:colorD];
    [colorArray addObject:colorE];
    [colorArray addObject:colorF];
    [colorArray addObject:colorG];
    [colorArray addObject:colorH];
    [colorArray addObject:colorI];
    [colorArray addObject:colorJ];
    return colorArray;
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
