//
//  ProductDetailsViewController.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/2.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import "BaseViewController.h"
#import "OnlineModel.h"

@interface ProductDetailsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_imageView;
    BOOL _isShow;
    NSInteger _buyCount;
}



@property (weak, nonatomic) IBOutlet UITableView *PDVTableView;

//立即购买
@property (weak, nonatomic) IBOutlet UIButton *BuyNowBtn;
- (IBAction)BuyNowBtn:(UIButton *)sender;

//加入购物车
@property (weak, nonatomic) IBOutlet UIButton *AddToCartBtn;
- (IBAction)AddToCartBtn:(UIButton *)sender;


@property (nonatomic, assign) BOOL isShoping;

- (IBAction)backBtnClick:(UIButton *)sender;//返回
- (IBAction)shopCarBtnClick:(UIButton *)sender;//购物车


@property (nonatomic, assign) BOOL isShopingCate;
@property (weak, nonatomic) IBOutlet UIView *downButtonView;

/**
 *  商品ID
 */
@property (nonatomic, copy) NSString *goodsID;
@end
