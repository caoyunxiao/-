//
//  TCNewDetailViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/19.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"

@interface TCNewDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    NSInteger _yiJianKaBei;
    BOOL isFirstOne;
    NSMutableArray *_leaveWordsArr;
}

@property (weak, nonatomic) IBOutlet UITableView *TCNewTableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
- (IBAction)backButtonClick:(UIButton *)sender;           //返回按钮

@property (strong, nonatomic) NSURL *videoFileURL;        //视频地址
@property (nonatomic,assign) BOOL isFull;//是否全屏
@property (nonatomic,assign) BOOL isTap;//是否点击
@property (nonatomic,copy) NSString *dreamID;
@property (weak, nonatomic) IBOutlet UIView *MessageView;     //留言输入框背景
@property (weak, nonatomic) IBOutlet UITextField *MessageTestField;//留言输入框
@property (nonatomic,assign) BOOL isMyinfoEnter;                   //判断是否是从个人中心进入


@end
