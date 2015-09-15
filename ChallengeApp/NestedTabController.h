//
//  UserContextPseudoTabController.h
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChallengesTableViewController.h"

typedef NS_ENUM(NSUInteger, TabBarOptions) {
    GlobalOptionsTabBarType = 1,
    UserOptionsTabBarType = 2
};


@interface NestedTabController : UIViewController <UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *globalOptionsTabBarVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet UITabBar *globalOptionsTabBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userOptionsTabBarVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet UITabBar *userOptionsTabBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewVerticalTopSpaceConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewVerticalBottonSpaceConstraint;
@property (strong, nonatomic) NSString *idLoginUser;
@property TabBarOptions tabBarType;
@end
