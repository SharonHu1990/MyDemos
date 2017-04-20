//
//  CustomCell.h
//  HeaderViewWithTableDemo
//
//  Created by 胡晓阳 on 16/7/27.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol CustomCellDelegate <NSObject>

- (void)updateHeightWithText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@end
@interface CustomCell : UITableViewCell<UITextViewDelegate>
@property (nonatomic, weak) id<CustomCellDelegate> delegate;
@property (nonatomic, copy) NSString *input;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
