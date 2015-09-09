//
//  ChallengeTableViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengeDao.h"

@interface ChallengeTableViewController : UITableViewController <ChallengeDelegate>

@property ChallengeDao * challengeDao;
@property NSArray * challengesArray;

@end
