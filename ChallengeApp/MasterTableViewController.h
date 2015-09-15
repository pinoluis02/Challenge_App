//
//  ChallengeTableViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Evidence.h"
#import "Challenge.h"

@class MasterRootController;

@interface MasterTableViewController : UITableViewController <UITableViewDelegate, UIGestureRecognizerDelegate>
@property MasterRootController * coordinatorController;
@property NSArray * itemsArray;
@end
