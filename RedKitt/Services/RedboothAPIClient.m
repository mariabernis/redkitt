//
//  RedboothAPIClient.m
//  TrackMyRadars
//
//  Created by Maria Bernis on 03/12/14.
//  Copyright (c) 2014 mariabernis. All rights reserved.
//

#import "RedboothAPIClient.h"
#import "MBCheck.h"

// Constants
#define RB_API_BASE_URL     @"https://redbooth.com"
#define RB_API_CLIENT       @"6ecf15fad3d945360e87e91943f6223e00e0eaa1285a53ed4e59ec6bb915ff94"
#define RB_API_SECRET       @"6bc01b8e06c61272c6435c5a05f29bf87714a6d2b1a80e5b5374cb9485408d4d"
#define RB_API_CALLBACK_URL @"http://mariabernis.github.io/redkitt.html"

#define KEY_ACCESS_TOKEN    @"access_token"
#define KEY_TOKEN_EXPIRES   @"access_token_expires"
#define KEY_REFRESH_TOKEN   @"refresh_token"


@interface RedboothAPIClient ()
@property (nonatomic, strong) AFOAuthCredential *credential;
@end

@implementation RedboothAPIClient

#pragma mark - Singleton instance
+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:RB_API_BASE_URL] clientID:RB_API_CLIENT secret:RB_API_SECRET];
    });
    return sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url clientID:(NSString *)clientID secret:(NSString *)secret
{
    self = [super initWithBaseURL:url clientID:clientID secret:secret];
    if (self) {
        BOOL isFirstLaunch = [MBCheck isFirstTimeAppLaunch];
        if (isFirstLaunch) {
            // Clear credentials in keychain
            [AFOAuthCredential deleteCredentialWithIdentifier:self.serviceProviderIdentifier];
            return self;
        }
        
        AFOAuthCredential *savedCredential = [AFOAuthCredential retrieveCredentialWithIdentifier:self.serviceProviderIdentifier];
        if (savedCredential) {
            self.credential = savedCredential;
            [self setAuthorizationHeaderWithCredential:savedCredential];
        }
    }
    return self;
}

- (void)setCredential:(AFOAuthCredential *)credential
{
    _credential = credential;
    _authorised = credential ? YES : NO;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    void (^realSuccessBlock)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        
       [super GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
           if(success) {
               success(task, responseObject);
           }
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           if(failure) {
               failure(task, error);
           }
       }];
    };

    [self refreshTokenIfNeededWithSuccess:realSuccessBlock failure:failure];
    return nil;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    void (^realSuccessBlock)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject) {
        
        [super POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            if(success) {
                success(task, responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(failure) {
                failure(task, error);
            }
        }];
    };
    
    [self refreshTokenIfNeededWithSuccess:realSuccessBlock failure:failure];
    return nil;
}


#pragma mark - Authentication
- (void)refreshTokenIfNeededWithSuccess:(void (^)(NSURLSessionDataTask *, id))success
                                failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if (self.credential == nil) {
        if (failure) {
            // Failed to get credentials
        }
        return;
    }
    if (!self.credential.isExpired) {
        if (success) {
            success(nil, nil);
        }
        return;
    }
    
    NSLog(@"🐼 Refresing token...");
    [self authenticateUsingOAuthWithPath:@"/oauth2/token"
                            refreshToken:self.credential.refreshToken
                                 success:^(AFOAuthCredential *credential) {
                                     
                                     NSLog(@"🐼 Refresing token SUCCEDED");
                                     [AFOAuthCredential storeCredential:credential
                                                         withIdentifier:self.serviceProviderIdentifier];
                                     self.credential = credential;
                                     
                                     if (success) {
                                         success(nil, nil);
                                     }
                                 } failure:^(NSError *error) {
                                     
                                     NSLog(@"😱 Refresing token FAILED");
                                     self.credential = nil;
                                     [AFOAuthCredential deleteCredentialWithIdentifier:self.serviceProviderIdentifier];
                                     
                                     if (failure) {
                                         failure(nil, error);
                                     }
                                 }];
}

- (void)launchAuthorizationFlow
{
    NSString *baseAuthURLStr = @"https://redbooth.com/oauth2/authorize";
    NSString *params = [NSString stringWithFormat:@"client_id=%@&redirect_uri=%@&response_type=code", RB_API_CLIENT, RB_API_CALLBACK_URL];
    NSString *scapedParams = [params stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *authURLStr = [NSString stringWithFormat:@"%@?%@", baseAuthURLStr, scapedParams];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURLStr]];
}

- (void)authoriseWithCode:(NSString *)code completion:(void(^)(NSError *error))completion
{
    [self authenticateUsingOAuthWithPath:@"/oauth2/token"
                                    code:code
                             redirectURI:RB_API_CALLBACK_URL
                                 success:^(AFOAuthCredential *credential) {
                                     
                                     [AFOAuthCredential storeCredential:credential
                                                         withIdentifier:self.serviceProviderIdentifier];
                                     self.credential = credential;
                                     
                                     NSLog(@"Login succeded");
                                     if (completion) {
                                         completion(nil);
                                     }
                                 }
                                 failure:^(NSError *error) {
                                     
                                     NSLog(@"Login failed");
                                     self.credential = nil;
                                     [AFOAuthCredential deleteCredentialWithIdentifier:self.serviceProviderIdentifier];
                                     
                                     if (completion) {
                                         completion(error);
                                     }
                                 }];
}


@end
