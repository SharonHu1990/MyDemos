//
//  RoundedRectangleView.m
//  PathLayersDemo
//
//  Created by 胡晓阳 on 2017/4/5.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "RoundedRectangleView.h"

@interface RoundedRectangleView (){
    UIBezierPath *path;
}

@end
@implementation RoundedRectangleView

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
    
    //四个角都是圆角
    path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:15.f];
    
    //左上和右下是圆角
    //path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:15.f];
    
    path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 0)];
    
    //Specify the fill color and apply it to the path.
    [[UIColor orangeColor] setFill];
    [path fill];
    
    //Specity the border (stroke) color.
    [[UIColor purpleColor] setStroke];
    [path stroke];
}



@end
