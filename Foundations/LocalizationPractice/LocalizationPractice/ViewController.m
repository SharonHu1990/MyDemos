//
//  ViewController.m
//  LocalizationPractice
//
//  Created by 胡晓阳 on 16/4/11.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *salesCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [_imageView setImage:[UIImage imageNamed:NSLocalizedString(@"myImageName", nil)]];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    NSString *numberString = [numberFormatter stringFromNumber:@(1000000)];
    
     
    _salesCountLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Yesterday you sold %@ apps", nil), numberString];
    
    [_likeButton setTitle:NSLocalizedString(@"You like?", nil) forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
