//
//  RedKittTaskParser.h
//  RedKitt
//
//  Created by Francisco Caro Diaz on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedKittProject.h"
#import "RedKittTask.h"

@class RedKittTask;
@interface RedKittTaskParser : NSObject
#pragma mark - Redbooth
// Redbooth fetch
+ (NSArray *)redKittTasksWithRBArray:(NSArray *)array;
+ (NSArray *)redKittTasksWithRBArray:(NSArray *)array urgent:(BOOL)isUrgent;
+ (NSArray *)redKittLastTasksWithRBArray:(NSArray *)array urgent:(BOOL)isUrgent withSize:(NSInteger)limit;
+ (RedKittTask *)redKittTaskWithRBInfo:(NSDictionary *)info;
+ (NSDate *)retrieveDateFromDescription:(NSString *)description;
+ (NSDictionary *)rbGETTasksParametersWithProject:(RedKittProject *)project;
@end
