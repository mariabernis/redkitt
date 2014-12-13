//
//  ChangeStatusInterfaceController.m
//  RedKitt
//
//  Created by Pol Quintana on 13/12/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import "ChangeStatusInterfaceController.h"


@interface ChangeStatusInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceButton *rejectButtonOutlet;
@property (nonatomic) BOOL rejected;

@end


@implementation ChangeStatusInterfaceController

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
    
    [self changeRejectButtonName];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

#pragma mark - Button actions

- (IBAction)completeButtonTap {
    
}

- (IBAction)holdButtonTap {
    
}

- (IBAction)rejectButtonTap {
    
}

#pragma mark - Button names 

- (void)changeRejectButtonName {
    
    if (self.rejectButtonOutlet) {
        [self.rejectButtonOutlet setTitle:@"Reopen"];
    }
    else {
        [self.rejectButtonOutlet setTitle:@"Reject"];
    }
}

@end



