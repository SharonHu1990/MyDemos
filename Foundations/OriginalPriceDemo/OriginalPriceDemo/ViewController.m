//
//  ViewController.m
//  OriginalPriceDemo
//
//  Created by 胡晓阳 on 16/8/5.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "AMOriginalPriceView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet AMOriginalPriceView *originalPriceView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _originalPriceView.priceColor = [UIColor redColor];
    [_originalPriceView fillContentWithOriginalPrice:@"360" unit:@"盒" fontSize:10.f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
