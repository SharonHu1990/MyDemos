//
//  ViewController.m
//  ScrollToTableFooterViewTest
//
//  Created by 胡晓阳 on 16/7/26.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableVie;
@property (nonatomic, retain) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *addReceiverButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 8, self.view.bounds.size.width - 8*2, (self.view.bounds.size.width - 8*2)*(72.f/670.f))];
    [addReceiverButton.layer setMasksToBounds:YES];
    [addReceiverButton.layer setCornerRadius:4.f];
    [addReceiverButton.layer setBorderWidth:0.5];
    [addReceiverButton setTitle:@"添加" forState:UIControlStateNormal];
    [addReceiverButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addReceiverButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [addReceiverButton setBackgroundColor:[UIColor whiteColor]];
    [addReceiverButton addTarget:self action:@selector(clickAddReceiverButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, addReceiverButton.frame.size.height + 21.f + 8*2)];
    [footerView setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]];
    [footerView addSubview:addReceiverButton];
    
    self.tableVie.tableFooterView = footerView;
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, addReceiverButton.frame.size.height + 21.f + 8*2)];
    [headerView setBackgroundColor:[UIColor redColor]];
    self.tableVie.tableHeaderView = headerView;
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [self.tableVie registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.tableVie reloadData];

}

- (void)clickAddReceiverButton:(id)sender{
    [self.dataSource addObject:@""];
//    [self.tableVie reloadData];
    [self.tableVie insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    //第一种方式(没成功)
//    [self.tableVie scrollRectToVisible:[self.tableVie convertRect:self.tableVie.tableFooterView.bounds fromView:self.tableVie.tableFooterView] animated:YES];
    //第二种方式（成功）
    [self.tableVie scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:
                                            [self.tableVie numberOfRowsInSection:0]-1 inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"第%ld行",indexPath.row]];
    return cell;
}

@end
