//
//  AMPaperTabItem.h
//  AlibabaV5
//
//  Created by Cure on 15/9/10.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YPNMaxBadgeView.h"
//#import "AMIMCompositeBadgeItem.h"
#import "AMPaperTabItemContol.h"

// 下划线类型
typedef NS_ENUM(NSUInteger, AMPaperTabItemUnderlineType) {
    AMPaperTabItemUnderlineTypeScaleTitle, // 根据underlineScale自适应title
    AMPaperTabItemUnderlineTypeScaleView, // 根据underlineScale自适应itemView
    AMPaperTabItemUnderlineTypeCustom, // 根据underlineWidth自定义
};

@interface AMPaperTabItem : NSObject

@property (nonatomic, weak) AMPaperTabItemContol *itemControl;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *selectedTitle;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *selectedTitleFont;

//@property (nonatomic, assign) NSInteger badge;
//@property (nonatomic, assign) YPNBadgeType badgeType;
//@property (nonatomic, strong) AMIMCompositeBadgeItem *badgeItem;

@property (nonatomic, assign) CGFloat underlineWidth;
@property (nonatomic, assign) CGFloat underlineWidthExtra;
@property (nonatomic, assign) CGFloat underlineScale;

- (instancetype)initWithTitle:(NSString *)title;

@end
