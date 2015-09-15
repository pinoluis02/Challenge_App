//
//  SendChallengeRequestViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendChallengeViewController.h"

@interface SendChallengeContainerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView * contentView;
@property (weak, nonatomic) IBOutlet UIView * buttonView;
@property (weak, nonatomic) IBOutlet UIView * tableView;

@property SendChallengeViewController * tableViewController;

- (IBAction)sendRequestButton:(UIButton *)sender;

@end
