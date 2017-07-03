//
//  UIViewController+AMMSPresentFloatingLayer.m
//  AlibabaV5
//
//  Created by 胡晓阳 on 2016/11/14.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import "UIViewController+AMMSPresentFloatingLayer.h"
#import <objc/runtime.h>

static void *KPresentedViewController = &KPresentedViewController;

@implementation UIViewController (AMMSPresentFloatingLayer)

- (void)setPresentedViewController:(UIViewController *)controller{
    objc_setAssociatedObject(self, KPresentedViewController, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)presentedViewController{
    return objc_getAssociatedObject(self, KPresentedViewController);
}

- (void)ms_presentViewController:(UIViewController *)presentedController completion:(void (^)(void))completionBlock{
    
    objc_setAssociatedObject(self, KPresentedViewController, presentedController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIViewController *targetController = [self p_targetController];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(targetController.view.bounds), CGRectGetHeight(targetController.view.bounds))];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackView:)];
    [containerView addGestureRecognizer:tapGesture];
    
    [targetController.view addSubview:containerView];
    [containerView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    
    [targetController addChildViewController:presentedController];
    [presentedController didMoveToParentViewController:targetController];
    [presentedController.view setFrame:CGRectMake(0, CGRectGetHeight(targetController.view.bounds), CGRectGetWidth(targetController.view.bounds), CGRectGetHeight(targetController.view.bounds))];
    [containerView addSubview:presentedController.view];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [containerView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
        [presentedController.view setTransform:CGAffineTransformMakeTranslation(0, -CGRectGetHeight(targetController.view.bounds))];
    } completion:^(BOOL finished) {
        if (completionBlock) {
            completionBlock();
        }
        
    }];
}

-(void)ms_dimissViewController:(UIViewController *)dismissedController completion:(void (^)(void))completionBlock{
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        UIView *containerView = dismissedController.view.superview;
        [containerView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [dismissedController.view setTransform:CGAffineTransformIdentity];
    } completion:^(BOOL finished) {
        
        [dismissedController.view.superview removeFromSuperview];
        [dismissedController.view removeFromSuperview];
        
        [dismissedController willMoveToParentViewController:nil];
        [dismissedController removeFromParentViewController];
        
        if (completionBlock) {
            completionBlock();
        }
    }];
    
}

- (void)tapBackView:(UITapGestureRecognizer *)gesture{

    UIViewController *presentedController = objc_getAssociatedObject(self, KPresentedViewController);
    [self ms_dimissViewController:presentedController completion:^{
        
    }];
}


- (UIViewController *)p_targetController{
    UIViewController * target = self;
    while (target.parentViewController != nil) {
        target = target.parentViewController;
    }
    return target;
}
@end
