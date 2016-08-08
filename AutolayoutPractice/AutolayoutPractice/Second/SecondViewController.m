//
//  SecondViewController.m
//  AutolayoutPractice
//
//  Created by 胡晓阳 on 16/4/15.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (nonatomic, assign) BOOL hasDistance;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _hasDistance = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)touchButton:(id)sender {
    
    if (_hasDistance) {
        _hasDistance = NO;
        self.leftConstraint.constant = 0;
    }else{
        _hasDistance = YES;
        self.leftConstraint.constant = 100;
    }
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

@end
