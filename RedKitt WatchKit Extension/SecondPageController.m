//
//  SecondPageController.m
//  RedKitt
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "SecondPageController.h"


@interface SecondPageController()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *taskIconImageView;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *taskDate;

#warning Complete!!
//@property (nonatomic, strong) TaskObject *task;

@end


@implementation SecondPageController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
    
    [self populateScreen];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}


#pragma mark - Prepare View Items

- (void)populateScreen {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @" dd MMM";
 
#warning Ale method to get the task
    //self.task = METODO ALESANDRO PARA SACAR EL OBJETO TASK
    
#warning Change @"taskName" with self.task.name and [NSDate date] with self.task.date
    
    self.taskNameLabel.text = @"taskName";
    self.taskDate.text = [[formatter stringFromDate:[NSDate date]] uppercaseString];
}

#pragma mark - Buttons

- (IBAction)markTaskAsCompleted {
    [self presentControllerWithName:@"Done" context:nil];
    [self performSelector:@selector(dismissController) withObject:nil afterDelay:2];
}

- (IBAction)changeStatusButtonTap {
    //Passar el self.task como context
#warning Complete!!
    
    
    [self presentControllerWithName:@"ChangeStatus" context:nil];
}


@end



