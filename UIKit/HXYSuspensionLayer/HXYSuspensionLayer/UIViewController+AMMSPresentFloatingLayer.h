//
//  UIViewController+AMMSPresentFloatingLayer.h
//  AlibabaV5
//
//  Created by 胡晓阳 on 2016/11/14.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AMMSTransitionDismissBlock)();

@interface UIViewController (AMMSPresentFloatingLayer)
- (void)ms_presentViewController:(UIViewController *)presentedController completion:(void(^)(void))completionBlock dismissBlock:(AMMSTransitionDismissBlock)dismissBlock;

- (void)ms_dimissViewController:(UIViewController *)dismissedController completion:(void(^)(void))completionBlock;

@end
