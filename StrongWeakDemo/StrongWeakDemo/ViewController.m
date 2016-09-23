//
//  ViewController.m
//  StrongWeakDemo
//
//  Created by 胡晓阳 on 2016/9/22.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __strong NSObject *obj1 = [[NSObject alloc] init];
    __strong NSObject *obj2 = obj1;
    
    NSLog(@"%@,%@",obj1,obj2);
    
    obj1 = nil;
    
    NSLog(@"%@,%@",obj1,obj2);
    
    NSAssert(obj1==obj2, @"不相等");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
