//
//  CustomSearchController.m
//  MySearchTableDemo
//
//  Created by 胡晓阳 on 16/8/10.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CustomSearchController.h"

@interface CustomSearchController ()<UISearchBarDelegate, UISearchControllerDelegate>

@end

@implementation CustomSearchController

-(UISearchBar *)searchBar{
    return self.customSearchBar;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController searchBarFrame:(CGRect)frame searchBarFont:(UIFont *)font searchBarTextColor:(UIColor *)searchBarTextColor searchBarTintColor:(UIColor *)searchBarTintColor searchBarFieldColor:(UIColor *)searchBarFieldColor{
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        
        [self configureSearchBarWithFrame:frame font:font textColor:searchBarTextColor backgroundColor:searchBarTintColor textFeildBgColor:searchBarFieldColor];
    }
    return self;
}

- (void)configureSearchBarWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)bgColor textFeildBgColor:(UIColor *)textFieldBgColor{
    
    _customSearchBar = [[CustomSearchBar alloc] initWithFrame:frame font:font textColor:textColor textfieldBackgroundColor:textFieldBgColor];
    
    _customSearchBar.barTintColor = bgColor;
    _customSearchBar.tintColor = textColor;
    
    [_customSearchBar.layer setBorderColor:_customSearchBar.barTintColor.CGColor];
    [_customSearchBar.layer setBorderWidth:1.f];
    
    _customSearchBar.delegate = self;
    
    self.delegate = self;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.customDelegate didStartSearching];
    [self.customSearchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.customSearchBar resignFirstResponder];
    
    [self.customSearchBar setShowsCancelButton:NO animated:YES];
    
    [self.customDelegate didClickCancelButton];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.customSearchBar resignFirstResponder];
    
    [self.customSearchBar setShowsCancelButton:NO animated:YES];
    
    [self.customDelegate didClickSearchButton];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.customDelegate didChangeSearchText:searchText];
}

#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController{
    [self.navigationController.navigationBar setTranslucent:true];
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    [self.navigationController.navigationBar setTranslucent:false];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
