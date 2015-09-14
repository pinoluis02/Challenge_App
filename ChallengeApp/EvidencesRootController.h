//
//  EvidencesRootController.h
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "customRootController.h"
#import "EvidencesTableViewController.h"

@interface EvidencesRootController : CustomRootController <UIGestureRecognizerDelegate>

@property Challenge * mainItem;
-(void)setUpMenuContent;
-(void)setUpMainViewContent;
-(void)setUpTableContent;
-(void)coordinateMenuHeightChange:(CGFloat)height;
-(void)coordinateTableItemSelection:(Evidence *)item            selectedByLongPress:(BOOL)longPress;
-(void)coordinateMainItemSelection:(Challenge *)item            selectedByLongPress:(BOOL)longPress;
@property NSArray * evidencesArray;
@end
