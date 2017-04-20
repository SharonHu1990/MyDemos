//
//  TriangleView.m
//  PathLayersDemo
//
//  Created by 胡晓阳 on 2017/4/5.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "TriangleView.h"

@interface TriangleView (){
    UIBezierPath *path;
}

@end
@implementation TriangleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [self createTriangle];
//    
//    [[UIColor redColor] setFill];
//    [path fill];
//    
//    [[UIColor blueColor] setStroke];
//    [path stroke];
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor grayColor]];
//        [self maskVsSublayer];
        [self twoShapes];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)createTriangle{
    
    path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(CGRectGetWidth(self.bounds)/2.f, 0.0)];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [path closePath];
    
}

- (void)maskVsSublayer{
    
    [self createTriangle];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [[UIColor yellowColor] CGColor];
//    shapeLayer.strokeColor = [[UIColor redColor] CGColor];
//    shapeLayer.lineWidth = 3.f;
    
//    [self.layer addSublayer:shapeLayer];
    self.layer.mask = shapeLayer;
}

- (void)twoShapes{
    
    CGFloat width = CGRectGetWidth(self.bounds)/2.f;
    CGFloat height = CGRectGetHeight(self.bounds)/2.f;
    
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    [path1 moveToPoint:CGPointMake(width/2.f, 0)];
    [path1 addLineToPoint:CGPointMake(0, height)];
    [path1 addLineToPoint:CGPointMake(width, height)];
    [path1 closePath];
    
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path2 moveToPoint:CGPointMake(width, 0)];
    [path2 addLineToPoint:CGPointMake(width/2.f, height)];
    [path2 addLineToPoint:CGPointMake(0, 0)];
    [path2 closePath];
    
    CAShapeLayer *shapeLayer1 = [[CAShapeLayer alloc] init];
    shapeLayer1.path = path1.CGPath;
    shapeLayer1.fillColor = [UIColor yellowColor].CGColor;
    
    CAShapeLayer *shapeLayer2 = [[CAShapeLayer alloc] init];
    shapeLayer2.path = path2.CGPath;
    shapeLayer2.fillColor = [UIColor greenColor].CGColor;
    
    shapeLayer2.position = CGPointMake(0, height);
    
    shapeLayer1.bounds = CGRectMake(0, 0, 200, 150);
    shapeLayer1.backgroundColor = [UIColor magentaColor].CGColor;
    
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
}

@end
