//
//  UserContextPseudoTabController.h
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TabBarOptions) {
    GlobalOptionsTabBarType = 1,
    UserOptionsTabBarType = 2
};


@interface GlobalContextPseudoTabController : UIViewController <UITabBarControllerDelegate>
@property (nonatomic) TabBarOptions tabBarType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *globalOptionsTabBarVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet UITabBar *globalOptionsTabBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userOptionsTabBarVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet UITabBar *userOptionsTabBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewVerticalSpaceConstraint;

@end
