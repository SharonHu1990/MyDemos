//
//  NSObject+AMFillPriceString.h
//  AlibabaV5
//
//  Created by 胡晓阳 on 16/7/11.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (AMFillPriceString)
/**
 *  给UILabel填充价格
 *
 *  @param label       label
 *  @param price       价格
 *  @param rmbFont     ¥符号的大小
 *  @param integerFont 整数大小
 *  @param decimalFont 小数大小
 */
- (void)fillPriceInLabel:(UILabel *)label price:(double)price rmbFont:(float)rmbFont integerFont:(float)integerFont decimalFont:(float)decimalFont;

/**
 *  给UILabel填充价格和单位
 *
 *  @param label       label
 *  @param price       价格
 *  @param unit        单文
 *  @param rmbFont     ¥符号的大小
 *  @param integerFont 整数大小
 *  @param decimalFont 小数大小
 *  @param unitFont    单位大小
 */
- (void)fillPriceInLabel:(UILabel *)label price:(double)price unit:(NSString *)unit rmbFont:(float)rmbFont integerFont:(float)integerFont decimalFont:(float)decimalFont unitFont:(float)unitFont;
@end
