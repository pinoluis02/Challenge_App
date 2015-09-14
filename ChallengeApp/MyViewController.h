//
//  MyViewController.h
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "ChallengeDao.h"
#import "FbSingleton.h"
#import "Reachability.h"


@interface MyViewController : UIViewController <FBSDKLoginButtonDelegate, ChallengeDelegate, FBclassDelegate>

- (IBAction)shareLink:(FBSDKShareButton *)sender;

@property (strong, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property ChallengeDao *challengeDao;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end