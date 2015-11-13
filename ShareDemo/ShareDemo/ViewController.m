//
//  ViewController.m
//  ShareDemo
//
//  Created by 胡晓阳 on 15/11/4.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "TencentService.h"
#import "QQSdkDefines.h"


@interface ViewController ()
{
    BOOL _isLogined;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQSuccessed) name:kLoginSuccessed object:[TencentService shareTencentService]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQFailed) name:kLoginFailed object:[TencentService shareTencentService]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQCancelled) name:kLoginCancelled object:[TencentService shareTencentService]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analysisResponse:) name:kGetUserInfoResponse object:[TencentService shareTencentService]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qqShareFinished:) name:kQQShareFinished object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录QQ
- (IBAction)loginQQ:(id)sender {

    [[TencentService shareTencentService] loginQQ];
}


#pragma mark - QQ Login Message
- (void)loginQQSuccessed{
    
    if (NO == _isLogined){
        _isLogined = YES;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}

- (void)loginQQFailed{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}

- (void)loginQQCancelled{
    //do nothing
}


//在处理通知中可以通过kResponse获取数据的返回结果
- (void)analysisResponse:(NSNotification *)notify{
    if (notify) {
        APIResponse *response = [[notify userInfo] objectForKey:kResponse];
        if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode) {
            
            NSString *userIcon_40 = [response.jsonResponse objectForKey:@"figureurl_qq_1"];
            
            NSString *userIcon_100 = [response.jsonResponse objectForKey:@"figureurl_qq_2"];
            
            NSString *nickname = [response.jsonResponse objectForKey:@"nickname"];
            
            NSString *sex = [response.jsonResponse objectForKey:@"gender"];
            
            NSString *province = [response.jsonResponse objectForKey:@"province"];
            
            NSString *city = [response.jsonResponse objectForKey:@"city"];
            
            NSString *accessToken = [[[TencentService shareTencentService] tencentOAuth] accessToken];//Access Token凭证，用于后续访问各开放接口
            NSString *openId = [[[TencentService shareTencentService] tencentOAuth] openId];//用户授权登录后对该用户的唯一标识
            
            
            //保存用户数据
            [self saveUserInfo];
            
        } else {
            NSString *errMsg = [NSString stringWithFormat:@"errorMsg:%@\n%@", response.errorMsg, [response.jsonResponse objectForKey:@"msg"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:errMsg delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (void)saveUserInfo{
    
}

-(void)qqShareFinished:(NSNotification *)notification{
    QQBaseResp *resp = notification.object;
    NSString *message = @"";
    if ([resp.result integerValue] == 0){
        //分享成功
        message = @"分享成功";
    }else if ([resp.result integerValue] == -4) {
        message = @"取消分享";
    }else{
        message = @"分享失败";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享结果" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 点击分享按钮

- (IBAction)sendQQText:(id)sender {
    NSString *text = @"这是分享到QQ好友的一条消息。";
    [[TencentService shareTencentService] sendTextToQQ:text destination:KShareToQQ];
   
}

- (IBAction)sendQQImage:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"SharedImage" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    [[TencentService shareTencentService] sendImageToQQ:imageData title:@"Title" description:@"Description" destination:KShareToQQ];
}
- (IBAction)sendQQVideo:(id)sender {
    NSURL *previewImageViewURL = [NSURL URLWithString:@"http://61.155.169.220:38080/proxy/common/readImage.jsp?ia=videohot&id=2be4b0294e18ee8ce7672807b968ff110000c680"];
    NSURL *videoURL = [NSURL URLWithString:@"http://mvideo.spriteapp.cn/video/2015/1109/56409998e5640_wpd.mp4"];
    NSString *title = @"Title";
    NSString *description = @"Description";
    NSURL *redirectURL = [NSURL URLWithString:@"https://www.baidu.com"];

    [[TencentService shareTencentService] sendVideoToQQWithVideoTitle:title description:description previewImageURL:previewImageViewURL videoURL:videoURL redicrectURL:redirectURL destination:KShareToQQ];
}
- (IBAction)sendQQAudio:(id)sender {

    NSString *title = @"Wish You Were Here";
    NSString *description = @"Avril Lavigne";
    NSString *audioURL = @"http://wfmusic.3g.qq.com/s?g_f=0&fr=&aid=mu_detail&id=2511915";

    NSString *previewImagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"audio.jpg"];
    [[TencentService shareTencentService] sendAudioWithURL:audioURL previewImageUrl:previewImagePath flashUrl:audioURL title:title description:description destination:KShareToQQ];

}

- (IBAction)sendQQNews:(id)sender {
    
    NSString *title = @"天公作美伦敦奥运圣火点燃成功 火炬传递开启";
    NSString *description = @"腾讯体育讯 当地时间5月10日中午，阳光和全世界的目光聚焦于希腊最高女祭司手中的火炬上，5秒钟内世界屏住呼吸。火焰骤然升腾的瞬间，古老的号角声随之从赫拉神庙传出——第30届伦敦夏季奥运会圣火在古奥林匹亚遗址点燃。取火仪式前，国际奥委会主席罗格、希腊奥委会主席卡普拉洛斯和伦敦奥组委主席塞巴斯蒂安-科互赠礼物，男祭司继北京奥运会后，再度出现在采火仪式中。";
    NSURL *newsUrl = [NSURL URLWithString:@"http://sports.qq.com/a/20120510/000650.htm"];
    NSURL *previewImageUrl = [NSURL URLWithString:@"http://img1.gtimg.com/sports/pics/hv1/87/16/1037/67435092.jpg"];

    [[TencentService shareTencentService] sendNewsWithURL:newsUrl title:title description:description previewImageURL:previewImageUrl destination:KShareToQQ];

}



- (IBAction)sendQzoneText:(id)sender {
    NSString *text = @"这是分享到QQ好友的一条消息。";
    [[TencentService shareTencentService] sendTextToQQ:text destination:KShareToQzone];
}
- (IBAction)sendQzoneImage:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"SharedImage" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    [[TencentService shareTencentService] sendImageToQQ:imageData title:@"Title" description:@"Description" destination:KShareToQzone];
}
- (IBAction)sendQzoneVideo:(id)sender {
    NSURL *previewImageViewURL = [NSURL URLWithString:@"http://61.155.169.220:38080/proxy/common/readImage.jsp?ia=videohot&id=2be4b0294e18ee8ce7672807b968ff110000c680"];
    NSURL *videoURL = [NSURL URLWithString:@"http://mvideo.spriteapp.cn/video/2015/1109/56409998e5640_wpd.mp4"];
    NSString *title = @"Title";
    NSString *description = @"Description";
    NSURL *redirectURL = [NSURL URLWithString:@"https://www.baidu.com"];
    
    [[TencentService shareTencentService] sendVideoToQQWithVideoTitle:title description:description previewImageURL:previewImageViewURL videoURL:videoURL redicrectURL:redirectURL destination:KShareToQzone];
}
- (IBAction)sendQzoneNews:(id)sender {
    NSString *title = @"天公作美伦敦奥运圣火点燃成功 火炬传递开启";
    NSString *description = @"腾讯体育讯 当地时间5月10日中午，阳光和全世界的目光聚焦于希腊最高女祭司手中的火炬上，5秒钟内世界屏住呼吸。火焰骤然升腾的瞬间，古老的号角声随之从赫拉神庙传出——第30届伦敦夏季奥运会圣火在古奥林匹亚遗址点燃。取火仪式前，国际奥委会主席罗格、希腊奥委会主席卡普拉洛斯和伦敦奥组委主席塞巴斯蒂安-科互赠礼物，男祭司继北京奥运会后，再度出现在采火仪式中。";
    NSURL *newsUrl = [NSURL URLWithString:@"http://sports.qq.com/a/20120510/000650.htm"];
    NSURL *previewImageUrl = [NSURL URLWithString:@"http://img1.gtimg.com/sports/pics/hv1/87/16/1037/67435092.jpg"];
    
    [[TencentService shareTencentService] sendNewsWithURL:newsUrl title:title description:description previewImageURL:previewImageUrl destination:KShareToQzone];
}

- (IBAction)sendQzoneAudio:(id)sender {
    NSString *title = @"Wish You Were Here";
    NSString *description = @"Avril Lavigne";
    NSString *audioURL = @"http://wfmusic.3g.qq.com/s?g_f=0&fr=&aid=mu_detail&id=2511915";
    
    NSString *previewImagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"audio.jpg"];
    [[TencentService shareTencentService] sendAudioWithURL:audioURL previewImageUrl:previewImagePath flashUrl:audioURL title:title description:description destination:KShareToQzone];
}


@end
