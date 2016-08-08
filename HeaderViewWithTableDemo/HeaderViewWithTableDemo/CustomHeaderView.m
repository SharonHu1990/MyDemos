//
//  CustomHeaderView.m
//  HeaderViewWithTableDemo
//
//  Created by 胡晓阳 on 16/7/26.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CustomHeaderView.h"
#import "CustomCell.h"
#import "UIView+XIB.h"
@interface CustomHeaderView()<CustomCellDelegate>


@property (nonatomic, assign) CGFloat myHeight;
@property (nonatomic, copy) NSMutableArray *inputSource;
@end
@implementation CustomHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    NSLog(@"customHeaderView -- layoutSubviews");
//    [self configureTable];
//}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"customHeaderView -- awakeFromNib");
    [self configureTable];
}



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"CustomHeaderView" owner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        containerView.frame = newFrame;
        [self addSubview:containerView];
        [self configureTable];
    }
    return self;
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        
////        UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"CustomHeaderView" owner:self options:nil] objectAtIndex:0];
////        CGRect newFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
////        containerView.frame = newFrame;
////        [self addSubview:containerView];
//        [self configureTable];
//    }
//    return self;
//}
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self configureTable];
//}

- (void)configureTable{
    _inputSource = [[NSMutableArray alloc] initWithCapacity:2];
    [_inputSource addObject:@""];
    [_inputSource addObject:@""];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView setEstimatedRowHeight:44.f];
    [_tableView setScrollEnabled:NO];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_tableView reloadData];
}

- (CGFloat)actualHeight{
    [self.tableView layoutIfNeeded];
    _myHeight = _tableView.contentSize.height;
    
//   CustomCell *myCustomCell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    CustomCell *myCustomCell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
//    [myCustomCell1 setNeedsDisplay];
//    [myCustomCell2 setNeedsDisplay];
//    _myHeight = [myCustomCell1 systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height + [myCustomCell2 systemLayoutSizeFittingSize:UILayoutFittingExpandedSize].height;
//    _myHeight = myCustomCell1.frame.size.height + myCustomCell2.frame.size.height;
    return _myHeight;
}

- (void)updateHeightWithText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath{
    [self.inputSource setObject:text atIndexedSubscript:indexPath.row];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [self.tableView layoutIfNeeded];
    _myHeight = _tableView.contentSize.height;

    
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
    [self.delegate updateHeaderHeight];

}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"CustomCellID"];
    CustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:@"CustomCellID" forIndexPath:indexPath];
    customCell.indexPath = indexPath;
    if ([self.inputSource count] > 0 && [[self.inputSource objectAtIndex:indexPath.row] isKindOfClass:[NSString class]] && [self.inputSource objectAtIndex:indexPath.row]) {
        customCell.input = self.inputSource[indexPath.row];
    }
    
    customCell.delegate = self;
    return  customCell;
}


@end
