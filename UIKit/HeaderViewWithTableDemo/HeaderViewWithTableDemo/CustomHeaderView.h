//
//  CustomHeaderView.h
//  HeaderViewWithTableDemo
//
//  Created by 胡晓阳 on 16/7/26.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

- (void)updateHeaderHeight;

@end
@interface CustomHeaderView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) id<HeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (CGFloat)actualHeight;

@end
