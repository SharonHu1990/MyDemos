//
//  ViewController.m
//  MultiMenuTest
//
//  Created by 胡晓阳 on 16/7/9.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    NSDictionary *productModel1 = @{};
    NSDictionary *productModel2 = @{};
    
    NSDictionary *sourceItem1 = @{@"companyName":@"公司1",
                                  @"receiverModel":@{@"name":@"张三", @"phone":@"122344245345", @"address":@"地址地址地址"},
                                  @"productList":@[]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
