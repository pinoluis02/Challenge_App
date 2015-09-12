//
//  ChallengeTableViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengeTableViewController.h"
#import "RegularItemTableViewCell.h"
#import "ChallengeEvidenceTableViewController.h"

@interface ChallengeTableViewController (){
    NSDictionary * items;
ChallengeTableViewControllerContent mContentType;
}
@end

@implementation ChallengeTableViewController


-(ChallengeTableViewControllerContent)contentType{
    return mContentType;
}

-(void)setContentType:(ChallengeTableViewControllerContent)contentType{
    mContentType = contentType;
    [self fetchData:contentType];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
       UINib *cellNib = [UINib nibWithNibName:@"RegularItemTableViewCell" bundle:nil];
        [self.tableView registerNib: cellNib forCellReuseIdentifier:@"RegularItemTableViewCell"];
    self.tableView.rowHeight = 255;

    //    Networking code
    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    
    self.challengesArray = [[NSMutableArray alloc]init];
}

-(void) fetchData:(ChallengeTableViewControllerContent)contentType{
    
    switch (contentType) {
        case AllChallenges:{
            //[self.challengeDao getAllChallenges];
            //[self.challengeDao getPopularChallenges];
            //[self.challengeDao getLastChallenges];
            //ChallengeCriteria *criteria;
            //[self.challengeDao searchChallenges:criteria];
            //[self.challengeDao getChallengesRequestByUserId:@10 withStatus:@1]; // OK
            //[self.challengeDao putChallengesRequestStatus:@20 withStatus:@1]; // OK
            //[self.challengeDao getChallengesEvidencesByUserId:@20];
            [self.challengeDao getChallengesPendingEvidencesByUserId:@20];
            //Challenge *challenge;
            //[self.challengeDao postChallenge:challenge]; // OK
            //User *user;
            //[self.challengeDao postUser:user];
            //[self.challengeDao getExistUser:@"8484248"];
            
        }break;
        case PopularChallenges:{
            [self.challengeDao getPopularChallenges];
        }break;
        case RecentChallenges:{
            [self.challengeDao getLastChallenges];
        }break;
        case SearchChallenges:{
            ChallengeCriteria * criteria = [ChallengeCriteria new];
            [self.challengeDao searchChallenges:criteria];
        }break;
        case UserChallengeInvitation:{
//Fix this documentation:
//            0 - noresponded
//            1 - accepted
//            2 - rejected
            NSNumber * userId = [NSNumber numberWithInt:1];
            NSNumber * statusIncomplete = [NSNumber numberWithInt:1];
            [self.challengeDao getChallengesRequestByUserId:userId withStatus:statusIncomplete];
        }break;
        case UserCompleteChallenges:{
                        NSNumber * userId = [NSNumber numberWithInt:1];
            [self.challengeDao getChallengesEvidencesByUserId:userId];
        }break;
        case UserIncompleteChallenges:{
            NSNumber * userId = [NSNumber numberWithInt:1];
            [self.challengeDao getChallengesPendingEvidencesByUserId:userId];
        }break;
        default:
            NSAssert(false, @"programmer you made an error");
    }
    
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
    return [self.challengesArray count];
//    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Challenge * item = [self.challengesArray objectAtIndex:indexPath.row];
    
    
    RegularItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegularItemTableViewCell" forIndexPath:indexPath];
    
    cell.title.text = item.title;
    cell.challengeDescription.text = item.descriptionItem;
    cell.author.text = item.nameAuthor;
    cell.pubDate.text = item.creationDate;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:item.urlThumbnail]];
    UIImage * image = [UIImage imageWithData:imageData];
    [cell.thumbnail setImage:image];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChallengeEvidenceTableViewController * vc = [ChallengeEvidenceTableViewController new];
    vc.challengeId = 99;
    vc.userId = 99;
    [self.navigationController pushViewController:vc animated:true];

}

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
    
//    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    [self.tableView reloadData];
    
}

-(void)  didFinishGetLastChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetLastChallengesWithResult count = %ld", [resultArray count]);

    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    [self.tableView reloadData];
    
}

-(void)  didFinishGetPopularChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetPopularChallengesWithResult count = %ld", [resultArray count]);
    
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    [self.tableView reloadData];
}

-(void)  didFinishGetChallengesFromUserWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesFromUserWithResult count = %ld", [resultArray count]);
    
}

-(void)  didFinishGetChallengesRequestByUserIdWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesRequestByUserIdWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    [self.tableView reloadData];
}

-(void)  didFinishAddChallengeWithResult:(NSError *) error {
    NSLog(@"didFinishAddChallengeWithResult count = %@", error);
    
}

-(void)  didFinishSearchChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishSearchChallengesWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    [self.tableView reloadData];
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

-(void)  didFinishAcceptOrRejectChallengeRequestWithResult:(NSError *) error {
    NSLog(@"didFinishAcceptOrRejectChallengeRequestWithResult count = %@", error);
    
}

-(void)  didFinishGetChallengesEvidencesByUserIdWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesEvidencesByUserIdWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    [self.tableView reloadData];
}

-(void)  didFinishGetChallengesPendingEvidencesByUserIdWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesPendingEvidencesByUserIdWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    [self.tableView reloadData];
}

-(void) didFinishAddUserWithResult:(NSError *) error {
    NSLog(@"didFinishAddUserWithResult count = %@", error);
    
}

-(void)  didFinishGetExistUserWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetExistUserWithResult count = %ld", [resultArray count]);
}

@end
