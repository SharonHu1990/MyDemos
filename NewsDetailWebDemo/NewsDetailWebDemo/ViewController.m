//
//  ViewController.m
//  NewsDetailWebDemo
//
//  Created by 胡晓阳 on 15/11/19.
//  Copyright © 2015年 HXY. All rights reserved.
//

#import "ViewController.h"
#import "GRMustache.h"
#import "AFNetworking.h"
#import "WebViewJavascriptBridge.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "IDMPhoto.h"
#import "IDMPhotoBrowser.h"

@interface ViewController ()<UIWebViewDelegate,IDMPhotoBrowserDelegate,UIImagePickerControllerDelegate>
{
    UIWebView *myWeb;
    WebViewJavascriptBridge *jsBridge;
    NSArray *imgIdArr;
    NSMutableArray *imgSrcArr;
    NSMutableArray *_allImagesOfThisArticle;
    
    UIImageView *tappedImageView;
    
    UIVisualEffectView *visualEffectView;
    
    IDMPhotoBrowser *myPhotoBrowser;
    
    NSInteger currentPhotoIndex;//当前显示的图片index
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    myWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    tappedImageView = [[UIImageView alloc] init];
    myWeb.delegate = self;
    [self.view addSubview:myWeb];
    
    
    //实例化和添加毛玻璃背景
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = myWeb.bounds;
    [visualEffectView setHidden:YES];
    [myWeb addSubview:visualEffectView];
    
    
    
    //Instantiate WebViewJavascriptBridge
    [WebViewJavascriptBridge enableLogging];
    
    
    jsBridge = [WebViewJavascriptBridge bridgeForWebView:myWeb webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {

        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *msgType = dataDic[@"messageType"];
        
        
        if ([msgType isEqualToString:@"addTagBtn"]) {
            
            NSString *tagName = dataDic[@"object"];
            NSLog(@"点击了网页标签：%@",tagName);
            
        }else if ([msgType isEqualToString:@"fetchAllImages"]) {
            NSArray *srcArr = dataDic[@"object"];
            NSLog(@"获取到图片资源：%@",srcArr);
            imgSrcArr = [NSMutableArray arrayWithArray:srcArr];
            [self downloadAllImagesInNative:srcArr];
        }
        
        
        responseCallback(@"Response for message from ObjC");
    }];
    
    [jsBridge registerHandler:@"imageDidClicked" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSInteger index = [[data objectForKey:@"index"] integerValue];
        
        CGFloat originX = [[data objectForKey:@"x"] floatValue];
        CGFloat originY = [[data objectForKey:@"y"] floatValue];
        CGFloat width   = [[data objectForKey:@"width"] floatValue];
        CGFloat height  = [[data objectForKey:@"height"] floatValue];
        
        tappedImageView.alpha = 0;
        tappedImageView.frame = CGRectMake(originX, originY, width, height);
        tappedImageView.image = _allImagesOfThisArticle[index];//_allImagesOfThisArticle是一个本地数组用来存放所有图片
        
        NSLog(@"OC已经收到JS的imageDidClicked了: %@", data);
        responseCallback(@"OC已经收到JS的imageDidClicked了");
        
        //点击放大图片
        [self presentPhotosBrowserWithInitialPage:index animatedFromView:tappedImageView];
    }];
    
    [self setupRequest];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)presentPhotosBrowserWithInitialPage:(NSInteger)index animatedFromView:(UIImageView *)imageView{
    NSArray *photosURL = imgSrcArr;
    NSArray *photos = [IDMPhoto photosWithURLs:photosURL];
    //从屏幕渐变出来
    myPhotoBrowser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    myPhotoBrowser.delegate = self;
    
    
    //Toolbar设置
    myPhotoBrowser.displayDoneButton = NO;
    myPhotoBrowser.displayToolbar = NO;
    
    //禁用垂直驳回滑动手势
    myPhotoBrowser.disableVerticalSwipe = YES;
    
    myPhotoBrowser.useWhiteBackgroundColor = YES;
    
    //显示图片
    [myPhotoBrowser setInitialPageIndex:index];
    
    //背景颜色
    myPhotoBrowser.view.backgroundColor = [UIColor clearColor];
    
    //创建navBar
    [self createPhotoNavigationBar];

    [visualEffectView setHidden:NO];
    [self presentViewController:myPhotoBrowser animated:YES completion:nil];
}



-(void)createPhotoNavigationBar{
    //标题
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [navBar setBackgroundColor:[UIColor redColor]];
    UINavigationItem *navTitle = [[UINavigationItem alloc] init];
    
    
    //返回按钮
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissPhotoBrowser:)];
    navTitle.leftBarButtonItems = @[spaceItem, leftBarItem];
    
    
    //保存按钮
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveImage)];
    navTitle.rightBarButtonItem = rightBarItem;
    
    [navBar pushNavigationItem:navTitle animated:YES];
    
    [navBar setItems:[NSArray arrayWithObjects:navTitle, nil]];
    
    navBar.tag = 1024;
    
    [myPhotoBrowser.view addSubview:navBar];
}





#pragma mark - IDMPhotoBrowserDelegate
-(void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didShowPhotoAtIndex:(NSUInteger)index{
 
    currentPhotoIndex = index;
    
    //修改标题
    NSString *title = [NSString stringWithFormat:@"%ld/%ld",index+1,_allImagesOfThisArticle.count];
    UINavigationBar *navBar = (UINavigationBar *)[photoBrowser.view viewWithTag:1024];


    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    
    UINavigationItem *navItem = navBar.items[0];
    navItem.titleView = titleLabel;
    
}

-(void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissAtPageIndex:(NSUInteger)index{
    [visualEffectView setHidden:YES];
}

#pragma mark - 触发myPhotoBrowser导航栏按钮事件

-(void)dismissPhotoBrowser:(UIBarButtonItem *)sender{
    [myPhotoBrowser dismissViewControllerAnimated:YES completion:^{
        [visualEffectView setHidden:YES];
    }];
}

/**
 *  保存图片
 */
- (void)saveImage{
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */

    UIImageWriteToSavedPhotosAlbum(_allImagesOfThisArticle[currentPhotoIndex], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo
{
    if (!error)
    {
        //提示"图片已保存到相册"
    }
    
}

#pragma mark -


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  请求数据
 */
- (void)setupRequest {
    
    NSMutableString *urlStr = [NSMutableString stringWithString:@"http://t23.roboo.com/news/detailJson.htm?id=593e8f03ccf613677d28dd316c712e85&index=nnews"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setupWebViewByData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error == %@",error);
        
    }];
    
}

/**
 *  加载HTML
 *
 *  @param data <#data description#>
 */
-(void)setupWebViewByData:(id)data{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:data];
    
    imgIdArr = [NSArray arrayWithArray:dataDic[@"imgIds"]];
    imgSrcArr = [NSMutableArray arrayWithCapacity:imgIdArr.count];
    
    
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSError *error = nil;
    GRMustacheTemplate *template = [GRMustacheTemplate templateFromContentsOfURL:[NSURL fileURLWithPath:templatePath] error:&error];
    if (error) {
        NSLog(@"error while loading template: %@", error);
    }else{
        
        
        
        /************* 标签按钮 **************/
        NSString *tagBtnsHTML = @"";
        //获取tagButtons
        NSArray *tagArr = dataDic[@"tags"];
        for (id tag in tagArr) {
            NSString *tagName = tag;
            
            tagBtnsHTML = [tagBtnsHTML stringByAppendingString:@"<div id='tagBtn' class='tagsDiv'></div>"];
            
            [jsBridge send:@{@"messageType":@"addTagBtn",@"object":tagName} responseCallback:^(id responseData) {
                NSLog(@"objc got response! %@", responseData);
            }];

            
        }
        
        [dataDic setObject:tagBtnsHTML forKey:@"tagBtns"];
        
        
        /************* 图片预处理 **************/
        NSMutableString *summary = [NSMutableString stringWithString:dataDic[@"summary"]];
        NSString *newSummary = [summary stringByReplacingOccurrencesOfString:@"src" withString:@"esrc"];
        //正则查找img标签，添加onClick事件
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img[^>]+esrc=\")(\\S+)\"" options:0 error:nil];
        NSString *result = [regex stringByReplacingMatchesInString:newSummary options:0 range:NSMakeRange(0, newSummary.length) withTemplate:@"<img esrc=\"$2\" onClick=\"javascript:onImageClick('$2')\""];
        
        [dataDic removeObjectForKey:@"summary"];
        [dataDic setObject:result forKey:@"summary"];
        

        NSString *sourceHTML = [template renderObjectsFromArray:@[dataDic] error:&error];
        if (error) {
            NSLog(@"error:%@",error);
        }else{
            [myWeb loadHTMLString:sourceHTML baseURL:[NSURL URLWithString:dataDic[@"url"]]];
        }

    }


}




#pragma mark - 
/**
 *  下载图片到本地
 *
 *  @param imageURLs <#imageURLs description#>
 */
-(void)downloadAllImagesInNative:(NSArray *)imageURLs {
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    //初始化一个置空元素数组
    _allImagesOfThisArticle = [NSMutableArray arrayWithCapacity:imageURLs.count];//本地的一个用于保存所有图片的数组
    
    
    for (NSUInteger i = 0; i < imageURLs.count; i++) {
        
        NSString *_url = imageURLs[i];
        
        
        [manager downloadImageWithURL:[NSURL URLWithString:_url] options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (image) {
                
                [_allImagesOfThisArticle addObject:image];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSString *imgB64 = [UIImageJPEGRepresentation(image, 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    
                    // 把图片在磁盘中的地址传回给JS
                    NSString *key = [manager cacheKeyForURL:imageURL];
                    
                    NSString *source = [NSString stringWithFormat:@"data:image/png;base64,%@", imgB64];
                    
                    //图片的最大宽度
                    CGFloat maxWidth = myWeb.bounds.size.width-20;
                    
                    CGFloat actualWidth = image.size.width;
                    CGFloat actualHeight = image.size.height;
                    
                    if (actualWidth > maxWidth) {
                        
                        CGFloat maxHeight = actualHeight * (maxWidth / actualWidth);
                        actualWidth = maxWidth;
                        actualHeight = maxHeight;
                    }
                    
                    [jsBridge callHandler:@"imagesDownloadCompleteHandler" data:@[key,source,[NSString stringWithFormat:@"%f",actualWidth], [NSString stringWithFormat:@"%f",actualHeight]]];
                    
                });
                
            }
            
        }];
    }
 
}



- (NSString *)replaceUrlSpecialString:(NSString *)string {
    
    return [string stringByReplacingOccurrencesOfString:@"/"withString:@"_"];
}

-(CGFloat)webViewHeight{
    //获取到的WebView的高度
    CGFloat height = [[myWeb stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    return height;
}


#pragma UIWebViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    
    //大图自适应屏幕
    [jsBridge send:@{@"messageType":@"resizeImages", @"maxWidth":[NSString stringWithFormat:@"%f",webView.bounds.size.width-20]} responseCallback:^(id responseData) {
        NSLog(@"objc got response! %@", responseData);
    }];

    
   
    
    
    
}



@end
