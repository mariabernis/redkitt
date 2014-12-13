//
//  StartViewController.m
//  RedKitt
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "StartViewController.h"
#import "RedboothAPIClient.h"
#import "WebViewController.h"
#import "UIButton+RedKitt.h"
#import "RedKittTaskParser.h"

@interface StartViewController ()<WebViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loginButton redboothLoginStyle];
    [self.loginButton setTitle:@"Connect to Redbooth" forState:UIControlStateNormal];
    [self.loginButton setTitle:@"Logged in" forState:UIControlStateDisabled];
    if ([RedboothAPIClient sharedInstance].isAuthorised) {
        [self loadTasks];
        self.loginButton.enabled = NO;
    } else {
        self.loginButton.enabled = YES;
    }
//    self.loginButton.enabled = ![RedboothAPIClient sharedInstance].isAuthorised;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)loginButtonPressed:(id)sender {
    
    NSURL *authURL = [[RedboothAPIClient sharedInstance] authorizationURL];
    WebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewScene"];
    webView.delegate = self;
    webView.initalURL = authURL;
    [self presentViewController:webView animated:YES completion:nil];
}

- (void)loadTasks {
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"task_lists" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSError *error = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSArray *parsedArray = [RedKittTaskParser redKittTasksWithRBArray:jsonArray];
}

#pragma mark - WebViewControllerDelegate
- (BOOL)webViewController:(WebViewController *)webVC shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Auth logic here
    NSURL *callbackURL = [[RedboothAPIClient sharedInstance] callbackURL];
    if ([request.URL.host isEqual:callbackURL.host]) {
        
        // Grab code from url.
        NSString *urlStr = request.URL.absoluteString;
        NSRange codeMatch = [urlStr rangeOfString:@"?code="];
        NSString *code = [urlStr substringFromIndex:codeMatch.location + codeMatch.length];
        NSLog(@"🐼 Got code %@", code);
        
        if (code.length == 0) {
            return YES;
        }
        [webVC dismissViewControllerAnimated:YES completion:^{
            [[RedboothAPIClient sharedInstance] authoriseWithCode:code completion:^(NSError *error) {
                
                self.loginButton.enabled = error != nil;
                if (error) {
                    NSLog(@"😱 Auth error: %@", error);
                    return;
                }
                
                [self loadTasks];
            }];
        }];
        
        return NO;
    }
    
    return YES;
}

@end
