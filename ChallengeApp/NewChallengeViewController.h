//
//  NewChallengeViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/8/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewChallengeViewController : UIViewController
- (IBAction)makeDonationButton:(UISwitch *)sender;

@property (strong, nonatomic) IBOutlet UIButton *createChallengeButton;

- (IBAction)addMediaButton:(id)sender;
@end
