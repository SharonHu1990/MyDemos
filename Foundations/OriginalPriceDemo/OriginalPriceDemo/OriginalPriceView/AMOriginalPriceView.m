//
//  AMOriginalPriceView.m
//  AlibabaV5
//
//  Created by 胡晓阳 on 16/8/5.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import "AMOriginalPriceView.h"
#import "NSObject+AMFillPriceString.h"
#import "NSObject+AMDefaultNumberFormatter.h"

@interface AMOriginalPriceView ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation AMOriginalPriceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"AMOriginalPriceView" owner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        containerView.frame = newFrame;
        [self addSubview:containerView];
        [self.contentLabel sizeToFit];
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        UIView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"AMOriginalPriceView" owner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        [self.contentLabel sizeToFit];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)fillContentWithOriginalPrice:(NSString *)originalPrice unit:(NSString *)unit fontSize:(CGFloat)fontSize{
    [self fillPriceInLabel:self.contentLabel price:[originalPrice doubleValue] unit:unit rmbFont:fontSize integerFont:fontSize decimalFont:fontSize - 2 unitFont:fontSize];
}

- (void)setPriceColor:(UIColor *)priceColor{
    [self.contentLabel setTextColor:priceColor];
}


@end
