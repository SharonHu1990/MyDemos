//
//  ViewController.m
//  ConvertRectDemo
//
//  Created by 胡晓阳 on 16/9/19.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    @property (weak, nonatomic) IBOutlet UIView *redView;
    @property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    CGRect blueViewInParentViewRect = [self.redView convertRect:self.redView.bounds toView:self.view];
    CGPoint p = [self.blueView convertPoint:self.blueView.frame.origin toView:self.view];
    NSLog(@"(%f,%f,%f,%f)",blueViewInParentViewRect.origin.x,blueViewInParentViewRect.origin.y,blueViewInParentViewRect.size.width, blueViewInParentViewRect.size.height);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
