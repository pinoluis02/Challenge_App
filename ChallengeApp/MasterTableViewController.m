//
//  ChallengeTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "MasterTableViewController.h"
#import "RegularItemTableViewCell.h"
#import "ChallengeEvidenceTableViewCell.h"
#import "Challenge.h"
#import "ChallengesRootController.h"

@interface MasterTableViewController (){
    NSDictionary * items;    
    NSArray * mItemsArray;
}
@end

@implementation MasterTableViewController


-(NSString *)nibName{
    return @"MasterTableViewController";
}

-(NSArray*)itemsArray{
    return mItemsArray;
}

-(void)setItemsArray:(NSArray *) arr{
    mItemsArray = arr;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"RegularItemTableViewCell" bundle:nil];
    [self.tableView registerNib: cellNib forCellReuseIdentifier:@"RegularItemTableViewCell"];

    UINib *evidenceCellNib = [UINib nibWithNibName:@"ChallengeEvidenceTableViewCell" bundle:nil];
    [self.tableView registerNib: evidenceCellNib forCellReuseIdentifier:@"ChallengeEvidenceTableViewCell"];
    
    self.tableView.estimatedRowHeight = 68.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [[items valueForKey:@"challenges"] count];
    NSInteger count = [self.itemsArray count];
    return count;
//    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * msg = [[NSString alloc] initWithFormat:@"%@.%@ Subclasses need to overwrite this method", [self class], NSStringFromSelector(_cmd)];
    NSAssert(NO, msg);
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Challenge *item = self.itemsArray[indexPath.row];
    [self.coordinatorController coordinateTableItemSelection:item selectedByLongPress:NO];
}


@end
