//
//  ViewController.m
//  TextKitTest
//
//  Created by 胡晓阳 on 2016/11/1.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "TextViewWithTag.h"

@interface ViewController ()
{
    NSString *content;
    NSString *tagText;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSTextStorage *textStorate = [[NSTextStorage alloc] initWithString:@"测试"];
//    CustomLayoutManager *textlayout = [[CustomLayoutManager alloc] init];
//    
//    [textStorate addLayoutManager:textlayout];
//    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
//    
//    [textlayout addTextContainer:textContainer];
//    
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height-20) textContainer:textContainer];
//    [self.view addSubview:textView];
//    
//    [textView.textStorage setAttributes:@{NSBackgroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(0, 2)];
//    textView.textContainer.lineFragmentPadding = 0.f;
//    textView.textContainerInset = UIEdgeInsetsZero;
//    textView.scrollEnabled = NO;
//    textView.scrollsToTop = NO;
//    textView.editable = NO;
    
    
    TextViewWithTag *textView = [[TextViewWithTag alloc] initWithFrame:CGRectZero];
    [self.view addSubview:textView];
    
    textView = [[TextViewWithTag alloc] initWithFrame:CGRectMake(0, 20, 100, 21) content:@"就是一个测试" tagLocation:0 tagLenght:2];
    
    [self.view addSubview:textView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
