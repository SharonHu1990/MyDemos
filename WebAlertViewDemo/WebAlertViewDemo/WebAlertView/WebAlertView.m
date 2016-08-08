//
//  WebAlertView.m
//  AlibabaV5
//
//  Created by 胡晓阳 on 16/5/4.
//  Copyright © 2016年 Alibaba-inc. All rights reserved.
//

#import "WebAlertView.h"

@interface WebAlertView ()<UIWebViewDelegate>{
    CGFloat webViewHeight;
}



@property (nonatomic, copy) NSString *tradeContractHTML;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIWebView *contentWebView;
@property (nonatomic, assign) BOOL webLoadSuccess;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *confirmButton;

@end
@implementation WebAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setFrame:frame];
        [self initiateSubviews];
    }
    return self;

}


- (void)dealloc{
    [_contentWebView loadHTMLString:@"" baseURL:nil];
    [_contentWebView stopLoading];
}



- (void)initiateSubviews{
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, self.bounds.size.width - 50.f, (self.bounds.size.width - 50.f)*(368.f/613.f))];
    [_alertView setBackgroundColor:[UIColor whiteColor]];
    [_alertView.layer setMasksToBounds:YES];
    [_alertView.layer setCornerRadius:2.f];
    
    
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(_alertView.frame.size.width - 17.f - 17.f, 8, 17.f, 17.f)];
    [cancelButton setImage:[UIImage imageNamed:@"ms_cancelButtonIcon"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:cancelButton];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, cancelButton.frame.origin.y + cancelButton.frame.size.height + 8.f, 0, 0)];
    [titleLabel setText:_title];
    [titleLabel setTextColor:[UIColor color]];
    [titleLabel sizeToFit];
    [_alertView addSubview:titleLabel];
    
    
    CGFloat contentWebViewOriginY = titleLabel.frame.origin.y + titleLabel.frame.size.height + 8.f;
    _contentWebView = [[UIWebView alloc] initWithFrame:CGRectMake(17, contentWebViewOriginY, self.bounds.size.width - 50.f - 34.f, webViewHeight)];
    [_contentWebView loadHTMLString:_htmlContent baseURL:nil];
    _contentWebView.delegate = self;
    [_contentWebView.scrollView setScrollEnabled:NO];
    [_alertView addSubview:_contentWebView];
    
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, contentWebViewOriginY + webViewHeight + 8.f, _alertView.frame.size.width, 1)];
    [_line setBackgroundColor:[UIColor colorWithHexString:@"E5E5E5"]];
    [_alertView addSubview:_line];
    
    _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _line.frame.origin.y + 1.f, _alertView.bounds.size.width, _alertView.bounds.size.height*(100/368.f))];
    [_confirmButton setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor colorWithHexString:@"FF7300"] forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(clickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_confirmButton];

    [_alertView setFrame:CGRectMake(25, 0, self.bounds.size.width - 50.f, _confirmButton.frame.origin.y+ _confirmButton.frame.size.height)];
    
    [_alertView setCenter:self.center];
    [self addSubview:_alertView];
}


-(void)show:(UIViewController *)controller{
    
    
    [self setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
    [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [UIApplication.sharedApplication.keyWindow?UIApplication.sharedApplication.keyWindow:UIApplication.sharedApplication.windows[0]
                                                                              addSubview:self];
    [self.superview bringSubviewToFront:self];
    
    
}

-(void)dismiss:(UIViewController *)controller{
    
    
    
//    [UIView animateWithDuration:0.25f
//                     animations:^{
//                         [self setBackgroundColor:[UIColor clearColor]];
//                         [controller.view setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
//                         [controller.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
//                         [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                             UIView* v = (UIView*)obj;
//                             [v setFrame:CGRectMake(v.frame.origin.x,
//                                                    UIScreen.mainScreen.bounds.size.height,
//                                                    v.frame.size.width,
//                                                    v.frame.size.height)];
//                         }];
//                     }
//                     completion:^(BOOL finished) {
//                         
//                     }];
    [self removeFromSuperview];
}

- (void)clickCancelButton:(UIButton *)sender{
    [self removeFromSuperview];
}

- (void)clickConfirmButton:(UIButton *)sender{
    [self removeFromSuperview];
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)aWebView{
    
    _webLoadSuccess = YES;
    
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    aWebView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
    
    webViewHeight = aWebView.frame.size.height;
    [_alertView setFrame:CGRectMake(25, 0, self.bounds.size.width - 50.f, _contentWebView.frame.origin.y +  webViewHeight + (self.bounds.size.width - 50.f)*(368.f/613.f)*(100/368.f))];
    [_alertView setCenter:self.center];
    
    [_line setFrame:CGRectMake(0, _contentWebView.frame.origin.y + webViewHeight + 8.f, _alertView.frame.size.width, 1)];
    [_confirmButton setFrame:CGRectMake(0, _line.frame.origin.y + 1.f, _alertView.bounds.size.width, (self.bounds.size.width - 50.f)*(368.f/613.f)*(100/368.f))];
    

}
@end
