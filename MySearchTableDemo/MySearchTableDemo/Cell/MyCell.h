//
//  MyCell.h
//  MySearchTableDemo
//
//  Created by 胡晓阳 on 16/8/9.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)fillCellWithContent:(NSString *)content;
@end
