//
//  HorizontalDottedLineView.m
//  DottedLineDemo
//
//  Created by 胡晓阳 on 16/7/22.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "HorizontalDottedLineView.h"

@implementation HorizontalDottedLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //设置虚线颜色
    [shapeLayer setStrokeColor:[UIColor colorWithWhite:226.f/255.f alpha:1].CGColor];
    //设置虚线宽度
    [shapeLayer setLineWidth:self.frame.size.height];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //设置虚线的线宽及间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:3], nil]];
    //创建虚线绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置虚线绘制路径起点
    CGPathMoveToPoint(path, NULL, 0, 0);
    //设置虚线绘制路径终点
    CGPathAddLineToPoint(path, NULL, self.frame.size.width, 0);
    //设置虚线绘制路径
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //添加虚线
    [self.layer addSublayer:shapeLayer];
}


@end
