//
//  AMPaperTabItem.m
//  AlibabaV5
//
//  Created by Cure on 15/9/10.
//  Copyright (c) 2015年 Alibaba-inc. All rights reserved.
//

#import "AMPaperTabItem.h"
#import <KVOController/FBKVOController.h>
#import <libextobjc/extobjc.h>

@implementation AMPaperTabItem

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _title = title;
        _selectedTitle = title;
//        _badgeType = YPNBadgeTypeNumber;
//        _badge = 0;
    }
    return self;
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        
        if (!self.selectedTitle) {
            self.selectedTitle = title;
        }
    }
}

//- (void)setBadge:(NSInteger)badge
//{
//    if (_badge != badge) {
//        _badge = badge;
//        [self.itemControl updateForKeyPath:@"badge"];
//    }
//}
//
//- (void)setBadgeType:(YPNBadgeType)badgeType
//{
//    if (_badgeType != badgeType) {
//        _badgeType = badgeType;
//        [self.itemControl updateForKeyPath:@"badgeType"];
//    }
//}

- (void)setItemControl:(AMPaperTabItemContol *)itemControl
{
    if (_itemControl != itemControl) {
        [self.KVOController unobserve:self];
        
        _itemControl = itemControl;
        
        @weakify(self)
        [self.KVOController observe:self.badgeItem keyPath:@"badgeType" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            @strongify(self)
            [self.itemControl updateForKeyPath:@"badgeItem.badgeType"];
        }];
        [self.KVOController observe:self.badgeItem keyPath:@"badgeText" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
            @strongify(self)
            [self.itemControl updateForKeyPath:@"badgeItem.badgeText"];
        }];
    }
}

@end
