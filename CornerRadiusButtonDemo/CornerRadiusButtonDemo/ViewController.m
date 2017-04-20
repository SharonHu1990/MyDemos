//
//  ViewController.m
//  CornerRadiusButtonDemo
//
//  Created by 胡晓阳 on 2016/12/21.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createACorderRadiusButton1];
    [self createACorderRadiusButton2];
    [self createACorderRadiusButton3];
}

/**
 普通的设置圆角的方法
 */
- (void)createACorderRadiusButton1{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:2.f];
    [self.view addSubview:btn];
}


/**
 使用CAShapeLayer设置圆角
 */
- (void)createACorderRadiusButton2{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 160, 100, 50)];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    
    CAShapeLayer *blueLayer = [CAShapeLayer layer];
    blueLayer.frame = CGRectMake(0, 0, 100, 50);
    blueLayer.fillColor = [UIColor blueColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 50) cornerRadius:2.f].CGPath;
    
    [btn.layer addSublayer:blueLayer];
}

- (void)createACorderRadiusButton3{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 100, 50)];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:2.f];
    [self.view addSubview:btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
