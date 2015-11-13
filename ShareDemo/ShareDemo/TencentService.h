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
#import "Singleton.h"

typedef enum : NSUInteger {
    KShareToQQ,
    KShareToQzone
} ShareDestination;

@interface TencentService : NSObject
<
TencentSessionDelegate,
QQApiInterfaceDelegate,
NSCopying
>

interfaceSingleton(TencentService);

@property (nonatomic, retain) TencentOAuth *tencentOAuth;

+ (BOOL) iphoneQQInstalled;

/**
 *  登录授权
 *
 *  @param success 成功回调
 *  @param fail    失败回调
 */
-(void)authorize:(void(^)(APIResponse* reponse,NSString *openId))success fail:(void(^)(void))fail;

-(void)loginQQ;


-(void)sendTextToQQ:(NSString *)text
        destination:(ShareDestination)destination;

-(void)sendImageToQQ:(NSData *)imageData
               title:(NSString *)title
         description:(NSString *)description
         destination:(ShareDestination)destination;

-(void)sendVideoToQQWithVideoTitle:(NSString *)title
                       description:(NSString *)description
                   previewImageURL:(NSURL *)previewImageUrl
                          videoURL:(NSURL *)videoUrl
                      redicrectURL:(NSURL *)redirectUrl
                       destination:(ShareDestination)destination;

-(void)sendNewsWithURL:(NSURL *)url
                 title:(NSString *)title
           description:(NSString *)description
       previewImageURL:(NSURL *)previewImageURL
           destination:(ShareDestination)destination;

-(void)sendAudioWithURL:(NSString *)url
        previewImageUrl:(NSString *)previewImageUrl
               flashUrl:(NSString *)flashURL
                  title:(NSString *)title
            description:(NSString *)description
            destination:(ShareDestination)destination;
@end
