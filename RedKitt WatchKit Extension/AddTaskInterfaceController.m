//
//  AddTaskInterfaceController.m
//  RedKitt
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "AddTaskInterfaceController.h"
#import "ChooseDateInterfaceController.h"


@interface AddTaskInterfaceController()

@end


@implementation AddTaskInterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark - Button

- (IBAction)addTaskButtonTap {
    NSArray *suggestions = [NSArray arrayWithObjects:@"Test Task", @"Test Task2", @"Test Task3", @"Test Task4", nil];
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModeAllowEmoji completion:^(NSArray *results) {
        [self createTaskWithName:results[0]];
    }];
}

- (void)createTaskWithName:(NSString *)taskName {
    NSLog(@"%@", taskName);
    [self presentControllerWithName:@"ChooseDate" context:taskName];
}


@end



