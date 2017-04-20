//
//  FourthViewController.m
//  AutolayoutPractice
//
//  Created by 胡晓阳 on 16/5/19.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *letterLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *letterTF;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchTheBackground:(id)sender {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *result = [textField.text stringByAppendingString:string];
    if (textField == _numberTF) {
        [_numberLabel setText:result];
    }else{
        [_letterLabel setText:result];
    }
    return YES;
}
@end
