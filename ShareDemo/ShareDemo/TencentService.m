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

- (id)init
{

    NSString *appid = __TencentDemoAppid_;
    _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                     andDelegate:self];

    return self;
}

+ (TencentService *)shareInstance{
    static TencentService *_service = nil;//声明一个静态变量去保存类的实例，确保它在类中的全局可用性。
    static dispatch_once_t oncePredicate;//声明一个静态变量dispatch_once_t ,它确保初始化器代码只执行一次
    
    //使用Grand Central Dispatch(GCD)执行初始化LibraryAPI变量的block.这正是单例模式的关键：一旦类已经被初始化，初始化器永远不会再被调用
    dispatch_once(&oncePredicate, ^{
        _service = [[TencentService alloc] init];
    });
    return _service;
}


- (void)showInvalidTokenOrOpenIdMessage{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - 处理分享请求


/**
 *  分享纯文本到QQ
 *
 *  @param text <#text description#>
 */
-(void)sendTextToQQ:(NSString *)text{
    //开发者分享的文本内容
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    //将内容分享到qq
    QQApiSendResultCode sent =  (_shareDestination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
}

/**
 *  分享纯图片到QQ
 *
 *  @param imageData   <#imageData description#>
 *  @param title       <#title description#>
 *  @param description <#description description#>
 */
-(void)sendImageToQQ:(NSData *)imageData title:(NSString *)title description:(NSString *)description{
    
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imageData
                                               previewImageData:imageData
                                                          title:title
                                                    description:description];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    QQApiSendResultCode sent =  (_shareDestination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
}

/**
 *  分享视频到QQ
 *
 *  @param title           <#title description#>
 *  @param description     <#description description#>
 *  @param previewImageUrl <#previewImageUrl description#>
 *  @param videoUrl        <#videoUrl description#>
 *  @param redirectUrl     <#redirectUrl description#>
 */
-(void)sendVideoToQQWithVideoTitle:(NSString *)title
                       description:(NSString *)description
                   previewImageURL:(NSURL *)previewImageUrl
                          videoURL:(NSURL *)videoUrl
                      redicrectURL:(NSURL *)redirectUrl{
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:videoUrl
                                                           title:title
                                                     description:description
                                                 previewImageURL:previewImageUrl];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
    QQApiSendResultCode sent =  (_shareDestination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
    [self handleSendResult:sent];
    
}

/**
 *  分享新闻
 *
 *  @param url             分享跳转URL
 *  @param title           title
 *  @param description     描述
 *  @param previewImageURL 预览图的URL地址
 */
-(void)sendNewsWithURL:(NSURL *)url
                 title:(NSString *)title
           description:(NSString *)description
       previewImageURL:(NSURL *)previewImageURL{
    
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:url
                                title: title
                                description:description
                                previewImageURL:previewImageURL];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    QQApiSendResultCode sent =  (_shareDestination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
}


/**
 *  分享音频
 *
 *  @param url             分享跳转URL
 *  @param previewImageUrl 分享图预览图URL地址
 *  @param title           标题
 *  @param description     描述
 */
-(void)sendAudioWithURL:(NSString *)url
        previewImageUrl:(NSString *)previewImageUrl
                  title:(NSString *)title
            description:(NSString *)description{
    
    QQApiAudioObject *audioObj =[QQApiAudioObject objectWithURL:[NSURL URLWithString:url]
                                                          title:title
                                                    description:description
                                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
    QQApiSendResultCode sent =  (_shareDestination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
}


/**
 *  消息回调
 *
 *  @param sendResult <#sendResult description#>
 */
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    NSString *msg = @"";
    switch (sendResult){
        case EQQAPIAPPNOTREGISTED:
            {
        msg = @"应用未注册";
        break;
            }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
            {
        msg = @"发送参数错误";
        break;
            }
        case EQQAPIQQNOTINSTALLED:
            {
        //            msg = @"QQ客户端未安装";
        msg = @"";
        break;
            }
        case EQQAPIQQNOTSUPPORTAPI:
            {
        msg = @"接口不支持";
        break;
            }
        case EQQAPISENDFAILD:
            {
        msg = @"发送失败";
        break;
            }
        case EQQAPIQZONENOTSUPPORTTEXT:
            {
        msg = @"空间分享不支持纯文本分享，请使用图文分享";
        break;
            }
        case EQQAPIQZONENOTSUPPORTIMAGE:
            {
        msg = @"空间分享不支持纯图片分享，请使用图文分享";
        break;
            }
        default:
            {
        break;
            }
    }
    
    if (![msg isEqualToString:@""]) {
        [[JokeHintService share] showBubble:msg];
    }
    
}




#pragma mark - TencentSessionDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
            {
        [self saveAuthorizeInfo];
        BOOL b=[_tencentOAuth getUserInfo];
        if(!b)
                {
            NSLog_debug(@"登录失败");
            authorizeFail();
                }
        NSLog_debug(@"授权成功");
            }
    else
            {
        NSLog_debug(@"登录失败");
        authorizeFail();
            }
}

/**
 * 登录失败后的回调
 * param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSLog_debug(@"登录失败");
    authorizeFail();
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog_debug(@"无网络连接，请设置网络");
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog_debug(@"获取用户信息");
    authorizeSuccess(response,[_tencentOAuth openId]);
}


#pragma mark -  QQApiInterfaceDelegate

- (void)onResp:(QQBaseResp *)resp{
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        if ([resp.errorDescription length] != 0) {
            NSLog_debug(@"resp:%@",resp);
            [[JokeHintService share] showBubble:resp.errorDescription];
        }else{
            //分享成功
            [[NSNotificationCenter defaultCenter] postNotificationName:@"QQShareFinishedNotification" object:resp];
        }
    }
}
@end
