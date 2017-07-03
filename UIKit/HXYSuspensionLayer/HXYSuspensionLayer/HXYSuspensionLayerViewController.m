/*!
 
 @header HXYSuspensionLayerViewController.m
 
 @abstract <#abstract#>
 
 @author Created by SharonHu on 2017/4/21.
 
 @version <#version#> 2017/4/21 Creation
 
   Copyright © 2017年 胡晓阳. All rights reserved.
 
 */

#import "HXYSuspensionLayerViewController.h"
#import "UIViewController+AMMSPresentFloatingLayer.h"
#import <PureLayout.h>

@interface HXYSuspensionLayerViewController ()

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation HXYSuspensionLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
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

- (void)configureView{
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.titleLabel autoSetDimension:ALDimensionHeight toSize:60.f];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectZero];
    [topLine setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:topLine];
    [topLine autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [topLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [topLine autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:60.f];
    [topLine autoSetDimension:ALDimensionHeight toSize:1.f/[UIScreen mainScreen].scale];
    
    [self.view addSubview:self.myTableView];
    [self.myTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel];
    [self.myTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.cancelButton];
    [self.myTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.myTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.myTableView reloadData];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
    [bottomLine setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bottomLine];
    [bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [bottomLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:43.5];
    [bottomLine autoSetDimension:ALDimensionHeight toSize:1.f/[UIScreen mainScreen].scale];
    
    [self.view addSubview:self.cancelButton];
    [self.cancelButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.cancelButton autoSetDimension:ALDimensionHeight toSize:43.5];

    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setBackgroundColor:[UIColor blackColor]];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(p_touchCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        
    }
    return _cancelButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setText:self.titleStr];
    }
    return _titleLabel;
}

- (void)p_touchCancelButton:(UIButton *)cancelButton{
    [self ms_dimissViewController:self completion:nil];
}

- (void)registerCellNib:(UINib *)cellNib forCellId:(NSString *)cellId estimateRowHeight:(CGFloat)estimateRowHeight{
    [self.myTableView registerNib:cellNib forCellReuseIdentifier:cellId];
    self.myTableView.estimatedRowHeight = estimateRowHeight;
//    [self.myTableView reloadData];
}

- (void)registerCellClass:(Class)cellClass forCellId:(NSString *)cellId estimateRowHeight:(CGFloat)estimateRowHeight{
    [self.myTableView registerClass:cellClass forCellReuseIdentifier:cellId];
    self.myTableView.estimatedRowHeight = estimateRowHeight;
//    [self.myTableView reloadData];
}

@end

