//
//  ViewController.m
//  RadiusDemo
//
//  Created by 胡晓阳 on 2017/3/22.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *containerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [containerImageView setImage:[UIImage imageNamed:@"demo"]];
    [containerImageView setBackgroundColor:[UIColor redColor]];
    [containerImageView.layer setCornerRadius:100.f];
    [self.view addSubview:containerImageView];
//
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [lb setText:@"测试"];
    [view2 addSubview:lb];
    [view2 setBackgroundColor:[UIColor blueColor]];
    [view2.layer setCornerRadius:50.f];
    [self.view addSubview:view2];
//
//    //开始画图
//    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
//    //使用贝塞尔曲线画一个圆形图
//    [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.frame.size.width] addClip];
//    [view drawRect:view.bounds];
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    //结束画图
//    UIGraphicsEndImageContext();
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
