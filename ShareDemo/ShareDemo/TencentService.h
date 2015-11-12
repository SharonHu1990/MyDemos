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

typedef enum : NSUInteger {
    KShareToQQ,
    KShareToQzone
} ShareDestination;

@interface TencentService : NSObject
<
TencentSessionDelegate,
QQApiInterfaceDelegate
>


@property (nonatomic, retain) TencentOAuth *tencentOAuth;
@property (nonatomic, assign) ShareDestination shareDestination;//分享到QQ或Qzone

+(TencentService *)shareInstance;

+ (BOOL) iphoneQQInstalled;

/**
 *  登录授权
 *
 *  @param success 成功回调
 *  @param fail    失败回调
 */
-(void)authorize:(void(^)(APIResponse* reponse,NSString *openId))success fail:(void(^)(void))fail;


-(void)sendTextToQQ:(NSString *)text;

-(void)sendImageToQQ:(NSData *)imageData
               title:(NSString *)title
         description:(NSString *)description;

-(void)sendVideoToQQWithVideoTitle:(NSString *)title
                       description:(NSString *)description
                   previewImageURL:(NSURL *)previewImageUrl
                          videoURL:(NSURL *)videoUrl
                      redicrectURL:(NSURL *)redirectUrl;

-(void)sendNewsWithURL:(NSURL *)url
                 title:(NSString *)title
           description:(NSString *)description
       previewImageURL:(NSURL *)previewImageURL;

-(void)sendAudioWithURL:(NSString *)url
        previewImageUrl:(NSString *)previewImageUrl
               flashUrl:(NSString *)flashURL
                  title:(NSString *)title
            description:(NSString *)description;
@end
