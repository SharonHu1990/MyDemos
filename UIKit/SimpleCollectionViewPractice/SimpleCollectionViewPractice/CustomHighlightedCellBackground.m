//
//  CustomHighlightedCellBackground.m
//  SimpleCollectionViewPractice
//
//  Created by 胡晓阳 on 16/3/23.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CustomHighlightedCellBackground.h"

@implementation CustomHighlightedCellBackground


// Draw a rounded rect bezier path filled with blue
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.f];
    bezierPath.lineWidth = 5.f;
    [[UIColor whiteColor] setStroke];//空心颜色为黑色（这个颜色要跟cell的背景色一样）
    [[UIColor redColor] setFill];//实心颜色为红色
    
    [bezierPath stroke];
    [bezierPath fill];
    CGContextRestoreGState(aRef);
}


@end
