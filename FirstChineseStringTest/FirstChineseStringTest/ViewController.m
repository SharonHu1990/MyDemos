//
//  ViewController.m
//  FirstChineseStringTest
//
//  Created by 胡晓阳 on 16/6/8.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str = @"我是汉字哈哈哈哈哈哈";
    str = @"Sharon";
    NSString *firstStr = [str substringToIndex:1];
    
    NSLog(@"firstStr:%@",[firstStr uppercaseString]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
