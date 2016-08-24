//
//  ViewController.h
//  MySearchTableDemo
//
//  Created by 胡晓阳 on 16/8/9.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchController/CustomSearchController.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate, UISearchControllerDelegate>


@end

