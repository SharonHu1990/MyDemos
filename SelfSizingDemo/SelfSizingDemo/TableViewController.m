//
//  TableViewController.m
//  SelfSizingDemo
//
//  Created by SharonHu on 15/11/11.
//  Copyright © 2015年 Sharon. All rights reserved.
//

#import "TableViewController.h"
#import "CustomTableViewCell.h"

@interface TableViewController ()
{
    NSArray *source;
    NSArray *names;
    NSArray *addresses;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    source = @[
               @{@"name":@"The Grand Del Mar" , @"address" : @"5300 Grand Del Mar Court, San Diego, CA 92130"},
              @{@"name":@"French Quarter Inn" , @"address" : @"166 Church St, Charleston, SC 29401"},
              @{@"name":@"Bardessono" , @"address" : @"6526 Yount Street, Yountville, CA 94599"},
              @{@"name":@"Hotel Yountville" , @"address" : @"6462 Washington Street, Yountville, CA 94599"},
              @{@"name":@"Islington Hotel" , @"address" : @"321 Davey Street, Hobart, Tasmania 7000, Australia"},
              @{@"name":@"The Henry Jones Art Hotel" , @"address" : @"25 Hunter Street, Hobart, Tasmania 7000, Australia"},
              @{@"name":@"Clarion Hotel City Park Grand" , @"address" : @"22 Tamar Street, Launceston, Tasmania 7250, Australia"},
              @{@"name":@"Quality Hotel Colonial Launceston" , @"address" : @"31 Elizabeth St, Launceston, Tasmania 7250, Australia"},
              @{@"name":@"Premier Inn Swansea Waterfront" , @"address" : @"Waterfront Development, Langdon Rd, Swansea SA1 8PL, Wales"},
              @{@"name":@"Hatcher's Manor" , @"address" : @"73 Prossers Road, Richmond, Clarence, Tasmania 7025, Australia"}
               ];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    [tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *hotelObj = [source objectAtIndex:indexPath.row];
    
    [cell showCellContentWith:hotelObj];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
