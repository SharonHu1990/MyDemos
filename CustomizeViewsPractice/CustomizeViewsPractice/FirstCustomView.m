//
//  FirstCustomView.m
//  CustomizeViewsPractice
//
//  Created by 胡晓阳 on 16/4/11.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "FirstCustomView.h"

@implementation FirstCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    NSLog(@"layoutSubviews被调用");
}
@end
