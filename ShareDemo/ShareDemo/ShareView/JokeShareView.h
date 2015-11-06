//
//  JokeShareView.h
//  NewRobooJoke
//
//  Created by Chun MingYou on 15/5/27.
//  Copyright (c) 2015年 Roboo. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JokeModel.h"
//#import "JokeService.h"
//#import "VeidoModel.h"
#import <MessageUI/MessageUI.h>
#import <TencentOpenAPI/QQApiInterface.h>

typedef enum : NSUInteger {
    JokeShareViewDefaultType=0,//复制、收藏、举报
    JokeShareViewDeleteType=1,//复制、收藏、删除
    JokeShareViewNoCopyType=2//收藏、举报
} JokeShareViewType;


@interface JokeShareView : UIView
<
WXApiDelegate,
MFMessageComposeViewControllerDelegate,
TencentSessionDelegate
>
{
    enum WXScene _scene;
    TencentOAuth *_tencentOAuth;
    JokeService *jokeService;
    
}


+ (CGFloat)shareHeight;
- (void)installShareApps;

@property (assign, nonatomic) JokeShareViewType shareViewType;
//@property (nonatomic, strong) JokeModel *jokeModel;
//@property (nonatomic, strong) VeidoModel *videoModel;
@property (nonatomic, assign) BOOL isFav;


@property (strong, nonatomic) void(^success)(id obj);
@property (strong, nonatomic) void(^fail)(id obj);
@property (strong, nonatomic) void(^cancel)(id obj);

@property (strong, nonatomic) void(^favSuccess)(id obj);

@end
