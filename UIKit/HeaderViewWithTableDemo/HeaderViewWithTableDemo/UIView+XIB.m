//
//  UIView+XIB.m
//  AlibabaV5
//
//  Created by 姜勋 on 15/6/11.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

+ (instancetype)createInstance
{
    return [self createInstanceWithXib:NSStringFromClass([self class])];
}

+ (instancetype)createInstanceWithXib:(NSString *)xibName
{
    __block id inst = nil;
    NSArray * arr = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[self class]]) {
            inst = obj;
            (*stop) = YES;
        }
    }];
//    AMParameterAssert(inst);
//    AMParameterAssert([inst isKindOfClass:[self class]]);
    return inst;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
