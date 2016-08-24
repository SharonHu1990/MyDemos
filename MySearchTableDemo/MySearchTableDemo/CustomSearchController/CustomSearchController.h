//
//  CustomSearchController.h
//  MySearchTableDemo
//
//  Created by 胡晓阳 on 16/8/10.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchBar.h"

@protocol CustomSearchControllerDelegate <NSObject>

- (void)didStartSearching;
- (void)didClickSearchButton;
- (void)didClickCancelButton;
- (void)didChangeSearchText:(NSString *)searchText;

@end

@interface CustomSearchController : UISearchController
@property (nonatomic, strong) CustomSearchBar *customSearchBar;
@property (nonatomic, weak) id<CustomSearchControllerDelegate> customDelegate;

-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController searchBarFrame:(CGRect)frame searchBarFont:(UIFont *)font searchBarTextColor:(UIColor *)searchBarTextColor searchBarTintColor:(UIColor *)searchBarTintColor searchBarFieldColor:(UIColor *)searchBarFieldColor;
@end
