//
//  ShowViewController.h
//  CosFund
//
//  Created by vivian on 15/9/22.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "LoadingButton.h"

@interface ShowViewController : BaseViewController{
    NSMutableArray *_dataArray;    //最新 -- 数据源数组
    NSMutableArray *_hotDataArr;   //最热
    NSMutableArray *_hasDownArr;   //已完成
    NSMutableArray *_titleArray;   //头部标签数组
    
    BOOL _isShowFabuBtn;           //是否显示发布页面
    NSInteger _indexBtn;
    
    NSString *_sorting;
    
    LoadingButton *_loadButton;
    
    NSInteger _loadingCount;
    UINavigationController *navigation; //拍摄视频导航栏
}


@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;




@end
