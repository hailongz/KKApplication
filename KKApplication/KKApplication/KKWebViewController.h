//
//  KKWebViewController.h
//  KKApplication
//
//  Created by hailong11 on 2017/12/29.
//  Copyright © 2017年 kkmofang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKApplication/KKPageViewController.h>
#import <WebKit/WebKit.h>

@interface KKWebViewController : UIViewController<KKViewController,WKScriptMessageHandler,WKNavigationDelegate>

@property(nonatomic,strong,readonly) KKPageController * pageController;
@property(nonatomic,strong) IBOutlet WKWebView * webView;
@property(nonatomic,strong) NSString * url;

-(WKWebView *) loadWebView;

-(WKWebViewConfiguration *) loadWebViewConfiguration;

-(IBAction) doCloseAction:(id)sender;

@end
