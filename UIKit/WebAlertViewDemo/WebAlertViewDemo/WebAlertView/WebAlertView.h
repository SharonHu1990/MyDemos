//
//  WebAlertView.h
//  AlibabaV5
//
//  Created by 胡晓阳 on 16/5/4.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebAlertView : UIView

@property (nonatomic, copy) NSString *htmlContent;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *confirmButtonTitle;

-(void)show:(UIViewController *)controller;
-(void)dismiss:(UIViewController *)controller;
@end
