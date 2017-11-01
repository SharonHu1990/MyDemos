//
//  RectangleView.m
//  PathLayersDemo
//
//  Created by 胡晓阳 on 2017/4/5.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "RectangleView.h"
#import <GLKit/GLKMath.h>

@interface RectangleView (){
    UIBezierPath *path;
}

@end
@implementation RectangleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [self createRectangle];
//    
//    //Specify the fill color and apply it to the path.
//    [[UIColor orangeColor] setFill];
//    [path fill];
//    
//    //Specity the border (stroke) color.
//    [[UIColor purpleColor] setStroke];
//    [path stroke];
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor grayColor]];
        [self sampleShapeLayer];
//        [self complexShape];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)createRectangle{
    
    path = [UIBezierPath bezierPath];
    
    //Specify the point that the path should start get draw
    [path moveToPoint:CGPointMake(0.0, 0.0)];
    
    //Create a line between the starting point and the bottom-left side of the view
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    
    //Create the bottom line(bottom-left to bottom-right)
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    
    //Create the right line(bottom-right to top-right)
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), 0.0)];
    
    //Close the paht.This will complete the last path automatically
    [path closePath];
    
}

- (void)sampleShapeLayer{
    [self createRectangle];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [[UIColor yellowColor] CGColor];
    shapeLayer.strokeColor = [[UIColor redColor] CGColor];
    shapeLayer.lineWidth = 3.f;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)complexShape{
    
    
    path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)/2.f-50, 0)];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds)/2.f-25.f, 25) radius:25 startAngle:GLKMathDegreesToRadians(180.0) endAngle:GLKMathDegreesToRadians(0.f) clockwise:YES];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)/2.f, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds)-50, 0)];
    [path addCurveToPoint:CGPointMake(CGRectGetWidth(self.bounds), 50.f) controlPoint1:CGPointMake(CGRectGetWidth(self.bounds)+50, 25) controlPoint2:CGPointMake(CGRectGetWidth(self.bounds)-150.f, 50.f)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    [path addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
    [path closePath];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    self.backgroundColor = [UIColor orangeColor];
//    [self.layer addSublayer:shapeLayer];
    self.layer.mask = shapeLayer;
}

@end
