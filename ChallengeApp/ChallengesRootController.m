//
//  ChallengesRootController.m
//  ChallengeApp
//
//  Created by MCS on 9/13/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "ChallengesRootController.h"
#import "NSDate+Utils.h"

@interface ChallengesRootController ()
{
ChallengeTableViewControllerContent mContentType;
    CGFloat mainViewHeight;
}
@end

@implementation ChallengesRootController


-(ChallengeTableViewControllerContent)contentType{
    return mContentType;
}

-(void)setContentType:(ChallengeTableViewControllerContent)contentType{
    mContentType = contentType;
    [self fetchData:contentType];
}


-(NSString *)nibName{
    return @"CustomRootController";
}


-(void)updateViewConstraints{
    self.mainViewHeightConstraint.constant = mainViewHeight;
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    Networking code
    self.challengeDao = [[ChallengeDao alloc] init];
    self.challengeDao.delegate = self;
    self.isFirstControllerInNavigation = true;
    //maybe we downloaded the files before the viewLoad event
    self.tableContentController.itemsArray = self.challengesArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark overrides

-(void)setUpMenuContent{
    ExpandableTableViewController *commandMenuController = [ExpandableTableViewController new];
    self.commandMenuController = commandMenuController;
    [self addChildViewController:commandMenuController];
    [self.commandMenuView addSubview:commandMenuController.view];
    commandMenuController.view.frame = CGRectMake(0, 0, self.commandMenuView.frame.size.width,  self.commandMenuView.frame.size.height);
    commandMenuController.coordinatorController = self;
}


-(void)setUpMainViewContent{
    mainViewHeight = 1;
    [self.view setNeedsUpdateConstraints];
}

-(void)setUpTableContent{
    ChallengesTableViewController * tableContentController = [ChallengesTableViewController new];
    self.tableContentController = tableContentController;
    [self addChildViewController:tableContentController];
    [self.tableContentView addSubview:tableContentController.tableView];
    tableContentController.tableView.frame = CGRectMake(0, 0, self.tableContentView.frame.size.width,  self.tableContentView.frame.size.height);
    tableContentController.coordinatorController = self;
}


-(void)coordinateMainItemSelection:(Challenge *)item
               selectedByLongPress:(BOOL)longPress{
    NSAssert(NO, @"ChallengesRootController shouldn't have a main item.");
}

-(void)coordinateTableItemSelection:(Challenge *)item
           selectedByLongPress:(BOOL)longPress;
{
    
    if(longPress){
        //unrelated, invited, accepted (incomplete), rejected, completed.
        NSArray * items = [CustomRootController loadMenuItemsForChallengeItem:item];
        self.commandMenuController.itemsInTable = items;
    }
    else{
        EvidencesRootController * newSpan = [EvidencesRootController new];
        newSpan.selectedItem = item;
        [self.navigationController pushViewController:newSpan animated:true];
        self.navigationController.navigationBar.translucent = false;
        self.navigationController.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
}

-(void)coordinateMenuHeightChange:(CGFloat)height{
    [super coordinateMenuHeightChange:height];
}

-(void)coordinateMenuItemSelection:(NSString *)command{
    [super coordinateMenuItemSelection:command];
}

#pragma mark -

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
    self.tableContentController.itemsArray = self.challengesArray;
}



-(void)  didFinishGetAllChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetAllChallengesWithResult count = %ld", [resultArray count]);
    
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    
}

-(void)  didFinishGetLastChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetLastChallengesWithResult count = %ld", [resultArray count]);
    
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
    
}

-(void)  didFinishGetPopularChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetPopularChallengesWithResult count = %ld", [resultArray count]);
    
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
}

-(void)  didFinishGetChallengesFromUserWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesFromUserWithResult count = %ld", [resultArray count]);
    
}

-(void)  didFinishGetChallengesRequestByUserIdWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesRequestByUserIdWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
}

-(void)  didFinishAddChallengeWithResult:(NSError *) error {
    NSLog(@"didFinishAddChallengeWithResult count = %@", error);
    
}

-(void)  didFinishSearchChallengesWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishSearchChallengesWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
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
}

-(void)  didFinishGetChallengesPendingEvidencesByUserIdWithResult:(NSArray *) resultArray {
    NSLog(@"didFinishGetChallengesPendingEvidencesByUserIdWithResult count = %ld", [resultArray count]);
    //    Setting both dummy objects, when model is ready leave only one
    self.challengesArray = resultArray;
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
