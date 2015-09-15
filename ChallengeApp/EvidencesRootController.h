//
//  EvidencesRootController.h
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MasterRootController.h"
#import "EvidencesTableViewController.h"
#import "ChallengeDao.h"

@interface EvidencesRootController : MasterRootController <UIGestureRecognizerDelegate, ChallengeDelegate>
@property ChallengeDao * challengeDao;
@property NSArray * evidenceArray;
@end
