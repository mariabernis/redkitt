//
//  RedKittTaskParser.m
//  RedKitt
//
//  Created by Francisco Caro Diaz on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "RedKittTaskParser.h"
#define MATCH_STR @"date://"
#define DATE_FORMAT @"dd-MM-yyyy"
#define TASK_ID @"id"
#define TASK_NAME @"name"
#define TASK_DESCRIPTION @"description"
#define TASK_STATUS @"status"
#define TASK_URGENT @"urgent"
#define TASK_DATE @"due_on"
#define LIMIT_ARRAY @"due_on"

@implementation RedKittTaskParser

#pragma mark - Redbooth
#pragma mark fetch

+ (NSArray *)redKittLastTasksWithRBArray:(NSArray *)array urgent:(BOOL)isUrgent withSize:(NSInteger)limit
{
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RedKittTask *item = [self redKittTaskWithRBInfo:(NSDictionary *)obj];
        if (isUrgent && item.taskUrgent || !isUrgent) {
            if ([self task:item isForDate:today]) {
                [items addObject:item];
            }
        }
    }];
    
    NSArray *sortedList = [items sortedArrayUsingFunction:Sort_Items_Comparer context:(__bridge void *)(self)];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i =0; i<limit; i++) {
        [result addObject:sortedList[i]];
    }
    
    return [NSArray arrayWithArray:result];
}

NSInteger Sort_Items_Comparer(id id1, id id2, void *context)
{
    // Sort Function
    RedKittTask *redKittTask1 = (RedKittTask*)id1;
    RedKittTask *redKittTask2 = (RedKittTask*)id2;
    
    
    return ([redKittTask1.taskDate compare:redKittTask2.taskDate]);
}

+ (NSArray *)redKittTasksWithRBArray:(NSArray *)array urgent:(BOOL)isUrgent
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RedKittTask *item = [self redKittTaskWithRBInfo:(NSDictionary *)obj];
        if (isUrgent && item.taskUrgent || !isUrgent) {
            [items addObject:item];
        }
    }];
    
    NSArray *sortedList = [items sortedArrayUsingFunction:Sort_Items_Comparer context:(__bridge void *)(self)];
    
    return [NSArray arrayWithArray:sortedList];
}

+ (NSArray *)redKittTasksWithRBArray:(NSArray *)array
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        RedKittTask *item = [self redKittTaskWithRBInfo:(NSDictionary *)obj];
        [items addObject:item];
    }];
    
    NSArray *sortedList = [items sortedArrayUsingFunction:Sort_Items_Comparer context:(__bridge void *)(self)];
    
    return [NSArray arrayWithArray:sortedList];
}

+ (RedKittTask *)redKittTaskWithRBInfo:(NSDictionary *)info
{
    RedKittTask *item = [[RadarTask alloc] init];
    item.taskId = [[info objectForKey:TASK_ID] integerValue];
    item.taskTitle = [info objectForKey:TASK_NAME];
    item.taskDescription = [info objectForKey:TASK_DESCRIPTION];
    item.taskStatus = [info objectForKey:TASK_STATUS];
    item.taskUrgent = [info objectForKey:TASK_URGENT];
    //item.taskDate = [self retrieveDateFromDescription:item.radarDescription];
    item.taskDate = [info objectForKey:TASK_DATE];
    return item;
}

+ (NSDate *)retrieveDateFromDescription:(NSString *)description
{
    NSRange matchDate = [description rangeOfString:MATCH_STR];
    if (matchDate.length == NSNotFound) {
        return nil;
    }
    NSString *rdar = [description substringToIndex:matchDate.length + 8];
    NSString *dateString = [rdar substringFromIndex:matchDate.length];
    
    //NSString *dateString = @"01-02-2010";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    
    return num;
}

+ (NSDictionary *)rbGETTasksParametersWithProject:(RedKittProject *)project
{
    // Add per_page to max value, otherwise it will page at 30.
    NSDictionary *taskParams = @{ @"project_id"  :@(project.redKittProjectId),
                                  @"task_list_id":@(project.redKittTaskListId),
                                  @"per_page"    :@1000
                                  };
    return taskParams;
}

+ (BOOL)task:(RedKittTask *)item isForDate:(NSDateComponents *)today
{
    // Here we check if the task date is today
    
    BOOL res = false;
    NSDateComponents *taskDate = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:item.taskDate];
    
    if([today day] == [taskDate day] &&
       [today month] == [taskDate month] &&
       [today year] == [taskDate year] &&
       [today era] == [taskDate era]) {
        res = false;
    }
    return res;
}
@end
