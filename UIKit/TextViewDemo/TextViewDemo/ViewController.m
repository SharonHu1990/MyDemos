//
//  ViewController.m
//  TextViewDemo
//
//  Created by 胡晓阳 on 2017/3/27.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *tagView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_textView setText:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试"];
    [self.view addSubview:_textView];
    
    [self.view addSubview:self.tagView];
    
    _textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
}

- (UIBezierPath *)translatedBezierPath{
    
    CGRect newRect = [_textView convertRect:self.tagView.frame fromView:self.view];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:newRect];
    return path;
}

- (UIView *)tagView{
    if (!_tagView) {
        _tagView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
        [_tagView setBackgroundColor:[UIColor redColor]];
    }
    return  _tagView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
