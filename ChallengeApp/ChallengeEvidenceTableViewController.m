//
//  ChallengeTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengeEvidenceTableViewController.h"
#import "RegularItemTableViewCell.h"
#import "ChallengeEvidenceTableViewCell.h"
#import "ChallengeCommentsTableViewController.h"
#import "NSDate+Utils.h"

@interface ChallengeEvidenceTableViewController (){
    NSMutableDictionary * originalChallenge;
    NSArray * evidenceArray;
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
    [self setDemoData];
    [self.tableView reloadData];

-(void)setDemoData{
    
    NSMutableDictionary * itemOne = [NSMutableDictionary dictionary];
    NSMutableDictionary * itemTwo = [NSMutableDictionary dictionary];
    
    [itemOne setValue:@1 forKey:@"id"];
    [itemOne setValue:@"Mauris Rhoncus" forKey:@"authorUserName"];
    [itemOne setValue:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enm ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." forKey:@"evidenceDescription"];
    [itemOne setValue:[NSDate date] forKey:@"creationDate"];
    
    [itemOne setValue:@2 forKey:@"id"];
    [itemOne setValue:@"UserXXII" forKey:@"authorUserName"];
    [itemOne setValue:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enm ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." forKey:@"evidenceDescription"];
    [itemOne setValue:[NSDate date] forKey:@"creationDate"];
    
    evidenceArray = @[itemOne, itemTwo];
    
    originalChallenge = [NSMutableDictionary dictionary];
    [originalChallenge setValue:@1 forKey:@"id"];
    [originalChallenge setValue:@"mauris, rhoncus id," forKey:@"title"];
    [originalChallenge setValue:@"Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet" forKey:@"description"];
    [originalChallenge setValue:@"image" forKey:@"type"];
    [originalChallenge setValue:@"http://i.blogs.es/e61022/bit-0-1/650_1200.jpg" forKey:@"url"];
    
}

-(void)setDemoData{

    NSMutableDictionary * itemOne = [NSMutableDictionary dictionary];
    NSMutableDictionary * itemTwo = [NSMutableDictionary dictionary];
    
    [itemOne setValue:@1 forKey:@"id"];
    [itemOne setValue:@"Mauris Rhoncus" forKey:@"authorUserName"];
    [itemOne setValue:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enm ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." forKey:@"evidenceDescription"];
    [itemOne setValue:[NSDate date] forKey:@"creationDate"];
    
    [itemOne setValue:@2 forKey:@"id"];
    [itemOne setValue:@"UserXXII" forKey:@"authorUserName"];
    [itemOne setValue:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enm ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda." forKey:@"evidenceDescription"];
    [itemOne setValue:[NSDate date] forKey:@"creationDate"];
    
    evidenceArray = @[itemOne, itemTwo];
    
    originalChallenge = [NSMutableDictionary dictionary];
    [originalChallenge setValue:@1 forKey:@"id"];
    [originalChallenge setValue:@"mauris, rhoncus id," forKey:@"title"];
    [originalChallenge setValue:@"Morbi accumsan laoreet ipsum. Curabitur consequat, lectus sit amet" forKey:@"description"];
    [originalChallenge setValue:@"image" forKey:@"type"];
    [originalChallenge setValue:@"http://i.blogs.es/e61022/bit-0-1/650_1200.jpg" forKey:@"url"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1 + [evidenceArray count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //    return [[items valueForKey:@"challenges"] count];
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if(indexPath.row == 0){
//    The first cell is the original challenge and has different style than the rest of the rows.
        RegularItemTableViewCell *originalChallengeCell = [tableView dequeueReusableCellWithIdentifier:@"RegularItemTableViewCell" forIndexPath:indexPath];
        
        NSDictionary * item = originalChallenge;
        originalChallengeCell.title = [item objectForKey:@"title"];
        originalChallengeCell.challengeDescription = [item objectForKey:@"description"];
        originalChallengeCell.author.text = @"UserXXII";
        NSDate * date = [NSDate date];
        originalChallengeCell.pubDate.text = [NSString stringWithFormat:@"%@", [date shortFormattedDateString]];
        UIImage * image = [UIImage imageNamed:@"homemovies"];
        [originalChallengeCell.thumbnail setImage:image];
        
        cell = originalChallengeCell;
    }else{
        ChallengeEvidenceTableViewCell *evidenceCell = [tableView dequeueReusableCellWithIdentifier:@"ChallengeEvidenceTableViewCell" forIndexPath:indexPath];
        
        NSDictionary * item = evidenceArray[indexPath.row];
        evidenceCell.evidenceDescription = [item objectForKey:@"evidenceDescription"];
        evidenceCell.authorUsername.text = [item objectForKey:@"authorUsername"];
        NSDate * today = [item objectForKey:@"creationDate"];
        evidenceCell.creationDate.text = [NSString stringWithFormat:@"%@", [today shortFormattedDateString]];
        UIImage * image = [UIImage imageNamed:@"homemovies"];
        [evidenceCell.thumbnail setImage:image];
        
        cell = evidenceCell;
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChallengeCommentsTableViewController * vc = [ChallengeCommentsTableViewController new];
    vc.challengeId = 99;
    vc.userId = 99;
    [self.navigationController pushViewController:vc animated:true];
    
}





@end
