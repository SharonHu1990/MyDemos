//
//  ViewController.m
//  PageControlContainerDemo
//
//  Created by 胡晓阳 on 2017/2/14.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "AMPaperTabControl.h"
#import "ViewController1.h"
#import "ViewController2.h"

@interface ViewController ()<AMPaperTabControlDelegate>
@property (nonatomic, strong) AMPaperTabControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollContainer;
@property (nonatomic, strong) UIViewController *controller1;
@property (nonatomic, strong) UIViewController *controller2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)setupPageControlContainer{
    
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.containerView];
    
    
    
}

- (AMPaperTabControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[AMPaperTabControl alloc] init];
        _pageControl.itemTitleFont = [UIFont systemFontOfSize:14];
        _pageControl.itemTitleColor = [UIColor blackColor];
        _pageControl.selectedItemTitleColor = [UIColor redColor];
        _pageControl.underlineColor = [UIColor redColor];
        _pageControl.itemUnderlineWidth = 49.f;
        
        _pageControl.items = @[@"title1",@"title2"];
        _pageControl.delegate = self;
    }
    return _pageControl;
}

- (UIScrollView *)scrollContainer{
    
    if (!_scrollContainer) {
        _scrollContainer = [[UIScrollView alloc] init];
    }
}

- (UIViewController *)controller1{
    
    if (!_controller1) {
        _controller1 = [[ViewController1 alloc] init];
    }
    return _controller1;
}

- (UIViewController *)controller2{
    if (!_controller2) {
        _controller2 = [[ViewController2 alloc] init];
    }
    return _controller2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
