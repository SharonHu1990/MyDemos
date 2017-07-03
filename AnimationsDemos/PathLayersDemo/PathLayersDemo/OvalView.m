//
//  OvalView.m
//  PathLayersDemo
//
//  Created by 胡晓阳 on 2017/4/5.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "OvalView.h"

@interface OvalView (){
    UIBezierPath *path;
}

@end
@implementation OvalView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //椭圆
    path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    path.lineWidth = 3.f;
    //圆形
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(CGRectGetWidth(self.bounds)-CGRectGetHeight(self.bounds), 0, CGRectGetHeight(self.bounds), CGRectGetHeight(self.bounds))];
    //Specify the fill color and apply it to the path.
    [[UIColor whiteColor] setFill];
    [path fill];
    
    //Specity the border (stroke) color.
    [[UIColor purpleColor] setStroke];
    [path stroke];
}

@end
