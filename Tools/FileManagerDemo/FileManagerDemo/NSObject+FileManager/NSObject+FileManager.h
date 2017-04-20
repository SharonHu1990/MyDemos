//
//  NSObject+FileManager.h
//  MicroSupply
//
//  Created by 胡晓阳 on 2017/4/17.
//  Copyright © 2017年 Alibaba-inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FileManager)

- (void)writeToDir:(NSString *)dir;
+ (id)readFromDir:(NSString *)dir;

@end
