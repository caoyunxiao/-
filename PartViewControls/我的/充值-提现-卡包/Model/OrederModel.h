//
//  OrederModel.h
//  CosFund
//
//  Created by qiuyaqingMac on 15/10/21.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrederModel : NSObject
/*
 addressID = 0;
 createTime = "/Date(1448095474077+0800)/";
 ctid = 10;
 orderDate = "/Date(1420041600000+0800)/";
 orderSN = SN8359016681230847332;
 saleGoodsList =         (
 {
 caBei = 0;
 color = "<null>";
 cover = "goods/good20151121042112.jpg";
 discription = "";
 goodsID = 44;
 name = "\U5496\U8303/COSFund \U6f14\U5531\U4f1a\U7537\U5973\U6b3e\U77ed\U8896T\U6064\U590f\U88c5\U8863\U670d\U6f6e";
 picVidList =                 (
 );
 price = 10;
 salesGoodsID = 895;
 salesID = 415;
 style = "\U5747\U7801";
 total = 3;
 type = 1;
 }
 );
 salesID = 415;
 state = 10;
 theAwb = "<null>";
 totalPrice = 30;
 userID = 3267;
 wLCompany = "<null>";
 */
/**
 *  商品名称
 */
@property (nonatomic, copy) NSString *addressID;
/**
 *  下单时间
 */
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *ctid;
@property (nonatomic, copy) NSString *orderDate;
@property (nonatomic, copy) NSString *orderSN;
@property (nonatomic, strong) NSMutableArray *saleGoodsList;

@property (nonatomic, copy) NSString *salesID;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *theAwb;
@property (nonatomic, copy) NSString *totalPrice;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *wLCompany;



@end
