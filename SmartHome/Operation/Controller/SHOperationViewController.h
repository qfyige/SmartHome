//
//  SHOperationViewController.h
//  SmartHome
//
//  Created by tong lele on 16/7/30.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHWebViewController.h"

<<<<<<< Updated upstream
@interface SHOperationViewController : PAIWebViewController<UIWebViewDelegate,NSURLConnectionDelegate>
{
    UIWebView *webView;
    
    UIActivityIndicatorView *activityIndicatorView;
    
    //当前的url
    NSURL *_currenURL;
    NSURLConnection* reUrlConnection;//重发请求
    NSURLRequest* originRequest;
    
}

@property(nonatomic,assign,getter =isAuthed)BOOL authed;
@property(nonatomic,strong)NSURL *currenURL;
=======
@interface SHOperationViewController : SHWebViewController
>>>>>>> Stashed changes

@end
