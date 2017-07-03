//
//  UIViewController+AMMSPresentFloatingLayer.m
//  AlibabaV5
//
//  Created by 胡晓阳 on 2016/11/14.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import "UIViewController+AMMSPresentFloatingLayer.h"
#import <objc/runtime.h>

static void *KAMMSTransitionDismissBlock = &KAMMSTransitionDismissBlock;

@implementation UIViewController (AMMSPresentFloatingLayer)

- (void)ms_presentViewController:(UIViewController *)presentedController completion:(void (^)(void))completionBlock dismissBlock:(AMMSTransitionDismissBlock)dismissBlock{
    
    objc_setAssociatedObject(self, KAMMSTransitionDismissBlock, dismissBlock, OBJC_ASSOCIATION_COPY);
    UIViewController *targetController = [self p_targetController];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(targetController.view.bounds), CGRectGetHeight(targetController.view.bounds))];
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
        
        AMMSTransitionDismissBlock dismissBlock = objc_getAssociatedObject(self, KAMMSTransitionDismissBlock);
        if(dismissBlock){
            dismissBlock();
        }
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
