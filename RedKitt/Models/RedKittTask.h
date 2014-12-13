//
//  RedKittTask.h
//  RedKitt
//
//  Created by Francisco Caro Diaz on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedKittTask : NSObject
@property (nonatomic, assign) NSInteger taskId;
@property (nonatomic, strong) NSDate *taskDate;
@property (nonatomic, strong) NSString *taskTitle;
@property (nonatomic, strong) NSString *taskDescription;
@property (nonatomic, strong) NSString *taskStatus;
@property BOOL *taskUrgent;
@end
