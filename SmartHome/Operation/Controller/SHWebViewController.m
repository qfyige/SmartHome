//
//  SHWebViewController.m
//  SmartHome
//
//  Created by hui.li on 16/9/3.
//  Copyright © 2016年 tong. All rights reserved.
//

#import "SHWebViewController.h"
#import "SHCommonHeader.h"
#import "SHUserModel.h"
#import "SHUserManager.h"

@implementation SHWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWebView];
}

- (void)initWebView
{
    if(self.urlString){
        self.urlString = [self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        myWebView.delegate = self;
        myWebView.scalesPageToFit = YES;
        [self.view addSubview:myWebView];
        
        activityIndicatorView = [[UIActivityIndicatorView alloc]
                                 initWithFrame :CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
        [activityIndicatorView setCenter:self.view.center] ;
        [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray] ;
        [self.view addSubview :activityIndicatorView];
        
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [myWebView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    myWebView.delegate = nil;
    myWebView = nil;
}

#pragma mark -
#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating] ;
    context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block typeof(self) weakSelf = self;
    context[@"getIDInfo"] = ^id(NSString *param){
        return [weakSelf getIDInfoStr];
    };
}

- (NSString *)getIDInfoStr
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
    SHSetModel *model = [SHSetModel shareInstance];
    NSString *netenv = @"";
    NSString *devip = @"";
    if (IS_NSString(model.localOperationIP)) {
        netenv = @"lan";
        devip = model.localOperationIP;
    }
    //有限使用局域网
    if (IS_NSString(model.remoteOperationIP) || !IS_NSString(model.localOperationIP)) {
        netenv = @"internet";
        devip = model.remoteOperationIP;
    }
    [dict setObject:netenv forKey:@"netenv"];
    [dict setObject:devip forKey:@"devip"];
    
    NSMutableDictionary *wss = [NSMutableDictionary dictionaryWithCapacity:1];
    SHUserModel *userModel = [[SHUserManager sharedInstance] getUser];
    [wss setObject:userModel.seckey forKey:@"seckey"];
    [wss setObject:userModel.userId forKey:@"user"];
    [wss setObject:userModel.password forKey:@"password"];
#warning test fromid 需要修改唯一标识
    [wss setObject:@"ldsh" forKey:@"devid"];
    [dict setObject:wss forKey:@"wss"];
    
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
    //    [dict setObject:@"internet" forKey:@"netenv"];
    //    [dict setObject:@"http://192.168.0.111/" forKey:@"devip"];
    //    NSMutableDictionary *wss = [NSMutableDictionary dictionaryWithCapacity:1];
    //    [wss setObject:@"2" forKey:@"seckey"];
    //    [wss setObject:@"1" forKey:@"user"];
    //    [wss setObject:@"23" forKey:@"password"];
    //    [wss setObject:@"2" forKey:@"devid"];
    //    [dict setObject:wss forKey:@"wss"];
    NSString *str = [self DataTOjsonString:dict];
    NSLog(@"getIDInfoStr str is %@",str);
    return str;
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
}

/**
 调如下js可以调用shouldStartLoadWithRequest方法
 function sendCommand(cmd,param){
 var url="protocol://"+cmd+":"+param;
 document.location = url;
 }
 **/
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = [[request URL]absoluteString];
    if ([url hasPrefix:@"protocol://"]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Called by JavaScript"
                                                        message:@"You've called iPhone provided control from javascript!!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    
    NSString* scheme = [[request URL] scheme];
    NSLog(@"scheme = %@",scheme);
    //判断是不是https
    if ([scheme isEqualToString:@"https"]) {
        //如果是https:的话，那么就用NSURLConnection来重发请求。从而在请求的过程当中吧要请求的URL做信任处理。
        if (!self.isAuthed) {
            originRequest = request;
            NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [conn start];
            [myWebView stopLoading];
            return NO;
        }
    }
    return YES;
}

#pragma mark -
#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0) {
        _authed = YES;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
        NSData *p12data = [NSData dataWithContentsOfFile:path];
        CFDataRef inP12data = (__bridge CFDataRef)p12data;
        
        SecIdentityRef myIdentity;
        SecTrustRef myTrust;
        extractIdentityAndTrust(inP12data, &myIdentity, &myTrust);
        long count = SecTrustGetCertificateCount(myTrust);
        NSMutableArray* myCertificates = nil;
        if(count > 1) {
            myCertificates = [NSMutableArray arrayWithCapacity:count];
            for(int i = 1; i < count; ++i) {
                [myCertificates addObject:(__bridge id)SecTrustGetCertificateAtIndex(myTrust, i)];
            }
        }
        
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:myIdentity certificates:nil persistence:NSURLCredentialPersistenceNone];
        assert(credential != nil);
        NSLog(@"User:%@, certificates %@ identity:%@", [credential user], [credential certificates], [credential identity]);
        [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
    }else{
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod
            isEqualToString:NSURLAuthenticationMethodServerTrust];
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"challenge == %@",challenge);
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    NSLog(@"%@",request);
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.authed = YES;
    //webview 重新加载请求。
    [myWebView loadRequest:originRequest];
    [connection cancel];
}

OSStatus extractIdentityAndTrust(CFDataRef inP12data, SecIdentityRef *identity, SecTrustRef *trust)
{
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("ever@01");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import(inP12data, options, &items);
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
        *identity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemTrust);
        *trust = (SecTrustRef)tempTrust;
        CFIndex count = CFArrayGetCount(items);
        NSLog(@"Certificates found:%ld",count);
    }
    if (options) {
        CFRelease(options);
    }
    return securityError;
}

@end
