//
//  OriginalItemTableViewCell.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengeTableViewCellFull.h"

@implementation ChallengeTableViewCellFull

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
//    http://roadfiresoftware.com/2015/05/how-to-size-a-table-header-view-using-auto-layout-in-interface-builder/
    [super layoutSubviews];
//    self.challengeDescription.preferredMaxLayoutWidth = self.challengeDescription.bounds.size.width;
}

@end
