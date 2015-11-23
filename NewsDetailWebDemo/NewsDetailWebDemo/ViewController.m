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

@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView *myWeb;
    WebViewJavascriptBridge *jsBridge;
    NSArray *imgIdArr;
    NSMutableArray *imgSrcArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    myWeb = [[UIWebView alloc] initWithFrame:self.view.bounds];
    myWeb.delegate = self;
    [self.view addSubview:myWeb];
    
    
    //Instantiate WebViewJavascriptBridge
    [WebViewJavascriptBridge enableLogging];
    
    
    jsBridge = [WebViewJavascriptBridge bridgeForWebView:myWeb webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {

        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *msgType = dataDic[@"messageType"];
        
        
        if ([msgType isEqualToString:@"addTagBtn"]) {
            
            NSString *tagName = dataDic[@"object"];
            NSLog(@"点击了网页标签：%@",tagName);
            
        }else if ([msgType isEqualToString:@"replaceImages"]) {
            NSArray *srcArr = dataDic[@"object"];
            NSLog(@"获取到图片资源：%@",srcArr);
            
        }
        
        responseCallback(@"Response for message from ObjC");
    }];
    
    
    [self setupRequest];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *  请求数据
 */
- (void)setupRequest {
    
    NSMutableString *urlStr = [NSMutableString stringWithString:@"http://t23.roboo.com/news/detailJson.htm?id=6d406d20c612b7808939d53e25a3a10c&index=nnews"];
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
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:&error];
        
        [regex enumerateMatchesInString:summary
                                options:0
                                  range:NSMakeRange(0, [summary length])
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                 
                                 //替换源HTML中的img标签
                                 NSString *imgTag = [summary substringWithRange:[result rangeAtIndex:1]];
                                 NSString *imgSrc = [summary substringWithRange:[result rangeAtIndex:2]];
                                 
                                 NSString *newImageTag = [NSString stringWithFormat:@"<img src = 'loading' id = '%@' >",imgSrc];
                                 [summary replaceOccurrencesOfString:imgTag withString:newImageTag options:NSCaseInsensitiveSearch range:[summary rangeOfString:imgTag]];
                                 
                                 //将获取到的图片src加入到数组中
                                 [imgSrcArr addObject:imgSrc];
                             }];
        [dataDic removeObjectForKey:@"summary"];
        [dataDic setObject:summary forKey:@"summary"];
        

        NSString *sourceHTML = [template renderObjectsFromArray:@[dataDic] error:&error];
        if (error) {
            NSLog(@"error:%@",error);
        }else{
            [myWeb loadHTMLString:sourceHTML baseURL:[NSURL URLWithString:dataDic[@"url"]]];
        [self getImageFromDownloaderOrDiskByImageUrlArray:imgSrcArr];
        }

    }


}


/**
 *  从本地缓存或网络获取图片
 *
 *  @param imageArray
 */
- (void)getImageFromDownloaderOrDiskByImageUrlArray:(NSArray *)imageArray {

    NSString *newPath = @"http://imgres.roboo.com/group1/M01/E0/93/wKhkZ1ZSyhuAWrDDAAEy29Aq_08170.jpg";
    [jsBridge send:@{@"messageType":@"replaceImages", @"imageId":imageArray[0], @"newPath":newPath}];
//
    
//    SDWebImageManager *imageManager = [SDWebImageManager sharedManager];
//    [[SDWebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url) {
//        url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
//        NSString *str = [self replaceUrlSpecialString:[url absoluteString]];
//        return str;
//    }];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
//    
//    for (NSString *imgSrc in imgSrcArr) {
//
//        NSURL *imageUrl = [NSURL URLWithString:imgSrc];
//        
//        //存在缓存
//        if ([imageManager diskImageExistsForURL:imageUrl]) {
//            
//            NSString *cacheKey = [imageManager cacheKeyForURL:imageUrl];
//            NSString *imagePaths = [imageManager.imageCache cachePathForKey:cacheKey inPath:filePath];
//            NSLog(@"imagePaths === %@",imagePaths);
//            
////            [jsBridge send:@{@"messageType":@"replaceImages", @"imageId":imgSrc, @"newPath":imagePaths}];
//            [jsBridge send:[NSString stringWithFormat:@"replaceimage%@,%@",[self replaceUrlSpecialString:imgSrc],imagePaths]];
//
//            
//        }else {
//            //不存在缓存
//            
//            [imageManager downloadImageWithURL:imageUrl options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                
//                if (image && finished) {//如果下载成功
//                    
//                    NSString *cacheKey = [imageManager cacheKeyForURL:imageUrl];
//                    NSString *imagePaths = [imageManager.imageCache cachePathForKey:cacheKey inPath:filePath];
//                    NSLog(@"imagePaths === %@",imagePaths);
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                        [jsBridge send:@{@"messageType":@"replaceImages", @"imageId":imgSrc, @"newPath":imagePaths}];
//                        [jsBridge send:[NSString stringWithFormat:@"replaceimage%@,%@",[self replaceUrlSpecialString:imgSrc],imagePaths]];
//                    });
//                    
//                }else {
//                    //下载失败
//                    NSString *localImagePath = [[NSBundle mainBundle] pathForResource:@"preview" ofType:@"png"];
////                    [jsBridge send:@{@"messageType":@"replaceImages", @"imageId":imgSrc, @"newPath":localImagePath}];
//                    [jsBridge send:[NSString stringWithFormat:@"replaceimage%@,%@",[self replaceUrlSpecialString:imgSrc],localImagePath]];
//                }
//                
//            }];
//            
//        }
//        
//    }
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
