//
//  CustomTableViewCell.h
//  SelfSizingDemo
//
//  Created by SharonHu on 15/11/11.
//  Copyright © 2015年 Sharon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


-(void)showCellContentWith:(NSDictionary *)content;

@end
