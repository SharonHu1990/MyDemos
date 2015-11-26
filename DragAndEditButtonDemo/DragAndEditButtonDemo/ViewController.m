//
//  ViewController.m
//  DragAndEditButtonDemo
//
//  Created by 胡晓阳 on 15/11/26.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "ViewController.h"
#define Duration 0.2
#define MyButtonCount 8//按钮总个数
#define MARGIN 8//边距
#define SPACING 15//平行间距
#define  PADDING 12//行距
#define NumbersOfPerLine 4//每行几个button
#define ButtonWidth  ([UIScreen mainScreen].bounds.size.width - MARGIN * 2 - SPACING * 3)/NumbersOfPerLine//按钮宽度
#define ButtonHeight ButtonWidth * 9.0/25.0//按钮高度
@interface ViewController ()
{
    NSMutableArray *myButtonArray;
    
    BOOL contain;
    CGPoint startPoint;//手指开始长按的位置
    CGPoint originPoint;//按钮起始的位置
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    myButtonArray = [NSMutableArray arrayWithCapacity:MyButtonCount];
    
    [self initiateMyButtons];
    
}

-(void)initiateMyButtons{
    for (int i = 0; i < MyButtonCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        
        
        
        //列
        int column = i % NumbersOfPerLine;
        //行
        int row = i / NumbersOfPerLine;
        
        
        
        CGFloat origin_x = MARGIN + (ButtonWidth + SPACING) * column;
        CGFloat origin_y = ButtonWidth * row + PADDING * (row + 1);
        
        [btn setFrame:CGRectMake(origin_x, origin_y, ButtonWidth, ButtonWidth)];
        
        [self.view addSubview:btn];
        
        //长按
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
        [btn addGestureRecognizer:longPressGesture];
        
        [myButtonArray addObject:btn];
        
        
    }
}

-(void)buttonLongPressed:(UILongPressGestureRecognizer *)sender{
    
    UIButton *btn = (UIButton *)sender.view;//被移动的按钮
    if (sender.state == UIGestureRecognizerStateBegan) {
        startPoint = [sender locationInView:sender.view];
        originPoint = btn.center;
        
        [UIView animateWithDuration:Duration animations:^{
            
            btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
            btn.alpha = 0.7;
            
        }];
    }else if (sender.state == UIGestureRecognizerStateChanged){
        CGPoint newPoint = [sender locationInView:sender.view];//移动到的位置
        CGFloat deltaX = newPoint.x - startPoint.x;
        CGFloat deltaY = newPoint.y - startPoint.y;

        btn.center = CGPointMake(btn.center.x + deltaX, btn.center.y + deltaY);
        
        int index = [self indexOfCurrentPoint:btn.center withButton:btn];
        if (index < 0) {
            contain = NO;
        }else{
            //移动
            [UIView animateWithDuration:Duration animations:^{
                
                CGPoint temp = CGPointZero;
                UIButton *button = myButtonArray[index];
                temp = button.center;
                btn.center = temp;
                button.center = originPoint;
                originPoint = btn.center;
                contain = YES;
                
            }];
        }
        
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:Duration animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
            if (!contain) {
                btn.center = originPoint;
            }
        }];
    }
}

/**
 *  替换第几个按钮
 *
 *  @param point 当前移动到的位置
 *  @param btn   被移动的按钮
 *
 *  @return 替换第几个按钮
 */
- (int)indexOfCurrentPoint:(CGPoint)point withButton:(UIButton *)btn{
    
    for (int i = 0; i < myButtonArray.count; i ++) {
        UIButton *button = myButtonArray[i];
        
        if (btn != button) {
            if (CGRectContainsPoint(button.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}

//抖动
- (void)shakeButton{
    //创建动画对象，绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置属性：动画持续时长
    [animation setDuration:0.08];
    
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    
    //重复次数，无限大
    animation.repeatCount = HUGE_VAL;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
