//
//  ViewController.m
//  HeaderViewWithTableDemo
//
//  Created by 胡晓阳 on 16/7/26.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "CustomHeaderView.h"
#import "UIView+XIB.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CustomHeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView setBackgroundColor:[UIColor redColor]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
//    _headerView = (CustomHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomHeaderView" owner:self options:nil] lastObject];
    _headerView = [[CustomHeaderView alloc] initWithFrame:CGRectZero];
    _headerView.delegate =self;
    
    [_headerView setNeedsLayout];
    [_headerView layoutIfNeeded];
    
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, [_headerView actualHeight])];
    [containerView addSubview:_headerView];
    self.tableView.tableHeaderView = containerView;
    
    CGRect headerFrame = self.tableView.tableHeaderView.frame;
    headerFrame.size.height = [_headerView actualHeight];
    headerFrame.size.width = [UIScreen mainScreen].bounds.size.width;
    self.tableView.tableHeaderView.frame = headerFrame;
    _headerView.frame = headerFrame;
    containerView.frame = _headerView.frame;
    [self.tableView setTableHeaderView:containerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidLoad");
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
//    UIView *header = self.tableView.tableHeaderView;
////    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    CGFloat height = [header actualHeight];
//    CGRect frame = header.frame;
//    
//    
//    if (height != frame.size.height) {
//        frame.size.height = height;
//        header.frame = frame;
//        _tableView.tableHeaderView = header;
//    }
    
}

- (void)updateHeaderHeight{
//    UIView *header = self.tableView.tableHeaderView;
//    
//    [_headerView setNeedsLayout];
//    [_headerView layoutIfNeeded];
//    
//    [_headerView setNeedsDisplay];
    
    CGFloat height = [_headerView actualHeight];
    CGRect frame = _headerView.frame;
    
    frame.size.height = height;
    _headerView.frame = frame;
    
    self.tableView.tableHeaderView.frame = frame;
    self.tableView.tableHeaderView = _headerView;
    
    NSLog(@"tableHeaderView:%f\ntableHeight:%f",_tableView.tableHeaderView.frame.size.height,_headerView.tableView.frame.size.height);
    
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.textLabel setText:@"内容"];
    return cell;
}

@end
