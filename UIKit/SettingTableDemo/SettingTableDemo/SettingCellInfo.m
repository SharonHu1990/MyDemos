//
//  SettingCellInfo.m
//  SettingTableDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "SettingCellInfo.h"

@implementation SettingCellInfo

+ (SettingCellInfo *)info:(NSString *)title target:(id)target Sel:(SEL)sel viewController:(UIViewController *)viewController accessoryType:(UITableViewCellAccessoryType)accessoryType{
    SettingCellInfo *info = [[SettingCellInfo alloc] init];
    info.title = title;
    info.target = target;
    info.sel = sel;
    info.viewController = viewController;
    info.accessoryType = accessoryType;
    return info;
}

+ (SettingCellInfo *)info:(NSString *)title target:(id)target Sel:(SEL)sel viewController:(UIViewController *)viewController userInfo:(id)userInfo accessoryType:(UITableViewCellAccessoryType)accessoryType{
    SettingCellInfo *info = [[SettingCellInfo alloc] init];
    info.title = title;
    info.target = target;
    info.sel = sel;
    info.viewController = viewController;
    info.userInfo = userInfo;
    info.accessoryType = accessoryType;
    return info;
}

@synthesize title = _title;
@synthesize target = _target;
@synthesize sel = _sel;
@synthesize viewController = _viewController;
@synthesize userInfo = _userInfo;
@synthesize accessoryType = _accessoryType;
@end
