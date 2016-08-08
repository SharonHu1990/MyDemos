//
//  ViewController.m
//  StringAnimationDemo
//
//  Created by 胡晓阳 on 16/7/29.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_myView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(id)sender {
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}
@end
