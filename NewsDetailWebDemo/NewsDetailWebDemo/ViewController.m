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
@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView *myWeb;
    WebViewJavascriptBridge *jsBridge;
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
        NSString *tagName = dataDic[@"object"];
        
        if ([msgType isEqualToString:@"addTagBtn"] && tagName) {
            NSLog(@"点击了网页标签：%@",tagName);
        }
        
        
        responseCallback(@"Response for message from ObjC");
    }];
    
    
    [self setupRequest];
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

-(void)setupWebViewByData:(id)data{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:data];
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
    NSError *error = nil;
    GRMustacheTemplate *template = [GRMustacheTemplate templateFromContentsOfURL:[NSURL fileURLWithPath:templatePath] error:&error];
    if (error) {
        NSLog(@"error while loading template: %@", error);
    }else{
        
        NSString *tagBtnsHTML = @"";
        //获取tagButtons
        NSArray *tagArr = dataDic[@"tags"];
        for (id tag in tagArr) {
            NSString *tagName = tag;
            
            tagBtnsHTML = [tagBtnsHTML stringByAppendingString:@"<div id='tagBtn' class='tagsDiv'></div>"];
            
            [jsBridge send:@{@"messageType":@"addTagBtn",@"object":tagName} responseCallback:^(id responseData) {
//                NSLog(@"objc got response! %@", responseData);
            }];

            
        }
        
        [dataDic setObject:tagBtnsHTML forKey:@"tagBtns"];
        
        NSString *sourceHTML = [template renderObjectsFromArray:@[dataDic] error:&error];
        if (error) {
            NSLog(@"error:%@",error);
        }else{
            [myWeb loadHTMLString:sourceHTML baseURL:[NSURL URLWithString:dataDic[@"url"]]];
        }

    }


}

-(CGFloat)webViewHeight{
    //获取到的WebView的高度
    CGFloat height = [[myWeb stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    return height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIWebViewDelegate
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [self resizeImagesSizeInWeb:webView];
    
}

-(void)resizeImagesSizeInWeb:(UIWebView *)webView{
    
    NSString *JS_ResizeImageSize = [NSString stringWithFormat:@"var script = document.createElement('script');"
                                    "script.type = 'text/javascript';"
                                    "script.text = \"function ResizeImages() { "
                                    "var myimg,oldwidth;"
                                    "var maxwidth=%f;" //缩放系数
                                    "for(i=0;i <document.images.length;i++){"
                                    "myimg = document.images[i];"
                                    "if(myimg.width > maxwidth){"
                                    "oldwidth = myimg.width;"
                                    "myimg.width = maxwidth;"
                                    "myimg.height = myimg.height * (maxwidth/oldwidth);"
                                    "}"
                                    "}"
                                    "}\";"
                                    "document.getElementsByTagName('head')[0].appendChild(script);",webView.bounds.size.width-20];
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:JS_ResizeImageSize];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}


@end
