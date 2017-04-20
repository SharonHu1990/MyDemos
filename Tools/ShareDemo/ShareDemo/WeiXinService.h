//
//  WeiXinService.h
//  NewRobooJoke
//
//  Created by 胡晓阳 on 15/11/12.
//  Copyright © 2015年 Roboo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <WXApiObject.h>

typedef enum : NSUInteger {
    WXShareText,
    WXShareWebpage,
    WXShareVideo
} WXShareType;

@interface WeiXinService : NSObject<WXApiDelegate>

@property (nonatomic, assign) WXShareType shareType;

+(WeiXinService *)shareInstance;

-(void)registApp;

-(void)shareWebpageWithTitle:(NSString *)title
                 description:(NSString *)description
                    imageUrl:(NSString *)imageURL
                 redirectURL:(NSString *)redirectURL
                    timeLine:(BOOL)timeLine;

-(void)shareVideoToWXWithTitle:(NSString *)title
                   description:(NSString *)description
                      imageUrl:(NSString *)imageURL
                      videoURL:(NSString *)videoURL
               videoLowBandURL:(NSString *)lowBandUrl
                      timeLine:(BOOL)timeLine;
@end
