//
//  AMPaperTabItemContol.h
//  AlibabaV5
//
//  Created by Cure on 15/9/10.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPaperTabItem;

@interface AMPaperTabItemContol : UIControl

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, weak, readonly) AMPaperTabItem *item;

- (instancetype)initWithItem:(AMPaperTabItem *)item;

- (void)updateForKeyPath:(NSString *)keyPath;

@end
