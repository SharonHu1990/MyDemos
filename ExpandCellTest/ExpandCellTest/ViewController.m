//
//  ViewController.m
//  ExpandCellTest
//
//  Created by 胡晓阳 on 2016/12/13.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *dataSource;
    UITableView *tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableDictionary *dic1 = [NSMutableDictionary new];
    [dic1 setValue:@"分类1" forKey:@"first"];
    NSArray *subCategory1 = @[@"子分类1",@"子分类2",@"子分类3",@"子分类4",@"子分类5"];
    [dic1 setValue:subCategory1 forKey:@"sub"];
    [dataSource addObject:dic1];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary new];
    [dic2 setValue:@"分类2" forKey:@"first"];
    NSArray *subCategory2 = @[@"子分类1",@"子分类2",@"子分类3",@"子分类4",@"子分类5"];
    [dic2 setValue:subCategory2 forKey:@"sub"];
    [dataSource addObject:dic2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
