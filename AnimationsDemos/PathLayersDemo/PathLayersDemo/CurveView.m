//
//  CurveView.m
//  PathLayersDemo
//
//  Created by SharonHu on 2017/6/13.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "CurveView.h"
@interface CurveView(){
    UIBezierPath *path;
}
@end

@implementation CurveView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addCurveLayer];
}

- (void)addCurveLayer{
    [self createCurveView];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayer.strokeColor = [[UIColor redColor] CGColor];
    shapeLayer.lineWidth = 3.f;
    
    //添加渐变色
    
    UIView *gradientView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:gradientView];

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = gradientView.bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,
                             (id)[UIColor yellowColor].CGColor,
                             (id)[UIColor blueColor].CGColor];
    
    //  设置三种颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@(0.1f) ,@(0.4f)];
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientView.layer.mask = shapeLayer;
    [gradientView.layer addSublayer:gradientLayer];

    
    [self.layer addSublayer:shapeLayer];
}

-(void)createCurveView{
    
//    //二次贝塞尔曲线
//    path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addQuadCurveToPoint:CGPointMake(100, 100) controlPoint:CGPointMake(0, 50)];
//    [path stroke];
    
    //三次贝塞尔曲线
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 80)];
    [path addCurveToPoint:CGPointMake(240, 80) controlPoint1:CGPointMake(50, 160) controlPoint2:CGPointMake(120, 0)];
    [path stroke];
    
    
    
    
}


@end
