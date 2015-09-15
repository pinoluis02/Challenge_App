//
//  UploadEvidenceViewController.m
//  ChallengeApp
//
//  Created by MCS on 9/15/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "UploadEvidenceViewController.h"
#import "FbSingleton.h"
#import "FBFriend.h"
#import "Challenge.h"
#import "NSDate+Utils.h"

@interface UploadEvidenceViewController ()
{
    NSString * mediaUrl;
    NSString * mediaType;
}
@end

@implementation UploadEvidenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //This variale will get the Title of these challenge from the DB
    NSString * titleChallenge = @"Title for the challenge";
    
    self.titleChallengeLabel.text =titleChallenge;
    self.challengeDao = [[ChallengeDao alloc]init];
    self.challengeDao.delegate = self;

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)didFinishAddChallengeWithResult:(NSArray *)resultArray{
    NSLog(@"didFinishAddChallengeWithResult:%@",resultArray);
}

- (IBAction)sendEvidenceButton:(UIButton *)sender
{
    
    NSLog(@"Send the evidence media video/photo to the file server");
    if ( ([self.addDescriptionText.text isEqualToString:@""]) || ([self.addHashtadText.text isEqualToString:@""]))
    {
        self.warningLabel.text = @"There are some fields missing";
    }
    else
    {
        NSLog(@"add Description -> %@", self.addDescriptionText.text);
        NSLog(@"add Hashtags     -> %@", self.addDescriptionText.text);
        
        NSString * descriptionText = self.addDescriptionText.text;
        NSString * aditionalHashtags =  self.addDescriptionText.text;
        
        NSLog(@"%@", descriptionText);
        NSLog(@"%@", aditionalHashtags);
        
        self.warningLabel.text = @"";
        
        // Funtion to send the variables for Details and Hashtags to the next method
        [self PostToServer];
    }
}

-(void)PostToServer{
    if(self.userComesFromCreateNewChallengeView){
        Challenge * challenge = [Challenge new];
//        @property (strong, nonatomic) NSString *idChallenge;
//        @property (strong, nonatomic) NSString *title;
//        @property (strong, nonatomic) NSString *descriptionItem;
//        @property (strong, nonatomic) NSString *type;
//        @property (strong, nonatomic) NSString *urlResource;
//        @property (strong, nonatomic) NSString *urlThumbnail;
//        @property (strong, nonatomic) NSString *idAuthor;
//        @property (strong, nonatomic) NSString *nameAuthor;
//        @property (strong, nonatomic) NSString *creationDate;
//        @property (strong, nonatomic) NSString *donation;
//        @property (strong, nonatomic) NSString *idPayPal;
//        @property (strong, nonatomic) NSString *organization;
//        @property (strong, nonatomic) NSString *hashtags;
//        @property (strong, nonatomic) NSString *userStatus;
//        @property float mount;

        challenge.title = self.createNewChallengeView_title;
        challenge.descriptionItem = self.createNewChallengeView_description;
        challenge.type = self.createNewChallengeView_resourceType;
        challenge.urlResource = self.createNewChallengeView_resourceUrl;
        challenge.urlThumbnail = self.createNewChallengeView_thumbnailUrl;
        challenge.idAuthor = [FbSingleton sharedInstance].userLoggedIn.userId;
        challenge.nameAuthor = [FbSingleton sharedInstance].userLoggedIn.userName;
        challenge.creationDate = [[NSString alloc] initWithString:[NSDate date].shortFormattedDateString];
        challenge.donation = self.createNewChallengeView_donationAmount;
        challenge.idPayPal = self.createNewChallengeView_donationPaypalId;
        challenge.organization = self.createNewChallengeView_donationOrganization;
        challenge.hashtags = self.addHashtadText.text;
        [self.challengeDao postChallenge:challenge];
    }
    else{
//    create new evidence for existing challenge
        NSNumber * challengeid = [NSNumber numberWithInteger:[self.selectedItem.idChallenge integerValue]];
        NSNumber * userId = [NSNumber numberWithInteger:[[FbSingleton sharedInstance].userLoggedIn.userId integerValue]];
        [self.challengeDao postChallengeEvidence:challengeid userId:userId mediaUrl:mediaUrl mediaType:mediaType];
    }
}

- (IBAction)addMediaButton:(UIButton *)sender
{
    NSLog(@"Open the Photo gallery to search for the Video/Photo from your phone");
    
    
}

@end
