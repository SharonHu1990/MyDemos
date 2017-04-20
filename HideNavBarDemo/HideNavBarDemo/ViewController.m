//
//  ViewController.m
//  HideNavBarDemo
//
//  Created by 胡晓阳 on 2017/3/6.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat lastContentOffsetY;
    BOOL scrollToTop;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];

    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (lastContentOffsetY < scrollView.contentOffset.y) {
        NSLog(@"向上滚动");
        scrollToTop = YES;
    }else{
        NSLog(@"向下滚动");
        scrollToTop = NO;
    }
    
    if (scrollToTop && scrollView.contentOffset.y >= 64) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",indexPath.row]];
    return cell;
}

@end
