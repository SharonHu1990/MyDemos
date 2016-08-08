//
//  NSObject+AMDefaultNumberFormatter.m
//  AlibabaV5
//
//  Created by 胡晓阳 on 16/7/11.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import "NSObject+AMDefaultNumberFormatter.h"

@implementation NSObject (AMDefaultNumberFormatter)
- (NSNumberFormatter *)defaultNumberFormatter
{
    static NSNumberFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterNoStyle;
        formatter.maximumFractionDigits = 2;
        formatter.minimumFractionDigits = 2;
        formatter.minimumIntegerDigits = 1;
        formatter.roundingMode = NSNumberFormatterRoundFloor;
    });
    return formatter;
}
@end
