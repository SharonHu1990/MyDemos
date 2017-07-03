//
//  ViewController.m
//  PathLayersDemo
//
//  Created by 胡晓阳 on 2017/4/5.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "RectangleView.h"
#import "TriangleView.h"
#import "OvalView.h"
#import "RoundedRectangleView.h"
#import "ArcView.h"
#import "TextLayerView.h"
#import "CurveView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //矩形
    CGFloat width = 240.f;
    CGFloat height = 160.f;
    
   /*
    RectangleView *rectangleView = [[RectangleView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2.f-width/2.f, CGRectGetHeight(self.view.bounds)/2.f-height/2.f, width, height)];
    [self.view addSubview:rectangleView];
*/
    
    
    /*
     RoundedRectangleView *roundedRectangleView = [[RoundedRectangleView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2.f-width/2.f, CGRectGetHeight(self.view.bounds)/2.f-height/2.f, width, height)];
     [self.view addSubview:roundedRectangleView];
     */
    
    
    /*
    //三角形
    TriangleView *triangleView = [[TriangleView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2.f-width/2.f, CGRectGetHeight(self.view.bounds)/2.f-height/2.f, width, height)];
    [self.view addSubview:triangleView];
    */
    
    
    //椭圆形 & 圆形
    
//    OvalView *ovalView = [[OvalView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2.f-width/2.f, CGRectGetHeight(self.view.bounds)/2.f-height/2.f, width, height)];
//    [self.view addSubview:ovalView];
    
    
    
//    //弧形
//    ArcView *arcView = [[ArcView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2.f-width/2.f, CGRectGetHeight(self.view.bounds)/2.f-height/2.f, width, height)];
//    [self.view addSubview:arcView];
     
    
    /*
    //Text Layer
    TextLayerView *textLayerView = [[TextLayerView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2.f-width/2.f, CGRectGetHeight(self.view.bounds)/2.f-height/2.f, width, height)];
    [self.view addSubview:textLayerView];
     */
    
    
    //贝塞尔曲线
    CurveView *curveView = [[CurveView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)/2.f-width/2.f, CGRectGetHeight(self.view.bounds)/2.f-height/2.f, width, height)];
    [self.view addSubview:curveView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
