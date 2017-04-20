//
//  ViewController.m
//  FileManagerDemo
//
//  Created by 胡晓阳 on 2017/4/17.
//  Copyright © 2017年 胡晓阳. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+FileManager.h"

static inline NSString *cachePathForKey(NSString* directory, NSString* key) {
    return [directory stringByAppendingPathComponent:key];
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = cachePathForKey(documentsDirectory, @"test.plist");
    [arr writeToDir:filePath];
    

    NSArray *newArr = [NSObject readFromDir:filePath];
    NSLog(@"newArr:%@",newArr);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
