//
//  SettingTableViewController.h
//  SettingTableDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UITableViewController{
    BOOL _isLogined;
}

@property (nonatomic, retain) NSMutableArray *sectionName;
@property (nonatomic, retain) NSMutableArray *sectionRow;
@end
