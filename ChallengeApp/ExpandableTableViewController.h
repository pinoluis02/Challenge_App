//
//  ExpandableTableViewController.h
//  ExpandableTable
//
//  Created by Manpreet Singh on 06/12/13.
//  Copyright (c) 2013 Manpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomRootController;

@protocol ExpandableTableViewContainer <NSObject>
-(void)respondToExpandableTableHeightChange:(CGFloat)height;
@end

@interface ExpandableTableViewController : UITableViewController

@property(nonatomic,strong) NSArray *items;
@property (nonatomic, retain) NSArray *itemsInTable;
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property CustomRootController * coordinatorController;
@end
