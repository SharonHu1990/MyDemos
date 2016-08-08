//
//  AMOriginalPriceView.h
//  AlibabaV5
//
//  Created by 胡晓阳 on 16/8/5.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMOriginalPriceView : UIView
- (void)fillContentWithOriginalPrice:(NSString *)originalPrice unit:(NSString *)unit fontSize:(CGFloat)fontSize;
@property (nonatomic, strong) UIColor *priceColor;
@property (nonatomic, assign) CGFloat fontSize;
@end
