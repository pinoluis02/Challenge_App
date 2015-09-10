//
//  ChallengeEvidenceTableViewCell.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChallengeEvidenceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorUsername;
@property (weak, nonatomic) IBOutlet UILabel *creationDate;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *evidenceDescription;

@end
