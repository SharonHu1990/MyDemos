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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQSuccessed) name:kLoginSuccessed object:[TencentService getInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQFailed) name:kLoginFailed object:[TencentService getInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginQQCancelled) name:kLoginCancelled object:[TencentService getInstance]];
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
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_IDOL,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_PIC_T,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_DEL_IDOL,
                            kOPEN_PERMISSION_DEL_T,
                            kOPEN_PERMISSION_GET_FANSLIST,
                            kOPEN_PERMISSION_GET_IDOLLIST,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_GET_REPOST_LIST,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                            nil];
    
    [[[TencentService getInstance] oauth] authorize:permissions inSafari:NO];

}

- (void)loginQQSuccessed{
    if (NO == _isLogined)
            {
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


- (IBAction)sendQQText:(id)sender {
}

- (IBAction)sendQQImage:(id)sender {
}
- (IBAction)sendQQVideo:(id)sender {
}
- (IBAction)sendQzoneText:(id)sender {
}
- (IBAction)sendQzoneImage:(id)sender {
}
- (IBAction)sendQzoneVideo:(id)sender {
}
@end
