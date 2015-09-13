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
#import "NSDate+Utils.h"
#import "customRootController.h"

@interface ChallengeTableViewController (){
    NSDictionary * items;
    ChallengeTableViewControllerContent mContentType;
    UILongPressGestureRecognizer * lpgr;

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
//    self.clearsSelectionOnViewWillAppear = NO;
       UINib *cellNib = [UINib nibWithNibName:@"RegularItemTableViewCell" bundle:nil];
        [self.tableView registerNib: cellNib forCellReuseIdentifier:@"RegularItemTableViewCell"];
//    self.tableView.rowHeight = 255;

    //    Networking code
    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    
    self.challengesArray = [[NSMutableArray alloc]init];
    
    self.tableView.estimatedRowHeight = 68.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
}

-(void) fetchData:(ChallengeTableViewControllerContent)contentType{
    
    BOOL debug = true;
    if(!debug)
    {
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
            [self.challengeDao getAllChallenges];
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
    }else
    {
        [self setDemoData];
    }
}

-(void)setDemoData{
    
     NSString * loremLipsum = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enm ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    
    Challenge * itemOne = [Challenge new];
    itemOne.idChallenge = @"1";
    itemOne.title = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium";
    itemOne.descriptionItem = loremLipsum;
    itemOne.type = @"image"; //Image/vide0
    itemOne.urlResource = @"www.google.com";
    itemOne.urlThumbnail = @"http://i.cdn.turner.com/asfix/repository//8a25c3920eec2495010eecf65c5a16f7/thumbnail_8877914413458619170.jpg";
    itemOne.idAuthor = @"1";
    itemOne.nameAuthor = @"Brendon Small";
    itemOne.creationDate = [[NSDate date] shortFormattedDateString];
    //unrelated, notified, accepted (incomplete), rejected, completed.
    itemOne.userStatus = @"unrelated";
    itemOne.donation = @"0.0";
    itemOne.idPayPal = nil;
    itemOne.organization = @"Red cross";

    
    Challenge * itemTwo = [Challenge new];
    itemTwo.idChallenge = @"1";
    itemTwo.title = @"title";
    itemTwo.descriptionItem = @"description";
    itemTwo.type = @"image"; //Image/vide0
    itemTwo.urlResource = @"www.google.com";
    itemTwo.urlThumbnail = @"http://33.media.tumblr.com/avatar_7e31575f9de3_128.png";
    itemTwo.idAuthor = @"1";
    itemTwo.nameAuthor = @"Roger";
    itemTwo.creationDate = [[NSDate date] shortFormattedDateString];
    //unrelated, notified, accepted (incomplete), rejected, completed.
    itemTwo.userStatus = @"notified";
    itemTwo.donation = @"0.0";
    itemTwo.idPayPal = nil;
    itemTwo.organization = @"Red cross";

    NSArray * resultsArray = @[itemOne, itemTwo];
    
    
        self.challengesArray = resultsArray;
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
    Challenge *item = self.challengesArray[indexPath.row];
    [self notifyCoordinatorOfItemSelection:item longPress:NO];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint p = [gestureRecognizer locationInView:self.tableView];
        
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            return;
        } else {
            Challenge *item = self.challengesArray[indexPath.row];
            [self notifyCoordinatorOfItemSelection:item longPress:YES];
        }
    }
}

-(void)notifyCoordinatorOfItemSelection: (Challenge *)item longPress:(BOOL)lp{
    [self.coordinatorController coordinateItemSelection:item selectedByLongPress:lp];
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
