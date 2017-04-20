//
//  AMPaperTabControl.h
//  AlibabaV5
//
//  Created by Cure on 15/9/10.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMPaperTabItem.h"
#import "AMPaperTabItemContol.h"

@class AMPaperTabControl;

@protocol AMPaperTabControlDelegate <NSObject>

@optional
- (BOOL)paperTabControl:(AMPaperTabControl *)tabControl shouldSelectTabIndex:(NSInteger)index;
- (void)paperTabControl:(AMPaperTabControl *)tabControl didTapItem:(AMPaperTabItem *)item atIndex:(NSInteger)index;

@end

@interface AMPaperTabControl : UIControl

@property (nonatomic, weak) id<AMPaperTabControlDelegate> delegate;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign, readonly) NSInteger selectedTabIndex;

@property (nonatomic, copy) UIColor *itemTitleColor;
@property (nonatomic, copy) UIColor *selectedItemTitleColor;

@property (nonatomic, strong) UIFont *itemTitleFont;
@property (nonatomic, strong) UIFont *selectedItemTitleFont;

@property (nonatomic, assign) BOOL showUnderline;
@property (nonatomic, copy) UIColor *underlineColor;

@property (nonatomic, assign) CGFloat underlineThickness;
@property (nonatomic, assign) AMPaperTabItemUnderlineType underlineType; // 下划线类型
@property (nonatomic, assign) CGFloat itemUnderlineScale;
@property (nonatomic, assign) CGFloat itemUnderlineWidth;
@property (nonatomic, assign) CGFloat itemUnderlineWidthExtra;
@property (nonatomic, assign) BOOL animatedUnderline;
@property (nonatomic, assign) NSTimeInterval underlineAnimationDuration;

- (void)selectTabIndex:(NSInteger)tabIndex;
- (void)selectTabIndex:(NSInteger)tabIndex animated:(BOOL)animated;
- (void)selectTabIndex:(NSInteger)tabIndex animated:(BOOL)animated sendActions:(BOOL)sendActions;

@end
