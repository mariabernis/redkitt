//
//  RedKittProject.m
//  RedKitt
//
//  Created by Francisco Caro Diaz on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "RedKittProject.h"
#define KEY_IMPORTED_PROJECT @"openradar_to_redbooth_proj"
#define KEY_RB_PROJECT_ID    @"imported_proj_id"
#define KEY_RB_TASKLIST_ID   @"imported_tasklist_id"
#define KEY_RB_PROJECT_NAME  @"imported_proj_name"

@implementation RedKittProject
+ (RedKittProject *)importedProject
{
    RedKittProject *project = nil;
    NSDictionary *projInfo = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_IMPORTED_PROJECT];
    if (projInfo) {
        project = [[RedKittProject alloc] init];
        project.radarsProjectId = [[projInfo objectForKey:KEY_RB_PROJECT_ID] integerValue];
        project.radarsTaskListId = [[projInfo objectForKey:KEY_RB_TASKLIST_ID] integerValue];
    }
    return project;
}

+ (BOOL)saveImportedProject:(RedKittProject *)project
{
    if (project.radarsProjectId == 0) {
        return NO;
    }
    
    NSDictionary *projInfo = @{ KEY_RB_PROJECT_ID  : @(project.radarsProjectId),
                                KEY_RB_TASKLIST_ID : @(project.radarsTaskListId)
                                };
    [[NSUserDefaults standardUserDefaults] setObject:projInfo forKey:KEY_IMPORTED_PROJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}
@end
