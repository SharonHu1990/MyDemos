//
//  FirstCustomCell.m
//  AutolayoutPractice
//
//  Created by 胡晓阳 on 16/5/17.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "FirstCustomCell.h"
@interface FirstCustomCell()
@property (weak, nonatomic) IBOutlet UITextView *senderTextView;
@property (nonatomic, weak) UITableView *myTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation FirstCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillContentWithContent:(NSString *)content atIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    [_senderTextView setText:content];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",textView.text);
    //存储到数据源中
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateFirstCellDatasource:indexPath:)]) {
        [self.delegate updateFirstCellDatasource:textView.text indexPath:_indexPath];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(UITableView *)getMyTableView{
    for(UIView*next = self; next; next = next.superview){
        if([next isKindOfClass:[UITableView class]]){
            return (UITableView*)next;
        }
    }
    return nil;
}
@end
