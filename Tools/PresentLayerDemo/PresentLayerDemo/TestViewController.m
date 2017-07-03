/*!
 
 @header TestViewController.m
 
 @abstract <#abstract#>
 
 @author Created by SharonHu on 2017/4/24.
 
 @version <#version#> 2017/4/24 Creation
 
   Copyright © 2017年 胡晓阳. All rights reserved.
 
 */

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor redColor]];
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-200, CGRectGetWidth(self.view.bounds), 200)];
    [testView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:testView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
