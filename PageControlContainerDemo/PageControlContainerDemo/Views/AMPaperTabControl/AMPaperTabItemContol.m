//
//  AMPaperTabItemContol.m
//  AlibabaV5
//
//  Created by Cure on 15/9/10.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import "AMPaperTabItemContol.h"
#import "AMPaperTabItem.h"

//#import "YPNMaxBadgeView.h"

#import <PureLayout/PureLayout.h>

typedef NS_ENUM(NSUInteger, AMPaperTabItemControlState) {
    AMPaperTabItemControlStateNormal,
    AMPaperTabItemControlStateHighlighted
};

@interface AMPaperTabItemContol ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
//@property (nonatomic, strong) YPNMaxBadgeView *badgeView;

@property (nonatomic, weak, readwrite) AMPaperTabItem *item;

@end

@implementation AMPaperTabItemContol

#pragma mark - Life Cycle

- (instancetype)initWithItem:(AMPaperTabItem *)item
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setup];
        self.item = item;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addSubview:self.titleLabel];
    
    [self.titleLabel autoCenterInSuperview];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0 relation:NSLayoutRelationGreaterThanOrEqual];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0 relation:NSLayoutRelationGreaterThanOrEqual];
//    
//    [self addSubview:self.badgeView];
//    [self.badgeView autoConstrainAttribute:ALAttributeHorizontal toAttribute:ALAttributeTop ofView:self.titleLabel withOffset:0.0];
//    [self.badgeView autoConstrainAttribute:ALAttributeVertical toAttribute:ALAttributeRight ofView:self.titleLabel withOffset:4.0];
//    [self.badgeView autoSetDimensionsToSize:CGSizeMake(100.0, 100.0)];
//    
    [self registerForKVO];
}

- (void)dealloc
{
    [self unregisterFromKVO];
}

#pragma mark - Getter

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

//- (YPNMaxBadgeView *)badgeView
//{
//    if (!_badgeView) {
//        _badgeView = [[YPNMaxBadgeView alloc] init];
//        _badgeView.badgeType = YPNBadgeTypeNumber;
//        _badgeView.badgeAlignment = YPNBadgeAlignmentCenter;
//        _badgeView.badgeTextFont = [UIFont im_badgeTextFont];
//        _badgeView.badgePointWidth = 10.0;
//    }
//    return _badgeView;
//}

#pragma mark - Setter

- (void)setItem:(AMPaperTabItem *)item
{
    if (_item != item) {
        _item = item;
        
        if (self.state == UIControlStateHighlighted || self.state == UIControlStateSelected) {
            self.titleLabel.text = item.selectedTitle;
            self.titleLabel.font = item.selectedTitleFont;
            self.titleLabel.textColor = item.selectedTitleColor;
        } else {
            self.titleLabel.text = item.title;
            self.titleLabel.font = item.titleFont;
            self.titleLabel.textColor = item.titleColor;
        }
        
//        if (item) {
//            if (item.badgeItem) {
//                self.badgeView.badgeType = item.badgeItem.badgeType;
//                self.badgeView.badgeText = item.badgeItem.badgeText;
//            } else {
//                self.badgeView.hidden = item.badge > 0 ? NO : YES;
//                self.badgeView.badgeText = [NSString stringWithFormat:@"%@", @(item.badge)];
//                self.badgeView.badgeType = item.badgeType;
//            }
//        }
    }
}

#pragma mark - KVO

- (NSArray *)observableKeyPaths
{
    return @[@"state",
             @"selected",
             ];
}

- (void)registerForKVO
{
    for (NSString *keyPath in [self observableKeyPaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:NULL];
    }
}

- (void)unregisterFromKVO
{
    for (NSString *keyPath in [self observableKeyPaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([NSThread isMainThread]) {
        [self updateForKeyPath:keyPath];
    } else {
        [self performSelectorOnMainThread:@selector(updateForKeyPath:) withObject:keyPath waitUntilDone:NO];
    }
}

- (void)updateForKeyPath:(NSString *)keyPath
{
    if ([keyPath isEqualToString:@"state"]) {
        if (self.item) {
            if (self.state == UIControlStateHighlighted || self.state == UIControlStateSelected) {
                self.titleLabel.text = self.item.selectedTitle;
                self.titleLabel.font = self.item.selectedTitleFont;
                self.titleLabel.textColor = self.item.selectedTitleColor;
            } else {
                self.titleLabel.text = self.item.title;
                self.titleLabel.font = self.item.titleFont;
                self.titleLabel.textColor = self.item.titleColor;
            }
        }
    } else if ([keyPath isEqualToString:@"selected"]) {
        if (self.item) {
            if (self.selected) {
                self.titleLabel.text = self.item.selectedTitle;
                self.titleLabel.font = self.item.selectedTitleFont;
                self.titleLabel.textColor = self.item.selectedTitleColor;
            } else {
                self.titleLabel.text = self.item.title;
                self.titleLabel.font = self.item.titleFont;
                self.titleLabel.textColor = self.item.titleColor;
            }
        }
    }
//    else if ([keyPath isEqualToString:@"badge"]) {
//        if (self.item
//            && !self.item.badgeItem) {
//            self.badgeView.hidden = self.item.badge > 0 ? NO : YES;
//            self.badgeView.badgeText = [NSString stringWithFormat:@"%@", @(self.item.badge)];
//        }
//    } else if ([keyPath isEqualToString:@"badgeType"]) {
//        if (self.item
//            && !self.item.badgeItem) {
//            self.badgeView.badgeType = self.item.badgeType;
//        }
//    } else if ([keyPath isEqualToString:@"badgeItem.badgeType"]) {
//        if (self.item) {
//            self.badgeView.badgeType = self.item.badgeItem.badgeType;
//        }
//    } else if ([keyPath isEqualToString:@"badgeItem.badgeText"]) {
//        if (self.item) {
//            self.badgeView.badgeText = self.item.badgeItem.badgeText;
//        }
//    }
}

@end
