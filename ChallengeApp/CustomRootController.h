//
//  UserContextPseudoTabController.h
//  ChallengeApp
//
//  Created by MCS on 9/7/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableTableViewController.h"
#import "CustomTableViewController.h"
#import "Challenge.h"
#import "Evidence.h"

@class Challenge;

@interface CustomRootController : UIViewController <UITabBarControllerDelegate>
@property BOOL isFirstControllerInNavigation;
@property (strong, nonatomic) NSString *idLoginUser;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commandMenuViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *commandMenuView;
@property (weak, nonatomic) IBOutlet UIView *tableContentView;
@property (weak, nonatomic) IBOutlet UIView *mainItemView;
@property CustomTableViewController * tableContentController;
@property ExpandableTableViewController * commandMenuController;
@property UIViewController * mainItemController;
@property id selectedItem;
-(void)setUpMenuContent;
-(void)setUpMainViewContent;
-(void)setUpTableContent;
-(void)coordinateMenuHeightChange:(CGFloat)height;
-(void)coordinateMenuItemSelection:(NSString *)command;
-(void)coordinateTableItemSelection:(NSObject *)item           selectedByLongPress:(BOOL)longPress;
-(void)coordinateMainItemSelection:(NSObject *)item            selectedByLongPress:(BOOL)longPress;

+(NSArray *)loadMenuItemsForEvidence;
+(NSArray *)loadMenuItemsForChallengeItem:(Challenge *)item;
@end
