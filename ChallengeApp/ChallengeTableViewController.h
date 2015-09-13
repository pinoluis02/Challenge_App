//
//  ChallengeTableViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengeDao.h"

@class CustomRootController;
typedef NS_ENUM(NSUInteger, ChallengeTableViewControllerContent) {
    //    the integer values must have a correspondence with the tab items tags on NestedTabViewController.
    AllChallenges = 6,
    PopularChallenges = 7,
    RecentChallenges = 8,
    SearchChallenges = 9,
    UserIncompleteChallenges = 2,
    UserChallengeInvitation = 3,
    UserCompleteChallenges = 4
};

@interface ChallengeTableViewController : UITableViewController <ChallengeDelegate, UITableViewDelegate, UIGestureRecognizerDelegate>
@property ChallengeDao * challengeDao;
@property NSArray * challengesArray;
@property ChallengeTableViewControllerContent contentType;
@property CustomRootController * coordinatorController;
@end
