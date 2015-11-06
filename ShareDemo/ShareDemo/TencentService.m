//
//  TencentService.m
//  ShareDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "TencentService.h"
#import "QQSdkDefines.h"

static TencentService *_service = nil;
@implementation TencentService

+ (TencentService *)getInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_service == nil) {
            _service = [[super allocWithZone] init];
            [_service setPhotos:[NSMutableArray arrayWithCapacity:1]];
            [_service setThumbPhotos:[NSMutableArray arrayWithCapacity:1]];
        }
    });
    return _service;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self getInstance];
}

- (id)init
{

    NSString *appid = __TencentDemoAppid_;
    _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                     andDelegate:self];

    return self;
}

- (void)tencentDidLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessed object:self];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCancelled object:self];
}

- (void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}


@end
