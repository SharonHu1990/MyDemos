//
//  ViewController.m
//  BaseTransformDemo
//
//  Created by SharonHu on 2017/6/13.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (weak, nonatomic) IBOutlet UIView *innerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CALayer *layer1 = [CALayer layer];
//    layer1.bounds = CGRectMake(0, 0, 100, 100);
//    layer1.position = self.view.center;
//    layer1.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer1];
//    
//    CALayer *layer2 = [CALayer layer];
//    layer2.bounds = CGRectMake(0, 0, 100, 100);
//    layer2.position = self.view.center;
//    layer2.backgroundColor = [UIColor blueColor].CGColor;
//    [self.view.layer addSublayer:layer2];
    
    /************** 仿射变换 ***************/
    
//    //旋转
//    CGAffineTransform affineTransform = CGAffineTransformMakeRotation(M_PI/18.f);//顺时针旋转
//    layer1.affineTransform = affineTransform;
    
//    //或者
//    CGAffineTransform affineTransform = CGAffineTransformIdentity;
//    affineTransform = CGAffineTransformRotate(affineTransform, M_PI_4);
//    layer1.affineTransform = affineTransform;
    
//    //混合变换(先缩小50%，再旋转30度，最后向右移动200个像素)
//    CGAffineTransform affineTransform = CGAffineTransformIdentity;
//    affineTransform = CGAffineTransformScale(affineTransform, 0.5, 0.5);
//    affineTransform = CGAffineTransformRotate(affineTransform, M_PI/6);
//    affineTransform = CGAffineTransformTranslate(affineTransform, 200, 0);//平移的路线也会被旋转30度，长短缩短为100
//    layer2.affineTransform = affineTransform;
    
    
    /************** 3D变换 ***************/
//    //3D透视旋转
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1/500.f;//应用透视效果之后再对图层做旋转操作
//    //绕Z轴顺时针旋转45度
//    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
//    layer2.transform = transform;
    
    
    //sublayerTransform
    
    /*
    //不使用sublayerTransform的情况
    CATransform3D transform1 = CATransform3DIdentity;
    transform1.m34 = -1/500.f;//应用透视效果之后再对图层做旋转操作
    transform1 = CATransform3DRotate(transform1, M_PI_4, 0, 1, 0);//向里旋转
    _layerView1.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = -1/500.f;
    transform2 = CATransform3DRotate(transform2, -M_PI_4, 0, 1, 0);//向外旋转
    _layerView2.layer.transform = transform2;
     */
    
    /*
    //使用sublayerTransform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1/500.f;
    _containerView.layer.sublayerTransform = perspective;
    _layerView1.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    _layerView2.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
     */
    
    //扁平化图层,内部图层通过反向旋转抵消外部图层造成的影响
//    _outerView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
//    _innerView.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1/500.f;//应用透视效果之后再对图层做旋转操作
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);//向里旋转
    _outerView.layer.transform = outer;
    
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1/500.f;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);//向外旋转
    _innerView.layer.transform = inner;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
