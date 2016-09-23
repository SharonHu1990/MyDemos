//
//  ViewController.m
//  ConverCoordinateTest
//
//  Created by 胡晓阳 on 16/9/18.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"第%ld行",indexPath.row]];
    
    
    UIButton *clickBt = [UIButton buttonWithType:UIButtonTypeSystem];
    clickBt.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addSubview:clickBt];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:clickBt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:clickBt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:clickBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:clickBt attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTrailingMargin multiplier:1 constant:5]];
    
    [clickBt setTitle:@"点击" forState:UIControlStateNormal];
    [clickBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)clickAction:(UIButton *)clickBt{
    
    CGPoint cellPoint = [clickBt convertPoint:clickBt.bounds.origin toView:self.table];
    NSIndexPath *indexPath = [self.table indexPathForRowAtPoint:cellPoint];
    
    UITableViewCell *cell = [self.table cellForRowAtIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"第%ld行被点击",indexPath.row]];
    
}




@end
