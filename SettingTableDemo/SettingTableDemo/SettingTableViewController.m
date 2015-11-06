//
//  SettingTableViewController.m
//  SettingTableDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SettingCellInfo.h"
#import "DetailPage1.h"
#import "DetailPage2.h"

@interface SettingTableViewController (){
    
}


@end

@implementation SettingTableViewController

@synthesize sectionName = _sectionName;
@synthesize sectionRow = _sectionRow;

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        //Custom initialization
        self.sectionName = [NSMutableArray arrayWithCapacity:1];
        self.sectionRow = [NSMutableArray arrayWithCapacity:1];
        [self loadData];
        _isLogined = NO;
        [self.navigationItem setTitle:@"设置"];
    }
    return self;
}


- (void)loadData{
    NSMutableArray *group1 = [NSMutableArray arrayWithCapacity:1];
    
    [group1 addObject:[SettingCellInfo info:@"只点击不切换" target:self Sel:@selector(action1) viewController:nil accessoryType:UITableViewCellAccessoryNone]];
    [[self sectionName] addObject:@"Group1"];
    [[self sectionRow] addObject:group1];
    
    
    NSMutableArray *group2 = [NSMutableArray arrayWithCapacity:2];
    [group2 addObject:[SettingCellInfo info:@"进入详情1" target:self Sel:@selector(pushToSelectedViewController:) viewController:nil userInfo:[NSNumber numberWithInt:kDetailPate1] accessoryType:UITableViewCellAccessoryDisclosureIndicator]];
    [group2 addObject:[SettingCellInfo info:@"进入详情2" target:self Sel:@selector(pushToSelectedViewController:) viewController:nil userInfo:[NSNumber numberWithInt:kDetailPage2] accessoryType:UITableViewCellAccessoryDisclosureIndicator]];
    
    [[self sectionName] addObject:@"Group2"];
    [[self sectionRow] addObject:group2];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Select Actions
- (void)action1{
    
}

- (void)pushToSelectedViewController:(NSNumber *)detailPageType {
    
    switch ([detailPageType integerValue]) {
        case kDetailPate1:{
            DetailPage1 *detailPage1 = [DetailPage1 new];
            [self.navigationController pushViewController:detailPage1 animated:YES];
        }
            break;
        case kDetailPage2:{
            DetailPage2 *detailPage2 = [DetailPage2 new];
            [self.navigationController pushViewController:detailPage2 animated:YES];
        }
            break;
            
        default:
            break;
    }


}

- (void)action3{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self sectionName] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self sectionRow] objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    static NSString *CellIdentifier = @"SettingCell";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSString *title = nil;
    UITableViewCellAccessoryType accessoryType = UITableViewCellAccessoryNone;
    NSMutableArray *array = [[self sectionRow] objectAtIndex:section];
    if ([array isKindOfClass:[NSMutableArray class]]){
        
        SettingCellInfo *cellInfo = [array objectAtIndex:row];
        title = [cellInfo title];
        accessoryType = [cellInfo accessoryType];
    }
    
    if (title == nil) {
        title = @"未知";
        
    }
    
    [[cell textLabel] setText:title];
    [[cell textLabel] setTextAlignment:NSTextAlignmentLeft];
    cell.accessoryType = accessoryType;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self sectionName] objectAtIndex:section];
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger row = indexPath.row;
    NSUInteger section = indexPath.section;
    NSArray *array = [[self sectionRow] objectAtIndex:section];
    if ([array isKindOfClass:[NSMutableArray class]]) {

        SettingCellInfo *cellInfo = [array objectAtIndex:row];
        SEL sel = [cellInfo sel];
        IMP imp = [self methodForSelector:sel];

        if ([self respondsToSelector:[cellInfo sel]]) {
            if ([cellInfo userInfo] == nil) {
                void (*func)(id, SEL) = (void *)imp;
                func(self, sel);

            }else{
                void(*func)(id, SEL, id) = (void*)imp;
                func(self, sel, [cellInfo userInfo]);
            }
        }
    }
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
