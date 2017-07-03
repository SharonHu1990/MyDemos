//
//  ViewController.m
//  ImplicitAnimationDemo
//
//  Created by SharonHu on 2017/6/13.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //add a custom action
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor":transition};
    
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColor:(id)sender {
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.5];

    //添加完成块
//    [CATransaction setCompletionBlock:^{
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:0.5];
//        CGAffineTransform transform = self.colorLayer.affineTransform;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        self.layerView.layer.affineTransform = transform;
//        [CATransaction commit];
//    }];

    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    [CATransaction commit];
    
    
    
    //    CATransition *animation = [CATransition animation];
    //    animation.duration = 1.f;
    //    [self.colorLayer addAnimation:animation forKey:@"animation1"];
}

@end
