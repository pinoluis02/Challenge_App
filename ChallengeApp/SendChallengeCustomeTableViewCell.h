//
//  SendChallengeCustomeTableViewCell.h
//  ChallengeApp
//
//  Created by MCS on 9/14/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendChallengeCustomeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userURLimageView;

@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;
@property (strong, nonatomic) IBOutlet UILabel *middleLabel;

@property (strong, nonatomic) IBOutlet UIButton *selectFriendButton;

- (IBAction)selectFriendButton:(id)sender;

@end
