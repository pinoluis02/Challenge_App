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

@class CustomRootController;


@interface CustomTableViewController : UITableViewController <UITableViewDelegate, UIGestureRecognizerDelegate>
@property CustomRootController * coordinatorController;
@property NSArray * itemsArray;
@end
