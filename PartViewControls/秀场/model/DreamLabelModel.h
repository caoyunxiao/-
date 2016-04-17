//
//  DreamLabelModel.h
//  CosFund
//
//  Created by ZFJ_APPLE on 15/10/24.
//  Copyright © 2015年 ZFJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DreamLabelModel : NSObject

/**
 *  标签的ID
 */
@property (nonatomic,copy) NSString *lableID;
/**
 *  标签的名字
 */
@property (nonatomic,copy) NSString *name;
/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL isSelect;

@end
