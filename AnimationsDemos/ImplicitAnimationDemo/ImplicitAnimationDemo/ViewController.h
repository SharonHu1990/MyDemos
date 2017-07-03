//
//  ViewController.h
//  ImplicitAnimationDemo
//
//  Created by SharonHu on 2017/6/13.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;/*热心人发现这里应该改为@property (nonatomic, strong)  CALayer *colorLayer;否则运行结果不正确.*/

@end

