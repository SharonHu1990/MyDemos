//
//  ViewController.m
//  CustomizeViewsPractice
//
//  Created by 胡晓阳 on 16/4/11.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "FirstCustomView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FirstCustomView *customView = [[FirstCustomView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:customView];
    
    [self.view layoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
