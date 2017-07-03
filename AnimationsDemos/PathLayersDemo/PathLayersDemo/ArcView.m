//
//  ArcView.m
//  PathLayersDemo
//
//  Created by 胡晓阳 on 2017/4/11.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ArcView.h"
#import <GLKit/GLKMath.h>

@interface ArcView (){
    UIBezierPath *path;
}

@end
@implementation ArcView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //以下方法只能画半圆
    path.lineWidth = 1.f;
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.f, CGRectGetHeight(self.bounds)/2.f) radius:CGRectGetHeight(self.bounds)/2.f startAngle:GLKMathDegreesToRadians(90.f) endAngle:GLKMathDegreesToRadians(270.f) clockwise:YES];
    [[UIColor orangeColor] setFill];
    [path fill];
    
    [[UIColor blackColor] setStroke];
    [path stroke];
}

@end
