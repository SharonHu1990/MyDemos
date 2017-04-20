//
//  CustomCell.m
//  HeaderViewWithTableDemo
//
//  Created by 胡晓阳 on 16/7/27.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CustomCell.h"
@interface CustomCell()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
    self.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textViewDidChange:(UITextView *)textView{
    [self.delegate updateHeightWithText:textView.text atIndexPath:_indexPath];
}

- (void)setInput:(NSString *)input{
    [self.textView setText:input];
}

@end
