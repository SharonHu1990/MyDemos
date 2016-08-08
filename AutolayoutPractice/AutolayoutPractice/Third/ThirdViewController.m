//
//  ThirdViewController.m
//  AutolayoutPractice
//
//  Created by 胡晓阳 on 16/5/17.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ThirdViewController.h"
#import "FirstCustomCell.h"

#define CellIdentifier_FirstCustomCell @"FirstCustomCellReuseID"

@interface ThirdViewController ()<FirstCustomCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, copy) NSMutableArray *dataSource;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_myTable registerNib:[UINib nibWithNibName:@"FirstCustomCell" bundle:nil] forCellReuseIdentifier:CellIdentifier_FirstCustomCell];
    _myTable.estimatedRowHeight = 266.f;
    _myTable.rowHeight = UITableViewAutomaticDimension;
    
    _dataSource = [NSMutableArray arrayWithObjects:@"内容",@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内",@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容", nil];
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

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstCustomCell *firstCustomCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier_FirstCustomCell forIndexPath:indexPath];
    [firstCustomCell fillContentWithContent:_dataSource[indexPath.row] atIndexPath:indexPath];
    firstCustomCell.delegate = self;
    return firstCustomCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - FirstCustomCellDelegate
-(void)updateFirstCellDatasource:(NSString *)content indexPath:(NSIndexPath *)indexPath{
    [_dataSource replaceObjectAtIndex:indexPath.row withObject:content];
//    [self.myTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.myTable beginUpdates];
    [self.myTable endUpdates];
}
@end
