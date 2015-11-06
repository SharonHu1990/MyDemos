//
//  JokeShareView.m
//  NewRobooJoke
//
//  Created by Chun MingYou on 15/5/27.
//  Copyright (c) 2015年 Roboo. All rights reserved.
//

#import "JokeShareView.h"
#import "MultipleJokeService.h"


@implementation JokeShareView
{
    
    //收藏按钮
    UIButton *favBtn;
    
    MBProgressHUD *HUD;
    
}

+ (CGFloat)shareHeight{
    
    CGFloat shareHeight;
    
    //安装的App数量
    int appCount=1;
    
    //微信和朋友圈
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        appCount+=2;
    }
    
    //qq和空间
    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
        appCount+=2;
    }
    
    //新浪微博
    if ([WeiboSDK isWeiboAppInstalled] && [WeiboSDK isCanShareInWeiboAPP]) {
        appCount+=1;
    }
    
    CGFloat appHeight=(appCount/5+1)*(50+15+15)+appCount/5*18;
    
    shareHeight=20+18+20+appHeight+25+1+15+80+16+37*DeviceWidth/320.0+13;
    
    return shareHeight;
    
}

- (void)installShareApps{
    
    self.backgroundColor=[UIColor whiteColor];
    
    //分享至
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, DeviceWidth, 18)];
    [label setText:@"分享至"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:18.0f]];
    [label setTextColor:kColorWithHex(0X2c2c2c)];
    [self addSubview:label];
    
    //安装的App
    NSMutableArray *appArray=[[NSMutableArray alloc] init];
    
    //微信和朋友圈
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        [appArray addObjectsFromArray:@[@{@"NormalImage":@"list_wx_new",@"SelectedImage":@"list_wx_pre_new",@"Title":@"微信好友",@"Tag":@"100"},
                                        @{@"NormalImage":@"list_pyq",@"SelectedImage":@"list_pyq_pre",@"Title":@"朋友圈",@"Tag":@"101"}]];
    }
    
    //qq和空间
    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
        [appArray addObjectsFromArray:@[@{@"NormalImage":@"list_qq_new",@"SelectedImage":@"list_qq_pre_new",@"Title":@"QQ好友",@"Tag":@"102"},
                                        @{@"NormalImage":@"list_qzome",@"SelectedImage":@"list_qzome_pre",@"Title":@"QQ空间",@"Tag":@"103"}]];
    }
    
    //新浪微博
    if ([WeiboSDK isWeiboAppInstalled] && [WeiboSDK isCanShareInWeiboAPP]) {
        [appArray addObjectsFromArray:@[@{@"NormalImage":@"list_wb_new",@"SelectedImage":@"list_wb_pre_new",@"Title":@"新浪微博",@"Tag":@"104"}]];
    }
    
    //短信
    [appArray addObjectsFromArray:@[@{@"NormalImage":@"list_dx_new",@"SelectedImage":@"list_dx_pre_new",@"Title":@"短信",@"Tag":@"105"}]];
    
    int appSpace=(DeviceWidth-70*4)/5.0;
    
    CGFloat startOriginY=58.0f;
    
    [appArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:[[obj objectForKey:@"Tag"] integerValue]];
        [btn setFrame:CGRectMake(appSpace*(idx%4+1)+70*(idx%4), startOriginY+(idx/4)*80+18*(idx/4), 70, 80)];
        [btn setImage:[UIImage imageNamed:[obj objectForKey:@"NormalImage"]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[obj objectForKey:@"SelectedImage"]] forState:UIControlStateHighlighted];
        [btn setTitle:[obj objectForKey:@"Title"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [btn setTitleColor:kColorWithHex(0X2c2c2c) forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(65, -50, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, 10, 0, 0)];
        [btn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
    
    
    //分割线，删除，复制，收藏
    NSUInteger appCount=[appArray count];
    startOriginY=(appCount/5+1)*(50+15+15)+appCount/5*18+58.0f+25.0f;
    
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(15, startOriginY, DeviceWidth-30, 1)];
    [line setBackgroundColor:kColorWithHex(0Xf5f5f5)];
    [self addSubview:line];
    
    NSMutableArray *actionArray=[NSMutableArray new];
    if(_shareViewType==JokeShareViewDeleteType){
        [actionArray addObjectsFromArray:@[@{@"NormalImage":@"list_scj",@"SelectedImage":@"list_scj_pre",@"Title":@"删除",@"Tag":@"200"}]];
    }
    
    //如果不是没有复制按钮的类型，就添加复制按钮
    if (_shareViewType != JokeShareViewNoCopyType) {
        [actionArray addObjectsFromArray:@[@{@"NormalImage":@"list_fz",@"SelectedImage":@"list_fz_pre",@"Title":@"复制",@"Tag":@"201"}]];
        [actionArray addObjectsFromArray:@[@{@"NormalImage":@"list_sc_new",@"SelectedImage":@"list_sc_pre_new",@"Title":@"收藏",@"Tag":@"202"}]];
    }

    
   // [actionArray addObjectsFromArray:@[@{@"NormalImage":@"list_sc_new",@"SelectedImage":@"list_sc_pre_new",@"Title":@"收藏",@"Tag":@"202"}]];
    [actionArray addObjectsFromArray:@[@{@"NormalImage":@"list_jbao",@"SelectedImage":@"list_jbao_pre",@"Title":@"举报",@"Tag":@"203"}]];
    
    CGFloat actionStartOriginalX=0.0;
    actionStartOriginalX=(DeviceWidth-[actionArray count]*70-appSpace*([actionArray count]-1))/2;
    
    [actionArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:[[obj objectForKey:@"Tag"] integerValue]];
        [btn setFrame:CGRectMake(actionStartOriginalX+idx*(70+appSpace), startOriginY+16, 70, 80)];
        [btn setImage:[UIImage imageNamed:[obj objectForKey:@"NormalImage"]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[obj objectForKey:@"SelectedImage"]] forState:UIControlStateHighlighted];
        [btn setTitle:[obj objectForKey:@"Title"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [btn setTitleColor:kColorWithHex(0X2c2c2c) forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(65, -50, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, 10, 0, 0)];
        [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if(btn.tag==202){
            if ([_jokeModel.isFav boolValue] == YES) {
                [btn setTitle:@"取消收藏" forState:UIControlStateNormal];
            }
            else
                {
                [btn setTitle:@"收藏" forState:UIControlStateNormal];
            }
            favBtn=btn;
        }
        [self addSubview:btn];
    }];
    
    //取消按钮
    UIButton *cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTag:204];
    [cancelBtn setImage:[UIImage imageNamed:@"btn_qx_new"] forState:UIControlStateNormal];
    [cancelBtn setImage:[UIImage imageNamed:@"btn_qx_new_pre"] forState:UIControlStateHighlighted];
    [cancelBtn setFrame:CGRectMake((DeviceWidth-282.0/320*DeviceWidth)/2, startOriginY+16+80+16, 282.0/320*DeviceWidth, 37/282.0*DeviceWidth)];
    [cancelBtn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
}

/**
 *  点击分享按钮
 *
 *  @param sender 被点击的按钮
 */
- (void)shareClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            [self weixiAction:sender];
            break;
        case 101:
            [self pyqAction:sender];
            break;
        case 102:
            [self qqAction:sender];
            break;
        case 103:
            [self qqzoneAction:sender];
            break;
        case 104:
            [self sinaAction:sender];
            break;
        case 105:
            [self smsAction:sender];
            break;
        default:
            break;
    }
}

- (void)actionClick:(UIButton *)sender{
    switch (sender.tag) {
        case 200:
            [self deleteAction];
            break;
        case 201:
            [self copyAction];
            break;
        case 202:
            [self collectAction];
            break;
        case 203:
            [self reportAction];
            break;
        case 204:
            [self cancelAction];
            break;
        default:
            break;
    }
}

#pragma mark - 删除 复制 收藏 取消
- (void)deleteAction{
    MultipleJokeService *service = [[MultipleJokeService alloc] init];
    [service deleteMyJoke:_jokeModel.id account:[UserService share].currentUser.account success:^{
        NSDictionary *userInfo = @{DeleteMyJokeSuccessIdKey:_jokeModel.id};
        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"删除成功" afterComplete:^{
            _cancel(nil);
            [[NSNotificationCenter defaultCenter] postNotificationName:DeleteMyJokeSuccessNotification object:nil userInfo:userInfo];
        }];
        
    } error:^(NSString *errMsg) {
        
    }];
}

- (void)copyAction{
    NSString *content = [[NSString alloc] decodeFromPercentEscapeString:[_jokeModel.content gtm_stringByUnescapingFromHTML]];
    NSString *redirectUrl = [NSString stringWithFormat:@"%@%@",[_jokeModel.jokeType isEqualToString:@"video"] ? UrlPrefix_VideoShare : UrlPrefix_NormalShare,_jokeModel.id];
    NSString *newContent = [NSString stringWithFormat:@"%@ %@",content, redirectUrl];
    if ([_jokeModel.pic length] != 0) {
        newContent = [NSString stringWithFormat:@"%@ 趣图地址：%@",[_jokeModel.title gtm_stringByUnescapingFromHTML],_jokeModel.pic];
    }
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = newContent;
    [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"已复制" afterComplete:^{
        _cancel(nil);
    }];
}

/**
 *  收藏
 */
- (void)collectAction{
    jokeService = [[JokeService alloc] init];
    
    if([UserService share].isLogin==NO)
    {
        [[JokeHintService share] showHintMessage:@"您尚未登录~"];
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if([_jokeModel.isFav boolValue]){
            
            [[JokeHintService share] showLoadingIndicator:self indicatorTitle:@"正在取消收藏..."];
        }
        else
        {
            [[JokeHintService share] showLoadingIndicator:self indicatorTitle:@"正在收藏..."];
        }
        
    });
    

    [jokeService favActionWithJokeID:_jokeModel.id category:@"sms" type:_jokeModel.channel acc:[UserService share].currentUser.account success:^{
        [[JokeHintService share] hideLoadingIndicator:self];
        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:([_jokeModel.isFav boolValue] ? @"已取消":@"已收藏") afterComplete:^{
            
            
            if([_jokeModel.isFav boolValue]){

                [[NSNotificationCenter defaultCenter] postNotificationName:DeleteMyFavSuccessNotification object:nil userInfo:@{MyFavJokeIdKey:_jokeModel.id}];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:AddMyFavSuccessNotification object:nil userInfo:@{MyFavJokeIdKey:_jokeModel.id}];
            }
            
            //成功
            _favSuccess(_jokeModel);
            
        }];
    } error:^(NSString *errMsg) {
        [[JokeHintService share] hideLoadingIndicator:self];
        [[JokeHintService share] showHintMessage:errMsg];
    }];
}

- (void)reportAction{
    [[JokeHintService share] showLoadingIndicator:self];
    
     NSString *url = [NSString stringWithFormat:@"%@/joke/userSearchJson.do?q=%@",JOKE_URL,[[NSString alloc] encodeToPercentEscapeString:@"举报"]];
    
    [[NetworkService share] sendRequest:url jokeSuccess:^(NSDictionary* responseObject) {
        
        [[JokeHintService share] hideLoadingIndicator:self];
        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"已收到我们会尽快处理" afterComplete:^{
            _cancel(nil);
        }];
        
    } jokeError:^(NSError *error) {
        [[JokeHintService share] hideLoadingIndicator:self];
        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"操作失败" afterComplete:^{
            _cancel(nil);
        }];
    }];
    
//    NSString *url = [NSString stringWithFormat:@"%@/common/advise4Json.htm", @"http://joke2.roboo.com"];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
////    [dic setObject:@"" forKey:@"advise.advice"];
////    [dic setObject:@"" forKey:@"advise.phone"];
////    [dic setObject:@"" forKey:@"advise.linkUrl"];
////    [dic setObject:@"" forKey:@"advise.user"];
//    
//    [[NetworkService share] sendPostRequest:url parameters:dic jokeSuccess:^(NSDictionary *responseObject) {
//        [[JokeHintService share] hideLoadingIndicator:self];
//        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"已收到我们会尽快处理" afterComplete:^{
//            _cancel(nil);
//        }];
//    } jokeError:^(NSError *error) {
//        [[JokeHintService share] hideLoadingIndicator:self];
//        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"操作失败" afterComplete:^{
//            _cancel(nil);
//        }];
//    }];
//    [[NetworkService share] sendRequest:@"http://www.baidu.com" jokeSuccess:^(NSDictionary *responseObject) {
//        [[JokeHintService share] hideLoadingIndicator:self];
//        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"已收到我们会尽快处理" afterComplete:^{
//            _cancel(nil);
//        }];
//    } jokeError:^(NSError *error) {
//        [[JokeHintService share] hideLoadingIndicator:self];
//        [[JokeHintService share] showLoadingCompleteIndicator:self indicatorTitle:@"操作失败" afterComplete:^{
//            _cancel(nil);
//        }];
//    }];
}

- (void)cancelAction{
    _cancel(nil);
}


#pragma mark - 分享
//微信
- (void)weixiAction:(id)sender {
    //微信好友
    _scene = WXSceneSession;
    [self sendWX];
    
}
//微信朋友圈
- (void)pyqAction:(id)sender {
    //微信好友
    _scene = WXSceneTimeline;
    [self sendWX];
    
    
}
//新浪微博
- (void)sinaAction:(id)sender {
    
    [self sendWeiBo];
}
//QQ空间
- (void)qqzoneAction:(id)sender {
    if ([self initTc] == NO) {
        [self touchQQorQZ:NO];
    }
}
//QQ好友
- (void)qqAction:(id)sender {
    if ([self initTc] == NO) {
        [self touchQQorQZ:YES];
    }
}
//短信
- (void)smsAction:(id)sender {
    //短信
    if ([MFMessageComposeViewController canSendText])
    {
        _cancel(nil);
        [self displaySMSComposerSheet];
    }else
    {
        [[JokeHintService share] showHintMessage:@"设备不支持发送短信"];
    }
    
}

#pragma mark - 微信
-(void)sendWX
{
    
    NSString *title = _jokeModel.title;
    //    NSString *description = [[NSString alloc] decodeFromPercentEscapeString:[_jokeModel.content gtm_stringByUnescapingFromHTML]];
    NSString *description = _jokeModel.content;
    
    NSUInteger bytes = [description lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    //描述内容不能超过1K
    if (bytes > 1024) {
        description = [description substringToIndex:511];
    }
    
    NSString *imgUrl = [_jokeModel.jokeType isEqualToString:@"video"] ? _jokeModel.imgfile128URL : _jokeModel.pic;
    UIImage *img = nil;
    
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:imgUrl]]) {
        img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgUrl];
        if(!img)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:imgUrl];
            img = [UIImage imageWithData:data];
        }
    }
    else
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
        img = [UIImage imageWithData:data];
    }
    
    UIImage *newImg = [self imageWithImage:img scaledToSize:CGSizeMake(240, 240)];
    WXMediaMessage *msg = [WXMediaMessage message];
    msg.title = title;
    msg.description = description;
    

    UIImage *thumbImage = newImg;
    if (thumbImage) {
        [msg setThumbImage:thumbImage];
    }else{
        [msg setThumbImage:[UIImage imageNamed:@"114"]];
    }
    
    msg.mediaObject = [_jokeModel.jokeType isEqualToString:@"video"] ? [self videoObjectOfWXSharing] : [self webpageObjectOfWXSharing];
    msg.mediaTagName = @"WECHAT_TAG_JUMP_SHOWRANK";
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = msg;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}

/**
 *  压缩图片
 *
 *  @param image       被压缩的图片
 *  @param maxFileSize 上限
 *
 *  @return <#return value description#>
 */
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.3f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

//对图片尺寸进行压缩--
-(UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

/**
 *  分享到微信的视频
 *
 *  @return <#return value description#>
 */
-(WXVideoObject *)videoObjectOfWXSharing{
    WXVideoObject *videoObject = [WXVideoObject object];
//    长度不能超过10K
    videoObject.videoUrl = _jokeModel.resourcefile;
//    长度不能超过10K
    videoObject.videoLowBandUrl = [NSString stringWithFormat:@"%@%@", UrlPrefix_VideoShare ,_jokeModel.id];

    return videoObject;
}


-(WXWebpageObject *)webpageObjectOfWXSharing{
    WXWebpageObject *webObj = [WXWebpageObject object];
    NSString *redirectUrl = [NSString stringWithFormat:@"%@%@",UrlPrefix_NormalShare,_jokeModel.id];
    webObj.webpageUrl = redirectUrl;
    return webObj;
}

#pragma mark - 新浪微博
-(void)sendWeiBo
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    NSString *text = [_jokeModel.jokeType isEqualToString:@"video"] ? _jokeModel.title : _jokeModel.content;
    message.text = [[NSString alloc] decodeFromPercentEscapeString:[text gtm_stringByUnescapingFromHTML]];

    if ([_jokeModel.jokeType isEqualToString:@"video"]) {
        NSString *webpageUrl = [NSString stringWithFormat:@"%@%@", [_jokeModel.jokeType isEqualToString:@"video"] ? UrlPrefix_VideoShare : UrlPrefix_NormalShare ,_jokeModel.id];
        message.text = [message.text stringByAppendingString:webpageUrl];
        
    }else{
        
        message.imageObject = [self imageObjectForWBSharing];
    }
   
    return message;
}

-(WBWebpageObject *)webpageObjectForWBSharing{
    

    NSString *title = _jokeModel.title;
    
    NSUInteger bytes = [title lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    //标题长度不能超过1K
    if (bytes > 1024) {
        title = [title substringToIndex:511];
    }

    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = _jokeModel.id;
    webpage.title = title;
//    webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
//    webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
    webpage.webpageUrl = [NSString stringWithFormat:@"%@%@", [_jokeModel.jokeType isEqualToString:@"video"] ? UrlPrefix_VideoShare : UrlPrefix_NormalShare ,_jokeModel.id];
webpage.webpageUrl = @"www.baidu.com";
    
    return webpage;
}

//
//-(WBVideoObject *)videoObjectForWBSharing{
//    WBVideoObject *videoObject = [WBVideoObject object];
//    videoObject.videoUrl = _jokeModel.resourcefile;//不能为空且长度不能超过255
//    videoObject.videoLowBandUrl = _jokeModel.resourcefile;//长度不能超过255
//    videoObject.objectID = _jokeModel.id;
//    videoObject.title = _jokeModel.title;
//    videoObject.videoLowBandStreamUrl =
//    videoObject.videoStreamUrl = _jokeModel.resourcefile;
//    return videoObject;
//}

-(WBImageObject *)imageObjectForWBSharing{
    NSString *imgUrl = _jokeModel.pic;
    UIImage *img = nil;
    
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:imgUrl]]) {
        img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgUrl];
        if(!img)
                {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:imgUrl];
            img = [UIImage imageWithData:data];
                }
    }
    else
            {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
        if ([UIImage imageWithData:data]) {
            img = [UIImage imageWithData:data];
        }else
            img = [UIImage imageNamed:@"114"];
            }
    
    //图片压缩0.3
    NSData *imgData = UIImageJPEGRepresentation(img, 0.3);

    
    WBImageObject *imageObj = [WBImageObject object];
    imageObj.imageData = imgData;
    
    return imageObj;
}

#pragma mark - QQ
-(BOOL)initTc
{
    if (_tencentOAuth == nil) {
        _tencentOAuth = [[TencentOAuth alloc]initWithAppId:TencentAppId andDelegate:self];
        _tencentOAuth.redirectURI = @"http://www.roboo.com";
        NSArray * _permissions = [NSArray arrayWithObjects:@"all", @"add_t", nil];
        [_tencentOAuth authorize:_permissions inSafari:NO];
        return YES;
    }
    return NO;
}

-(void)touchQQorQZ:(BOOL)qz
{
    NSArray *permissions =  [NSArray arrayWithObjects:kOPEN_PERMISSION_ADD_TOPIC,nil];
    if (![_tencentOAuth isSessionValid]) {
        [_tencentOAuth localAppId];
        [_tencentOAuth authorize:permissions inSafari:NO];
    }
    else
    {
        [self doQQShare:qz];
    }
}

-(void)doQQShare:(BOOL)qqqqq
{

    QQApiObject *qqApiObject = [_jokeModel.jokeType isEqualToString:@"video"] ? [self videoObjectOfQQSharing] : [self newsObjectOfQQSharing];
    SendMessageToQQReq *req =[SendMessageToQQReq reqWithContent:qqApiObject];
    QQApiSendResultCode sent = 0;
    if (!qqqqq)
    {
        //分享到QZone
        sent = [QQApiInterface SendReqToQZone:req];
    }
    else
    {
        //分享到QQ
        sent = [QQApiInterface sendReq:req];
    }
    [self handleSendResult:sent];
}

/**
 *  分享到QQ的Url视频对象
 *
 *  @return <#return value description#>
 */
-(QQApiVideoObject *)videoObjectOfQQSharing{
    
    
    NSString *redirectUrlString = [NSString stringWithFormat:@"%@%@", UrlPrefix_VideoShare,_jokeModel.id];
    NSURL *videoUrl = [NSURL URLWithString:redirectUrlString];
    NSString *videoTitle = @"儒豹段子";
    NSString *videoDescription = _jokeModel.title;
    NSURL *videoPreviewImageUrl = [NSURL URLWithString:_jokeModel.imgfile128URL];
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:videoUrl title:videoTitle description:videoDescription previewImageURL:videoPreviewImageUrl];
    return videoObj;
}

/**
 *  分享到QQ的新闻对象
 *
 *  @return <#return value description#>
 */
-(QQApiNewsObject *)newsObjectOfQQSharing{
    NSString *redirectUrl = [NSString stringWithFormat:@"%@%@",UrlPrefix_NormalShare,_jokeModel.id];
    NSString *imgUrl = _jokeModel.pic;
    UIImage *img = nil;
    
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:imgUrl]]){
        img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgUrl];
        if(!img){
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:imgUrl];
            img = [UIImage imageWithData:data];
        }
    }
    else{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
        img = [UIImage imageWithData:data];
    }
    
    
    if (img == nil) {
        img = [UIImage imageNamed:@"114"];
    }

    //图片压缩0.3
    NSData *imgData = UIImageJPEGRepresentation(img, 0.3);
    
    QQApiNewsObject *newsobject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:redirectUrl] title:@"儒豹段子" description:[[NSString alloc] decodeFromPercentEscapeString:[_jokeModel.content gtm_stringByUnescapingFromHTML]] previewImageData:imgData];
    return newsobject;
}

/**
 *  消息回调
 *
 *  @param sendResult <#sendResult description#>
 */
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    NSString *msg = @"";
    switch (sendResult)
    {
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
    
    
    if (![msg length] == 0) {
        [[JokeHintService share] showHintMessage:msg];
    }
    
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
        BOOL b=[_tencentOAuth getUserInfo];
        if(!b)
        {
            //NSLog(@"登录失败");
        }
        //NSLog(@"授权成功");
    }
    else
    {
       // NSLog(@"登录失败");
    }
}

/**
 * 登录失败后的回调
 * param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    NSLog(@"登录失败");
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    //NSLog(@"无网络连接，请设置网络");
}

#pragma mark -短信
- (void)displaySMSComposerSheet
{

    NSString *jokeId = _jokeModel.id;
   
    NSString *description = [_jokeModel.jokeType isEqualToString:@"video"] ? _jokeModel.title : _jokeModel.content;
    
    NSString *shareMsg = [NSString stringWithFormat:@"快看看来自【儒豹段子】的分享：%@ 详情戳这里：",description];
    
    NSString *redirectUrl = [NSString stringWithFormat:@"%@%@",[_jokeModel.jokeType isEqualToString:@"video"] ?  UrlPrefix_VideoShare : UrlPrefix_NormalShare,jokeId];
    
    NSString *content = [NSString stringWithFormat:@"%@ %@",shareMsg,redirectUrl];
    
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.body = content;
    
    [AppDelegateEntity.window.rootViewController presentViewController:picker animated:YES completion:NULL];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [AppDelegateEntity.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}
@end
