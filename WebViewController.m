//
//  WebViewController.m
//  RedKitt
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    if (self.initalURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.initalURL];
        [self.webView loadRequest:request];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewController:shouldStartLoadWithRequest:navigationType:)]) {
        
        return [self.delegate webViewController:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    // Auth logic here
//    if ([request.URL.host isEqual:self.callBackURLHost]) {
//        
//        // Grab code from url.
//        NSString *urlStr = request.URL.absoluteString;
//        NSRange codeMatch = [urlStr rangeOfString:@"?code="];
//        NSString *code = [urlStr substringFromIndex:codeMatch.location + codeMatch.length];
//        NSLog(@"🐼 Got code %@", code);
//        
//        return NO;
//    }
    
    return YES;
}

@end
