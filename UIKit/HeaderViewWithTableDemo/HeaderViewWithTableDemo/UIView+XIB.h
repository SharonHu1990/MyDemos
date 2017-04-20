//
//  UIView+XIB.h
//  AlibabaV5
//
//  Created by 姜勋 on 15/6/11.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XIB)

/// 从 xib 创建对象
+ (instancetype)createInstance;
+ (instancetype)createInstanceWithXib:(NSString *)xibName;

@end
