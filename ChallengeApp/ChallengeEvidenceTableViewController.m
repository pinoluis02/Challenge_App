//
//  ChallengeTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengeEvidenceTableViewController.h"
#import "RegularItemTableViewCell.h"
#import "NSDate+Utils.h"

@interface ChallengeEvidenceTableViewController (){
    NSDictionary * items;
}
@end

@implementation ChallengeEvidenceTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    UINib *originalChallengeNib = [UINib nibWithNibName:@"RegularItemTableViewCell" bundle:nil];
        [self.tableView registerNib: originalChallengeNib forCellReuseIdentifier:@"RegularItemTableViewCell"];
    
    UINib *evidenceChallengeNib = [UINib nibWithNibName:@"ChallengeEvidenceTableViewCell" bundle:nil];
    [self.tableView registerNib: evidenceChallengeNib forCellReuseIdentifier:@"ChallengeEvidenceTableViewCell"];
    
    self.tableView.rowHeight = 255;

 
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
//    return [[items valueForKey:@"challenges"] count];
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegularItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegularItemTableViewCell" forIndexPath:indexPath];
    
    NSDictionary * item = [items valueForKey:@"challenges"][indexPath.row];
    cell.title = [item objectForKey:@"title"];
    cell.challengeDescription = [item objectForKey:@"description"];
    cell.author.text = @"UserXXII";
    NSDate * today = [NSDate date];
    cell.pubDate.text = [NSString stringWithFormat:@"%@", [today shortFormattedDateString]];
    UIImage * image = [UIImage imageNamed:@"homemovies"];
    [cell.thumbnail setImage:image];
    return cell;
}






@end
