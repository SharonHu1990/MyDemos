//
//  SettingCellInfo.h
//  SettingTableDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kDetailPate1,
    kDetailPage2,
} DetailPage;
@interface SettingCellInfo : NSObject

+ (SettingCellInfo *)info:(NSString *)title target:(id)target Sel:(SEL)sel viewController:(UIViewController *)viewController accessoryType:(UITableViewCellAccessoryType)accessoryType;

+ (SettingCellInfo *)info:(NSString *)title target:(id)target Sel:(SEL)sel viewController:(UIViewController *)viewController userInfo:(id)userInfo accessoryType:(UITableViewCellAccessoryType)accessoryType;



@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL sel;
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, retain) id userInfo;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

@end
