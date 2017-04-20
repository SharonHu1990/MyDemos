//
//  TextViewWithTag.m
//  TextKitTest
//
//  Created by 胡晓阳 on 2016/11/1.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "TextViewWithTag.h"
#import "CustomLayoutManager.h"

@implementation TextViewWithTag

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */


//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self configure];
//    }
//    return self;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        self = [self initWithFrame:self.frame content:self.tex tagLocation:<#(NSUInteger)#> tagLenght:<#(NSUInteger)#>]
//    }
//    return self;
//}


- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content tagLocation:(NSUInteger)location tagLenght:(NSUInteger)length{
    
    _content = content;
    _location = location;
    _length = length;
    
    self.frame = frame;

    NSTextStorage *textStorate = [[NSTextStorage alloc] initWithString:content];
    CustomLayoutManager *textlayout = [[CustomLayoutManager alloc] init];
    
    [textStorate addLayoutManager:textlayout];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.bounds.size];
    textContainer.widthTracksTextView = YES;
    textContainer.heightTracksTextView = YES;
    [textlayout addTextContainer:textContainer];
    
    
    self = [self initWithFrame:frame textContainer:textContainer];
    
    [self.textStorage setAttributes:@{NSBackgroundColorAttributeName: [UIColor redColor]} range:NSMakeRange(location, length)];
    self.textContainer.lineFragmentPadding = 0.f;//每行文本左右空出的间距
    self.textContainerInset = UIEdgeInsetsZero;
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.editable = NO;
    return self;
}



@end
