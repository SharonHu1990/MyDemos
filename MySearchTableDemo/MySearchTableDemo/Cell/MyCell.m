//
//  MyCell.m
//  MySearchTableDemo
//
//  Created by 胡晓阳 on 16/8/9.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillCellWithContent:(NSString *)content{
    [self.contentLabel setText:content];
}
@end
