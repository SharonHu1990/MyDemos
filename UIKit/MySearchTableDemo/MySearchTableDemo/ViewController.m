//
//  ViewController.m
//  MySearchTableDemo
//
//  Created by 胡晓阳 on 16/8/9.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "SearchResultViewController/SearchResultsTabelviewVC.h"

@interface ViewController (){
    NSMutableArray *dataSource;
    NSMutableArray *filteredArray;
    BOOL shouldShowSearchResults;
    __weak IBOutlet UITableView *myTable;
}

@property (nonatomic, strong) UISearchController *mySearchController;
@property (nonatomic, strong) CustomSearchController *customSearchController;
@property (nonatomic, strong) SearchResultsTabelviewVC *searchResultsTableiewVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureCustomSearchController];
//    [self configureSearchController];
    [self configureTableView];
    [self loadDataSource];
}

- (SearchResultsTabelviewVC *)searchResultsTableiewVC{
    if (!_searchResultsTableiewVC) {
        _searchResultsTableiewVC = [[SearchResultsTabelviewVC alloc] init];
    }
    return _searchResultsTableiewVC;
}

#pragma mark - Private Methods
- (void)loadDataSource{
    NSArray *originalDataSource = [[[self mockDataWithFileName:@"addressHistory" ofType:@"json"] objectForKey:@"data"] objectForKey:@"resultList"];

    filteredArray = [[NSMutableArray alloc] init];
    dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < originalDataSource.count; i++) {
        NSDictionary *sourceItem = originalDataSource[i];
        NSString *content = [NSString stringWithFormat:@"%@%@%@%@%@",sourceItem[@"personalName"],sourceItem[@"mobileNO"], sourceItem[@"province"],sourceItem[@"city"],sourceItem[@"district"]];
        [dataSource addObject:content];
    }
    
}

- (void)configureTableView{
    myTable.dataSource = self;
    myTable.delegate = self;
    [myTable setEstimatedRowHeight:44.f];
    myTable.rowHeight = UITableViewAutomaticDimension;
    [myTable registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCellReuseID"];
}
- (void)configureSearchController{
    self.mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];

    _mySearchController.searchResultsUpdater = self;
    _mySearchController.dimsBackgroundDuringPresentation = NO;
    _mySearchController.searchBar.placeholder = @"搜索";
    _mySearchController.searchBar.delegate = self;
    [_mySearchController.searchBar sizeToFit];
    
    myTable.tableHeaderView = _mySearchController.searchBar;
}

- (void)configureCustomSearchController{
    
    SearchResultsTabelviewVC *resultVC = [[SearchResultsTabelviewVC alloc] init];
    resultVC.searchResults = filteredArray;
    
    
    _customSearchController = [[CustomSearchController alloc] initWithSearchResultsController:resultVC searchBarFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44.f) searchBarFont:[UIFont systemFontOfSize:14.f] searchBarTextColor:[UIColor grayColor] searchBarTintColor:[UIColor whiteColor] searchBarFieldColor:[UIColor colorWithWhite:232.f/255.f alpha:1]];
    
    _customSearchController.delegate = self;
    _customSearchController.customDelegate = self;
    
    _customSearchController.searchResultsUpdater = self;
    _customSearchController.dimsBackgroundDuringPresentation = YES;
    _customSearchController.searchBar.placeholder = @"搜索";
    [_customSearchController.searchBar sizeToFit];
    myTable.tableHeaderView = _customSearchController.customSearchBar;
    
    
//    _customSearchController.hidesNavigationBarDuringPresentation = false;
//    self.navigationItem.titleView = _customSearchController.searchBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return shouldShowSearchResults ? filteredArray.count : dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *mycell = [tableView dequeueReusableCellWithIdentifier:@"MyCellReuseID" forIndexPath:indexPath];
    if (shouldShowSearchResults) {
        [mycell fillCellWithContent:[filteredArray objectAtIndex:indexPath.row]];
    }else{
        [mycell fillCellWithContent:[dataSource objectAtIndex:indexPath.row]];
    }
    
    return mycell;
}

- (id)mockDataWithFileName:(NSString *)fileName ofType:(NSString *)type {
    id mockDic = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];;
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if ([fileData bytes] && [@"json" isEqualToString:type]) {
        NSError *error;
        mockDic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
    }
    return mockDic;
}


#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    shouldShowSearchResults = YES;
    [myTable reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    shouldShowSearchResults = NO;
    [myTable reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (!shouldShowSearchResults) {
        shouldShowSearchResults = YES;
        [myTable reloadData];
    }
    
    [_mySearchController.searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    
    [filteredArray removeAllObjects];
    NSString *searchString = _mySearchController.searchBar.text;
    for (NSString *sourceItem in dataSource) {
        if ([sourceItem rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [filteredArray addObject:sourceItem];
        }
    }
    
    [myTable reloadData];
}

#pragma mark - CustomSearchControllerDelegate
- (void)didStartSearching{
    shouldShowSearchResults = true;
    [myTable reloadData];
}

- (void)didClickSearchButton{
    if (!shouldShowSearchResults) {
        shouldShowSearchResults = true;
        [myTable reloadData];
    }
}

- (void)didClickCancelButton{
    shouldShowSearchResults = false;
    [myTable reloadData];
    
    myTable.tableHeaderView = _customSearchController.customSearchBar;
}

-(void)didChangeSearchText:(NSString *)searchText{
    [filteredArray removeAllObjects];
    for (NSString *sourceItem in dataSource) {
        if ([sourceItem rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [filteredArray addObject:sourceItem];
        }
    }
    [myTable reloadData];
}

//#pragma mark - UISearchControllerDelegate
//- (void)willPresentSearchController:(UISearchController *)searchController{
//    [self.navigationController.navigationBar setTranslucent:true];
//}
//
//- (void)willDismissSearchController:(UISearchController *)searchController{
//    [self.navigationController.navigationBar setTranslucent:false];
//}

@end
