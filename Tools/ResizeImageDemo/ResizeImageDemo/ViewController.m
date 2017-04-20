//
//  ViewController.m
//  ResizeImageDemo
//
//  Created by 胡晓阳 on 16/8/10.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    [_imageView setImage:[self cutImage:[UIImage imageNamed:@"111.jpg"] withImageView:_imageView]];
//    [_imageView setImage:[UIImage imageNamed:@"2.jpg"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image withImageView:(UIImageView *)imageView
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (imageView.frame.size.width / imageView.frame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * imageView.frame.size.height / imageView.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * imageView.frame.size.width / imageView.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}
@end
