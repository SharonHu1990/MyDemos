//
//  ViewController.m
//  LayoutSubViewsTest
//
//  Created by 胡晓阳 on 16/4/12.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (nonatomic, assign) BOOL hasDistance;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _hasDistance = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchButton:(id)sender {
    if (!_hasDistance) {
        _hasDistance = YES;
        _leftConstraint.constant = 100;
        
    }else{
        _hasDistance = NO;
        _leftConstraint.constant = 0;
    }
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.view layoutIfNeeded];//立即实现布局，如果不写这一句就没有动画效果
    } completion:nil];
}

@end
