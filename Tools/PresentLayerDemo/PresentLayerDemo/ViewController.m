//
//  ViewController.m
//  PresentLayerDemo
//
//  Created by SharonHu on 2017/4/24.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+AMMSPresentFloatingLayer.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [btn setTitle:@"打开" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setCenter:CGPointMake(CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(self.view.bounds)/2.f)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show{
    TestViewController *testVC = [[TestViewController alloc] init];

    [self ms_presentViewController:testVC completion:^{
        NSLog(@"打开");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
