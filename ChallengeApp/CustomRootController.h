//
//  UserContextPseudoTabController.h
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableTableViewController.h"
#import "ChallengeTableViewController.h"

@class Challenge;
typedef NS_ENUM(NSUInteger, TabBarOptions) {
    GlobalOptionsTabBarType = 1,
    UserOptionsTabBarType = 2
};


@interface CustomRootController : UIViewController <UITabBarControllerDelegate>
@property (nonatomic) TabBarOptions tabBarType;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *globalOptionsTabBarVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet UITabBar *globalOptionsTabBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userOptionsTabBarVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet UITabBar *userOptionsTabBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewVerticalTopSpaceConstraint;
@property (strong, nonatomic) NSString *idLoginUser;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewVerticalBottonSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commandMenuViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *commandMenuView;
@property (weak, nonatomic) IBOutlet UIView *tableContentView;
@property (weak, nonatomic) IBOutlet UIView *mainItemView;
-(void)coordinateMainContentViewHeightWithMenuHeight:(CGFloat)height;
+(NSArray *)loadMenuItemsForChallengeItem:(Challenge *)item;
-(void)coordinateItemSelection:(NSObject *)item
           selectedByLongPress:(BOOL)longPress;
-(void)respondToMenuItemSelection:(NSString *)command;
@property int userId;

@property ChallengeTableViewController * tableContentController;
@property ExpandableTableViewController * commandMenuController;
@property UIViewController * mainItemController;
@property Challenge * selectedItem;

@end
