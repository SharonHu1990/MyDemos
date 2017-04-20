/*!
 
 @header TestXibViewController.m
 
 @abstract TestViewController
 
 @author Created by SharonHu on 2017/4/18.
 
 @version 1.0 2017/4/18 Creation
 
   Copyright © 2017年 胡晓阳. All rights reserved.
 
 */
#import "TestXibViewController.h"
#import "TestViewController.h"


@interface TestXibViewController ()<TestVCDelegate>

@end

@implementation TestXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self testMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testMethod{
    
    TestViewController *testVC = [[TestViewController alloc] init];
    testVC.enumValue = TestEnum_V1;
}

#pragma mark - TestVCDelegate

- (void)testDelegateMethod{
    
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
