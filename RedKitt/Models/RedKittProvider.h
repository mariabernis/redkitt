//
//  RedKittProvider.h
//  RedKitt
//
//  Created by Francisco Caro Diaz on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "RedKittProject.h"

@interface RedKittProvider : NSObject
#pragma mark - Fetching
- (void)fetchRedKittTasksWithCompletion:(void(^)(NSArray *tasks, NSError *error))completion;
- (void)fetchLastRedKittWithLimit:(NSInteger)limit isUrgent:(BOOL)urgent completion:(void(^)(NSArray *redKittTasks, NSError *error))completion;
@end
