//
//  TencentService.h
//  ShareDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface TencentService : NSObject<TencentSessionDelegate,QQApiInterfaceDelegate>

+ (TencentService *)getInstance;
+ (void)showInvalidTokenOrOpenIdMessage;

@property (nonatomic, retain)TencentOAuth *oauth;
@property (nonatomic, retain)NSMutableArray* photos;
@property (nonatomic, retain)NSMutableArray* thumbPhotos;
@end
