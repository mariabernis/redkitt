//
//  ChooseDateInterfaceController.m
//  RedKitt
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "ChooseDateInterfaceController.h"


@interface ChooseDateInterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (nonatomic) CGFloat priority;

@end


@implementation ChooseDateInterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        self.titleLabel.text = context;
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

#pragma mark - Set Task Priority

- (IBAction)prioritySliderValueChanged:(float)value {
    
    self.priority = value;
    
}

#pragma mark - Create Task

- (IBAction)createTaskForToday {
    
}

- (IBAction)createTaskForTomorrow {
    
}

- (IBAction)createTaskForNextWeek {

}


@end



