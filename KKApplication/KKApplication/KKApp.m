//
//  KKApp.m
//  KKApplication
//
//  Created by zhanghailong on 2017/12/28.
//  Copyright © 2017年 kkmofang.cn. All rights reserved.
//

#import "KKApp.h"

#import "KKPageViewController.h"
#import "KKWebViewController.h"
#import "KKWindowPageController.h"
#import "KKNavigationController.h"
#import <KKWebSocket/KKWebSocket.h>
#import <KKWebSocket/KKWebSocket.h>
#import <CommonCrypto/CommonCrypto.h>
#import "KKLandscapeNavigationController.h"
#import "KKPortraitNavigationController.h"
#import "KKPageElement.h"

static unsigned char require_js[] = {0xa,0x28,0x66,0x75,0x6e,0x63,0x74,0x69,0x6f,0x6e,0x28,0x6b,0x6b,0x29,0x7b,0xa,0x9,0x76,0x61,0x72,0x20,0x6d,0x6f,0x64,0x75,0x6c,0x65,0x73,0x20,0x3d,0x20,0x7b,0x7d,0x3b,0xa,0x9,0x6b,0x6b,0x2e,0x72,0x65,0x71,0x75,0x69,0x72,0x65,0x20,0x3d,0x20,0x66,0x75,0x6e,0x63,0x74,0x69,0x6f,0x6e,0x28,0x70,0x61,0x74,0x68,0x29,0x20,0x7b,0xa,0x9,0x9,0x76,0x61,0x72,0x20,0x6d,0x20,0x3d,0x20,0x6d,0x6f,0x64,0x75,0x6c,0x65,0x73,0x5b,0x70,0x61,0x74,0x68,0x5d,0x3b,0xa,0x9,0x9,0x69,0x66,0x28,0x6d,0x20,0x3d,0x3d,0x3d,0x20,0x75,0x6e,0x64,0x65,0x66,0x69,0x6e,0x65,0x64,0x29,0x20,0x7b,0xa,0x9,0x9,0x9,0x6d,0x20,0x3d,0x20,0x7b,0x20,0x65,0x78,0x70,0x6f,0x72,0x74,0x73,0x20,0x3a,0x20,0x7b,0x7d,0x20,0x7d,0x3b,0xa,0x9,0x9,0x9,0x74,0x72,0x79,0x20,0x7b,0xa,0x9,0x9,0x9,0x9,0x76,0x61,0x72,0x20,0x63,0x6f,0x64,0x65,0x20,0x3d,0x20,0x6b,0x6b,0x2e,0x67,0x65,0x74,0x53,0x74,0x72,0x69,0x6e,0x67,0x28,0x70,0x61,0x74,0x68,0x29,0x3b,0xa,0x9,0x9,0x9,0x9,0x76,0x61,0x72,0x20,0x66,0x6e,0x20,0x3d,0x20,0x65,0x76,0x61,0x6c,0x28,0x22,0x28,0x66,0x75,0x6e,0x63,0x74,0x69,0x6f,0x6e,0x28,0x6d,0x6f,0x64,0x75,0x6c,0x65,0x2c,0x65,0x78,0x70,0x6f,0x72,0x74,0x73,0x29,0x7b,0x22,0x20,0x2b,0x20,0x63,0x6f,0x64,0x65,0x20,0x2b,0x20,0x22,0x7d,0x29,0x22,0x29,0x3b,0xa,0x9,0x9,0x9,0x9,0x69,0x66,0x28,0x74,0x79,0x70,0x65,0x6f,0x66,0x20,0x66,0x6e,0x20,0x3d,0x3d,0x20,0x27,0x66,0x75,0x6e,0x63,0x74,0x69,0x6f,0x6e,0x27,0x29,0x20,0x7b,0xa,0x9,0x9,0x9,0x9,0x9,0x66,0x6e,0x28,0x6d,0x2c,0x6d,0x2e,0x65,0x78,0x70,0x6f,0x72,0x74,0x73,0x29,0x3b,0xa,0x9,0x9,0x9,0x9,0x7d,0xa,0x9,0x9,0x9,0x9,0x70,0x72,0x69,0x6e,0x74,0x28,0x22,0x72,0x65,0x71,0x75,0x69,0x72,0x65,0x20,0x22,0x20,0x2b,0x20,0x70,0x61,0x74,0x68,0x29,0x3b,0xa,0x9,0x9,0x9,0x7d,0x20,0x63,0x61,0x74,0x63,0x68,0x28,0x65,0x29,0x20,0x7b,0xa,0x9,0x9,0x9,0x9,0x70,0x72,0x69,0x6e,0x74,0x28,0x65,0x2e,0x74,0x6f,0x53,0x74,0x72,0x69,0x6e,0x67,0x28,0x29,0x29,0x3b,0xa,0x9,0x9,0x9,0x7d,0xa,0x9,0x9,0x9,0x6d,0x6f,0x64,0x75,0x6c,0x65,0x73,0x5b,0x70,0x61,0x74,0x68,0x5d,0x20,0x3d,0x20,0x6d,0x3b,0xa,0x9,0x9,0x7d,0xa,0x9,0x9,0x72,0x65,0x74,0x75,0x72,0x6e,0x20,0x6d,0x2e,0x65,0x78,0x70,0x6f,0x72,0x74,0x73,0x3b,0xa,0x9,0x7d,0x3b,0xa,0x7d,0x29,0x28,0x6b,0x6b,0x29,0x3b,0xa,0x00};

@interface KKApplication(){
    NSMutableArray * _jsWebSockets;
    NSMutableArray * _objectRecycles;
    NSMutableDictionary * _objectRecyclesForKey;
}

@end

@implementation KKApplication

+(void) initialize {
    [KKPageElement class];
}

@synthesize jsContext = _jsContext;
@synthesize jsObserver = _jsObserver;
@synthesize http = _http;
@synthesize asyncCaller = _asyncCaller;
@synthesize jsHttp = _jsHttp;
@synthesize jsWebSocket = _jsWebSocket;

-(instancetype) initWithBundle:(NSBundle *) bundle {
    return [self initWithBundle:bundle jsContext:[[JSContext alloc] initWithVirtualMachine:[KKApplication jsVirtualMachine]]];
}

-(instancetype) initWithBundle:(NSBundle *) bundle jsContext:(JSContext *) jsContext {
    if((self = [super init])) {
        _jsContext = jsContext;
        _jsObserver = [[KKJSObserver alloc] initWithObserver:[[KKObserver alloc] initWithJSContext:jsContext]];
        _bundle = bundle;
        _viewContext = [[KKViewContext alloc] init];
        [_viewContext setBasePath:self.path];
        _viewContext.delegate = self;
        
        [jsContext KKViewOpenlib];
        
        __weak KKApplication * app = self;
        
        {
            JSValue * kk = [JSValue valueWithNewObjectInContext:jsContext];
            
            [kk setValue:@(KKApplicationKernel) forProperty:@"kernel"];
            [kk setValue:@"ios" forProperty:@"platform"];
            [kk setValue:[[NSLocale currentLocale] localeIdentifier] forProperty:@"lang"];
            [kk setValue:[KKHttp userAgent] forProperty:@"userAgent"];
            [kk setValue:^NSString *(NSString *path){

                return [NSString stringWithContentsOfFile:[app absolutePath:path] encoding:NSUTF8StringEncoding error:nil];
                
            } forProperty:@"getString"];
            
            {
                JSValue * app = [JSValue valueWithNewObjectInContext:jsContext];
            
                NSBundle * main = [NSBundle mainBundle];
                [app setValue:[[main infoDictionary] valueForKey:@"CFBundleIdentifier"] forProperty:@"id"];
                [app setValue:[[main infoDictionary] valueForKey:@"CFBundleShortVersionString"] forProperty:@"version"];
                [app setValue:[[main infoDictionary] valueForKey:@"CFBundleVersion"] forProperty:@"build"];
                [app setValue:[[main infoDictionary] valueForKey:@"CFBundleDisplayName"] forProperty:@"name"];
                [app setValue:[[NSLocale currentLocale] localeIdentifier] forProperty:@"lang"];
                
                [kk setValue:app forProperty:@"app"];
            }
            
            {
                JSValue * v = [JSValue valueWithNewObjectInContext:jsContext];
                
                UIDevice * device = [UIDevice currentDevice];
                
                CC_MD5_CTX m;
                
                CC_MD5_Init(&m);
                
                NSData * data = [[[device identifierForVendor] UUIDString] dataUsingEncoding:NSUTF8StringEncoding];
                
                CC_MD5_Update(&m, [data bytes], (CC_LONG) [data length]);
                
                unsigned char md[16];
                
                CC_MD5_Final(md, &m);
                
                [v setValue:[NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
                               ,md[0],md[1],md[2],md[3],md[4],md[5],md[6],md[7]
                               ,md[8],md[9],md[10],md[11],md[12],md[13],md[14],md[15]] forProperty:@"id"];
                [v setValue:[device systemName] forProperty:@"systemName"];
                [v setValue:[device systemVersion] forProperty:@"systemVersion"];
                [v setValue:[device model] forProperty:@"model"];
                [v setValue:[device name] forProperty:@"name"];
                
                [kk setValue:v forProperty:@"device"];
            }
            
            [[jsContext globalObject] setValue:kk forProperty:@"kk"];
            
        }
        
        {
            [jsContext evaluateScript:[NSString stringWithCString:(char *) require_js encoding:NSUTF8StringEncoding]];
        }
        
        
        [self.observer on:^(id value, NSArray *changedKeys, void *context) {
            
            if(app && [value isKindOfClass:[NSDictionary class]]) {
                
                [app doAction:value];
                
            }
            
        } keys:@[@"action",@"open"] context:nil];
        
        [self.observer on:^(id value, NSArray *changedKeys, void *context) {
            
            if(app && value) {
                
                [[[UIAlertView alloc] initWithTitle:nil message:KKStringValue(value)
                                           delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                
            }
            
        } keys:@[@"alert"] context:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doAppForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doAppBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        {
            JSValue * global = [jsContext globalObject];
            [global setValue:self.jsHttp forProperty:@"http"];
            [global setValue:self.jsObserver forProperty:@"app"];
            [global setValue:self.asyncCaller.SetTimeoutFunc forProperty:@"setTimeout"];
            [global setValue:self.asyncCaller.ClearTimeoutFunc forProperty:@"clearTimeout"];
            [global setValue:self.asyncCaller.SetIntervalFunc forProperty:@"setInterval"];
            [global setValue:self.asyncCaller.ClearIntervalFunc forProperty:@"clearInterval"];
        }
        
    }
    return self;
}

-(void) doAppForeground {
    [self.observer set:@[@"app",@"foreground"] value:@{}];
}

-(void) doAppBackground {
    [self.observer set:@[@"app",@"background"] value:@{}];
}

-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [_jsObserver recycle];
    [_asyncCaller recycle];
    [_jsHttp recycle];
    {
        for(KKJSWebSocket * v in _jsWebSockets){
            [v recycle];
        }
    }
    {
        for(id<KKObjectRecycle> v in _objectRecycles) {
            [v recycle];
        }
    }
    {
        for(id<KKObjectRecycle> v in [_objectRecyclesForKey allValues]) {
            [v recycle];
        }
    }
}

-(JSValue *) jsWebSocket {
    
    if(_jsWebSocket == nil) {
        
        _jsWebSockets = [[NSMutableArray alloc] initWithCapacity:4];
        
        _jsWebSocket = [JSValue valueWithNewObjectInContext:self.jsContext];
        
        __weak NSMutableArray * items = _jsWebSockets;
        
        _jsWebSocket[@"alloc"] = ^JSValue*() {
            
            NSArray * arguments = [JSContext currentArguments];
            NSString * url = nil;
            NSString * protocol = nil;
            
            if([arguments count] >0) {
                url = [arguments[0] toString];
            }
            
            if([arguments count] >1) {
                url = [arguments[1] toString];
            }
            
            if(url) {
                
                KKWebSocket * webSocket = [[KKWebSocket alloc] initWithURL:[NSURL URLWithString:url]];
                
                if(protocol != nil) {
                    webSocket.headers[@"Sec-WebSocket-Protocol"] = protocol;
                }
                
                KKJSWebSocket * jsWebSocket = [[KKJSWebSocket alloc] initWithWebSocket:webSocket];
                
                [items addObject:jsWebSocket];
                
                [webSocket connect];
                
                return [JSValue valueWithObject:jsWebSocket inContext:[JSContext currentContext]];
                
            }
            
            return nil;
        };
    }
    return _jsWebSocket;
}

-(KKAsyncCaller *) asyncCaller {
    if(_asyncCaller == nil) {
        _asyncCaller = [[KKAsyncCaller alloc] init];
    }
    return _asyncCaller;
}

-(KKJSHttp *) jsHttp {
    if(_jsHttp == nil) {
        id<KKHttp> http = self.http;
        if(http == nil) {
            http = self.viewContext;
        }
        _jsHttp = [[KKJSHttp alloc] initWithHttp:http];
    }
    return _jsHttp;
}

-(KKObserver *) observer {
    return _jsObserver.observer;
}

-(KKElement *) elementWithPath:(NSString *) path data:(KKJSObserver *) data{
    
    KKElement * rootElement = [[KKElement alloc] init];
    
    if(_viewContext) {
        [KKViewContext pushContext:_viewContext];
    }
    
    NSString * code = [NSString stringWithContentsOfFile:[self absolutePath:path] encoding:NSUTF8StringEncoding error:nil];
    
    JSValue * fn = [self.jsContext evaluateScript:[NSString stringWithFormat:@"(function(element,data){ %@ })",code]];
    
    @try{
        [fn callWithArguments:@[rootElement,data]];
    }
    @catch(NSException * ex) {
        NSLog(@"[KK] %@",ex);
    }
    
    if(_viewContext) {
        [KKViewContext popContext];
    }
    
    return rootElement.lastChild;
}

-(NSString *) path {
    return [_bundle bundlePath];
}

-(void) openlib:(NSString *) path {
    
    NSString * v = [self.path stringByAppendingPathComponent:path];
    NSString * code = [NSString stringWithContentsOfFile:v encoding:NSUTF8StringEncoding error:nil];
    
    if(code) {
        [self.jsContext evaluateScript:code];
    }
    
}

-(void) exec:(NSString *) path librarys:(NSDictionary *)librarys {
    
    NSString * v = [self.path stringByAppendingPathComponent:path];
    NSString * code = [NSString stringWithContentsOfFile:v encoding:NSUTF8StringEncoding error:nil];
    
    if(code) {
        
        NSMutableDictionary * libs = [NSMutableDictionary dictionaryWithCapacity:4];
        
        if(librarys != nil) {
            [libs addEntriesFromDictionary:librarys];
        }
        
        if(libs[@"app"] == nil) {
            libs[@"app"] = self.jsObserver;
        }
        
        NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:4];
        
        NSMutableString * execCode = [[NSMutableString alloc] initWithCapacity:128];
        
        [execCode appendString:@"(function("];
        
        NSEnumerator * keyEnum = [libs keyEnumerator];
        NSString * key;
        
        while((key = [keyEnum nextObject])) {
            if([arguments count] != 0) {
                [execCode appendString:@","];
            }
            [execCode appendString:key];
            [arguments addObject:[libs valueForKey:key]];
        }
        
        [execCode appendFormat:@"){%@})",code];
        
        JSValue * fn = [self.jsContext evaluateScript:execCode withSourceURL:[NSURL fileURLWithPath:v]];
        
        @try{
            [fn callWithArguments:arguments];
        }
        @catch(NSException * ex) {
            NSLog(@"[KK] %@",ex);
        }
        
    } else {
        NSLog(@"[KK] Not Found %@",v);
    }
    
}

-(KKObserver *) newObserver {
    return [[KKObserver alloc] initWithJSContext:self.jsContext];
}

-(NSString *) absolutePath:(NSString *) path {
    return [self.path stringByAppendingPathComponent:path];
}

-(BOOL) has:(NSString *) path {
    return [[NSFileManager defaultManager] fileExistsAtPath:[self absolutePath:path]];
}


-(UITabBarController *) openTabBarController:(NSDictionary *) action {
    
    UITabBarController * tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:self.bundle];
    
    NSMutableArray * viewControllers = [NSMutableArray arrayWithCapacity:4];
    
    UIViewController * selectedViewController = nil;
    
    NSArray * items = [action kk_getValue:@"items"];
    
    if([items isKindOfClass:[NSArray class]]) {
        
        for(NSDictionary * item in items) {
            
            if([item isKindOfClass:[NSDictionary class]]) {
                
                UIViewController * viewController = [self openViewController:item];
                
                KKNavigationController * navController = [[KKNavigationController alloc] initWithRootViewController:viewController];
                
                {
                    id topbar = [item kk_getValue:@"topbar"];
                    {
                        UIColor * v = [UIColor KKElementStringValue:[topbar kk_getString:@"background-color"]];
                        if(v) {
                            navController.navigationBar.backgroundColor = v;
                        }
                    }
                    
                    {
                        UIColor * v = [UIColor KKElementStringValue:[topbar kk_getString:@"tint-color"]];
                        if(v) {
                            navController.navigationBar.tintColor = v;
                        }
                    }
                    
                    {
                        UIColor * v = [UIColor KKElementStringValue:[topbar kk_getString:@"color"]];
                        if(v) {
                            navController.navigationBar.barTintColor = v;
                        }
                    }
                }
                
                id tabbar = [item kk_getValue:@"tabbar"];
                
                UIImage * image = [self.viewContext imageWithURI:[tabbar kk_getString:@"image"]];
                UIImage * selectedImage = [self.viewContext imageWithURI:[tabbar kk_getString:@"image:selected"]];
                
                if(image && selectedImage) {
                    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                }
                
                NSString * title = [tabbar kk_getString:@"title"];
                
                navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
                
                [viewControllers addObject:navController];
                
                if([[tabbar kk_getValue:@"selected"] boolValue]) {
                    selectedViewController = navController;
                }
            }
            
        }
    }
    
    tabBarController.viewControllers = viewControllers;
    
    if(selectedViewController) {
        tabBarController.selectedViewController = selectedViewController;
    }
    
    {
        __weak UITabBarController * v = tabBarController;
        
        [self.observer on:^(id value, NSArray *changedKeys, void *context) {
            
            if(v && value) {
                NSInteger i = [value integerValue];
                if(i >=0 && i < [v.viewControllers count]) {
                    v.selectedIndex = i;
                }
            }
            
        } keys:@[@"tabbar",@"selected"] context:nil];
        
    }
    
    id tabbar = [action kk_getValue:@"tabbar"];
    {
        UIColor * v = [UIColor KKElementStringValue:[tabbar kk_getString:@"background-color"]];
        if(v) {
            tabBarController.tabBar.backgroundColor = v;
        }
    }
    
    {
        UIColor * v = [UIColor KKElementStringValue:[tabbar kk_getString:@"tint-color"]];
        if(v) {
            tabBarController.tabBar.tintColor = v;
        }
    }
    
    {
        UIColor * v = [UIColor KKElementStringValue:[tabbar kk_getString:@"color"]];
        if(v) {
            tabBarController.tabBar.barTintColor = v;
        }
    }
    
    {
        UIColor * v = [UIColor KKElementStringValue:[action kk_getString:@"background-color"]];
        if(v) {
            tabBarController.view.backgroundColor = v;
        }
    }
    
    {
        UIColor * v = [UIColor KKElementStringValue:[action kk_getString:@"tint-color"]];
        if(v) {
            tabBarController.view.tintColor = v;
        }
    }
    
    return tabBarController;
}

-(UIViewController *) openViewController:(NSDictionary *) action {
    
    UIViewController * viewController = nil;
    
    if([(id) _delegate respondsToSelector:@selector(KKApplication:viewController:)]) {
        viewController = [_delegate KKApplication:self viewController:action];
    }
    
    if(viewController == nil) {
        
        Class isa = NSClassFromString([action valueForKey:@"class"]);
        
        if(isa == nil && [action kk_getString:@"url"]) {
            isa = [KKWebViewController class];
        }
        
        if(isa == nil && [action kk_getString:@"scheme"]) {
            NSString * v = [action kk_getString:@"scheme"];
            if([v hasPrefix:@"http://"] || [v hasPrefix:@"https://"]) {
                isa = [KKWebViewController class];
            } else {
                return nil;
            }
        }
        
        if(isa ==nil && [[action kk_getString:@"type"] isEqualToString:@"tabbar"]) {
            return [self openTabBarController:action];
        }

        if(isa == nil && [action kk_getString:@"path"]) {
            isa = [KKPageViewController class];
        }
        
        if(isa == nil) {
            NSLog(@"Not Implement Action %@",action);
            return nil;
        }
        
        viewController = [[isa alloc] initWithNibName:[action valueForKey:@"nibName"] bundle:self.bundle];
        
    }
    
    viewController.title = [action valueForKey:@"title"];
    
    if([viewController conformsToProtocol:@protocol(KKViewController)]) {
        id<KKViewController>  kkViewController = (id<KKViewController>) viewController;
        kkViewController.application = self;
        kkViewController.action = action;
    }
    
    return viewController;
}

-(KKWindowPageController *) openWindowPageController:(NSDictionary *) action {
    
    __strong KKApplication * v = self;
    
    NSArray * vs = [[action kk_getString:@"back"] componentsSeparatedByString:@"/"];
    
    if(vs != nil ){
        
        UIViewController * topViewController = [KKApplication topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
        
        if([topViewController isKindOfClass:[UINavigationController class]]) {
            
            NSMutableArray * viewControllers = [NSMutableArray arrayWithArray:[(UINavigationController *) topViewController viewControllers]];
            
            for(NSString * v in vs) {
                if([v isEqualToString:@".."]) {
                    [viewControllers removeLastObject];
                }
            }
            
            if([viewControllers count] >0){
                [(UINavigationController *) topViewController popToViewController:[viewControllers lastObject] animated:YES];
            } else {
                [(UINavigationController *) topViewController popToRootViewControllerAnimated:YES];
            }
        }
        
    }
    
    KKWindowPageController * pageController = [[KKWindowPageController alloc] init];
    
    pageController.application = v;
    pageController.action = action;
    
    [pageController show];
    
    return pageController;
}

-(void) doAction:(NSDictionary *) action {
    
    if([(id) _delegate respondsToSelector:@selector(KKApplication:openAction:)]) {
        if([_delegate KKApplication:self openAction:action]) {
            return;
        }
    }
    
    if([[action kk_getString:@"type"] isEqualToString:@"window"]) {
        [self openWindowPageController:action];
        return ;
    }
    
    UIViewController * viewController = [self openViewController:action];
    
    if(viewController == nil) {
        
        if([action kk_getString:@"scheme"]) {
            NSString * v = [action kk_getString:@"scheme"];
            if(![v hasPrefix:@"http://"] && ![v hasPrefix:@"https://"]) {
                
                UIViewController * topViewController = [KKApplication topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
                
                if([topViewController isKindOfClass:[UINavigationController class]]) {
                    NSArray * vs = [[action kk_getString:@"back"] componentsSeparatedByString:@"/"];
                    for(NSString * v in vs) {
                        if([v isEqualToString:@".."]) {
                            [(UINavigationController *) topViewController popViewControllerAnimated:NO];
                        }
                    }
                }
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:v]];
                return;
            }
        }
        
        return ;
    }
    
    [viewController view];
    
    if([(id) _delegate respondsToSelector:@selector(KKApplication:openViewController:action:)]) {
        if([_delegate KKApplication:self openViewController:viewController action:action]) {
            return;
        }
    }

    UIViewController * topViewController = [KKApplication topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    
    BOOL animated = YES;
    
    {
        id v = [action kk_getValue:@"animated"];
        if(v != nil) {
            animated = [v boolValue];
        }
    }
    
    if(topViewController == nil
       || [[action kk_getString:@"target"] isEqualToString:@"root"]) {
        
        if([viewController isKindOfClass:[UITabBarController class]] || [viewController isKindOfClass:[UINavigationController class]]) {
            [[UIApplication sharedApplication].keyWindow setRootViewController:viewController];
        } else if([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UINavigationController class]]){
            [(UINavigationController *) [UIApplication sharedApplication].keyWindow.rootViewController setViewControllers:@[viewController] animated:NO];
        } else {
            [[UIApplication sharedApplication].keyWindow setRootViewController:[[KKNavigationController alloc] initWithRootViewController:viewController]];
        }
        
    }
    else if([topViewController isKindOfClass:[UINavigationController class]]) {
        
        NSArray * vs = [[action kk_getString:@"back"] componentsSeparatedByString:@"/"];
        
        for(NSString * v in vs) {
            if([v isEqualToString:@".."]) {
                [(UINavigationController *) topViewController popViewControllerAnimated:NO];
            }
        }
        
        NSSet * orientation = [NSSet setWithArray:[[action kk_getString:@"orientation"] componentsSeparatedByString:@"|"]];
        
        if([orientation containsObject:@"landscape"] && [orientation containsObject:@"portrait"]) {
            
            if(![topViewController isKindOfClass:[KKNavigationController class]]) {
                
                KKNavigationController * nav = [[KKNavigationController alloc] initWithRootViewController:viewController];
                
                nav.action = action;
                
                [topViewController presentViewController:nav animated:animated completion:nil];
                
                return;
            }
            
        } else if([orientation containsObject:@"landscape"]) {
            
            if(![topViewController isKindOfClass:[KKLandscapeNavigationController class]]) {
                
                KKLandscapeNavigationController * nav = [[KKLandscapeNavigationController alloc] initWithRootViewController:viewController];
                
                nav.action = action;
                
                [topViewController presentViewController:nav animated:animated completion:nil];
                
                return;
            }
            
        } else if([orientation containsObject:@"portrait"]) {
            
            if(![topViewController isKindOfClass:[KKPortraitNavigationController class]]) {
                
                KKPortraitNavigationController * nav = [[KKPortraitNavigationController alloc] initWithRootViewController:viewController];
                
                nav.action = action;
                
                [topViewController presentViewController:nav animated:animated completion:nil];
                
                return;
            }
            
        }
        
        [(UINavigationController *) topViewController pushViewController:viewController animated:animated];
    } else {
        [topViewController presentViewController:viewController animated:animated completion:nil];
    }
}

+(UIViewController *) topViewController:(UIViewController *) viewController {
    
    if(viewController.presentedViewController) {
        return [self topViewController:viewController.presentedViewController];
    }
    
    if([viewController isKindOfClass:[UINavigationController class]]) {
        return viewController;
    }
    
    if([viewController isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *) viewController selectedViewController]];
    }
    
    return viewController;
}

-(void) run {
    [self exec:@"main.js" librarys:@{}];
}

-(void) KKViewContext:(KKViewContext *)viewContext willSend:(KKHttpOptions *)options {
    
    if([(id) _delegate respondsToSelector:@selector(KKApplication:willSend:)]) {
        [_delegate KKApplication:self willSend:options];
    }
    
}

-(id<KKHttpTask>) KKViewContext:(KKViewContext *) viewContext send:(KKHttpOptions *) options weakObject:(id) weakObject {
    
    id<KKHttpTask> v = nil;
    
    if([(id)_delegate respondsToSelector:@selector(KKApplication:send:weakObject:)]) {
        v = [_delegate KKApplication:self send:options weakObject:weakObject];
    }
    
    if(v == nil && _http != nil) {
        v = [_http send:options weakObject:weakObject];
    }

    return v;
}

-(BOOL) KKViewContext:(KKViewContext *) viewContext cancel:(id) weakObject {
    
    BOOL r = NO;
    
    if([(id)_delegate respondsToSelector:@selector(KKApplication:cancel:)]) {
        r = [_delegate KKApplication:self cancel:weakObject];
    }
    
    if(r == NO && _http != nil) {
        [_http cancel:weakObject];
    }
    
    return r;
}

-(UIImage *) KKViewContext:(KKViewContext *) viewContext imageWithURI:(NSString * ) uri {
    
    if([(id)_delegate respondsToSelector:@selector(KKApplication:imageWithURI:)]) {
        return [_delegate KKApplication:self imageWithURI:uri];
    }
    
    return nil;
}

-(void) KKViewContext:(KKViewContext *) viewContext element:(KKViewElement *) element changedKey:(NSString *) key {
    
}

-(void) recycle {
    [_jsHttp recycle];
    [_asyncCaller recycle];
    [_jsObserver recycle];
    _jsObserver = nil;
    _asyncCaller = nil;
    _jsHttp = nil;
    {
        for(KKJSWebSocket * v in _jsWebSockets){
            [v recycle];
        }
        _jsWebSockets = nil;
    }
    {
        for(id<KKObjectRecycle> v in _objectRecycles) {
            [v recycle];
        }
        _objectRecycles = nil;
        _objectRecyclesForKey = nil;
    }
    
    {
        for(id<KKObjectRecycle> v in [_objectRecyclesForKey allValues]) {
            [v recycle];
        }
        _objectRecyclesForKey = nil;
    }
}

-(void) addObjectRecycle:(id<KKObjectRecycle>) object {
    if(_objectRecycles == nil) {
        _objectRecycles = [[NSMutableArray alloc] initWithCapacity:4];
    }
    [_objectRecycles addObject:object];
}

-(void) removeObjectRecycle:(id<KKObjectRecycle>) object {
    [_objectRecycles removeObject:object];
}

-(void) setObjectRecycle:(id<KKObjectRecycle>) object forKey:(NSString *) key {
    if(_objectRecyclesForKey == nil) {
        _objectRecyclesForKey = [[NSMutableDictionary alloc] initWithCapacity:4];
    }
    id<KKObjectRecycle> v = [_objectRecyclesForKey valueForKey:key];
    if(v != object) {
        [v recycle];
        [_objectRecyclesForKey setValue:object forKey:key];
    }
}

-(void) removeObjectRecycleForKey:(NSString *) key {
    id<KKObjectRecycle> v = [_objectRecyclesForKey valueForKey:key];
    if(v) {
        [v recycle];
    }
    [_objectRecyclesForKey removeObjectForKey:key];
}

-(id<KKObjectRecycle>) objectRecycleForKey:(NSString *) key {
    return [_objectRecyclesForKey valueForKey:key];
}

+(JSVirtualMachine *) jsVirtualMachine {
    static JSVirtualMachine * v = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [[JSVirtualMachine alloc] init];
    });
    return v;
}

@end

@implementation UIApplication (KKApplication)

-(KKApplication *) KKApplication {
    
    UIViewController * viewController = [[self keyWindow] rootViewController];
    
    if([viewController isKindOfClass:[UINavigationController class]]) {
        viewController = [[(UINavigationController *) viewController viewControllers] firstObject];
    } else if([viewController isKindOfClass:[UITabBarController class]]) {
        viewController = [[(UITabBarController *) viewController viewControllers] firstObject];
    }
    
    if([viewController conformsToProtocol:@protocol(KKViewController)]) {
        return [(id<KKViewController>) viewController application];
    }
    
    return nil;
}

-(UIViewController *) kk_topViewController {
    return [KKApplication topViewController:self.keyWindow.rootViewController];
}

@end
