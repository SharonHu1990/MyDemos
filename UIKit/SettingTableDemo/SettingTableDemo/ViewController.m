//
//  ViewController.m
//  SettingTableDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "ViewController.h"
#import "SettingTableViewController.h"
#import "SettingCellInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchSetButton:(id)sender {
    SettingTableViewController *settingTableViewController =[[SettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingTableViewController animated:YES];
}
@end
