//
//  RedKittProvider.m
//  RedKitt
//
//  Created by Francisco Caro Diaz on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "RedKittProvider.h"
#import "RedKittTaskParser.h"
#import "RedboothAPIClient.h"

@implementation RedKittProvider
- (void)fetchRBRedKittWithProject:(RedKittProject *)project
                      completion:(void(^)(NSArray *redKittTasks, NSError *error))completion
{
    RedboothAPIClient *redboothClient = [RedboothAPIClient sharedInstance];
    
    NSDictionary *tasksParams = [RedKittTaskParser rbGETTasksParametersWithProject:project];
    [redboothClient GET:RB_PATH_TASK
             parameters:tasksParams
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    NSArray *results = (NSArray *)responseObject;
                    NSArray *redKittTasks = [RedKittTaskParser redKittTasksWithRBArray:results];
                    if (completion) {
                        completion(redKittTasks, nil);
                    }
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                    NSLog(@"😱 Error fetching rb tasks: %@", error);
                    if (completion) {
                        completion(nil, error);
                    }
                }];
}

- (void)fetchLastRBRedKittWithProject:(RedKittProject *)project isUrgent:(BOOL)urgent withLimit:(NSInteger)limit completion:(void(^)(NSArray *redKittTasks, NSError *error))completion
{
    RedboothAPIClient *redboothClient = [RedboothAPIClient sharedInstance];
    
    NSDictionary *tasksParams = [RedKittTaskParser rbGETTasksParametersWithProject:project];
    [redboothClient GET:RB_PATH_TASK
             parameters:tasksParams
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    NSArray *results = (NSArray *)responseObject;
                    NSArray *redKittTasks = [RedKittTaskParser redKittLastTasksWithRBArray:results urgent:urgent withSize:limit];
                    if (completion) {
                        completion(redKittTasks, nil);
                    }
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                    NSLog(@"😱 Error fetching rb tasks: %@", error);
                    if (completion) {
                        completion(nil, error);
                    }
                }];
}
@end
