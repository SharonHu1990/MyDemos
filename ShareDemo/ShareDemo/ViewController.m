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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQSuccessed) name:kLoginSuccessed object:[TencentService shareInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQFailed) name:kLoginFailed object:[TencentService shareInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQCancelled) name:kLoginCancelled object:[TencentService shareInstance]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analysisResponse:) name:kGetUserInfoResponse object:[TencentService shareInstance]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录QQ
- (IBAction)loginQQ:(id)sender {

    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_SHARE,
                            nil];
    
    [[[TencentService shareInstance] tencentOAuth] authorize:permissions inSafari:NO];

}

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
            
            NSString *accessToken = [[[TencentService shareInstance] tencentOAuth] accessToken];//Access Token凭证，用于后续访问各开放接口
            NSString *openId = [[[TencentService shareInstance] tencentOAuth] openId];//用户授权登录后对该用户的唯一标识
            
            
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

- (IBAction)sendQQText:(id)sender {
    NSString *text = @"这是分享到QQ好友的一条消息。";
    [[TencentService shareInstance] sendTextToQQ:text];
}

- (IBAction)sendQQImage:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"SharedImage" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    [[TencentService shareInstance] sendImageToQQ:imageData title:@"Title" description:@"Description"];
}
- (IBAction)sendQQVideo:(id)sender {
    NSURL *previewImageViewURL = [NSURL URLWithString:@"http://61.155.169.220:38080/proxy/common/readImage.jsp?ia=videohot&id=2be4b0294e18ee8ce7672807b968ff110000c680"];
    NSURL *videoURL = [NSURL URLWithString:@"http://mvideo.spriteapp.cn/video/2015/1109/56409998e5640_wpd.mp4"];
    NSString *title = @"Title";
    NSString *description = @"Description";
    NSURL *redirectURL = [NSURL URLWithString:@"https://www.baidu.com"];
    [[TencentService shareInstance] sendVideoToQQWithVideoTitle:title description:description previewImageURL:previewImageViewURL videoURL:videoURL redicrectURL:redirectURL];
}
- (IBAction)sendQzoneText:(id)sender {
}
- (IBAction)sendQzoneImage:(id)sender {
}
- (IBAction)sendQzoneVideo:(id)sender {
}
- (IBAction)sendQQAudio:(id)sender {
}
- (IBAction)sendQzoneAudio:(id)sender {
}

@end
