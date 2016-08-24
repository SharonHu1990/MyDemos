//
//  main.m
//  NumbersFormatterDomo
//
//  Created by 胡晓阳 on 16/8/5.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
//        NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle,
//        NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle,
//        NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle,
//        NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle,
//        NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle,
//        NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle,
//        NSNumberFormatterOrdinalStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterOrdinalStyle,
//        NSNumberFormatterCurrencyISOCodeStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyISOCodeStyle,
//        NSNumberFormatterCurrencyPluralStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyPluralStyle,
//        NSNumberFormatterCurrencyAccountingStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyAccountingStyle,
//        
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        
        //小数形式（保留小数点后三位，四舍五入）
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;//1.635
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.634567890]]);
        
        
        //四舍五入的整数
        numberFormatter.numberStyle = NSNumberFormatterNoStyle;//2
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.634567890]]);
        
        
        
        numberFormatter.numberStyle = NSNumberFormatterPercentStyle;//123%
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.234567890]]);
        
        numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;//￥ 1.23
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.234567890]]);
        
        numberFormatter.numberStyle = NSNumberFormatterScientificStyle;//1.23456789E0
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.234567890]]);
        
        numberFormatter.numberStyle = NSNumberFormatterSpellOutStyle;//一点二三四五六七八九
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.234567890]]);
        
        numberFormatter.numberStyle = NSNumberFormatterOrdinalStyle;//第2
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.634567890]]);
        
        numberFormatter.numberStyle = NSNumberFormatterCurrencyISOCodeStyle;//CNY 1.24
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        numberFormatter.numberStyle = NSNumberFormatterCurrencyPluralStyle;//1.24人民币
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        numberFormatter.numberStyle = NSNumberFormatterCurrencyAccountingStyle;//￥1.24
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        
//        
//        NSNumberFormatterRoundCeiling = kCFNumberFormatterRoundCeiling,
//        NSNumberFormatterRoundFloor = kCFNumberFormatterRoundFloor,
//        NSNumberFormatterRoundDown = kCFNumberFormatterRoundDown,
//        NSNumberFormatterRoundUp = kCFNumberFormatterRoundUp,
//        NSNumberFormatterRoundHalfEven = kCFNumberFormatterRoundHalfEven,
//        NSNumberFormatterRoundHalfDown = kCFNumberFormatterRoundHalfDown,
//        NSNumberFormatterRoundHalfUp = kCFNumberFormatterRoundHalfUp
        
        
        //四舍五入，保留到整数位
        numberFormatter.numberStyle = NSNumberFormatterRoundCeiling;//2
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.735567890]]);
        
        //四舍五入，保留小数点后三位
        numberFormatter.numberStyle = NSNumberFormatterRoundFloor;//1.236
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        //四舍五入，保留小数点后两位，加上人民币符号
        numberFormatter.numberStyle = NSNumberFormatterRoundDown;//￥ 1.24
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        //先四舍五入，保留小数点后两位，然后转化为百分数
        numberFormatter.numberStyle = NSNumberFormatterRoundUp;//124%
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        //科学计数法
        numberFormatter.numberStyle = NSNumberFormatterRoundHalfEven;//1.23556789E0（E0表示10的0次幂，E1表示10的1次幂，以此类推）
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        //转为文字描述
        numberFormatter.numberStyle = NSNumberFormatterRoundHalfDown;// 一点二三五五六七八九
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
        
        //先四舍五入，保留到整数位，再转化为第几
        numberFormatter.numberStyle = NSNumberFormatterRoundHalfUp;//第1
        NSLog(@"%@",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:1.235567890]]);
    }
    return 0;
}
