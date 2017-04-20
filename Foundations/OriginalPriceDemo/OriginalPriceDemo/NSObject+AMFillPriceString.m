//
//  NSObject+AMFillPriceString.m
//  AlibabaV5
//
//  Created by 胡晓阳 on 16/7/11.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import "NSObject+AMFillPriceString.h"
#import "NSObject+AMDefaultNumberFormatter.h"

@implementation NSObject (AMFillPriceString)
- (void)fillPriceInLabel:(UILabel *)label price:(double)price rmbFont:(float)rmbFont integerFont:(float)integerFont decimalFont:(float)decimalFont{
    
    NSString *priceStr = [NSString stringWithFormat:@"¥%@",[[self defaultNumberFormatter] stringFromNumber:@(price)]];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    
    NSRange pointRange = [priceStr rangeOfString:@"."];
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:label.textColor, NSFontAttributeName:[UIFont systemFontOfSize:integerFont]} range:NSMakeRange(0, pointRange.location)];
    [attributedStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:decimalFont]} range:NSMakeRange(pointRange.location, priceStr.length - pointRange.location)];
    [label setAttributedText:attributedStr];
}


- (void)fillPriceInLabel:(UILabel *)label price:(double)price unit:(NSString *)unit rmbFont:(float)rmbFont integerFont:(float)integerFont decimalFont:(float)decimalFont unitFont:(float)unitFont{
    
    NSString *priceStr = [NSString stringWithFormat:@"¥%@",[[self defaultNumberFormatter] stringFromNumber:@(price)]];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    
    NSRange pointRange = [priceStr rangeOfString:@"."];
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:label.textColor, NSFontAttributeName:[UIFont systemFontOfSize:integerFont]} range:NSMakeRange(0, pointRange.location)];
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:label.textColor, NSFontAttributeName:[UIFont systemFontOfSize:decimalFont]} range:NSMakeRange(pointRange.location, priceStr.length - pointRange.location)];
    
    if (unit) {
        NSString *unitStr = [NSString stringWithFormat:@"/%@",unit];
        NSMutableAttributedString *unitAttributedStr = [[NSMutableAttributedString alloc] initWithString:unitStr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:unitFont], NSForegroundColorAttributeName: [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1]}];
        [attributedStr appendAttributedString:unitAttributedStr];
    }
    
    
    [label setAttributedText:attributedStr];
}
@end
