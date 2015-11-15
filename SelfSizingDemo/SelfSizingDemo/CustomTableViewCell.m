//
//  CustomTableViewCell.m
//  SelfSizingDemo
//
//  Created by SharonHu on 15/11/11.
//  Copyright © 2015年 Sharon. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showCellContentWith:(NSDictionary *)content{
    NSString *name = [content objectForKey:@"name"];
    NSString *address = [content objectForKey:@"address"];
    
    [_addressLabel setText:address];
    [_nameLabel setText:name];
}

@end
