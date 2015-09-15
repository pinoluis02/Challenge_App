//
//  ChallengesRootController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengesRootController.h"
#import "EvidencesRootController.h"
#import "NSDate+Utils.h"

@interface ChallengesRootController ()
{

}
@end

@implementation ChallengesRootController

-(void)updateViewConstraints{
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    self.tableControllerClass = [ChallengesTableViewController class];
    self.nextRootControllerClass = [EvidencesRootController class];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    Networking code
    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    self.isFirstControllerInNavigation = true;
    //maybe we downloaded the files before the viewLoad event
    [self fetchData:self.contentType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) fetchData:(ChallengeTableViewControllerContent)contentType{
//    NSLog(@"contentType:%@",[self contentypeToString:contentType]);
    
    BOOL debug = true;
    if(!debug)
    {
        switch (contentType) {
            case AllChallenges:{
                [self.challengeDao getAllChallenges];                
            }break;
            case PopularChallenges:{
                [self.challengeDao getPopularChallenges];
            }break;
            case RecentChallenges:{
                [self.challengeDao getLastChallenges];
            }break;
            case SearchChallenges:{
                ChallengeCriteria * criteria = [ChallengeCriteria new];
                criteria.title   = @"Ice Bucket";
                criteria.hashtag = @"nil";
                criteria.userId  = @"nil";
                [self.challengeDao searchChallenges:criteria];
            }break;
            case UserChallengeInvitation:{
                //Fix this documentation:
                //            0 - noresponded
                //            1 - accepted
                //            2 - rejected
                NSNumber * userId = [NSNumber numberWithInt:2];
                NSNumber * statusIncomplete = [NSNumber numberWithInt:0];

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
    self.tableContentController.itemsArray = self.challengesArray;
}



-(void)  didFinishGetAllChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetAllChallengesWithResult count = %ld", [resultArray count]);
    self.challengesArray = resultArray;
    self.tableContentController.itemsArray = self.challengesArray;
    
}

-(void)  didFinishGetLastChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetLastChallengesWithResult count = %ld", [resultArray count]);
    self.challengesArray = resultArray;
    self.tableContentController.itemsArray = self.challengesArray;
    
}

-(void)  didFinishGetPopularChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetPopularChallengesWithResult count = %ld", [resultArray count]);
    self.challengesArray = resultArray;
    self.tableContentController.itemsArray = self.challengesArray;
}

-(void)  didFinishGetChallengesFromUserWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesFromUserWithResult count = %ld", [resultArray count]);
    
}

-(void)  didFinishGetChallengesRequestByUserIdWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesRequestByUserIdWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    self.tableContentController.itemsArray = self.challengesArray;
    //[self.tableContentController.tableView reloadData];
}

-(void)  didFinishAddChallengeWithResult:(NSError *) error {
    NSLog(@"didFinishAddChallengeWithResult count = %@", error);
    
}

-(void)  didFinishSearchChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishSearchChallengesWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    self.tableContentController.itemsArray = self.challengesArray;

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
     self.tableContentController.itemsArray = self.challengesArray;
  //  [self.tableContentController.tableView reloadData];
}

-(void)  didFinishGetChallengesPendingEvidencesByUserIdWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesPendingEvidencesByUserIdWithResult count = %ld", [resultArray count]);
    self.challengesArray = resultArray;
    self.tableContentController.itemsArray = self.challengesArray;
   // [self.tableContentController.tableView reloadData];
}

-(void) didFinishAddUserWithResult:(NSError *) error {
    NSLog(@"didFinishAddUserWithResult count = %@", error);
    
}

-(void)  didFinishGetExistUserWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetExistUserWithResult count = %ld", [resultArray count]);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
