//
//  FirstCustomCell.h
//  AutolayoutPractice
//
//  Created by 胡晓阳 on 16/5/17.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FirstCustomCellDelegate <NSObject>

- (void)updateFirstCellDatasource:(NSString *)content indexPath:(NSIndexPath *)indexPath;

@end
@interface FirstCustomCell : UITableViewCell<UITextViewDelegate>
@property (nonatomic, assign) id<FirstCustomCellDelegate> delegate;
- (void)fillContentWithContent:(NSString *)content atIndexPath:(NSIndexPath *)indexPath;

@end
