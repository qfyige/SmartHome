//
//  SHWebViewController.h
//  SmartHome
//
//  Created by hui.li on 16/9/3.
//  Copyright © 2016年 tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHWebViewController.h"
#import "SHBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface SHWebViewController : SHBaseViewController<UIWebViewDelegate,NSURLConnectionDelegate>
{
    UIWebView *myWebView;
    UIActivityIndicatorView *activityIndicatorView;
    
    //当前的url
    NSURLConnection *reUrlConnection;//重发请求
    NSURLRequest *originRequest;
    JSContext *context;
}

@property (nonatomic,assign,getter =isAuthed) BOOL authed;
@property (nonatomic,strong) NSURL *currenURL;
@property (nonatomic, strong) NSString *urlString;

@end
