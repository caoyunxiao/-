//
//  MODropAlertView.m
//  MODropAlertDemo
//
//  Created by Ahn JungMin on 2014. 7. 1..
//  Copyright (c) 2014년 Ahn JungMin. All rights reserved.
//

#import "MODropAlertView.h"
//#import "UIImage+ImageEffects.h"

//屏幕的物理高度和宽度
#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height

//static const CGFloat kAlertButtonBottomMargin = 10;
static const CGFloat kAlertButtonSideMargin = 15;
//static const CGFloat kAlertButtonsBetweenMargin = 3;
static const CGFloat kAlertButtonHeight = 30;

static const CGFloat kAlertTitleLabelHeight = 30;
static const CGFloat kAlertTitleLabelTopMargin = 30;
static const CGFloat kALertDescriptionLabelTopMargin = 40;
static const CGFloat kAlertDescriptionLabelHeight = 100;

static const CGFloat kAlertTitleLabelFontSize = 24;
static const CGFloat kAlertDescriptionLabelFontSize = 14;
static const CGFloat kAlertButtonFontSize = 14;

static NSString* kAlertOKButtonNormalColor = @"#ffffff";//ok正常状态下
static NSString* kAlertOKButtonHighlightColor = @"#ffffff";//ok高亮点击状态
static NSString* kAlertCancelButtonNormalColor = @"#ffffff";//取消按钮
static NSString* kAlertCancelButtonHighlightColor = @"#ffffff";//取消点击状态

@implementation MODropAlertView {
    
@private
    NSString *okButtonTitleStr;
    NSString *cancelButtonTitleString;
    NSString *titleStr;
    NSString *descrptionString;
    
    UIImageView *backgroundView;
    UIView *alertView;
    
    UIView *topLine;
    
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    
    UIButton *okButton;
    UIButton *cancelButton;
    
    DropAlertViewType kType;
    UIColor *okButtonColor;
    UIColor *cancelButtonColor;
    blk successBlockCallback;
    blk failureBlockCallback;
}

#pragma mark - Initialized Drop Alert Methods
- (instancetype)initDropAlertWithTitle:(NSString *)title description:(NSString *)description okButtonTitle:(NSString *)okButtonTitle
{
    return [self initDropAlertWithTitle:title description:description okButtonTitle:okButtonTitle cancelButtonTitle:nil okButtonColor:nil cancelButtonColor:nil alertType:DropAlertDefault];
}

- (instancetype)initDropAlertWithTitle:(NSString *)title description:(NSString *)description okButtonTitle:(NSString *)okButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle
{
    return [self initDropAlertWithTitle:title description:description okButtonTitle:okButtonTitle cancelButtonTitle:cancelButtonTitle okButtonColor:nil cancelButtonColor:nil alertType:DropAlertDefault];
}

- (instancetype)initDropAlertWithTitle:(NSString *)title description:(NSString *)description okButtonTitle:(NSString *)okButtonTitle okButtonColor:(UIColor *)okBtnColor
{
    return [self initDropAlertWithTitle:title description:description okButtonTitle:okButtonTitle cancelButtonTitle:nil okButtonColor:okBtnColor cancelButtonColor:nil alertType:DropAlertCustom];
}
- (instancetype)initDropAlertWithTitle:(NSString *)title description:(NSString *)description okButtonTitle:(NSString *)okButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle okButtonColor:(UIColor *)okBtnColor cancelButtonColor:(UIColor *)cancelBtnColor
{
    return [self initDropAlertWithTitle:title description:description okButtonTitle:okButtonTitle cancelButtonTitle:cancelButtonTitle okButtonColor:okBtnColor cancelButtonColor:cancelBtnColor alertType:DropAlertCustom];
}

- (instancetype)initDropAlertWithTitle:(NSString *)title description:(NSString *)description okButtonTitle:(NSString *)okButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle okButtonColor:(UIColor *)okBtnColor cancelButtonColor:(UIColor *)cancelBtnColor alertType:(DropAlertViewType)alertType
{
    self = [super init];
    if (self) {
        okButtonTitleStr = okButtonTitle;
        cancelButtonTitleString = cancelButtonTitle;
        descrptionString = description;
        titleStr = title;
        kType = alertType;
        okButtonColor = okBtnColor;
        cancelButtonColor = cancelBtnColor;
        [self initDropAlert];
    }
    return self;
}

- (instancetype)initDropAlertWithTitle:(NSString *)title description:(NSString *)description okButtonTitle:(NSString *)okButtonTitle successBlock:(blk)successBlock
{
    return [self initDropAlertWithTitle:title description:description okButtonTitle:okButtonTitle cancelButtonTitle:nil okButtonColor:nil cancelButtonColor:nil successBlock:successBlock failureBlock:nil alertType:DropAlertDefault];
}

- (instancetype)initDropAlertWithTitle:(NSString *)title description:(NSString *)description okButtonTitle:(NSString *)okButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle successBlock:(blk)successBlock failureBlock:(blk)failureBlock
{
    return [self initDropAlertWithTitle:title description:description okButtonTitle:okButtonTitle cancelButtonTitle:cancelButtonTitle okButtonColor:nil cancelButtonColor:nil successBlock:successBlock failureBlock:failureBlock alertType:DropAlertDefault];
}

- (instancetype)initDropAlertWithTitle:(NSString *)title
                           description:(NSString *)description
                         okButtonTitle:(NSString *)okButtonTitle
                         okButtonColor:(UIColor *)okBtnColor
                          successBlock:(blk)successBlock
{
    return [self initDropAlertWithTitle:title
                            description:description
                          okButtonTitle:okButtonTitle
                      cancelButtonTitle:nil
                          okButtonColor:okButtonColor
                      cancelButtonColor:nil
                           successBlock:successBlock
                           failureBlock:nil
                              alertType:DropAlertCustom];
}

- (instancetype)initDropAlertWithTitle:(NSString *)title
                           description:(NSString *)description
                         okButtonTitle:(NSString *)okButtonTitle
                     cancelButtonTitle:(NSString *)cancelButtonTitle
                         okButtonColor:(UIColor *)okBtnColor
                     cancelButtonColor:(UIColor *)cancelBtnColor
                          successBlock:(blk)successBlock
                          failureBlock:(blk)failureBlock
{
    return [self initDropAlertWithTitle:title
                            description:description
                          okButtonTitle:okButtonTitle
                      cancelButtonTitle:cancelButtonTitle
                          okButtonColor:okButtonColor
                      cancelButtonColor:cancelButtonColor
                           successBlock:successBlock
                           failureBlock:failureBlock
                              alertType:DropAlertCustom];
}

- (instancetype)initDropAlertWithTitle:(NSString *)title
                           description:(NSString *)description
                         okButtonTitle:(NSString *)okButtonTitle
                     cancelButtonTitle:(NSString *)cancelButtonTitle
                         okButtonColor:(UIColor *)okBtnColor
                     cancelButtonColor:(UIColor *)cancelBtnColor
                          successBlock:(blk)successBlock
                          failureBlock:(blk)failureBlock
                             alertType:(DropAlertViewType)alertType
{
    self = [super init];
    if (self) {
        okButtonTitleStr = okButtonTitle;
        cancelButtonTitleString = cancelButtonTitle;
        descrptionString = description;
        titleStr = title;
        kType = alertType;
        okButtonColor = okBtnColor;
        cancelButtonColor = cancelBtnColor;
        successBlockCallback = successBlock;
        failureBlockCallback = failureBlock;
        [self initDropAlert];
    }
    return self;
}

- (void)initDropAlert
{
    self.frame = [self mainScreenFrame];
    self.opaque = YES;
    self.backgroundColor = [UIColor clearColor];
    
    [self makeAlertPopupView];
    [self makeAlertTitleLabel];
    [self makeAlertDescriptionLabel];
    [self setUIViewLine:cancelButtonTitleString ? YES : NO];
    [self makeAlertButton:cancelButtonTitleString ? YES : NO];
    [self moveAlertPopupView];
}

#pragma mark - 设置分割线
- (void)setUIViewLine:(BOOL)hasCancelButton
{
    topLine = [[UIView alloc]init];
    topLine.backgroundColor = [UIColor colorWithRed:220/255.0 green:221/255.0 blue:222/255.0 alpha:1];
    topLine.frame = CGRectMake(0, descriptionLabel.frame.size.height+descriptionLabel.frame.origin.y+10, alertView.frame.size.width, 1);
    [alertView addSubview:topLine];
    [topLine bringSubviewToFront:alertView];
    if(hasCancelButton)
    {
        UIView *lineView = [[UIView alloc]init];
        [lineView setFrame:CGRectMake(CGRectGetWidth(alertView.frame)/2+3, descriptionLabel.frame.size.height+descriptionLabel.frame.origin.y+10, 1, 50)];
        lineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:221/255.0 blue:222/255.0 alpha:1];
        [alertView addSubview:lineView];
        [lineView bringSubviewToFront:alertView];
        alertView.frame = CGRectMake(0, 0, 200, lineView.frame.size.width + lineView.frame.origin.y+30);
    }
    else
    {
        alertView.frame = CGRectMake(0, 0, 200, topLine.frame.origin.y+30);
    }
    
    alertView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
}

- (void)makeAlertPopupView
{
    CGRect frame = CGRectMake(0, 0, 200, 200);
    CGRect screen = [self mainScreenFrame];
    alertView = [[UIView alloc]initWithFrame:frame];
    alertView.center = CGPointMake(CGRectGetWidth(screen)/2, CGRectGetHeight(screen)/2);
    alertView.layer.masksToBounds = YES;
    alertView.layer.cornerRadius = 5;
    alertView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    
    [self addSubview:alertView];
}

- (void)makeAlertTitleLabel
{
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertView.frame) - kAlertButtonSideMargin, kAlertTitleLabelHeight)];
    titleLabel.center = CGPointMake(CGRectGetWidth(alertView.frame)/2, kAlertTitleLabelTopMargin);
    titleLabel.text = titleStr;
    titleLabel.textColor = [UIColor darkGrayColor];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [titleLabel.font fontWithSize:kAlertTitleLabelFontSize];
    
    [alertView addSubview:titleLabel];
}

- (void)makeAlertDescriptionLabel
{
    descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertView.frame) - kAlertButtonSideMargin, kAlertDescriptionLabelHeight)];
    descriptionLabel.center = CGPointMake(CGRectGetWidth(alertView.frame)/2, kAlertTitleLabelTopMargin + CGRectGetHeight(titleLabel.frame) + kALertDescriptionLabelTopMargin);
    descriptionLabel.text = descrptionString;
    descriptionLabel.textColor = [UIColor grayColor];
    descriptionLabel.font = [descriptionLabel.font fontWithSize:kAlertDescriptionLabelFontSize];
    
    // Line Breaking
    descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLabel.numberOfLines = 0;
    
    [descriptionLabel setTextAlignment:NSTextAlignmentLeft];
    [descriptionLabel sizeToFit];
    
    [alertView addSubview:descriptionLabel];
}

- (void)makeAlertButton:(BOOL)hasCancelButton
{
    
    cancelButton = [[UIButton alloc]init];
    CGRect topLineFrame = topLine.frame;
    if (hasCancelButton)
    {
        okButton = [[UIButton alloc]init];
        [okButton setFrame:CGRectMake(0,topLineFrame.origin.y+1,CGRectGetWidth(alertView.frame)/2,kAlertButtonHeight)];
        [okButton setTitleColor:[UIColor colorWithRed:67/255.0 green:68/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
        //[self setShadowLayer:okButton.layer];//设置阴影
        [okButton setTitle:okButtonTitleStr forState:UIControlStateNormal];
        [okButton.titleLabel setFont:[okButton.titleLabel.font fontWithSize:kAlertButtonFontSize]];
        [okButton addTarget:self action:@selector(pressAlertButton:) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:okButton];
        [cancelButton setFrame:CGRectMake(CGRectGetWidth(alertView.frame)/2,topLineFrame.origin.y+1,CGRectGetWidth(alertView.frame)/2,kAlertButtonHeight)];
    }
    else
    {
        [cancelButton setFrame:CGRectMake(0, topLineFrame.origin.y+1, CGRectGetWidth(alertView.frame), kAlertButtonHeight)];
    }
    [cancelButton setTitle:okButtonTitleStr forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[cancelButton.titleLabel.font fontWithSize:kAlertButtonFontSize]];
    [cancelButton addTarget:self action:@selector(pressAlertButton:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:[UIColor colorWithRed:210/255.0 green:0/255.0 blue:104/255.0 alpha:1] forState:UIControlStateNormal];
    //[self setShadowLayer:cancelButton.layer];//设置阴影
    [alertView addSubview:cancelButton];
    
}

#pragma mark - View Animation Methods
- (void)moveAlertPopupView
{
    CGRect screen = [self mainScreenFrame];
    CATransform3D move = CATransform3DIdentity;
    CGFloat initAlertViewYPosition = (CGRectGetHeight(screen) + CGRectGetHeight(alertView.frame)) / 2;
    
    move = CATransform3DMakeTranslation(0, -initAlertViewYPosition, 0);
    move = CATransform3DRotate(move, 40 * M_PI/180, 0, 0, 1.0f);
    
    alertView.layer.transform = move;
}

- (void)show
{
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    
    if( [self.delegate respondsToSelector:@selector(alertViewWillAppear:)] ) {
        [self.delegate alertViewWillAppear:self];
    }
    
    [self showAnimation];
}

- (void)showAnimation
{
    [UIView animateWithDuration:0.3f animations:^{
        backgroundView.alpha = 1.0f;
    }];
    
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
         usingSpringWithDamping:0.4f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CATransform3D init = CATransform3DIdentity;
                         alertView.layer.transform = init;
                         
                     }
                     completion:^(BOOL finished) {
                         if( [self.delegate respondsToSelector:@selector(alertViewDidAppear:)] && finished) {
                             [self.delegate alertViewDidAppear:self];
                         }
                     }];
}

- (void)dismiss:(DropAlertButtonType)buttonType
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(alertViewWilldisappear:buttonType:)] ) {
        [self.delegate alertViewWilldisappear:self buttonType:buttonType];
    }
    [self dismissAnimation:buttonType];
}

- (void)dismissAnimation:(DropAlertButtonType)buttonType
{
    blk cb;
    switch (buttonType) {
        case DropAlertButtonOK:
            successBlockCallback ? cb = successBlockCallback: nil;
            break;
        case DropAlertButtonFail:
            failureBlockCallback ? cb = failureBlockCallback: nil;
        default:
            break;
    }
    [UIView animateWithDuration:0.8f
                          delay:0.0f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         CGRect screen = [self mainScreenFrame];
                         CATransform3D move = CATransform3DIdentity;
                         CGFloat initAlertViewYPosition = CGRectGetHeight(screen);
                         
                         move = CATransform3DMakeTranslation(0, initAlertViewYPosition, 0);
                         move = CATransform3DRotate(move, -40 * M_PI/180, 0, 0, 1.0f);
                         alertView.layer.transform = move;
                         
                         backgroundView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         if (cb) {
                             cb();
                         }
                         else if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewDidDisappear:buttonType:)] && finished) {
                             [self.delegate alertViewDidDisappear:self buttonType:buttonType];
                         }
                     }];
    
}

#pragma mark - Button Methods
- (IBAction)pressAlertButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    DropAlertButtonType buttonType;
    BOOL blockFlag = false;
    
    if( [button isEqual:okButton] ) {
        NSLog(@"Pressed Button is OkButton");
        buttonType = DropAlertButtonOK;
        if (successBlockCallback) {
            blockFlag = true;
        }
    }
    else {
        NSLog(@"Pressed Button is CancelButton");
        buttonType = DropAlertButtonFail;
        if (failureBlockCallback) {
            blockFlag = true;
        }
    }
    
    if ( !blockFlag && [self.delegate respondsToSelector:@selector(alertViewPressButton:buttonType:)]) {
        [self.delegate alertViewPressButton:self buttonType:buttonType];
    }
    
    [self dismiss:buttonType];
    
}

#pragma mark - Util Methods
- (CGRect)mainScreenFrame
{
    return [UIScreen mainScreen].bounds;
}

- (void)setShadowLayer:(CALayer *)layer
{
    layer.shadowOffset = CGSizeMake(1, 1);
    layer.shadowRadius = 0.6;
    layer.shadowOpacity = 0.3;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end