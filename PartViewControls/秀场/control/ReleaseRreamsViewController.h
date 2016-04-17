//
//  ReleaseRreamsViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/3.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "HySideScrollingImagePicker.h"

@interface ReleaseRreamsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    NSInteger _imageWidth;
    NSMutableArray *_imageArray;     //从相册中选择的照片
    //NSInteger _buttonIndex;        //发布梦想选择的方式
    NSMutableArray *_thumbnailsArr;  //缩略图
    NSURL *_videoFileURL;            //视频地址
    CGRect _hyFrame;
    BOOL _oneOrTwo;
}

@property (weak, nonatomic) IBOutlet UITableView *RDTableView;


@end
