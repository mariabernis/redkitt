//
//  RedboothAPIClient.h
//  TrackMyRadars
//
//  Created by Maria Bernis on 03/12/14.
//  Copyright (c) 2014 mariabernis. All rights reserved.
//


#import <GROAuth2SessionManager/GROAuth2SessionManager.h>

#define RB_PATH_ORGANIZATION @"api/3/organizations"
#define RB_PATH_PROJECT      @"api/3/projects"
#define RB_PATH_TASKLIST     @"api/3/task_lists"
#define RB_PATH_TASK         @"api/3/tasks"


typedef void (^RedboothRequestCompletion)(id responseObject, NSError *error);

@class AFOAuthCredential;
@interface RedboothAPIClient : GROAuth2SessionManager

@property (nonatomic, readonly, getter=isAuthorised) BOOL authorised;

// Singleton instance
+ (instancetype)sharedInstance;

#pragma mark - Authentication
- (void)launchAuthorizationFlow;
- (NSURL *)authorizationURL;
- (NSURL *)callbackURL;
- (void)authoriseWithCode:(NSString *)code completion:(void(^)(NSError *error))completion;

@end
