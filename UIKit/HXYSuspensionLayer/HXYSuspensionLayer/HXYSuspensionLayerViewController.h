/*!
 
 @header HXYSuspensionLayerViewController.h
 
 @abstract <#abstract#>
 
 @author Created by SharonHu on 2017/4/21.
 
 @version <#version#> 2017/4/21 Creation
 
   Copyright © 2017年 胡晓阳. All rights reserved.
 
 */

#import <UIKit/UIKit.h>

@interface HXYSuspensionLayerViewController : UIViewController

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) NSArray *dataSource;

- (void)registerCellNib:(UINib *)cellNib forCellId:(NSString *)cellId estimateRowHeight:(CGFloat)estimateRowHeight;

- (void)registerCellClass:(Class)cellClass forCellId:(NSString *)cellId estimateRowHeight:(CGFloat)estimateRowHeight;

@end
