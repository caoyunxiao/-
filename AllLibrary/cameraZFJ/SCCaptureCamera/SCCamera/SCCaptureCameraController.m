//
//  SCCaptureCameraController.m
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-16.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import "SCCaptureCameraController.h"
#import "SCSlider.h"
#import "SCCommon.h"
#import "PublishedPhotosViewController.h"
#import "SCNavigationController.h"
#import "SGImagePickerController.h"

#define SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE      0   //对焦框是否一直闪到对焦完成

//height
#define CAMERA_TOPVIEW_HEIGHT   0  //title
#define CAMERA_MENU_VIEW_HEIGH  44  //menu

//对焦
#define ADJUSTINT_FOCUS @"adjustingFocus"
#define LOW_ALPHA   0.7f
#define HIGH_ALPHA  1.0f

@interface SCCaptureCameraController ()
{
    int alphaTimes;
    CGPoint currTouchPoint;
    UIButton *_photoAlbumChooseButton;//相册选择button
    UIButton *_downButton;//完成button
    NSInteger _photoCount;
    NSMutableArray *_imageArray;//存放照片的数组
    NSMutableArray *_photoArray;//拍照的数组
}

@property (nonatomic, strong) SCCaptureSessionManager *captureManager;
@property (nonatomic, strong) UIView *bottomContainerView;//除了顶部标题、拍照区域剩下的所有区域
@property (nonatomic, strong) UIView *cameraMenuView;//网格、闪光灯、前后摄像头等按钮
@property (nonatomic, strong) NSMutableSet *cameraBtnSet;

@property (nonatomic, strong) UIView *doneCameraUpView;
@property (nonatomic, strong) UIView *doneCameraDownView;

//对焦
@property (nonatomic, strong) UIImageView *focusImageView;

@property (nonatomic, strong) SCSlider *scSlider;

@end

@implementation SCCaptureCameraController

#pragma mark -------------life cycle---------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        alphaTimes = -1;
        currTouchPoint = CGPointZero;
        _cameraBtnSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _photoCount = 0;
    _imageArray = [[NSMutableArray alloc]init];
    _photoArray = [NSMutableArray array];
    
    //AvcaptureManager
    if (CGRectEqualToRect(_previewRect, CGRectZero)) {
        self.previewRect = CGRectMake(0, 0, SC_APP_SIZE.width, SC_APP_SIZE.width + CAMERA_TOPVIEW_HEIGHT);
    }
    //session manager
    SCCaptureSessionManager *manager = [[SCCaptureSessionManager alloc] init];
    [manager configureWithParentLayer:self.view previewRect:_previewRect];
    self.captureManager = manager;

    [self addbottomContainerView];
    [self addCameraMenuView];
    [self addFocusView];
    [self addCameraCover];
    [self addPinchGesture];

    /**
     *  4S隐藏底部imageview
     */
    if (isHigherThaniPhone4_SC) {
        
        [self setdownImageView];
    }
    
    [_captureManager.session startRunning];
}

- (void)dealloc
{
    if (!self.navigationController)
    {
        if ([UIApplication sharedApplication].statusBarHidden != _isStatusBarHiddenBeforeShowCamera) {
            [[UIApplication sharedApplication] setStatusBarHidden:_isStatusBarHiddenBeforeShowCamera withAnimation:UIStatusBarAnimationSlide];
        }
    }
    
    #if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device && [device isFocusPointOfInterestSupported])
    {
        [device removeObserver:self forKeyPath:ADJUSTINT_FOCUS context:nil];
    }
    #endif
    
    self.captureManager = nil;
}

#pragma mark - 设置底部imageview
- (void)setdownImageView
{
    for (int i = 0; i<6; i++)
    {
        //cameraMenuView
        CGFloat width = (ScreenWidth-7*10)/6;
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10+(width+10)*i, ScreenHeight - (width + 10), width, width)];
        view.contentMode = UIViewContentModeScaleAspectFill;
        [self.cameraMenuView addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1.0];
        view.tag = 50 + i;
        view.clipsToBounds = YES;
    }
}

#pragma mark - bottomContainerView，总体
- (void)addbottomContainerView {
    
    CGFloat bottomY = _captureManager.previewLayer.frame.origin.y + _captureManager.previewLayer.frame.size.height;
    CGRect bottomFrame = CGRectMake(0, bottomY, SC_APP_SIZE.width, SC_APP_SIZE.height - bottomY + 20);
    
    UIView *view = [[UIView alloc] initWithFrame:bottomFrame];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    self.bottomContainerView = view;
}

#pragma mark - 拍照菜单栏
- (void)addCameraMenuView {
    
    //拍照按钮
    CGFloat downH = (isHigherThaniPhone4_SC ? CAMERA_MENU_VIEW_HEIGH : 0);
    CGFloat view_y = _bottomContainerView.frame.size.height - downH;
    CGFloat cameraBtnLength = 80;
    CGFloat camera_x = (SC_APP_SIZE.width - cameraBtnLength) / 2;
    [self buildButton:CGRectMake(camera_x, (view_y - cameraBtnLength) / 2 , cameraBtnLength, cameraBtnLength)
         normalImgStr:@"circle.png"
      highlightImgStr:@"circle.png"
       selectedImgStr:@"circle.png"
               action:@selector(takePictureBtnPressed:)
           parentView:_bottomContainerView];
    
    //相册选择
    CGFloat ChooseBtnLength = 40;
    _photoAlbumChooseButton = [[UIButton alloc]initWithFrame:CGRectMake((camera_x - ChooseBtnLength)/2, (view_y - ChooseBtnLength) / 2, ChooseBtnLength, ChooseBtnLength)];
    [_photoAlbumChooseButton setImage:[UIImage imageNamed:@"photoAlbumChoose"] forState:UIControlStateNormal];
    [_bottomContainerView addSubview:_photoAlbumChooseButton];
    [_photoAlbumChooseButton addTarget:self action:@selector(photoAlbumChooseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //完成选择界面
    CGFloat downButton_x = camera_x + cameraBtnLength + (ScreenWidth - camera_x - cameraBtnLength - ChooseBtnLength)/2;
    _downButton = [[UIButton alloc]initWithFrame:CGRectMake(downButton_x, (view_y - ChooseBtnLength) / 2, ChooseBtnLength, ChooseBtnLength)];
    [_downButton setImage:[UIImage imageNamed:@"downButtonImage"] forState:UIControlStateNormal];
    [_bottomContainerView addSubview:_downButton];
    [_downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //拍照的菜单栏view（屏幕高度大于480的，此view在上面，其他情况在下面）
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, CAMERA_MENU_VIEW_HEIGH)];
    [self.view addSubview:menuView];
    self.cameraMenuView = menuView;
    
    [self addMenuViewButtons];
}
#pragma mark - 相册中选择
- (void)photoAlbumChooseButtonClick
{
    [self SGImagePickerController];
}
#pragma mark - 从手机相册中选择
- (void)SGImagePickerController
{
    
    //从手机相册中选择
    SGImagePickerController *picker = [[SGImagePickerController alloc] init];
    //返回选择的缩略图
    [picker setDidFinishSelectThumbnails:^(NSArray *thumbnails) {
        NSLog(@"缩略图%@",thumbnails);
    }];
    //返回选中的原图
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    [picker setDidFinishSelectImages:^(NSArray *images) {
        for (UIImage *image in images)
        {
            if(imageArr)
            {
                if(![imageArr containsObject:image])
                {
                    [imageArr addObject:image];
                }
            }
        }
        if(imageArr.count>0)
        {
//            [_imageArray removeAllObjects];
            //完成选择
            for (int i = 0; i<imageArr.count; i++)
            {
                UIImageView *imageView = (UIImageView *)[self.view viewWithTag:_photoCount + 50];
                _photoCount ++;
                imageView.image = [imageArr objectAtQYQIndex:i];
                [_imageArray addObject:[imageArr objectAtQYQIndex:i]];
            }
            [PersonInfo sharePersonInfo].photoCount = _imageArray.count;
            if(_photoCount >= 6)
            {
                SCNavigationController *nav = (SCNavigationController*)self.navigationController;
                if ([nav.scNaigationDelegate respondsToSelector:@selector(didTakePicture:imagearr:)]) {
                    [nav.scNaigationDelegate didTakePicture:nav imagearr:_imageArray];
                }
            }
        }
    }];
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - 完成界面
- (void)downButtonClick
{
    
    if(_imageArray.count<=0)
    {
        Alert(@"至少拍摄一张照片");
        return;
    }
    //添加梦想轨迹
    if (_ISME) {
        
       [PersonInfo sharePersonInfo].uoLoadImageArray = _imageArray;
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i=0; i<_imageArray.count; i++) {
            
            [imageArray addObject:[NSString stringWithFormat:@"%@",[BaseViewController getOSSObjectKeyWithtype:@"png" index:i]]];
        }
        NSString *Dream = [imageArray componentsJoinedByString:@","];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:_Trajectorydict];
        [dict setObject:Dream forKey:@"medialist"];
        [PersonInfo sharePersonInfo].upLoadResultArr = imageArray;
        

        //需要判断是否在梦想秀历史界面调用
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isMyOldDream"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddDreamForMyOldDream" object:dict];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddDreamTrajectory" object:dict];
        }
    }
    else
    {
      
        //发布梦想
        SCNavigationController *nav = (SCNavigationController*)self.navigationController;
        if ([nav.scNaigationDelegate respondsToSelector:@selector(didTakePicture:imagearr:)]) {
            [nav.scNaigationDelegate didTakePicture:nav imagearr:_imageArray];
//          [_imageArray removeAllObjects];
        }
    }
}


#pragma mark - 拍照菜单栏上的按钮
- (void)addMenuViewButtons
{
    NSMutableArray *normalArr = [[NSMutableArray alloc] initWithObjects:@"record_close_normal.png", @"camera_line.png", @"switch_camera.png", @"flashing_off.png", nil];
    NSMutableArray *highlightArr = [[NSMutableArray alloc] initWithObjects:@"record_lensflip_highlighted.png", @"", @"", @"", nil];
    NSMutableArray *selectedArr = [[NSMutableArray alloc] initWithObjects:@"", @"camera_line_h.png", @"switch_camera_h.png", @"", nil];
    
    NSMutableArray *actionArr = [[NSMutableArray alloc] initWithObjects:@"dismissBtnPressed:", @"gridBtnPressed:", @"switchCameraBtnPressed:", @"flashBtnPressed:", nil];
    
    CGFloat eachW = SC_APP_SIZE.width / actionArr.count;
    
    //[SCCommon drawALineWithFrame:CGRectMake(eachW, 0, 1, CAMERA_MENU_VIEW_HEIGH) andColor:rgba_SC(102, 102, 102, 1.0000) inLayer:_cameraMenuView.layer];
    
    //屏幕高度大于480的，后退按钮放在_cameraMenuView；小于480的，放在_bottomContainerView
    for (int i = 0; i < actionArr.count; i++) {
        
//        CGFloat theH = (!isHigherThaniPhone4_SC && i == 0 ? _bottomContainerView.frame.size.height : CAMERA_MENU_VIEW_HEIGH);
//        UIView *parent = (!isHigherThaniPhone4_SC && i == 0 ? _bottomContainerView : _cameraMenuView);
        
        UIButton * btn = [self buildButton:CGRectMake(eachW * i, 0, eachW, 44)
                              normalImgStr:[normalArr objectAtQYQIndex:i]
                           highlightImgStr:[highlightArr objectAtQYQIndex:i]
                            selectedImgStr:[selectedArr objectAtQYQIndex:i]
                                    action:NSSelectorFromString([actionArr objectAtQYQIndex:i])
                                parentView:_cameraMenuView];
        
        btn.showsTouchWhenHighlighted = YES;
        
        [_cameraBtnSet addObject:btn];
    }
}
#pragma mark - 创建按钮的函数
- (UIButton*)buildButton:(CGRect)frame
            normalImgStr:(NSString*)normalImgStr
         highlightImgStr:(NSString*)highlightImgStr
          selectedImgStr:(NSString*)selectedImgStr
                  action:(SEL)action
              parentView:(UIView*)parentView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (normalImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:normalImgStr] forState:UIControlStateNormal];
    }
    if (highlightImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:highlightImgStr] forState:UIControlStateHighlighted];
    }
    if (selectedImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:selectedImgStr] forState:UIControlStateSelected];
    }
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:btn];
    
    return btn;
}

#pragma mark - 对焦的框
- (void)addFocusView
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touch_focus_x.png"]];
    imgView.alpha = 0;
    [self.view addSubview:imgView];
    self.focusImageView = imgView;
    
    #if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device && [device isFocusPointOfInterestSupported])
    {
        [device addObserver:self forKeyPath:ADJUSTINT_FOCUS options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    #endif
}

#pragma mark - 拍完照后的遮罩
- (void)addCameraCover
{
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SC_APP_SIZE.width, 0)];
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    self.doneCameraUpView = upView;
    
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, _bottomContainerView.frame.origin.y, SC_APP_SIZE.width, 0)];
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    self.doneCameraDownView = downView;
}
#pragma mark - 牌照后的遮罩 显示都在隐藏
- (void)showCameraCover:(BOOL)toShow
{
    [UIView animateWithDuration:0.05f animations:^{
        CGRect upFrame = _doneCameraUpView.frame;
        upFrame.size.height = (toShow ? SC_APP_SIZE.width / 2 + CAMERA_TOPVIEW_HEIGHT : 0);
        _doneCameraUpView.frame = upFrame;
        
        CGRect downFrame = _doneCameraDownView.frame;
        downFrame.origin.y = (toShow ? SC_APP_SIZE.width / 2 + CAMERA_TOPVIEW_HEIGHT : _bottomContainerView.frame.origin.y);
        downFrame.size.height = (toShow ? SC_APP_SIZE.width / 2 : 0);
        _doneCameraDownView.frame = downFrame;
    }];
}

#pragma mark - 伸缩镜头的手势
- (void)addPinchGesture
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinch];

    //竖向
    CGFloat width = 40;
    CGFloat height = _previewRect.size.height - 100;
    SCSlider *slider = [[SCSlider alloc] initWithFrame:CGRectMake(_previewRect.size.width - width, (_previewRect.size.height + CAMERA_MENU_VIEW_HEIGH - height) / 2, width, height) direction:SCSliderDirectionVertical];
    slider.alpha = 0.f;
    slider.minValue = MIN_PINCH_SCALE_NUM;
    slider.maxValue = MAX_PINCH_SCALE_NUM;
    
    WEAKSELF_SC
    [slider buildDidChangeValueBlock:^(CGFloat value) {
        [weakSelf_SC.captureManager pinchCameraViewWithScalNum:value];
    }];
    [slider buildTouchEndBlock:^(CGFloat value, BOOL isTouchEnd) {
        [weakSelf_SC setSliderAlpha:isTouchEnd];
    }];
    
    [self.view addSubview:slider];
    
    self.scSlider = slider;
}

void c_slideAlpha() {
    
}
#pragma mark - 设置伸缩函数
- (void)setSliderAlpha:(BOOL)isTouchEnd
{
    if (_scSlider) {
        _scSlider.isSliding = !isTouchEnd;
        
        if (_scSlider.alpha != 0.f && !_scSlider.isSliding) {
            double delayInSeconds = 3.88;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                if (_scSlider.alpha != 0.f && !_scSlider.isSliding) {
                    [UIView animateWithDuration:0.3f animations:^{
                        _scSlider.alpha = 0.f;
                    }];
                }
            });
        }
    }
}

#if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
#pragma mark -  监听对焦是否完成了
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:ADJUSTINT_FOCUS])
    {
        BOOL isAdjustingFocus = [[change objectForKey:NSKeyValueChangeNewKey] isEqualToNumber:[NSNumber numberWithInt:1] ];
        if (!isAdjustingFocus) {
            alphaTimes = -1;
        }
    }
}

- (void)showFocusInPoint:(CGPoint)touchPoint
{
    [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        int alphaNum = (alphaTimes % 2 == 0 ? HIGH_ALPHA : LOW_ALPHA);
        self.focusImageView.alpha = alphaNum;
        alphaTimes++;
        
    } completion:^(BOOL finished) {
        
        if (alphaTimes != -1) {
            [self showFocusInPoint:currTouchPoint];
        } else {
            self.focusImageView.alpha = 0.0f;
        }
    }];
}
#endif

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    alphaTimes = -1;
    
    UITouch *touch = [touches anyObject];
    currTouchPoint = [touch locationInView:self.view];
    
    if (CGRectContainsPoint(_captureManager.previewLayer.bounds, currTouchPoint) == NO) {
        return;
    }
    
    [_captureManager focusInPoint:currTouchPoint];
    
    //对焦框
    [_focusImageView setCenter:currTouchPoint];
    _focusImageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
    
    #if SWITCH_SHOW_FOCUSVIEW_UNTIL_FOCUS_DONE
    [UIView animateWithDuration:0.1f animations:^{
        _focusImageView.alpha = HIGH_ALPHA;
        _focusImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [self showFocusInPoint:currTouchPoint];
    }];
    #else
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _focusImageView.alpha = 1.f;
        _focusImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f delay:0.5f options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _focusImageView.alpha = 0.f;
        } completion:nil];
    }];
#endif
}

#pragma mark - 拍照页面，拍照按钮函数
- (void)takePictureBtnPressed:(UIButton*)sender
{
    if (_imageArray.count == 6) {
        
        Alert(@"最多只能有6张照片");
        return;
    }
    
    sender.userInteractionEnabled = NO;
    [self showCameraCover:YES];

    WEAKSELF_SC
    [_captureManager takePicture:^(UIImage *stillImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [SCCommon saveImageToPhotoAlbum:stillImage];//存至本机
        });
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            sender.userInteractionEnabled = YES;
            [weakSelf_SC showCameraCover:NO];
        });
        
        [_imageArray addObject:stillImage];
        [PersonInfo sharePersonInfo].photoCount = _imageArray.count;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:_photoCount + 50];
        imageView.image = stillImage;
        
        NSLog(@"当前数组个数:%ld",(long)_imageArray.count);
        _photoCount ++ ;
        
        if(_photoCount >= 6)
        {
            
            SCNavigationController *nav = (SCNavigationController*)weakSelf_SC.navigationController;
            if ([nav.scNaigationDelegate respondsToSelector:@selector(didTakePicture:imagearr:)]) {
                [nav.scNaigationDelegate didTakePicture:nav imagearr:_imageArray];
            }
            else
            {
                [self downButtonClick];
            }
        }
        
    }];
}

- (void)tmpBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 拍照页面，"X"按钮
- (void)dismissBtnPressed:(id)sender {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [PersonInfo sharePersonInfo].photoCount = 0;
    [_imageArray removeAllObjects];
    //删除通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemovedefaultCenter" object:nil];
}

#pragma mark - 拍照页面，网格按钮
- (void)gridBtnPressed:(UIButton*)sender {
    sender.selected = !sender.selected;
    [_captureManager switchGrid:sender.selected];
}

#pragma mark - 拍照页面，切换前后摄像头按钮按钮
- (void)switchCameraBtnPressed:(UIButton*)sender {
    sender.selected = !sender.selected;
    [_captureManager switchCamera:sender.selected];
}

#pragma mark - 拍照页面，闪光灯按钮
- (void)flashBtnPressed:(UIButton*)sender {
    [_captureManager switchFlashMode:sender];
}

#pragma mark - 伸缩镜头
- (void)handlePinch:(UIPinchGestureRecognizer*)gesture
{
    [_captureManager pinchCameraView:gesture];
    
    if (_scSlider)
    {
        if (_scSlider.alpha != 1.f)
        {
            [UIView animateWithDuration:0.3f animations:^{
                _scSlider.alpha = 1.f;
            }];
        }
        [_scSlider setValue:_captureManager.scaleNum shouldCallBack:NO];
        
        if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled)
        {
            [self setSliderAlpha:YES];
        }
        else
        {
            [self setSliderAlpha:NO];
        }
    }
}

#pragma mark -界面将要显示时
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏系统栏
- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}


@end
