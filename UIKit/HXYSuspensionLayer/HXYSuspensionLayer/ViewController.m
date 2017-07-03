//
//  ViewController.m
//  HXYSuspensionLayer
//
//  Created by SharonHu on 2017/4/21.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "HXYSuspensionLayerViewController.h"
#import "UIViewController+AMMSPresentFloatingLayer.h"
#import <PureLayout.h>

@interface ViewController ()
@property (nonatomic, strong) HXYSuspensionLayerViewController *layerVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    
    [btn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [btn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [btn autoSetDimensionsToSize:CGSizeMake(100, 50)];
    [btn setTitle:@"打开浮层" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(p_showLayer:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)p_showLayer:(UIButton *)sender{
    [self ms_presentViewController:self.layerVC completion:nil dismissBlock:nil];
}

- (HXYSuspensionLayerViewController *)layerVC{
    if (!_layerVC) {
        _layerVC = [[HXYSuspensionLayerViewController alloc] init];
        _layerVC.titleStr = @"测试浮层";
        [_layerVC registerCellClass:[UITableViewCell class] forCellId:@"CellId" estimateRowHeight:50];
        NSArray *dataSource = @[@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试"];
        _layerVC.dataSource = dataSource;
    }
    return _layerVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
