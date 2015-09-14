//
//  SendChallengeCustomeTableViewCell.m
//  ChallengeApp
//
//  Created by MCS on 9/14/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "SendChallengeCustomeTableViewCell.h"

@implementation SendChallengeCustomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)selectFriendButton:(id)sender
{

    NSLog(@"Button Pressend from Custome Cell");
    
    if ([self.selectFriendButton isSelected])
    {
        [self.selectFriendButton setImage:[UIImage imageNamed:@"RoundCheck.png"] forState:UIControlStateSelected];
    }
    else
    {
        [self.selectFriendButton setImage:[UIImage imageNamed:@"RoundUnCheck.png"] forState:UIControlStateNormal];
    }
    
    
}


@end
