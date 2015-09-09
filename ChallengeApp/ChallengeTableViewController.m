//
//  ChallengeTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengeTableViewController.h"

@interface ChallengeTableViewController ()

@end

@implementation ChallengeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    [self.challengeDao getAllChallenges];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"articleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Challenge * challenge = [self.challengesArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = challenge.name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)  didFinishGetAllChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetAllChallengesWithResult count = %ld", [resultArray count]);
    
    self.challengesArray = resultArray;
    
    
}

-(void)  didFinishGetLastChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetLastChallengesWithResult count = %ld", [resultArray count]);
    
}

-(void)  didFinishGetPopularChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetPopularChallengesWithResult count = %ld", [resultArray count]);
    
}

-(void)  didFinishGetChallengesFromUserWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesFromUserWithResult count = %ld", [resultArray count]);
    
}

-(void)  didFinishAddChallengeWithResult:(NSError *) error {
    NSLog(@"didFinishAddChallengeWithResult count = %@", error);
    
}

-(void)  didFinishSearchChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishSearchChallengesWithResult count = %ld", [resultArray count]);
    
}

// This method returns a list of challenges requests for a given challenge
-(void)  didFinishGetChallengeRequestsWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengeRequestsWithResult count = %ld", [resultArray count]);
    
}

// This method returns a list of evidences or reponses for a given challenge
-(void)  didFinishGetChallengesResponsesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesResponsesWithResult count = %ld", [resultArray count]);
    
}

-(void)  didFinishAcceptChallengeRequestWithResult:(NSError *) error  {
    NSLog(@"didFinishAcceptChallengeRequestWithResult count = %@", error);
    
}

-(void)  didFinishRejectChallengeRequestWithResult:(NSError *) error {
    NSLog(@"didFinishRejectChallengeRequestWithResult count = %@", error);
    
}


@end
