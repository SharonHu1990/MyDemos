//
//  AMPaperTabControl.m
//  AlibabaV5
//
//  Created by Cure on 15/9/10.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import "AMPaperTabControl.h"
#import <PureLayout/PureLayout.h>

static const NSUInteger AMTagOffset = 400;

@interface AMPaperTabControl ()

@property (nonatomic, assign, readwrite) NSInteger selectedTabIndex;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *underline;

@property (nonatomic, strong) NSLayoutConstraint *underlineConstraintX;
@property (nonatomic, strong) NSLayoutConstraint *underlineConstraintHeight;
@property (nonatomic, strong) NSLayoutConstraint *underlineConstraintWidth;

@property (nonatomic, assign) BOOL animating;

@end

@implementation AMPaperTabControl

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
    [self addSubview:self.contentView];
    [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    _selectedTabIndex = -1;
    
    _itemTitleColor = [UIColor colorWithHexString:@"333333"];
    _selectedItemTitleColor = [UIColor colorWithHexString:@"ff7300"];
    _itemTitleFont = [UIFont systemFontOfSize:16.0];
    _selectedItemTitleFont = [UIFont systemFontOfSize:16.0];
    
    _underlineThickness = 2.0;

    _underlineType = AMPaperTabItemUnderlineTypeScaleTitle;
    _itemUnderlineScale = 1.0;
    _itemUnderlineWidth = 44.0;
    
    _animatedUnderline = YES;
    _underlineAnimationDuration = 0.2;
    
    self.underlineColor = _selectedItemTitleColor;

    self.showUnderline = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.animating) {
        [self updateUnderlineConstraints];
        [super layoutSubviews];
    }
}


#pragma mark - Getter

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _contentView;
}

- (UIView *)underline
{
    if (!_underline) {
        _underline = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _underline;
}

- (UIColor *)underlineColor
{
    return self.underline.backgroundColor;
}

#pragma mark - Setter

- (void)setItems:(NSArray *)items
{
    if (!items.count) {
        return;
    }
    
    _items = items;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    NSUInteger i = 0;
    for (NSObject *object in items) {
        if ([object isKindOfClass:[AMPaperTabItem class]]) {
            AMPaperTabItem *item = (AMPaperTabItem *)object;
            if (!item.titleColor) {
                item.titleColor = self.itemTitleColor;
            }
            if (!item.selectedTitleColor) {
                item.selectedTitleColor = self.selectedItemTitleColor;
            }
            if (!item.titleFont) {
                item.titleFont = self.itemTitleFont;
            }
            if (!item.selectedTitleFont) {
                item.selectedTitleFont = self.selectedItemTitleFont;
            }
            
            AMPaperTabItemContol *itemControl = [[AMPaperTabItemContol alloc] initWithItem:item];
            item.itemControl = itemControl;
            itemControl.tag = AMTagOffset + i;
            [self.contentView addSubview:itemControl];
            
            [itemControl autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [itemControl autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            
            [itemControl addTarget:self action:@selector(itemControlTapped:) forControlEvents:UIControlEventTouchUpInside];
            
            i++;
        }
    }
    
    if (i > 0) {
        if (i > 1) {
            [self.contentView.subviews autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0.0];
        } else {
            [self.contentView.subviews[0] autoPinEdgeToSuperviewEdge:ALEdgeLeading];
            [self.contentView.subviews[0] autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
            [self.contentView.subviews[0] autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        }
        
        [self selectTabIndex:0 animated:NO sendActions:NO];
    }
    
    [self setNeedsLayout];
}

- (void)setShowUnderline:(BOOL)showUnderline
{
    if (_showUnderline != showUnderline) {
        _showUnderline = showUnderline;
        
        if (!_showUnderline) {
            [self.underline removeFromSuperview];
        } else if (!self.underline.superview) {
            [self addSubview:self.underline];
            [self.underline autoPinEdgeToSuperviewEdge:ALEdgeBottom];
            self.underlineConstraintHeight = [self.underline autoSetDimension:ALDimensionHeight toSize:self.underlineThickness];
            self.underlineConstraintX = [self.underline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0];
            self.underlineConstraintWidth = [self.underline autoSetDimension:ALDimensionWidth toSize:CGRectGetWidth(self.bounds)];
        }
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    for (AMPaperTabItem *item in self.items) {
        if (!item.titleColor
            || item.titleColor == _itemTitleColor) {
            item.titleColor = itemTitleColor;
        }
    }
    
    _itemTitleColor = itemTitleColor;
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor
{
    for (AMPaperTabItem *item in self.items) {
        if (!item.selectedTitleColor
            || item.selectedTitleColor == _selectedItemTitleColor) {
            item.selectedTitleColor = selectedItemTitleColor;
        }
    }
    
    _selectedItemTitleColor = selectedItemTitleColor;
    
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont
{
    for (AMPaperTabItem *item in self.items) {
        if (!item.titleFont
            || item.titleFont == _itemTitleFont) {
            item.titleFont = itemTitleFont;
        }
    }
    
    _itemTitleFont = itemTitleFont;
}

- (void)setSelectedItemTitleFont:(UIFont *)selectedItemTitleFont
{
    for (AMPaperTabItem *item in self.items) {
        if (!item.selectedTitleFont
            || item.selectedTitleFont == _selectedItemTitleFont) {
            item.selectedTitleFont = selectedItemTitleFont;
        }
    }
    _selectedItemTitleFont = selectedItemTitleFont;
}

- (void)setUnderlineColor:(UIColor *)underlineColor
{
    self.underline.backgroundColor = underlineColor;
}

- (void)setUnderlineThickness:(CGFloat)underlineThickness
{
    _underlineThickness = underlineThickness;
    self.underlineConstraintHeight.constant = underlineThickness;
    [self setNeedsLayout];
}

#pragma mark - Action

- (void)itemControlTapped:(AMPaperTabItemContol *)sender
{
    NSInteger index = sender.tag - AMTagOffset;
    
    if ([self.delegate respondsToSelector:@selector(paperTabControl:didTapItem:atIndex:)]) {
        [self.delegate paperTabControl:self didTapItem:self.items[index] atIndex:index];
    }
    
    [self selectTabIndex:index animated:self.animatedUnderline sendActions:YES];
}

#pragma - API

- (void)selectTabIndex:(NSInteger)tabIndex
{
    [self selectTabIndex:tabIndex animated:YES sendActions:YES];
}

- (void)selectTabIndex:(NSInteger)tabIndex animated:(BOOL)animated
{
    [self selectTabIndex:tabIndex animated:animated sendActions:YES];
}

- (void)selectTabIndex:(NSInteger)tabIndex animated:(BOOL)animated sendActions:(BOOL)sendActions
{
    if (_selectedTabIndex != tabIndex) {
        
        if ([self.delegate respondsToSelector:@selector(paperTabControl:shouldSelectTabIndex:)]) {
            if (![self.delegate paperTabControl:self shouldSelectTabIndex:tabIndex]) {
                return;
            }
        }
        
        _selectedTabIndex = tabIndex;
        
        for (UIView *view in self.contentView.subviews) {
            if ([view isKindOfClass:[AMPaperTabItemContol class]]) {
                AMPaperTabItemContol *itemControl = (AMPaperTabItemContol *)view;
                if (itemControl.tag != AMTagOffset + tabIndex) {
                    itemControl.selected = NO;
                } else {
                    itemControl.selected = YES;
                }
            }
        }
        
        if (self.showUnderline) {
            [self updateUnderlineConstraints];
            
            if (animated) {
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                self.animating = YES;
                [UIView animateWithDuration:self.underlineAnimationDuration animations:^{
                    [self layoutIfNeeded];
                } completion:^(BOOL finished) {
                    self.animating = NO;
                    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                }];
            } else {
                [self layoutIfNeeded];
            }
        }
        
        if (sendActions) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

#pragma mark -

- (void)updateUnderlineConstraints
{
    CGFloat buttonWidth = CGRectGetWidth(self.bounds) / self.items.count;
    AMPaperTabItem *selectedItem = self.items[self.selectedTabIndex];
    
    CGFloat widthExtra = selectedItem.underlineWidthExtra > 0 ? selectedItem.underlineWidthExtra : self.itemUnderlineWidthExtra;
    CGFloat width;
    switch (self.underlineType) {
        case AMPaperTabItemUnderlineTypeScaleTitle:
        {
            CGFloat scale = selectedItem.underlineScale > 0 ? selectedItem.underlineScale : self.itemUnderlineScale;
            UIFont *font = selectedItem.selectedTitleFont ? selectedItem.selectedTitleFont : self.selectedItemTitleFont;
            CGFloat titleWidth = [selectedItem.selectedTitle sizeWithAttributes:@{NSFontAttributeName: font}].width;
            width = round(titleWidth * scale + widthExtra);
        }
            break;
        case AMPaperTabItemUnderlineTypeScaleView:
        {
            CGFloat scale = selectedItem.underlineScale > 0 ? selectedItem.underlineScale : self.itemUnderlineScale;
            width = round(buttonWidth * scale + widthExtra);
        }
            break;
        case AMPaperTabItemUnderlineTypeCustom: default:
        {
            CGFloat width0 = selectedItem.underlineWidth > 0 ? selectedItem.underlineWidth : self.itemUnderlineWidth;
            width = width0 + widthExtra;
        }
            break;
    }
    
    self.underlineConstraintWidth.constant = width;
    self.underlineConstraintX.constant = round(buttonWidth * self.selectedTabIndex + buttonWidth * 0.5 - width * 0.5);
}

@end
