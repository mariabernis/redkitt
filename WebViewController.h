//
//  WebViewController.h
//  RedKitt
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WebViewController;
@protocol WebViewControllerDelegate <NSObject>
@required

@optional
- (BOOL)webViewController:(WebViewController *)webVC shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end

@interface WebViewController : UIViewController

@property (nonatomic, weak) id<WebViewControllerDelegate>delegate;
@property (nonatomic, strong) NSURL *initalURL;
@property (nonatomic, strong) NSString *callBackURLHost;

@end
