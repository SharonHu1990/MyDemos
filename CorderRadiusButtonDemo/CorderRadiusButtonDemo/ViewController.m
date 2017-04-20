//
//  ViewController.m
//  CornerRadiusButtonDemo
//
//  Created by 胡晓阳 on 2016/12/21.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createACorderRadiusButton1];
    [self createACorderRadiusButton2];
    [self createACorderRadiusButton3];
    
    UIFont *font = _label.font;
    CGFloat x = font.lineHeight - font.pointSize;
    CGFloat space = 5 - x;
    
}


/**
 普通的设置边框圆角的方法
 */
- (void)createACorderRadiusButton1{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
    [self.view addSubview:btn];
//    [btn setBackgroundColor:[UIColor whiteColor]];
//    [btn.layer setBorderColor:[UIColor redColor].CGColor];
//    [btn.layer setBorderWidth:1.f];
//    [btn.layer setMasksToBounds:YES];
//    [btn.layer setCornerRadius:4.f];
    [btn setImage:[UIImage imageNamed:@"ms_bg-shareframe"] forState:UIControlStateNormal];
}


/**
 使用CAShapeLayer设置边框圆角
 */
- (void)createACorderRadiusButton2{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 210, 300, 100)];
    [self.view addSubview:btn];
    
    CAShapeLayer *blueLayer = [CAShapeLayer layer];
    blueLayer.frame = CGRectMake(0, 0, 300, 100);
    blueLayer.strokeColor = [UIColor blueColor].CGColor;
    blueLayer.fillColor = [UIColor whiteColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 300, 100) cornerRadius:4.f].CGPath;
    [btn.layer addSublayer:blueLayer];

}

- (void)createACorderRadiusButton3{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 320, 300, 100)];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:4.f];
    [self.view addSubview:btn];
}


/**
 设置圆角view
 */
- (void)createACorderRadiusView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 430, 300, 100)];
    [self.view addSubview:view];
    
    
    CAShapeLayer *blueLayer = [CAShapeLayer layer];
    blueLayer.frame = CGRectMake(0, 0, 300, 100);
//    blueLayer.strokeColor = [UIColor blueColor].CGColor;
    blueLayer.fillColor = [UIColor yellowColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 300, 100) cornerRadius:4.f].CGPath;
    [view.layer addSublayer:blueLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
