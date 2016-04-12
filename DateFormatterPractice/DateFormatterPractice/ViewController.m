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
    
    //long long类型的日期转换为NSDate类型
    long long date2 = 1460435400000;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:date2 / 1000];
    NSLog(@"startDate:%@",[dateFormatter stringFromDate:startDate]);
    
    //NSString对象转为NSDate对象
    NSString *date3 = @"2015-08-06 11:08:35";
    NSLog(@"date3:%@",[dateFormatter dateFromString:date3]);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
