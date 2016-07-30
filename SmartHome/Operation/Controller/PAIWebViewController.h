//
//  PAIWebViewController.h
//  PAI2.0
//
//  Created by pencho on 16/5/13.
//  Copyright © 2016年 pencho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "SHBaseViewController.h"

@interface PAIWebViewController : SHBaseViewController

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic,copy) NSString *urlString;
@property (nonatomic,assign) BOOL isShowNavigation;
-(void)load;
//退出当前页面
- (void)dismiss;
//加载失败 重写这个方法
- (void)failLoad;
- (void)getJSMessage:(id)message;
@end
