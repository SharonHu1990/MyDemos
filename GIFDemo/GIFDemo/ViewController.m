//
//  ViewController.m
//  GIFDemo
//
//  Created by 胡晓阳 on 2016/10/10.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import <UIImage+MultiFormat.h>
#import <UIButton+WebCache.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *slowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fastImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    _slowImageView.animationImages = [self animationImages];
    [_slowImageView setAnimationDuration:2];
    [_slowImageView setAnimationRepeatCount:1];
    [_slowImageView startAnimating];
    

    _fastImageView.animationImages = [self animationImages];
    _fastImageView.animationDuration = 2;
    [_fastImageView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_slowImageView.animationDuration+1) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_slowImageView stopAnimating];
    });
     */
     
    [self showGIF];
}

- (void)showGIF{

    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:bt];
    [bt sd_setImageWithURL:[NSURL URLWithString:@"https://cbu01.alicdn.com/cms/upload/2017/554/689/2986455_507369190.gif"] forState:UIControlStateNormal];
    [_slowImageView sd_setImageWithURL:[NSURL URLWithString:@"https://cbu01.alicdn.com/cms/upload/2017/554/689/2986455_507369190.gif"]];
}


- (void)showAnimationView:(UIImageView *)view{

    [UIView animateWithDuration:0.7 animations:^{
        [view setAlpha:1.f];
    }];
}


- (void)hideAnimationView:(UIImageView *)view{
    [UIView animateWithDuration:0.7 animations:^{
        [view setAlpha:0.f];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}




- (NSArray *)animationImages
{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"ms_launch" withExtension:@"gif"];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t frameCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < frameCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *imageName = [UIImage imageWithCGImage:imageRef];
        [frames addObject:imageName];
        CGImageRelease(imageRef);
    }
    return frames;
}


@end
