//
//  TencentService.m
//  ShareDemo
//
//  Created by 胡晓阳 on 15/11/6.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "TencentService.h"
#import "QQSdkDefines.h"

static TencentService *_service;
@implementation TencentService


//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    // 由于alloc方法内部会调用allocWithZone: 所以我们只需要保证在该方法只创建一个对象即可
//    /*
//     * 如果考虑到多线程情况下，即有可能存在多个线程判断(_instance == nil)并进入创建方法，导致重复创建实例对象，破坏单例。
//     if (_instance == nil) {
//     NSLog(@"创建一个实例对象");
//     _instance = [super allocWithZone:zone];
//     }
//     */
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"创建一个实例对象");
//        _service = [super allocWithZone:zone];
//    });
//    return _service;
//}
//
//+ (TencentService *)shareInstance{
//    static dispatch_once_t oncePredicate;
//    dispatch_once(&oncePredicate, ^{
//        _service = [[TencentService alloc] init];
//    });
//    return _service;
//}
//
//-(id)copyWithZone:(NSZone *)zone{
//    return _service;
//}

implementationSingle(TencentService)

- (id)init
{

    NSString *appid = __TencentDemoAppid_;
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid
                                     andDelegate:self];

    return self;
}




- (void)showInvalidTokenOrOpenIdMessage{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}



-(void)loginQQ{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_SHARE,
                            nil];
 [_tencentOAuth authorize:permissions inSafari:NO];

}


#pragma mark - 处理分享请求


/**
 *  分享纯文本到QQ
 *
 *  @param text <#text description#>
 */
-(void)sendTextToQQ:(NSString *)text destination:(ShareDestination)destination{
    //开发者分享的文本内容
    QQApiTextObject *txtObj = [QQApiTextObject objectWithText:text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:txtObj];
    //将内容分享到qq
    QQApiSendResultCode sent =  (destination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
}

/**
 *  分享纯图片到QQ
 *
 *  @param imageData   <#imageData description#>
 *  @param title       <#title description#>
 *  @param description <#description description#>
 */
-(void)sendImageToQQ:(NSData *)imageData title:(NSString *)title description:(NSString *)description destination:(ShareDestination)destination{
    
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:imageData
                                               previewImageData:imageData
                                                          title:title
                                                    description:description];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    QQApiSendResultCode sent =  (destination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
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
                      redicrectURL:(NSURL *)redirectUrl
                       destination:(ShareDestination)destination{
    
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:videoUrl
                                                           title:title
                                                     description:description
                                                 previewImageURL:previewImageUrl];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
    QQApiSendResultCode sent =  (destination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
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
       previewImageURL:(NSURL *)previewImageURL
           destination:(ShareDestination)destination{
    
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:url
                                title: title
                                description:description
                                previewImageURL:previewImageURL];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    QQApiSendResultCode sent =  (destination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
    [self handleSendResult:sent];
    
}


/**
 *  <#Description#>
 *
 *  @param url             分享跳转URL
 *  @param previewImageUrl 分享图预览图URL地址
 *  @param flashURL        流媒体地址
 *  @param title           标题
 *  @param description     描述
 *  @param destination     目标
 */
-(void)sendAudioWithURL:(NSString *)url previewImageUrl:(NSString *)previewImageUrl flashUrl:(NSString *)flashURL title:(NSString *)title description:(NSString *)description destination:(ShareDestination)destination{
    QQApiAudioObject *audioObj =[QQApiAudioObject objectWithURL:[NSURL URLWithString:url]
                                                          title:title
                                                    description:description
                                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
    QQApiSendResultCode sent =  (destination == KShareToQQ )? [QQApiInterface sendReq:req] : [QQApiInterface SendReqToQZone:req];
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
//        [[JokeHintService share] showBubble:msg];
    }
    
}




#pragma mark - TencentSessionDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{

}

/**
 * 登录失败后的回调
 * param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSLog(@"登录失败");
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCancelled object:self];
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog(@"无网络连接，请设置网络");
     [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}


/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@"获取用户信息");
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetUserInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


#pragma mark -  QQApiInterfaceDelegate

- (void)onResp:(QQBaseResp *)resp{
    [[NSNotificationCenter defaultCenter] postNotificationName:kQQShareFinished object:resp];
}
@end
