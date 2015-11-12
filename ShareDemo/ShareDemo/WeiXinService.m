//
//  WeiXinService.m
//  NewRobooJoke
//
//  Created by 胡晓阳 on 15/11/12.
//  Copyright © 2015年 Roboo. All rights reserved.
//

#import "WeiXinService.h"
#import "JokeShareService.h"
#import "UIImage+Resizing.h"


@implementation WeiXinService

+(WeiXinService *)shareInstance{
    static WeiXinService *_service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[WeiXinService alloc] init];
    });
    
    return  _service;
}

-(instancetype)init{
    if (self = [super init]) {
        //初始化
    }
    return self;
}

//注册应用
-(void)registApp{
    [WXApi registerApp:WEIXINAppID];
}

#pragma mark - 第三方分享
-(void)shareWebpageWithTitle:(NSString *)title description:(NSString *)description imageUrl:(NSString *)imageURL redirectURL:(NSString *)redirectURL timeLine:(BOOL)timeLine
{
    

    NSUInteger bytes = [description lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    //描述内容不能超过1K
    if (bytes > 1024) {
        description = [description substringToIndex:19];
    }
    
    UIImage *thumImage = nil;
    if ([imageURL length] != 0) {
        
        if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:imageURL]]) {
            thumImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
            if(!thumImage){
                NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:imageURL];
                thumImage = [UIImage imageWithData:data];
            }
        }
        else{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
            thumImage = [UIImage imageWithData:data];
        }
        
        thumImage = [UIImage imageWithImage:thumImage scaledToSize:CGSizeMake(240, 240)];

    }else{
        thumImage = [UIImage imageNamed:@"114"];
    }
    
    
    WXMediaMessage *msg = [WXMediaMessage message];
    msg.title = (title.length == 0) ? description : title;
    msg.description = description;
    [msg setThumbImage:thumImage];
    
    msg.mediaObject = [self webpageObjWithURL:redirectURL];
    msg.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = msg;
    req.scene = timeLine ? WXSceneTimeline : WXSceneSession;
    
    [WXApi sendReq:req];
    

}


/**
 *  分享到微信的视频
 *
 *  @return <#return value description#>
 */
-(WXVideoObject *)videoObjectWithURL:(NSString *)videoURL videoLowBandURL:(NSString *)lowBandURL{
    WXVideoObject *videoObject = [WXVideoObject object];
    //长度不能超过10K
    videoObject.videoUrl = videoURL;
    //长度不能超过10K
    videoObject.videoLowBandUrl = lowBandURL;
    return videoObject;
}


-(WXWebpageObject *)webpageObjWithURL:(NSString *)redirectURL{
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = redirectURL;
    return webObj;
}

-(void)shareVideoToWXWithTitle:(NSString *)title description:(NSString *)description imageUrl:(NSString *)imageURL videoURL:(NSString *)videoURL videoLowBandURL:(NSString *)lowBandUrl timeLine:(BOOL)timeLine{
    
    NSUInteger bytes = [description lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    //描述内容不能超过1K
    if (bytes > 1024) {
        description = [description substringToIndex:511];
    }
    
    
    UIImage *img = nil;
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:imageURL]]) {
        img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];
        if(!img){
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:imageURL];
            img = [UIImage imageWithData:data];
        }
    }
    else{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        img = [UIImage imageWithData:data];
    }
    
    UIImage *newImg = [UIImage imageWithImage:img scaledToSize:CGSizeMake(240, 240)];
    
    WXMediaMessage *msg = [WXMediaMessage message];
    msg.title = (title.length == 0) ? description : title;
    msg.description = description;
    
    
    UIImage *thumbImage = newImg;
    if (thumbImage) {
        [msg setThumbImage:thumbImage];
    }else{
        [msg setThumbImage:[UIImage imageNamed:@"114"]];
    }
    
    msg.mediaObject = [self videoObjectWithURL:videoURL videoLowBandURL:lowBandUrl];
    msg.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = msg;
    req.scene = timeLine ? WXSceneTimeline : WXSceneSession;
    
    [WXApi sendReq:req];
    
}


#pragma mark - WXApiDelegate

/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp
{
    
    if([resp isKindOfClass:[SendMessageToWXResp class]]){
        
        NSString *errDescription = @"";
        switch (resp.errCode) {
            case WXSuccess:
                errDescription = @"分享成功";
                break;
            case WXErrCodeCommon:
                errDescription = @"发送失败";
                break;
            case WXErrCodeUserCancel:
                errDescription = @"取消分享";
                break;
            case WXErrCodeAuthDeny:
                errDescription = @"授权失败";
                break;
            case WXErrCodeUnsupport:
                errDescription = @"微信不支持";
                break;
                
            default:
                break;
        }
        
        [[JokeShareService share] finishedSharing];
        [[JokeHintService share] showBubble:errDescription];

    }
    //授权登录
    else if([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
            }
}

@end
