//
//  CustomSearchBar.m
//  MySearchTableDemo
//
//  Created by 胡晓阳 on 16/8/9.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "CustomSearchBar.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomSearchBar ()
{
    UIFont *preferredFont;
    UIColor *preferredTextColor;
    UIColor *preferredTextFieldBackgroundColor;
    
}
@end

@implementation CustomSearchBar

- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color textfieldBackgroundColor:(UIColor *)textfeildBgColor{
    if (self = [super init]) {
        self.frame = frame;
        preferredFont = font;
        preferredTextColor = color;
        preferredTextFieldBackgroundColor = textfeildBgColor;
        
        self.searchBarStyle = UISearchBarStyleProminent;
        self.translucent = false;
        
        self.showsBookmarkButton= false;
        [self setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        
        [self setValue:@"取消" forKey:@"_cancelButtonText"];
        UIButton *cancelButton = [self valueForKey:@"_cancelButton"];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        //取消按钮的字体颜色
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateNormal];

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

#pragma mark - Private Methods
- (int)indexOfSearchFieldInSubviews{
    int index = 0;
    UIView *searchBarView = self.subviews[0];
    
    for (int i = 0; i<searchBarView.subviews.count; i++) {
        if ([searchBarView.subviews[i] isKindOfClass:[UITextField class]]) {
            index = i;
            break;
        }
    }
    return index;
}

- (int)indexOfBackgroundViewInSubviews{
    int index = 0;
    UIView *searchBarView = self.subviews[0];
    for (int i = 0; i<searchBarView.subviews.count; i++) {
        if ([searchBarView.subviews[i] isKindOfClass:[UIView class]]) {
            index = i;
            break;
        }
    }
    return index;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    int index = [self indexOfSearchFieldInSubviews];
    UITextField *searchField = (UITextField *)self.subviews[0].subviews[index];
    
    [searchField setFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10.f, CGRectGetHeight(self.frame)-10.f)];
    
    searchField.font = preferredFont;
    searchField.textColor = preferredTextColor;
    searchField.backgroundColor = preferredTextFieldBackgroundColor;

    
    [searchField.layer setBorderWidth:1.f/[UIScreen mainScreen].scale];
    [searchField.layer setBorderColor:[UIColor colorWithWhite:204.f/255.f alpha:1].CGColor];
    [searchField.layer setCornerRadius:4.f];
    
    
    [super drawRect:rect];
    
    
    //draw a line at the bottom
    CGPoint startPoint = CGPointMake(0, CGRectGetHeight(self.frame));
    CGPoint endPoint = CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = preferredTextColor.CGColor;
    shapeLayer.lineWidth = 1.0/[UIScreen mainScreen].scale;
    
    [self.layer addSublayer:shapeLayer];
    [super drawRect: rect];
   
}


@end
