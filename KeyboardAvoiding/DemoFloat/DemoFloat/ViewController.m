//
//  ViewController.m
//  DemoFloat
//
//  Created by 胡晓阳 on 16/7/6.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i<10; i++) {
        CGFloat a = [self test];
        
        NSLog(@"%f", a);
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (CGFloat)test {
    return [super test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
