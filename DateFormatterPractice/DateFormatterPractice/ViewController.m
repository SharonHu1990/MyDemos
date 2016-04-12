//
//  ViewController.m
//  DateFormatterPractice
//
//  Created by 胡晓阳 on 16/4/11.
//  Copyright © 2016年 胡晓阳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //NSDate对象转换成NSString对象
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
//    dateFormatter.timeStyle = NSDateFormatterLongStyle;
//    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];////设置时区为 iPhone 当前时区
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";//设置转换成字符串的格式
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    NSLog(@"date:%@",date);
    NSLog(@"dateString:%@",dateStr);
    
    
    
    //Long Long日期转换成NString对象
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
