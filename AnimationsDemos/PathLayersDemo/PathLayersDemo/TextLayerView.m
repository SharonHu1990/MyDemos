//
//  TextLayerView.m
//  PathLayersDemo
//
//  Created by 胡晓阳 on 2017/4/13.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "TextLayerView.h"

@implementation TextLayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor grayColor]];
        //        [self sampleShapeLayer];
        [self createTextLayer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)createTextLayer{
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.string = @"测试\nThis is text on layer";
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont fontWithName:@"Avenir" size:15.f]);
    textLayer.fontSize = 15.f;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.backgroundColor = [UIColor orangeColor].CGColor;
    textLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)/2.f-20.f, CGRectGetWidth(self.bounds), 40.f);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:textLayer];
    
}

@end
