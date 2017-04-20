//
//  NSObject+FileManager.m
//  MicroSupply
//
//  Created by 胡晓阳 on 2017/4/17.
//  Copyright © 2017年 Alibaba-inc. All rights reserved.
//

#import "NSObject+FileManager.h"

@implementation NSObject (FileManager)

- (void)writeToDir:(NSString*)dir{
    
    @try {
        
        if ([self conformsToProtocol:@protocol(NSCoding)]) {
            
            @synchronized (self) {
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
                
                NSURL *fileURL = [NSURL fileURLWithPath:dir];
                
                NSFileManager *fileManager = [[NSFileManager alloc] init];
                if (![fileManager fileExistsAtPath:dir]) {
                    [fileManager createFileAtPath:dir contents:nil attributes:nil];
                }
                
                
                //excluding backup
                NSError *error = nil;
                BOOL excludeBackupSuccess = [fileURL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
                if(!excludeBackupSuccess){
                    NSLog(@"Error excluding %@ from backup %@", [fileURL lastPathComponent], error);
                }
                
                if (![data writeToURL:fileURL atomically:YES]) {
                    NSLog(@"write redrain cache failed!!!!");
                }
            }
        }
    } @catch (...) {
        NSLog(@"write redrain cache failed!!!!");
    }
    
    NSLog(@"write redrain to cache success");
}


+ (NSArray*)readFromDir:(NSString*)dir{
    
    NSArray *array = nil;
    
    @try {
        
        NSData *data = [NSData dataWithContentsOfFile:dir];
        array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } @catch (...) {
        NSLog(@"read redrain cache failed!!!!");
    }
    
    NSLog(@"read redrain to cache success");
    return array;
    
}
@end
