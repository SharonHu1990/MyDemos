//
//  ViewController.m
//  LongValueDemo
//
//  Created by 胡晓阳 on 16/8/2.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /*数据类型在32位机型上的各种情况*/
    
    NSString *num = @"536291857507";
    
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    long longNum = [[formatter numberFromString:num] longValue];
    
    
    NSLog(@"longNum:%ld",longNum);//-579054493
    
    NSLog(@"longlongNum:%lld",[num longLongValue]);//536291857507
    
    NSLog(@"integerNum:%d",[num integerValue]);//2147483647
    
    NSLog(@"intNum:%d",[num intValue]);//2147483647
    
    NSLog(@"doubleNum:%f",[num doubleValue]);//536291857507.000000
    
    NSLog(@"floadNum:%f",[num floatValue]);  //536291868672.000000
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
