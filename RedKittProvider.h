//
//  RedKittProvider.h
//  RedKitt
//
//  Created by Francisco Caro Diaz on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedKittProject.h"

@interface RedKittProvider : NSObject
#pragma mark - Fetching
- (void)fetchRBRedKittWithProject:(RedKittProject *)project
                      completion:(void(^)(NSArray *radars, NSError *error))completion;
- (void)fetchLastRBRedKittWithProject:(RedKittProject *)project isUrgent:(BOOL)urgent withLimit:(NSInteger)limit completion:(void(^)(NSArray *redKittTasks, NSError *error))completion;
@end
