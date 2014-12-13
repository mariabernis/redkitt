//
//  InterfaceController.m
//  RedKitt WatchKit Extension
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceImage *taskIconImageView;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *taskTitleLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *taskDate;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self populateScreen];

    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}


#pragma mark - Prepare View Items

- (void)populateScreen {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd MMM - HH:mm";
    
    self.taskTitleLabel.text = @"taskTitle";
    self.taskNameLabel.text = @"taskName";
    self.taskDate.text = [formatter stringFromDate:[NSDate date]];
}

@end



