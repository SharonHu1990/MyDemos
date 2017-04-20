//
//  CustomCollectionViewCell.m
//  SimpleCollectionViewPractice
//
//  Created by 胡晓阳 on 16/3/23.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "CustomHighlightedCellBackground.h"
#import "DetailViewController.h"

@interface CustomCollectionViewCell(){
    
    __weak IBOutlet UIImageView *topImageView;
    __weak IBOutlet UILabel *bottomLabel;
    
    NSIndexPath *myIndexPath;
}
@end
@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // change to our custom selected background view
        CustomHighlightedCellBackground *backView = [[CustomHighlightedCellBackground alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView = backView;
    }
    return self;
    
}

-(void)fillContentWithImage:(NSString *)imageToLoad description:(NSString *)description indexPath:(NSIndexPath *)indexPath{
    myIndexPath = indexPath;
    [topImageView setImage:[UIImage imageNamed:imageToLoad]];
    [bottomLabel setText:description];
}



@end
