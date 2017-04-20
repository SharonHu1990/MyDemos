//
//  ViewController.m
//  SortDemo
//
//  Created by 胡晓阳 on 2017/3/3.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@"5", @"-1", @"10", @"4", @"-19"];
    
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }else{
            return NSOrderedDescending;
        }
    }];
    
    NSLog(@"arr:%@",arr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
